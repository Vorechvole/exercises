#!/bin/bash

#PING=$(ping seznam.cz -w1)
PING_adv=$( ping 10.0.0.6 -w1 | grep "ttl"  | cut -d " " -f7 | cut -d "=" -f2)

if [[ ${PING_adv} -gt 0 ]]; then
    echo "Internet dostupný"
elif [[ -z ${PING_adv} ]]; then
    echo "Internet nedostupný"
fi

