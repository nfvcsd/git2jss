#!/bin/bash
# NFV First Run DEP Script
# 10/23/17
# asnyder@nfv.k12.ia.us


caffeinate -dis & pid=$!

sudo jamf policy -event nomad

sudo killall -HUP loginwindow


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

/Applications/Utilities/DEPNotify.app/Contents/MacOS/DEPNotify -jamf -fullScreen &>/dev/null &

echo "Command: DeterminateManual: 10" >> /var/tmp/depnotify.log
echo "Command: KillCommandFile:" >> /var/tmp/depnotify.log

#####################################
#
# Preferences
#
#####################################

# set computer name
sudo jamf policy -event setname
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Enable ARD and hide <500 users
sudo jamf policy -event hide500

sudo jamf policy -event ARD
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Set Preferences
sudo jamf policy -event addprint
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

sudo jamf policy -event settz
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

####################################
#
# ADMIN TOOLS
#
####################################

#echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Lanschool #
echo "Status: Installing LanSchool Student" >> /var/tmp/depnotify.log
sudo jamf policy -event veslanschool
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# install iboss
echo "Status: Installing iboss" >> /var/tmp/depnotify.log
sudo jamf policy -event iboss
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install cocoa
echo "Status: Installing LanSchool Cocoa" >> /var/tmp/depnotify.log
sudo jamf policy -event cocoa
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Bit Bar
echo "Status: Installing Bit Bar" >> /var/tmp/depnotify.log
sudo jamf policy -event bitbar
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#############################
#
# INSTALL SOFTWARE
#
##############################

#install Browsers #
echo "Status: Installing Firefox" >> /var/tmp/depnotify.log
sudo jamf policy -event firefox
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Chrome" >> /var/tmp/depnotify.log
sudo jamf policy -event chrome 
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#install office #
echo "Status: Installing Microsoft Office" >> /var/tmp/depnotify.log
sudo jamf policy -event office11
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Digital Editions #
echo "Status: Installing Digital Editions" >> /var/tmp/depnotify.log
sudo jamf policy -event digitaleditions
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install VLC #
echo "Status: Installing VLC" >> /var/tmp/depnotify.log
sudo jamf policy -event vlc
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Adobe Reader #
echo "Status: Installing Adobe Reader" >> /var/tmp/depnotify.log
sudo jamf policy -event adobereader
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Google Earth #
echo "Status: Installing Google Earth" >> /var/tmp/depnotify.log
sudo jamf policy -event googleearth
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install kidspiration #
echo "Status: Installing Kidspiration" >> /var/tmp/depnotify.log
sudo jamf policy -event kidspiration
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#install Lockdown browser #
echo "Status: Installing NWEA Lockdown Browser" >> /var/tmp/depnotify.log
sudo jamf policy -event lockdownbrowser
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#############    WE NEED SKETCHUP IN HERE STILL ##############################

# Install Type to Learn 4 #
echo "Status: Installing Type to Learn 4" >> /var/tmp/depnotify.log
sudo jamf policy -event typetolearn
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

################################
#
# Plugins
#
################################

#Install Shockwave #
echo "Status: Installing Shockwave" >> /var/tmp/depnotify.log
sudo jamf policy -event shockwave 
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#Install Flash #
echo "Status: Installing Flash" >> /var/tmp/depnotify.log
sudo jamf policy -event flash 
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Java #
echo "Status: Installing Java" >> /var/tmp/depnotify.log
sudo jamf policy -event java
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Silverlight #
echo "Status: Installing Silverlight" >> /var/tmp/depnotify.log
sudo jamf policy -event silverlight
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

################################
#
# Printers
#
################################
sudo pkill "Adobe Digital Editions"
# Install HP Printers #
echo "Status: Installing HP Print Drivers" >> /var/tmp/depnotify.log
sudo jamf policy -event hpprint
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Updating Computer Record" >> /var/tmp/depnotify.log
sudo jamf recon
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
#echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
kill $pid
sleep 10

# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log
