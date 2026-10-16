#!/bin/bash

log_folder="/var/log/shell-log"
log_file="${log_folder}/${0}.log"

user_id=$(id -u)

if [ $user_id -ne 0 ]; then
    echo "Please run the script with sudo acess....."
    exit 1
fi

mkdir -p $log_folder

echo "Script started execution at $(date +"%F %T")" &>> $log_file

validate(){
    if [ $1 -ne 0 ]; then
        echo "$2 is FAILED" | tee -a $log_file
        exit 1
    else
        echo "$2 is SUCCESS" | tee -a $log_file
        
    fi
}


dnf install nginx -y &>> $log_file
validate $? "nginx installation"

dnf install mysql -y &>> $log_file
validate $? "mysql installation"

echo "Script ended execution at $(date +"%F %T")" &>> $log_file