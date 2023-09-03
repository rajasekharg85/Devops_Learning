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

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOGFILE

VALIDATE $? "Setting up NPM Source"

yum install nodejs -y &>>$LOGFILE

VALIDATE $? "Installing NodeJS"

useradd roboshop &>>$LOGFILE

#Write a conditions to check directory already exist or not

mkdir /app &>>$LOGFILE

curl -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>>$LOGFILE

VALIDATE $? "downloading cart artifact"

cd /app &>>$LOGFILE

VALIDATE $? "Moving into app directory"

#unzip /tmp/cart.zip &>>$LOGFILE

VALIDATE $? "unzipping cart"

npm install &>>$LOGFILE

VALIDATE $? "Installing dependencies"
 
cp /root/Devops_Learning/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>$LOGFILE

VALIDATE $? "copying cart.service"

systemctl daemon-reload &>>$LOGFILE

VALIDATE $? "daemon reload"

systemctl enable cart &>>$LOGFILE

VALIDATE $? "Enabling cart"

systemctl start cart &>>$LOGFILE

VALIDATE $? "Starting car"

