#!/bin/bash
echo "Zadej kam chceš pingnout"
read PING

echo "Ping...."
PING_adv=$( ping $PING -w1 | grep "ttl"  | cut -d " " -f7 | cut -d "=" -f2)

if [[ ${PING_adv} -gt 0 ]]; then
    echo "Internet dostupný"
elif [[ -z ${PING_adv} ]]; then
    echo "Internet nedostupný"
fi

