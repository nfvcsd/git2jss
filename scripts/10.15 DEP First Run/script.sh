#!/bin/bash
# NFV First Run DEP Script
# 11/1/19
# asnyder@nfv.k12.ia.us

sudo jamf policy -event nomad

killall -HUP loginwindow

sudo jamf policy -event depnotify

# Wait for user to be logged in

dockStatus=$(pgrep -x Dock)
log "Waiting for Desktop"
while [ "$dockStatus" == "" ]; do
  log "Desktop is not loaded. Waiting."
  sleep 2
  dockStatus=$(pgrep -x Dock)
done

# Call DEPNotify
/Applications/Utilities/DEPNotify.app/Contents/MacOS/DEPNotify -fullScreen -jamf &>/dev/null &

# set computer name
sudo jamf policy -event setname

# Enable ARD and hide <500 users
sudo jamf policy -event hide500

sudo jamf policy -event ARD

# Set Preferences
sudo jamf policy -event addprint
sudo jamf policy -event settz
sudo jamf policy -event security
sudo jamf policy -event dockutil

# Install Lanschool
sudo jamf policy -event hslanschool

# Install Bit Bar
sudo jamf policy -event bitbar
sudo jamf recon

sleep 10

# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log