#!/bin/bash

#colors
#validations
#Log redirections

LOGFILE_DIRECTORY=/tmp
DATE=$(date +%F:%H:%M:%S)
SCRIPT_NAME=$0
LOGFILE=$LOGFILE_DIRECTORY/$SCRIPT_NAME-$DATE.log

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

DISK_USAGE=$(df -hT | grep -vE "tmpfs|Filesystem")
DISK_USAGE_THRESHOLD=1

#IFS means internal field separator is space
while IFS= read line
do
    # This command will give you usage in number format for comparision
    usage=$(echo $line | awk '{print $6}' | cut -d % -f1)
    ## This command will give us partition
    partition=$(echo $line | awk '{print $1}')
    ## Now you need to check whether it is more then threshhold or not
    if [ $usage -gt $DISK_USAGE_THRESHOLD ];
    then
        message+="HIGH DISK USAGE on $partition: $usage\n"
    fi
done <<< $DISK_USAGE

echo -e "message: $message"

#echo -e "$message": | mail -s "High Disk usage" rajasekhar.gaddam02@gmail.com

sh mail.sh rajasekhar.gaddam@gmail.com "High Disk Usage" "$message" "Devops Team" "High Disk Usage"
