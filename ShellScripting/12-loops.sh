#!/bin/bash

DATE=$(date +%F)
SCRIPT_NAME=$0
LOGDIR=/home/centos/shellscript-logs
#/home/centos/shellscript-logs/script-name-date.log
LOGFILE=$LOGDIR/$0-$DATE.log
USERID=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [ $USERID -ne 0 ]
then 
    echo "ERROR:: Please run this script with root access"
    exit 1
fi

VALIDATE() {

    #$1 --> it will the argument 1
    if [ $1 -ne 0 ];
    then 
        echo -e "Installing $2... $R FAILURE $N" 
    else 
        echo -e "Installing $2... $G success $N"
    fi
}

# All arguments are in $@
for i in $@
do 
    yum list installed $i &>>$LOGFILE
    if [ $? -ne 0 ]
    then 
        echo "$i is not installed, let's install it"
        yum install $i -y &>>$LOGFILE
        VALIDATE $? "$i"
    else
        echo -e "$Y $i is already installed $N"
fi
done

## Improvements

# implement log files
# implement colors
# implement validations
# implement validations throush functions
# your script should check package is already installed or not, if already installed print yellow color
# if installed just print package is already installed, it should not run installl command
