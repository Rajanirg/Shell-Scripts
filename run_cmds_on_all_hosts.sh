#!/bin/bash

set -x
CMD=$1
USER='root'
hosts='all_hosts.txt'

if [ -f $hosts ] && [ $# -eq 1 ]
then
	while read line
	do
		host="$line"
		echo "Running $CMD command in host: $host"
		ssh -i ~/path/to/pem_file -oStrictHostKeyChecking=no $USER@$host $CMD
	done < $hosts	
else
	if [ $# -ne 1 ]
	then
		echo "you did not pass any command to run..."
	else
		echo "$hosts ==> File does not exists!"
	fi
  exit 1
fi
