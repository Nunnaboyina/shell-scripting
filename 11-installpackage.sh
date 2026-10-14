#!/bin/bash

user_id=$(id -u)

if [ $user_id -ne 0 ]; then
    echo"Please run this script with sudo access"
fi
echo "Proceeding"
dnf install nginx -y
    