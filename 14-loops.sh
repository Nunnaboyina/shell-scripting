#!/bin/bash

user_id=$(id -u)

if [ $user_id -ne 0 ]; then 
    echo "Please run this script with sudo access..."
    exit 1
fi

log_folder="/var/log/shell-log"
log_file="${log_folder}/${0}.log"

mkdir -p $log_folder

echo "Execution started at $(date +"%F %T")" &>> $log_file

validate(){
    if [ $1 -ne 0 ]; then
        echo "$2 is FAILED" | tee -a $log_file 
        exit 1
    else 
        echo "$2 is SUCCESS" | tee -a $log_file
    fi

}

for package in $@
do 
    dnf list installed ${package} &>> $log_file
    if [ $($?) -ne 0 ]; then
        echo "Installing the ${package} package...."
        dnf install ${package} -y &>> $log_file
        validate $? "${package} installing"
    else
        echo "${package} is already installed ----SKIPPING" 
    fi

    
done

echo "Execution ended at $(date +"%F %T")" &>> $log_file