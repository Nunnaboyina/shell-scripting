#!/bin/bash

set -e

user_id=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
log_folder="/var/log/shell-log"
log_file="${log_folder}/${0}.log"

trap 'echo "Error at $LINENO", command: "$BASH_COMMAND"' ERR

if [ $user_id -ne 0 ]; then 
    echo "Please run this script with sudo access..."
    exit 1
fi

mkdir -p $log_folder

echo "Execution started at $(date +"%F %T")" &>> $log_file


for package in $@
do 
    dnf list installed ${package} &>> $log_file 
    if [ $? -ne 0 ]; then  
        echo "Installing the ${package} package...."      
        dnf install ${package} -y &>> $log_file
    else
        echo -e "${package} is already installed ----${Y}SKIPPING${N}" 
    fi 
done
 