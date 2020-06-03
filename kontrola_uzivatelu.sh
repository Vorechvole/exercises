#!/bin/bash
echo "Jaký chceš nastavit threshold pro skript?"
echo -n "THRESHOLD: "
read -n 10 THRESHOLD
actualcas=$(date "+%H:%M:%S" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
uzivatel=$(w | cut -d " " -f1 | grep -v USER > /tmp/users.txt)
function vypis {
	loggedcas=$(w -h $line | cut -d " " -f10-13 | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
	DIFF=$(($actualcas-$loggedcas ))
	if [[ $THRESHOLD -gt $DIFF ]]; then
		echo -e "\e[31mSEC_USER_LASTLOG:WARNING\e[0m"
	else
		echo -e "\e[32mSEC_USER_LASTLOG:OK\e[0m"
	fi
        echo "User $line logged in $DIFF seconds ago"
        echo "SEC_USER_LASTLOG_user=$line ( "$DIFF" sec ago)"
        echo "SEC_USER_LASTLOG_THRESHOLD="$THRESHOLD""
}
while read line; do
    if [[ $line =~ "root" ]]; then
        vypis
    elif [[ $line =~ "apache" ]];then
	vypis
    elif [[ $line =~ "mysql" ]];then
        vypis
    elif [[ $line =~ "nginx" ]];then
        vypis
    elif [[ $line =~ "volrabd" ]];then
        vypis
    fi
done < /tmp/users.txt

