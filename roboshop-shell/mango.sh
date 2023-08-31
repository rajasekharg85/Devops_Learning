#!/bin/bash

DATE=$(date +%F)
LOGDIR=/tmp
#/home/centos/shellscript-logs/script-name-date.log
SCRIPT_NAME=$0
LOGFILE=$LOGDIR/$0-$DATE.log
USERID=$(id -u)
R="\e[31m"
G="\e[33m"
N="\e[0m"
Y="\e[33m"

if [ $USERID -ne 0 ];
then
    echo -e "$R ERROR: Please run this script with root access $N"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "Installing $2 ... $G SUCCESS $N"
    fi
}

cp /root/Devops_Learning/roboshop-shell/mango.repo /etc/yum.repos.d/mango.repo &>> $LOGFILE

VALIDATE $? "Copied MangoDB  repo into yum.repo.d"

yum install mongodb-org -y &>> $LOGFILE
            
VALIDATE $? "Installation of MangoDB"

systemctl enable mongod &>> $LOGFILE

VALIDATE $? "Enabling MongoDB"

systemctl start mongod &>> $LOGFILE

VALIDATE $? "Starting MangoDB"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>> $LOGFILE

VALIDATE $? "Edited MangoDB conf"

systemctl restart mongod &>> $LOGFILE

VALIDATE $? "Restarting MangoDB"
