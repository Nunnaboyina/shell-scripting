#!/bin/bash

disk_usage=$(df -hT | grep -v FileSystem)
server_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
usage_threshold=20

while IFS= read -r line;
do
usage=$(echo $line | awk '{print $6}' | cut -d "%" -f1)
mount=$(echo $line | awk '{print $7}')
if [ "$usage" -ge "$usage_threshold" ]; then
    message+="High disk usage on $mount: $usage \n"
fi

done <<< "$disk_usage"

echo -e "$message"

sh mail.sh "Devops Team" "$server_ip" "High Disk Usage" "$message" "824bhavya@gmail.com" "Warning: High Disk usage alert"

