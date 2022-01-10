#!/bin/bash
# This script finds out your public IP
# 
# Note: This script needs to be put in cron (daily)
# 
#
os=$(uname) # what your os

if [ -e network_ssid.txt ] # check if desired network ssid is already saved for the script usage
then
    ssid=$(cat network_ssid.txt)
    if [[ $os == "Darwin" ]] # Darwin = MAC
    then
        interface=$(networksetup -listallhardwareports | grep -A1 'Wi-Fi' | grep Device | awk '{print $2}')
        wifi_network=$(networksetup -getairportnetwork en0 | rev | awk '{print $1}' | rev)
        if  [[ $wifi_network == "$ssid" ]]  
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
else
    echo "you haven't save desired wifi network. Script wont' work."
fi
if [ -e public_ip.txt ]
then
    pubip=`cat public_ip.txt`
    echo "success!! your public ip is ${pubip}"
else
    echo "script failed. No public IP found"
fi
