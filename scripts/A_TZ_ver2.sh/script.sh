#!/bin/sh

#Use "/usr/sbin/systemsetup -listtimezones" to see a list of available list time zones.
#This script is meant to be used with Casper.
# $4 variable should be filled with the TimeZone information (ie: America/Chicago, America/New_York )
# $5 variable should be filled with the TimeServer information (ie: time.apple.com )
TimeZone="America/Chicago"
TimeServer="time.apple.com"

############# Pause for network services #############
/bin/sleep 10
######################################################

#Disable network time
/usr/sbin/systemsetup -setusingnetworktime off

#Set an initial time zone
/usr/sbin/systemsetup -settimezone "$TimeZone"

#Set specific time server
/usr/sbin/systemsetup -setnetworktimeserver "$TimeServer"

# enable location services
/bin/launchctl unload /System/Library/LaunchDaemons/com.apple.locationd.plist
uuid=`ioreg -rd1 -c IOPlatformExpertDevice | awk -F'"' '/IOPlatformUUID/{print $4}'`

/usr/bin/defaults write /private/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd."$uuid" LocationServicesEnabled -int 1
/usr/bin/defaults write /private/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.notbackedup."$uuid" LocationServicesEnabled -int 1
/usr/sbin/chown -R _locationd:_locationd /var/db/locationd
/bin/launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist

# set time zone automatically using current location
/usr/bin/defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true

#Re-enable network time
/usr/sbin/systemsetup -setusingnetworktime on

#Detect the timezone
/usr/sbin/systemsetup -gettimezone

#Get the time from time server
/usr/sbin/systemsetup -getnetworktimeserver

exit 0