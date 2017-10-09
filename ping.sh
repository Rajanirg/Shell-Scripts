#!/bin/bash



# check sites
function check_sites {
	for i in $(cat sites.txt)
	do
		ping -c2 $i
		if [ ! $? -eq 0 ]
		then
			echo "$i -- DOWN" | mail -s "SITE DOWN!!!" "amgill1234@gmail.com"
		else
			echo "$i -- UP"
		fi
	done
}


# check services
function check_services {
	for i in $(cat services.txt)
	do
		service $i status
		if [ $? -ne 0 ]
		then
			echo "$i -- DOWN" | mail -s "SERVICE DOWN!!!" "amgill1234@gmail.com"
			echo "$i -- starting...."
			service $i start
		else
			echo "$i -- UP"
			echo "SKIPPING START -- NOT NEEDED"
		fi
	done
}

check_sites





