#!/bin/bash
APP_LOGS_DIR=/app-logs

DATE=$(date +%F)
LOGDIR=/home/centos/shellscripts-logs
SCRIPT_NAME=$0
LOGFILE=$LOGDIR/$0-$DATE.log

FILES_TO_DELETE=$(find $APP_LOGS_DIR -name "*.log" -type f -mtime +14)

echo "$FILES_TO_DELETE"