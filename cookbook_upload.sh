#!/bin/bash

CHEF_REPO="$HOME/chef-repo"
COOKBOOKS="$CHEF_REPO/cookbooks"
WHICH_COOKBOOK=$1
OLD_VERSION=$2
NEW_VERSION=$3
FIND="version '$2'"
REPLACE="version '$3'"
METADATA=$COOKBOOKS/$WHICH_COOKBOOK/metadata.rb


cookbook_exists(){
	if [ ! -e $METADATA ]
	then
		echo "$WHICH_COOKBOOK DOES NOT EXISTS!!!"
		exit 1
	fi
}

update_metadata(){
	sed -iv "s/$FIND/$REPLACE/g" $METADATA
}

upload_cookbook(){
	knife cookbook upload $WHICH_COOKBOOK
}

cookbook_exists
cd $COOKBOOKS
update_metadata
upload_cookbook