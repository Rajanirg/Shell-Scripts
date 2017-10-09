#!/bin/bash

cd ./text_files

for ((i=0;i<=9;i++)); do
	if [ ! -e file_$i.txt ]
	then
		touch file_$i.txt
		echo "Hello Helloo World" > file_$i.txt

	else
		echo "file_$i.txt already exists..."
	fi
done



