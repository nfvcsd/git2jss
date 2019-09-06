#!/bin/bash
# NFV First Run DEP Script
# 10/23/17
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

/Applications/Utilities/DEPNotify.app/Contents/MacOS/DEPNotify -fullScreen &>/dev/null &

echo "Command: DeterminateManual: 21" >> /var/tmp/depnotify.log
echo "Command: KillCommandFile:" >> /var/tmp/depnotify.log
#####################################
#
#
# Preferences
#
#####################################
# set computer name
echo "Status: Running Security Scripts" >> /var/tmp/deponotify.log
sudo jamf policy -event setname
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Enable ARD and hide <500 users
sudo jamf policy -event hide500
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

sudo jamf policy -event ARD
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Set Preferences
sudo jamf policy -event addprint
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

sudo jamf policy -event settz
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

sudo jamf policy -event security
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

####################################
#
# ADMIN TOOLS
#
#
####################################

echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Install Lanschool Teacher
echo "Status: Installing Lanschool Teacher" >> /var/tmp/depnotify.log
sudo jamf policy -event lanschoolteacher
sudo pkill [Tt]eacher
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Admin Tools" >> /var/tmp/depnotify.log
# Install cocoa
sudo jamf policy -event cocoa
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Bit Bar
sudo jamf policy -event bitbar
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#############################
#
#
# INSTALL SOFTWARE
#
#
#
##############################
echo "Status: Installing Software" >> /var/tmp/depnotify.log

#install Browsers #
echo "Status: Installing Firefox" >> /var/tmp/depnotify.log
sudo jamf policy -event firefox
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Google Chrome" >> /var/tmp/depnotify.log
sudo jamf policy -event chrome
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#install office #
echo "Status: Installing Microsoft Office 2016" >> /var/tmp/depnotify.log
sudo jamf policy -event office16
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install VLC #
echo "Status: Installing VLC Media Player" >> /var/tmp/depnotify.log
sudo jamf policy -event vlc
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Adobe Reader #
echo "Status: Installing Adobe Reader" >> /var/tmp/depnotify.log
sudo jamf policy -event adobereader
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
################################
#
# Plugins
#
################################
echo "Status: Installing Plugins" >> /var/tmp/depnotify.log

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
#
# Printers
#
#
################################
# Install HP Printers #
echo "Status: Installing Printer Drivers" >> /var/tmp/depnotify.log
#sudo jamf policy -event esprinter
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Updating Computer Record" >> /var/tmp/depnotify.log
sudo jamf recon
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log


# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log
