#!/bin/bash
##########################################################################################
# Computer Naming Script
#
#
#
#
#
#
#
#
#
#
#
##########################################################################################


# Set Global Vars
#######################################################################
# Figure out the hostname
#######################################################################

#Set the hostname

# figure out the user
user=$(/opt/nfv/bin/python3.8 -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

#figure out the user's full name
name=$(finger "$user" | awk -F: '{ print $3 }' | head -n1 | sed 's/^ //' )

# get first initial
finitial="$(echo "$name" | head -c 1)"

# get last name
ln="$(echo "$name" | cut -d \  -f 2)"

#Get Mac
mac=`networksetup -getmacaddress Wi-Fi | awk '{ field = substr($3,10,8) }; END{ print field }' | sed s/://g`


# add first and last together
un=($ln"_"$finitial"_"$mac)

un2=($ln"-"$finitial"-"$mac)

# clean up un to have all lower case
hostname=$(echo "$un" | awk '{print tolower($0)}')
hostname2=$(echo "$un2" | awk '{print tolower($0)}')

echo $hostname

sudo scutil --set HostName $hostname2
sudo scutil --set LocalHostName $hostname2
sudo scutil --set ComputerName $hostname
dscacheutil -flushcache