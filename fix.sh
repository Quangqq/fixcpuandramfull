#!/bin/bash
THRESHOLD_CPU=90
THRESHOLD_MEM=80

ps -eo pid,%cpu,%mem,cmd --sort=-%cpu | awk -v cpu=$THRESHOLD_CPU -v mem=$THRESHOLD_MEM '
NR>1 && $2 > cpu || $3 > mem {
    if ($4 !~ /(root|systemd|ssh|top)/) {
        print "Killing PID " $1 " (" $4 ") - CPU: " $2 "% MEM: " $3 "%"
        system("kill -9 " $1)
    }
}'
