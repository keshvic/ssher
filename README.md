**Objective**
The objective of this project is to set up ssh config such that I could ssh to my public ip lab without having to verify my public ip.

**What Script does**
Three things
1. Checks if my current Mac wifi Network is the one where my Lab server is hooked up
2. Notes down the public IP for the Network (my ISP keeps changing that)
3. Updates my Mac ssh config to latest public IP

**Why I had to write this script**
I have to often login to my home linux server to check one or other thing, however I am mostly in corporate VPN (which updates my routes) and often I cannot ssh to my home server on LAN and have to SSH from public network. Another problem is that I don't have static IP provided by my ISP so I need to manually check my public IP before I could ssh to my server. 

**Notes**
1. It is assumed that you have ~/.ssh/config configured with Aliases for home lab
2. The script will use networksetup command of macos to change the wifi network.
3. You might want to use cron or something to keep this running automatically behind the scenes.
4. Use it at your own risk. No guarantees or warrantees.  

