#!/bin/bash

START_TIME=$(date +%s)
echo "Script started excecution at : $START_TIME "
sleep 10

END_TIME=$(date +%s)
echo "Script ended exectution at: $END_TIME "

TOTAL_TIME=$($END_TIME-$START_TIME)
echo "Total time taken: $TOTAL_TIME"
