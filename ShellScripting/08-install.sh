#!/bin/bash

## Our program goal is to install mqsql

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "ERROR:: Please run this script with root access"
    exit 1

#else
#   echo "INFO:: Your are root user"
fi

# It is our responsibility again to check installation success or not
yum install mysql -y
if [ $? -ne 0 ]
then 
    echo "Installation of mysql is error"
else 
    echo "Installation of mysql is success"
fi