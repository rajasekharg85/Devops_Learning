#!/bin/bash

NAMES=("mandodb" "redis" "mysql" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
for i in "${NAMES[@]}"
do
    echo "Name: is $i"
done