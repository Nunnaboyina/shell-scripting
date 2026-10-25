#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

source_dir=$1
destination_dir=$2
days=${3:-14}

usage(){
    echo "Provide Info as::$0 [source_dir] [destination_dir] [days_to_be_passed(optional)] "
    exit 1
}

if [ -z "$source_dir" ] || [ -z "$destination_dir" ]; then
    echo -e "${R}ERROR:: Missing either source_dir or destination_dir ${N}"
    usage
fi

if [ ! -d "$source_dir" ]; then
    echo -e "${R}SOURCE_DIR:: $source_dir does not exist ${N}"
    exit 1
fi

if [ ! -d "$destination_dir" ]; then
    echo -e "${R}DEST_DIR:: $destination_dir does not exist ${N}"
    exit 1
fi

echo "Scanning files which are 14 days older"
files_to_archive=$(find $source_dir -name "*.log" -type f -mtime +$days)

if [ -z "$files_to_archive" ]; then
    echo "No files are found older than $days"
    exit 1
fi 

timestamp=$(date "+%Y-%m-%d-%H-%M-%S")
log_file="$destination_dir/logs-$timestamp.tar.gz"
echo "$log_file"

tar -czf $log_file $files_to_archive


if [ $? -ne 0 ]; then 
    echo -e "${R}ERROR:: Log Archival failed${N}"
    exit 1
else
   echo "Logs are archived: $log_file "
   while IFS= read -r line
   do
       echo "File is going to be deleted : $line"
       rm -f $line
       echo "File got deleted: $line"
   done <<< "$files_to_archive"
fi    