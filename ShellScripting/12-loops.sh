#!/bin/bash

# All arguments are in $@
for i in $@
do 
    yum install $i -y
done
