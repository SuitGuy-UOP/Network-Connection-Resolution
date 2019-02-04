#!/bin/bash

TIME=$(date '+%H:%M:%S')
DATE=$(date '+%Y-%m-%d')

if ss -tp >> Processing/ssOutput.txt
    then
        grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' Processing/ssOutput.txt > Processing/part2.txt
    else
       echo "[$DATE] | [$TIME]::[ERR]: No TCP connections found" >> /var/log/networkMon.log
fi

while read -r LINE; do
    getent hosts "$LINE"
done < Processing/part2.txt > Processing/resolved.txt

cat Processing/resolved.txt | sed '/UNKNOWN/d' | sort | uniq > Processing/unique.txt



echo "Continue"

