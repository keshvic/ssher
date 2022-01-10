#!/bin/bash
# This script checks your host os and wifi and accordingly finds out your public IP
# 
# Note: This script needs to be put in cron (daily or howsoever you predict public IP change)
# 
#
if [ -e network_ssid.txt ] # check if desired network ssid is already saved for the script usage
then
    ssid=`cat network_ssid.txt` 
    read -p "Do you want to update desired wifi network name (y/n): " new_ssid_choice
    if [[ $new_ssid_choice == "y" ]]
    then
        read -p "Enter your new wifi network name (SSID): " new_ssid
        echo "your new desired wifi network is: $new_ssid"
        echo "${new_ssid}" > network_ssid.txt # Now the desired network ssid is updated.
else
    read -p "Enter your wifi network name (SSID): " ssid 
    echo "your desired wifi network is: $ssid"
    echo "${ssid}" > network_ssid.txt # Now the desired network ssid is saved.
fi
os=$(uname) # what your os
if [[ $os == "Darwin" ]] # Darwin = MAC
then
    echo "you are on a MAC"
    interface=$(networksetup -listallhardwareports | grep -A1 'Wi-Fi' | grep Device | awk '{print $2}')
    wifi_network=$(networksetup -getairportnetwork en0 | rev | awk '{print $1}' | rev)
    echo "${wifi_network}" > current_wifi_network.txt 
    echo "your current wifi network is: $wifi_network"
elif [[ $os == "Linux" ]]
then
    echo "you are on a Linux/Windows Sub-system for Linux"
    #work in progress
    #Not Possible Today
fi
    


