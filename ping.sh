#!/bin/bash



# check sites
fucntion check_sites {
	for i in $(cat sites.txt)
	do
		ping -c2 $i > /dev/null
		if [ $? -ne 0 ]
		then
			ehco "$i -- DOWN" | mail -s "SITE DOWN!!!" "amgill1234@gmail.com"

		else
			echo "$i -- UP"
		fi
	done
}


# check services
function check_services {
	for i in $(cat services.txt)
	do
		service $i status > /dev/null 2<&1
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




