#!/bin/bash

# All arguments are in $@
for i in $@
do 
    yum install $i -y
done

## Improvements

# implement log files
# implement colors
# implement validations
# implement validations throush functions
