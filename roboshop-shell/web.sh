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
        echo -e  "$2 ... $G SUCCESS $N"
    fi
}

yum install nginx -y  &>>$LOGFILE

VALIDATE $? "Installing nginx"

systemctl enable nginx  &>>$LOGFILE

VALIDATE $? "Enabling nginx"

systemctl start nginx  &>>$LOGFILE

VALIDATE $? "Starting nginx"

rm -rf /usr/share/nginx/html/*  &>>$LOGFILE

VALIDATE $? "Removing default website"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip  &>>$LOGFILE

VALIDATE $? "Downloading web artifacts"

cd /usr/share/nginx/html  &>>$LOGFILE

VALIDATE $? "Moving to default HTML directory"

unzip /tmp/web.zip  &>>$LOGFILE

VALIDATE $? "Unzipping web artifacts"

cp /root/root/Devops_Learning/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf  &>>$LOGFILE

VALIDATE $? "Copying roboshop config"

systemctl restart nginx  &>>$LOGFILE

VALIDATE $? "Restarting nginx"