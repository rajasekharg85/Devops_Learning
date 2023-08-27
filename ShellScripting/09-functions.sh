#!/bin/bash

## Our program goal is to install mqsql

USERID=$(id -u)

# This function should validate the previous command and inform user it is success or failure
VALIDATE() {

    #$1 --> it will the argument 1
    if [ $1 -ne 0 ]
    then 
        echo "Installation... FAILURE"
    else 
        echo "Installation... success"
    fi
}

if [ $USERID -ne 0 ]
then 
    echo "ERROR:: Please run this script with root access"
    exit 1

#else
#   echo "INFO:: Your are root user"
fi

# It is our responsibility again to check installation success or not
yum install mysql -y

VALIDATE $?

yum install postfix -y

VALIDATE $?