#!/bin/bash

NAMES=("mandodb" "redis" "mysql" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
for i in "${NAMEs[@]}"
do
    echo "Name: is $i"
done