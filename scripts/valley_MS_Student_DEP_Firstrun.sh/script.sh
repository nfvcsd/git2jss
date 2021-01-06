#!/bin/bash
# NFV First Run DEP Script
# 4/23/19
# asnyder@nfv.k12.ia.us

arch=$(/usr/bin/arch)
if [ "$arch" == "arm64" ]; then
    echo "Apple Silicon - Installing Rosetta"
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
elif [ "$arch" == "i386" ]; then
    echo "Intel - Skipping Rosetta"
else
    echo "Unknown Architecture"
fi

caffeinate -dis & pid=$!

sudo jamf policy -event nomad

sudo killall -HUP loginwindow

loginWindowStatus=$(pgrep -x loginwindow)
log "Waiting for Login Window"
while [ "$loginWindowStatus" == "" ]; do
  log "Login Window is not loaded. Waiting."
  sleep 2
  loginWindowStatus=$(pgrep -x loginwindow)
done


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
#sudo jamf policy -event hide500

sudo jamf policy -event ARD
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Set Preferences
sudo jamf policy -event addprint
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

####################################
#
# ADMIN TOOLS
#
####################################

#echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Lanschool
echo "Status: Installing LanSchool Student" >> /var/tmp/depnotify.log
sudo jamf policy -event mslanschool
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# install iboss
sudo jamf policy -event iboss
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install cocoa
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Bit Bar
sudo jamf policy -event bitbar
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install outset
sudo jamf policy -event outset
#############################
#
# INSTALL SOFTWARE
#
##############################

#install Browsers
echo "Status: Installing Firefox" >> /var/tmp/depnotify.log
sudo jamf policy -event firefox
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Chrome" >> /var/tmp/depnotify.log
sudo jamf policy -event chrome
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#install office
echo "Status: Installing Microsoft Office" >> /var/tmp/depnotify.log
sudo jamf policy -event office16
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# install audacity
echo "Status: Installing Audacity" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Audacity Plugins" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Digital Editions
echo "Status: Installing Digital Editions" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install VLC
echo "Status: Installing VLC" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Adobe Reader
echo "Status: Installing Adobe Reader" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Dropbox
echo "Status: Installing Dropbox" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install GIMP
echo "Status: Installing GIMP" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Hackety Hack
echo "Status: Installing Hackety Hack" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Google Earth
echo "Status: Installing Google Earth" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Inspiration
echo "Status: Installing inspiration" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#install Lockdown browser
echo "Status: Installing NWES Lockdown Browser" >> /var/tmp/depnotify.log
sudo jamf policy -event lockdownbrowser
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install MuseScore
echo "Status: Installing MuseScore" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Logger
echo "Status: Installing Logger" >> /var/tmp/depnotify.log
sudo jamf policy -event logger
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#############    WE NEED SKETCHUP IN HERE STILL ##############################

# Install Type to Learn 4
echo "Status: Installing Type to Learn 4" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

################################
#
# Plugins
#
################################


#Install Shockwave
echo "Status: Installing Shockwave" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#Install Flash
echo "Status: Installing Flash" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Java
echo "Status: Installing Java" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Silverlight
echo "Status: Installing Silverlight" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
sudo pkill "Adobe Digital Editions"
################################
#
# Printers
#
################################

# Install HP Printers
echo "Status: Installing HP Printers" >> /var/tmp/depnotify.log
#sudo jamf policy -event hpprint
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Updating Computer Record" >> /var/tmp/depnotify.log
sudo jamf recon
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
#echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

sleep 10

kill $pid

# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart - Thanks Tracy." >> /var/tmp/depnotify.log
