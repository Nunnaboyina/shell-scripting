#!/bin/bash

user_id=$(id -u)

if [ $user_id -ne 0 ]; then
    echo "Please run the script with sudo acess....."
    exit 1
fi

validate(){
    if [ $1 -ne 0 ]; then
        echo "$2 is FAILED"
    else
        echo "$2 is SUCCESS"
        exit 1
    fi
}

echo "proceeding......."

dnf install nginx -y
validate $? "nginx installation"

dnf install mysql -y
validate $? "mysql installation"
