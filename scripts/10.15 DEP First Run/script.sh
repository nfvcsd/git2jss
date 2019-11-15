#!/bin/bash
# NFV First Run DEP Script
# 11/1/19
# asnyder@nfv.k12.ia.us

jamf policy -event nomad

killall -HUP loginwindow

jamf policy -event depnotify

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
jamf policy -event setname

# Enable ARD and hide <500 users
jamf policy -event hide500

jamf policy -event ARD

# Set Preferences
jamf policy -event addprint
jamf policy -event settz
jamf policy -event security
jamf policy -event dockutil

# Install Lanschool
jamf policy -event hslanschool

# Install Bit Bar
jamf policy -event bitbar
jamf recon

sleep 10

# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log