#!/bin/bash
# This script updates your ~/.ssh/config file with desired public IP
# 
# Note: This script needs to be put in cron (daily)
# Note that my ~/.ssh/config file is in following format
# -------------
# Host home_linux_public (there has to be some keyword in name which you can grep, in my case it is 'public')
#  	    HostName aaa.bbb.ccc.ddd
# 	    User ksh
#   	Other settings ...
# -------------
new_public_ip=$(cat public_ip.txt)
echo "your new ip $new_public_ip"
old_public_ip=$(grep -A10 public ~/.ssh/config | grep HostName | awk '{print $2}')
if [[ "$new_public_ip" = "$old_public_ip"]]
then
    echo "your ip hasn't changed. all done!"
    break
elif [ -z "$old_public_ip" ]
then
    echo "you don't have old ip set"
    sed -i.bak "s/HostName $old_public_ip/HostName $new_public_ip/" ~/.ssh/config
else
    echo "your old ip $old_public_ip"
    sed -i.bak "s/$old_public_ip/$new_public_ip/" ~/.ssh/config
fi
echo "all done!"
