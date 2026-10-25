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

log_file="logs-$(date "+%Y-%m-%d-%H-%M-%s").tar.gz"
echo "$log_file"
tar -czvf $log_file $files_to_archive

#echo "moving files to $destination_dir location"
#mv logs_archive.tar.gz $destination_dir

#if [ -z "$destination_dir" ]; then 
#    echo "ERROR:: NO files added to $destination_dir"
#    exit 1
#else
#    echo "deleting the files in $source_dir"
#    while IFS= read -r line
#    do
#        echo "File is going to be deleted : $line"
#        rm -f $line
#        echo "File got deleted: $line"
#    done <<< $logs_archive.tar.gz
#fi    