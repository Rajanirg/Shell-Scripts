#!/bin/bash

CHEF="$HOME/chef-repo"
DATA_BAGS="$CHEF/data_bags"
WHICH_BAG=$1

check_db_exists(){
	if [ ! -d $DATA_BAGS/$WHICH_BAG ]
	then
		echo "$WHICH_BAG Does not exists inside $DATA_BAGS"
		exit 1
	fi
}

upload_db(){
	cd $DATA_BAGS/$WHICH_BAG
	knife data bag from file $WHICH_BAG $(ls)
}

list_on_chef_server(){
	cd $CHEF
	echo "-------------------- Current Chef Server Data Bags --------------------"
	knife data bag list
}

cd $DATA_BAGS
check_db_exists
if [ $? -eq 0 ]
then
	upload_db
fi 
list_on_chef_server