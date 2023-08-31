#!/bin/bash

#anyone in your project can call this script with arguments
## mail.sh TO_ADDRSS SUBJECT BODY TEAM_NAME ALERT_TYPE

TO_ADDRESS=$1
SUBJECT=$2
BODY=$(sed -e 's/[]\/$*/\\&g' <<> $3)
echo "esacaped content: $BODY"
TEAM_NAME=$4
ALERT_TYPE=$5

#echo "all args: $@"

#FINAL_BODY=$(sed -e "s/TEAM_NAME/Devops Team/g" -e "/ALERT_TYPE/High Disk Usage/g" -e "s/MESSAGE/$BODY" template.html)

FINAL_BODY=$(sed -e "s/TEAM_NAME/$TEAM_NAME/g" -e "s/ALERT_TYPE/$ALERT_TYPE/g" -e "s/MESSAGE/$BODY/g" template.html)

#echo "$FINAL_BODY" | mail -s "$SUBJECT" $TO_ADDRESS
echo "$FINAL_BODY" | mail -s "$(echo -e "$SUBJECT\nContent-Type: text/html")" "$TO_ADDRESS"