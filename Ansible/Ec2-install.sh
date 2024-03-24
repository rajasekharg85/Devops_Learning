#!/bin/bash

NAMES=("mandodb" "redis" "mysql" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
INSTANCE_TYPE=""
IMAGE_ID=ami-0f3c7d07486cad139
SECURITY_GROUP_ID=sg-0ac489c6167a83372
#if mysql or mongodb instanse_type should be t3.medium. for all others it is t2.micro

for i in "${NAMES[@]}"
do
    if [ [ $i == "mangodb" || $i == "mysql" ] ];
    then
        INSTANCE_TYPE="t3.medium"
    else
        INSTANCE_TYPE="t2.micro"
    fi
    echo "Creating $i instance"
    aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]"
done