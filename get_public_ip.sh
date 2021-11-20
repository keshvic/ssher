#!/bin/bash
# This script checks your host os, wifi and accordingly finds out your public IP
# 
# Note: This script needs to be put in cron (daily)
# 
#
if [ -e network_ssid.txt ] # check network ssid is already known
then
    ssid=`cat network_ssid.txt` 
else
    read -p "Enter your wifi network name (SSID: " ssid 
    echo "verifying your network reesenfinch"
    echo "${ssid}" > network_ssid.txt
fi
os=$(uname) # what your os
if [[ $os == "Darwin" ]] # Darwin = MAC
then
    echo "you are on a MAC"
    interface=$(networksetup -listallhardwareports | grep -A1 'Wi-Fi' | grep Device | awk '{print $2}')
    wifi_network=$(networksetup -getairportnetwork en0 | rev | awk '{print $1}' | rev)
    if  [[ $wifi_network == "$ssid" ]]  # enter your wifi network name (SSID) here
    then
        public_ip=$(curl -s https://ifconfig.me | egrep '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
        echo $public_ip | tee public_ip.txt
    else
        echo "you are on different wifi network - ($wifi_network), you should be on $ssid to continue"	    
        exit 0
    fi
elif [[ $os == "Linux" ]]
then
    echo "you are on a Linux"
    #work in progress
    #Not Possible Today
fi
if [ -e public_ip.txt ]
then
    pubip=`cat public_ip.txt`
    echo "success!! your public ip is ${pubip}"
fi

    


