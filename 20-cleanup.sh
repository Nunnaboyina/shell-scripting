#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

source_dir=$1
days=${2:-14}

usage(){
    echo "Provide command as :: $0 source_dir days_to_be_passed(optional)"
}
# If source dir name is given
if [ -z "$source_dir" ]; then 
    echo -e "${R}ERROR::Missing Parameters${N}"
    usage
fi

# If directory exists
if [ ! -d "$source_dir" ]; then
    echo -e "${R}ERROR:: $source_dir does not exist ${N}"
    exit 1
fi

echo "Scanning files older than $days in $source_dir"
files_to_delete=$(find $source_dir -name "*.log" -type f -mtime +$days)

if [ -z "$files_to_delete" ]; then 
    echo "No log files found older than $days"
    exit 1
fi

while IFS= read -r line
do 
    echo "File is going to be deleted : $line"
    rm -f $line
    echo "File got deleted: $line"

done <<< $files_to_delete


