#!/bin/bash

## Our program goal is to install mqsql

DATE=$(date +%F)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log

R="\e[31m"
G="\e[32m"
N="\e[0m"

# This function should validate the previous command and inform user it is success or failure
VALIDATE() {

    #$1 --> it will the argument 1
    if [ $1 -ne 0 ]
    then 
        echo -e "$2... $R FAILURE $N" 
    else 
        echo -e "$2... $G success $N"
    fi
}
USERID=$(id -u)


if [ $USERID -ne 0 ]
then 
    echo "ERROR:: Please run this script with root access"
    exit 1

#else
#   echo "INFO:: Your are root user"
fi

# It is our responsibility again to check installation success or not
yum install mysql -y &>>$LOGFILE

VALIDATE $? "Installing MySQL"

yum install postfixddd -y &>>$LOGFILE

VALIDATE $? "Installing postfix"