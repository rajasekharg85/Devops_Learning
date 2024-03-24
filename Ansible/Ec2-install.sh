#!/bin/bash

NAMES=("mandodb" "redis" "mysql" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
INSTANCE_TYPE=""
#if mysql or mongodb instanse_type should be t3.medium. for all others it is t2.micro

for i in "${NAMES[@]}"
do
    if [ [ $i == "mangodb" || $i = "mysql" ]]
    then
        INSTANCE_TYPE="t3.medium"
    else
        INSTANCE_TYPE="t2.micro"
    fi
    echo "Name: is $i"
done