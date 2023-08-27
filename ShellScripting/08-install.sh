#!/bin/bash

## Our program goal is to install mqsql

USERID=$(id -u)

if [ $USERID -ne 0]
then 
    echo "ERROR:: Please run this script with root access"

#else
#   echo "INFO:: Your are root user"
fi

yum install mysql -y