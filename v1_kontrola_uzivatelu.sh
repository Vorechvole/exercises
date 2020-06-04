#!/bin/bash
THRESHOLD=600
actualcas=$(date +%s)
uzivatele=("root" "nginx" "apache" "mysql" "volrabd")
for prihlaseni in "${uzivatele[@]}"
do
    if [[ "$prihlaseni" == "root" ]];then
        konvertor=$(last root --time-format iso | head -n1 | awk '{print $3}' | sed 's/T/ /' | sed 's/+02:00/ /' )
    else
        konvertor=$(last $prihlaseni --time-format iso | head -n1 | awk '{print $4}' | sed 's/T/ /' | sed 's/+02:00/ /' )
    fi
    cas=$(date -d "$konvertor" +%s)
    DIFF=$(($actualcas-$cas))
    if [[ -z $konvertor ]]; then
        continue
    elif [[ $DIFF -gt $THRESHOLD ]]; then
        echo -e " \e[32mSEC_USER_LASTLOG:OK\e[0m"
        echo "    SEC_USER_LASTLOG_user="$prihlaseni" ("$DIFF" sec ago)"
        echo "    SEC_USER_LASTLOG_THRESHOLD="$THRESHOLD""
    elif [[ $DIFF -lt $THRESHOLD ]]; then
        echo -e " \e[31mSEC_USER_LASTLOG:WARNING\e[0m"
        echo "    User "$prihlaseni" logged in $DIFF seconds ago"
        echo "    SEC_USER_LASTLOG_user="$prihlaseni" ("$DIFF" sec ago)"
        echo "    SEC_USER_LASTLOG_THRESHOLD="$THRESHOLD""
    fi
done
