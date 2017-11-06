#!/bin/bash

### attempt_1 -- Installs Chef Server for Rhel 

#### NOT DONE YET
## TO DO:
## make the 2nd function idempotent

CHEF_RPM="https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chef-server-11.0.8-1.el6.x86_64.rpm"
PACKS=("git" "tree" "wget" "vim" "unzip" "ruby" "curl")
DL_DIR="/home/chef"


install_packs(){
	for pack in ${PACKS[@]}; do
		yum list installed $pack > /dev/null 2>&1
		if [ $? -eq 0 ]
		then
			echo "$pack is already installed"
		else
			yum install $pack -y > /dev/null 2>&1
		fi
	done
}

install_chef_rpm(){
	if [ ! -d $DL_DIR ]
	then
		mkdir $DL_DIR
	fi
	cd $DL_DIR
	yum list installed chef-server > /dev/null 2>&1
	if [ ! $? -eq 0 ]
	then
		if [ ! -e 'chef-server-11.0.8-1.el6.x86_64.rpm' ]
		then 
			echo "chef-server-11.0.8-1.el6.x86_64.rpm does not exist"
			wget $CHEF_RPM
		fi
		rpm -ivh *.rpm
		chef-server-ctl reconfigure
	fi
}
