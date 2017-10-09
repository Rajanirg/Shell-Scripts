#!/bin/bash

#### NOT The best -- I know (This was my very first attempt)

## deploys java war to tomcat webapps folder

## I would run this shell script as root
## will this run on jenkins host?
## if so -- copy jenkins pub key to all nodes .ssh dir for auto ssh

BACKUP_DIR='/var/binary_backups'
DOWNLOAD_DIR='/var/downloads'
TOMCAT_WEBAPPS='/opt/tomcat/webapps'
DL_LINK=''
ARTI_NAME=''
SERVERS='all_hosts.txt'

DATE=$(date +%Y_%m_%d_%H_%M_%S)


create_backup_dir() {
	if [ ! -d $BACKUP_DIR ]
	then
		echo "Creating a back up directory...."
		mkdir $BACKUP_DIR
	else
		echo "SKIPPING ---- Back up dir already exists ---- SKIPPING"
	fi
}

create_downloads_dir() {
	if [ ! -d $DOWNLOAD_DIR ]
	then
		echo "Creating a downloads directory...."
		mkdir $DOWNLOAD_DIR
	else
		echo "SKIPPING ---- downloads dir already exists ---- SKIPPING"
	fi
}

backup_binary() {
	dir=$($BACKUP_DIR/$DATE)
	cp $TOMCAT_WEBAPPS/$ARTI_NAME $dir
	if [ $? -eq 0 ]
	then
		tar -zcf $dir_archieved $dir 
	else
		echo "Not sure if binary was successfully moved...."
	fi
}

download_binary() {
	## this is downloading in jenkins
	cd $DOWNLOAD_DIR
	wget --silent $DL_LINK
}

deploy() {
		## ssh and then execute each func?
		create_backup_dir
		create_downloads_dir
		backup_binary
		download_binary
}

for i in $(cat $SERVERS)
do
	cd $HOME/Downloads
	ssh -i "imac_private_key.pem" $i; "$(set); deploy"
	if [ $? -ne 0 ]
	then
		echo "DEPLOY FAILED FOR $i" | mail -s "DEPLOY FAILED" "amgill1234@gmail.com"
	else
		echo "Binary deployed to: $i"
		exit
	fi
done
