#!/bin/bash

## Our program goal is to install mqsql

DATE=$(date +%F)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log

# This function should validate the previous command and inform user it is success or failure
VALIDATE() {

    #$1 --> it will the argument 1
    if [ $1 -ne 0 ]
    then 
        echo "$2... FAILURE" 
    else 
        echo "$2... success"
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

yum install postfix -y &>>$LOGFILE

VALIDATE $? "Installing postfix"