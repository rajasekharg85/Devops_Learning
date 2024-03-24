#!/bin/bash

NAMES=("mangodb" "redis" "mysql" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
INSTANCE_TYPE=""
IMAGE_ID=ami-0f3c7d07486cad139
SECURITY_GROUP_ID=sg-0ac489c6167a83372
DOMAIN_NAME=rajus.cloud
#if mysql or mongodb instanse_type should be t3.medium. for all others it is t2.micro

for i in "${NAMES[@]}"
do
    if [[ $i == "mangodb" || $i == "mysql" ]];
    then
        INSTANCE_TYPE="t3.medium"
    else
        INSTANCE_TYPE="t2.micro"
    fi
    echo "Creating $i instance"
    IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" | jq -r '.Instances[0].PrivateIpAddress')
    echo "Create $i instance: $IP_ADDRESS"

    aws route53 change-resource-record-sets --hosted-zone-id Z06312703UF3MX5JLGU8P --change-batch '
    {
            "Comment": "CREATE/DELETE/UPSERT a record",
            "Chnages": [{
            "Action": "CREATE",
                        "ResourceRecordSet": {
                            "Name": "'$i.$DOMAIN_NAME'",
                            "Type": "A",
                            "TTL": 300,
                            "ResourceRecords": [{ "Value: "'$IP_ADDRESS'"}]
                        }}]
    }
    '
done