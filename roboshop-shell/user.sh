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

curl -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>>$LOGFILE

VALIDATE $? "downloading user artifact"

cd /app &>>$LOGFILE

VALIDATE $? "Moving into app directory"

#unzip /tmp/user.zip &>>$LOGFILE

VALIDATE $? "unzipping user"

npm install &>>$LOGFILE

VALIDATE $? "Installing dependencies"
 
cp /root/Devops_Learning/roboshop-shell/user.service /etc/systemd/system/user.service &>>$LOGFILE

VALIDATE $? "copying user.service"

systemctl daemon-reload &>>$LOGFILE

VALIDATE $? "daemon reload"

systemctl enable user &>>$LOGFILE

VALIDATE $? "Enabling user"

systemctl start user &>>$LOGFILE

VALIDATE $? "Starting user"

cp /root/root/Devops_Learning/roboshop-shell/mango.repo /etc/yum.repos.d/mongo.repo &>>$LOGFILE

VALIDATE $? "Copying mongo repo"

yum install mongodb-org-shell -y &>>$LOGFILE

VALIDATE $? "Installing mongo client"

mongo --host mongodb.rajus.cloud </app/schema/user.js &>>$LOGFILE

VALIDATE $? "loading user data into mongodb"