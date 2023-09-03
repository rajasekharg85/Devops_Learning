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

yum install maven -y &>>$LOGFILE

VALIDATE $? "Installing Maven"

useradd roboshop &>>$LOGFILE

VALIDATE $? "Adding roboshop user"

mkdir /app &>>$LOGFILE

VALIDATE $? "Creating app directory"

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>>$LOGFILE

VALIDATE $? "Downloading Shipping Atrifact"

cd /app &>>$LOGFILE

VALIDATE $? "Moving to app directory"

unzip /tmp/shipping.zip &>>$LOGFILE

VALIDATE $? "Unzipping shipping Artifacts"

mvn clean package &>>$LOGFILE

VALIDATE $? "Packaging Shipping app"

mv target/shipping-1.0.jar shipping.jar &>>$LOGFILE

VALIDATE $? "Renaming Shipping jar"

cp /root/Devops_Learning/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>$LOGFILE

VALIDATE $? "Copying Shipping Service"

systemctl daemon-reload &>>$LOGFILE

VALIDATE $? "Daemon-reload"

systemctl enable shipping  &>>$LOGFILE

VALIDATE $? "Enabling Shipping"

systemctl start shipping &>>$LOGFILE

VALIDATE $? "Start Shipping"

yum install mysql -y &>>$LOGFILE

VALIDATE $? "Installing MySqQL client"

mysql -h mysql.rajus.cloud -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>$LOGFILE

VALIDATE $? "Loaded countries and cities info"

systemctl restart shipping &>>$LOGFILE

VALIDATE $? "Restarting Shipping"