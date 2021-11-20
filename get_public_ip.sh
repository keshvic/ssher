#!/bin/bash
# This script checks your host os, wifi and accordingly finds out your public IP
# 
# Note: This script needs to be put in cron (daily)
# 
#
if [ -e network_ssid.txt ] # check network ssid is already known
then
    :
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
    if  [[ $wifi_network == "<read comment>" ]]  # enter your wifi network name (SSID) here
    then
        public_ip=$(curl -s ifconfig.me | egrep '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\.[0-9]{3}')
        echo $public_ip | tee public_ip.txt
    fi
elif [[ $os == "Linux" ]]
then
    echo "you are on a Linux"
    #work in progress
    #Not Possible Today
fi

    


