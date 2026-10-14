#!/bin/bash

var1=10
var2=20

echo "$var1+$var2"

var3=siva
echo "$(($var1+$var2+$var3))"
declare -i COUNT=30
COUNT=COUNT+1
echo "count is $COUNT"

FRUITS=("APPLE" "BANANA" "CARROT")
echo "${FRUITS[@]}"

echo "${FRUITS[1]}"