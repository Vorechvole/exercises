#!/bin/bash
PING=$1
PING_adv=$( ping "$1" -w1 | grep "ttl"  | cut -d " " -f7 | cut -d "=" -f2)

if [[ ${PING_adv} -gt 0 ]]; then
    echo "Internet dostupný"
elif [[ -z ${PING_adv} ]]; then
    echo "Internet nedostupný"
fi

