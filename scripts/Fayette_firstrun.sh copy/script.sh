#!/bin/sh

#####################################
# Script for imaging White Macbooks #
# (C) Alex Snyder 2018              #
#####################################


#sudo jamf policy -event enrollmenthelper
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

/Applications/Utilities/DEPNotify.app/Contents/MacOS/DEPNotify -fullScreen &>/dev/null &

echo "Command: DeterminateManual: 10" >> /var/tmp/depnotify.log
echo "Command: KillCommandFile:" >> /var/tmp/depnotify.log

# set computer name

sudo jamf policy -event setname
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Enable ARD and hide <500 users
sudo jamf policy -event hide500

sudo jamf policy -event ARD
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Set Preferences
sudo jamf policy -event addprint

sudo jamf policy -event settz

echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Lanschool FIX THIS FOR Fayette
#sudo jamf policy -event hslanschool
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Install IBOSS

#sudo jamf policy -event iboss
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Install cocoa

sudo jamf policy -event cocoa
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Install Bit Bar

sudo jamf policy -event bitbar
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#
# SOFTWARE
#

#install Browsers

sudo jamf policy -event firefox

sudo jamf policy -event chrome
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
#install office

#sudo jamf policy -event office11


# Install Lockdown Browser
sudo jamf policy -event lockdownbrowser

# Install VLC
sudo jamf policy -event vlc

# Istall google earth
sudo jamf policy -event googleearth

#
# PLUGINS
#

# Install Flash

sudo jamf policy -event flash

# Install java

sudo jamf policy -event java

# Install Shockwave
sudo jamf policy -event shockwave

# Install silverlight
sudo jamf policy -event silverlight

#install adobe reader
sudo jamf policy -event adobereader

sudo jamf recon
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

sleep 10

echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log
