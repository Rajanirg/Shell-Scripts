CHEF="$HOME/chef-repo"
ENV='all_envs.txt'
COOKBOOKS='required_cookbooks.txt'
ROLES='roles/*.rb'

cd $CHEF
pwd
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin
## upload all cookbooks
echo "=============== Uploading required cookbooks ==============="
for i in $(cat $COOKBOOKS); do
	if [ ! -d cookbooks/$i ]
	then
		echo $i "directory does not exists!!!"
	else
		knife cookbook upload $i
	fi
done
echo "=============== All cookbooks successfully uploaded! ==============="


## upload all environments
echo "=============== Uploading all envrionments all_envs.txt ==============="
for i in $(cat $ENV); do
 if [ -e $i.rb ]
 then
     knife environment from file $i".rb"
 else
 	echo "$i.rb does not exist in ${HOME}/chef-repo" 
 fi
done
echo "=============== All ENV successfully uploaded! ==============="


## upload all roles
echo "=============== Uploading all roles in roles/ directory ==============="
for i in $(ls $ROLES); do
	knife role from file $i
done
echo "=============== All Roles sucessfully uploaded! ==============="
