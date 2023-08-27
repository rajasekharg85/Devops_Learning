#!/bin/bash

# This is called array, instead of single value it can hold multiple values
PERSONS=("Ramesh" "Suresh" "Rajesh")
# Inside array we always refer values with index and it starts from 0
echo "First Person: ${PERSONS[@]}"
