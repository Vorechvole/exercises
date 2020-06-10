#!/bin/bash
EXCLUDE=("sshd" "pure-ftpd" "systemd-resolv")
if [[ -f ".nettest.txt" ]]; then
        netstat --inet -tulpn | grep -v "${EXCLUDE}"  > .nettest2.txt
        if cmp -s ".nettest2.txt" ".nettest.txt"; then
                echo "OK no change"
        else
                rows=$(diff .nettest2.txt .nettest.txt | grep -v "^[0-9]" | sed -e 's/>/-/g' -e 's/</+/g' | awk '{print $1$5":"$8}')
                echo -e "WARNING PORTS CHANGED: $rows"
                netstat --inet -tulpn | grep -v "${EXCLUDE}" > .nettest.txt
        fi
else
         netstat --inet -tulpn | grep -v "${EXCLUDE}" > .nettest.txt
        echo "Vytvořil jsem template, při následné změně portu budu hlásit změny."
fi

