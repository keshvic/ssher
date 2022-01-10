#!/bin/bash
# This script is the main script which calls other script and run them one by one 
# Basically following steps are done via script
# Note down your current and desired (for public IP) wifi network 
# Switch to your desired public IP (if need be)
# Note down your public IP and update the ssh config file
#
# Note: This script needs to be put in cron (daily or howsoever you predict public IP change)
# 
#
bash get_current_wifi.sh
bash set_desired_wifi.sh
bash set_public_ip.sh