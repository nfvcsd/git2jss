#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin export PATH
#
# Apple Setup Helper
#
# demote newlly created user from admin user #501 to normal user
# and setup machine name correctly based on full name of user
#

# Hard coding userID to be default first userID, can change this later.
# 
TARGET_USER_ID=502
DEBUG_LOG_FILE=/Library/Logs/ash.log
DEBUG=true
#DEBUG=false

if $DEBUG ; then
	touch $DEBUG_LOG_FILE
fi

###############################################################################
#
# Apple Setup Assistant must be done
#
if [ ! -e "/var/db/.AppleSetupDone" ]; then
	echo WARN: AppleSetupDone file not found, exiting
	if $DEBUG ; then
		echo "WARN: AppleSetupDone file not found, exiting" >> $DEBUG_LOG_FILE
	fi
	exit 0
fi

#
# Apple Setup Assistant Helper must not have been previously run
# (or it must have been cleaned up using the admin cleanup tool)
#
if [ -e "/var/db/.AppleSetupHelperDone" ]; then
	echo WARN: AppleSetupHelperDone file found, exiting
	if $DEBUG ; then
		echo "WARN: AppleSetupHelperDone file found, exiting" >> $DEBUG_LOG_FILE
	fi
	exit 0
fi

#
# Must be the root user to run this application
#
if [ `id -u` != 0 ]; then
	echo $0: Please run this as root
	if $DEBUG ; then
		echo "$0: Please run this as root" >> $DEBUG_LOG_FILE
	fi
	exit 1
fi

#
# Create helper done lock file
#
touch /var/db/.AppleSetupHelperDone
if $DEBUG ; then
	echo "touch AppleSetupHelperDone is done" >> $DEBUG_LOG_FILE
fi
#
#
#
###############################################################################

#
# get username, first initial, lastname of UID 501  
# and last 6 hex digits of airport MAC address 
#
ASH_USERNAME=`dscl . -search /Users UniqueID 501 | awk '{print $1}; NR == 1 {exit}'`
if $DEBUG ; then
	echo "ASH_USERNAME = $ASH_USERNAME" >> $DEBUG_LOG_FILE
fi

ASH_FIRST_INITIAL=`dscl . -read /Users/${ASH_USERNAME} RealName | awk '{ field = substr($1,0,1) }; END{ print field }'`
if $DEBUG ; then
	echo "ASH_FIRST_INITIAL = $ASH_FIRST_INITIAL" >> $DEBUG_LOG_FILE
fi

ASH_LAST_NAME=`dscl . -read /Users/${ASH_USERNAME} RealName | awk '{ field = $NF }; END{ print field }'`
if $DEBUG ; then
	echo "ASH_LAST_NAME = $ASH_LAST_NAME" >> $DEBUG_LOG_FILE
fi

ASH_ETHERNET_HASH=`networksetup -getmacaddress Wi-Fi | awk '{ field = substr($3,10,8) }; END{ print field }' | sed s/://g`
if $DEBUG ; then
	echo "ASH_ETHERNET_HASH = $ASH_ETHERNET_HASH" >> $DEBUG_LOG_FILE
fi

dseditgroup -o edit -d "$ASH_USERNAME" -t user -n /Local/Default admin	

networksetup -setcomputername "${ASH_LAST_NAME}_${ASH_FIRST_INITIAL}_${ASH_ETHERNET_HASH}"
scutil --set LocalHostName "${ASH_LAST_NAME}-${ASH_FIRST_INITIAL}-${ASH_ETHERNET_HASH}"

defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

ASH_LOGIN_WINDOW_PID=`ps -Aj | grep -i loginwindow | grep -i $ASH_USERNAME | awk '{print $2}; NR == 1 {exit}'`
if $DEBUG ; then
	echo "ASH_LOGIN_WINDOW_PID = $ASH_LOGIN_WINDOW_PID" >> $DEBUG_LOG_FILE
fi

killall DirectoryServices

## removed logout / reboot options left them in script in case needed in the future 
#
# let DirectoryServices respawn
#
## sleep 2
#
## kill -9 $ASH_LOGIN_WINDOW_PID
#
## reboot -q
