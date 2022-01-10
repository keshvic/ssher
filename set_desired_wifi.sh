#!/bin/bash
# This script switches to desired wifi and notes down public IP and then reverts to original wifi
# 
# Note: This script needs to be put in logon or cron 
# 
#
if [ -e network_ssid.txt ] # check if desired network ssid is already saved for the script usage
then
    desired_ssid=$(cat network_ssid.txt)
else
    echo "your desired wifi network is not provided. Exiting"
fi
os=$(uname) # what your os
if [[ $os == "Darwin" ]] # Darwin = MAC
then
    echo "you are on a MAC"
    existing_wifi_network=$(networksetup -getairportnetwork en0 | rev | awk '{print $1}' | rev)
    if [[ $existing_wifi_network != $desired_ssid ]]
    then
        networksetup -setairportnetwork en0 "$desired_ssid"
        n1_wifi_network=$(networksetup -getairportnetwork en0 | rev | awk '{print $1}' | rev)
        if [[ $n1_wifi_network == $desired_ssid ]]
        then
            bash ./get_public_ip.sh
        fi
        networksetup -setairportnetwork en0 "$existing_wifi_network"
        n2_wifi_network=$(networksetup -getairportnetwork en0 | rev | awk '{print $1}' | rev)
        if [[ $n2_wifi_network == $existing_wifi_network ]]
        then
            echo "wifi network change script completed successfully"
            echo "your current wifi network is: $n2_wifi_network"
        fi
    else
        echo "no change required. You are already on desired wifi network"
        bash get_public_ip.sh
    fi
elif [[ $os == "Linux" ]]
then
    echo "you are on a Linux/Windows Sub-system for Linux"
    #work in progress
    #Not Possible Today
fi