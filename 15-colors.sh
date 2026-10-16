#!/bin/bash

user_id=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

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
        echo -e "$2 is ${R}FAILED${N}" | tee -a $log_file 
        exit 1
    else 
        echo -e "$2 is ${G}SUCCESS${N}" | tee -a $log_file
    fi
}

for package in $@
do 
    dnf list installed ${package} &>> $log_file  #### checking if we have already installed any packages
    if [ $? -ne 0 ]; then  
        echo "Installing the ${package} package...."      #### If not installing the package
        dnf install ${package} -y &>> $log_file
        validate $? "${package} installing"
    else
        echo -e "${package} is already installed ----${Y}SKIPPING${N}"  ### If yes skipping the package
    fi 
done
 