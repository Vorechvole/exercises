#!/bin/bash


for soubor in check_security.sh check_security.global.conf;
do
    if [[ -f /ansible2/roles/common/files/nagios/plugins/$soubor ]]; then
        cha1=$(cksum /ansible2/roles/common/files/nagios/plugins/$soubor | cut -d " " -f1)
        cha2=$(cksum ./$soubor | cut -d " " -f1)
        if [[ "$cha1" == "$cha2" ]]; then
            echo "Soubor $soubor  se shoduje."
        else
            read -p "Soubory se liší, přepsat cílový soubor? (y/n)" -n 1 -r
            echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                     echo "Zkopiruji pozadovane soubory do prod adresare nagiosu:"
                    cp -v ../ansible2/roles/common/files/nagios/plugins/$soubor /tmp/
                    cp -v $soubor ../ansible2/roles/common/files/nagios/plugins/
                fi
                else
                    echo "Nepřepisuji, končím."
        fi
    else
        echo "Tento soubor v cíli neexistuje."
    fi
done
#cp -v check_security.sh ../ansible2/roles/common/files/nagios/plugins/
#cp -v check_security.global.conf ../ansible2/roles/common/files/nagios/plugins/

