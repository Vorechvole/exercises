#!/bin/bash
EXCLUDE=('sshd' 'pure-ftpd' 'httpd') 
if [[ -f ".nettest.txt"  &&  -n "${EXCLUDE[@]}" ]]; then
	netstat --inet -tulpn | grep -vFf <(printf "%s\n" "${EXCLUDE[@]}") > .nettest2.txt	
	if cmp -s ".nettest2.txt" ".nettest.txt"; then
		echo "OK no change"
	else
		rows=$(diff .nettest2.txt .nettest.txt | grep -vFf <(printf "%s\n" ${EXCLUDE[@]} ) | grep -v "^[0-9]\|---" | sed -e 's/>/-/g' -e 's/</+/g' | awk '{print $1$5":"$8}')
		echo "WARNING PORTS CHANGED:" $rows
		cat .nettest2.txt | grep -vFf <(printf "%s\n" "${EXCLUDE[@]}") > .nettest.txt
	fi
elif [[ -f ".nettest.txt"  &&  -z "${EXCLUDE[@]}" ]]; then
	netstat --inet -tulpn  > .nettest2.txt
        if cmp -s ".nettest2.txt" ".nettest.txt"; then
                echo "OK no change"
        else
                rows=$(diff .nettest2.txt .nettest.txt | grep -v "^[0-9]\|---" | sed -e 's/>/-/g' -e 's/</+/g' | awk '{print $1$5":"$8}')
                echo "WARNING PORTS CHANGED:" $rows
                cat .nettest2.txt > .nettest.txt
        fi
else
	netstat --inet -tulpn > .nettest.txt	
	echo "Vytvořil jsem template, při následné změně portu budu hlásit změny."
fi





