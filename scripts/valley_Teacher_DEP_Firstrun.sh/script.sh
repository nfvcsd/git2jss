#!/bin/bash
# NFV First Run DEP Script
# 6/22/20
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

echo "Command: DeterminateManual: 31" >> /var/tmp/depnotify.log
echo "Command: KillCommandFile:" >> /var/tmp/depnotify.log
#####################################
#
#
# Preferences
#
#####################################
echo "Status: Running Security Scripts" >> /var/tmp/depnotify.log

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
#
####################################


# Install Lanschool Teacher
echo "Status: Installing LanSchool Teacher" >> /var/tmp/depnotify.log
sudo jamf policy -event lanschoolteacher
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Admin Tools" >> /var/tmp/depnotify.log

# Install cocoa
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
sudo jamf policy -event munki
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
echo "Status: Installing Firefox" >> /var/tmp/depnotfiy.log
sudo jamf policy -event firefox
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Google Chrome" >> /var/tmp/depnotify.log
sudo jamf policy -event chrome 
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#install office #
echo "Status: Installing Microsoft Office 2016" >> /var/tmp/depnotify.log
sudo jamf policy -event office16
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# install audacity #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Digital Editions #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Skype #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install VLC #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Adobe Reader #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Dropbox #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install GIMP #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Hackety Hack #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Google Earth #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Inspiration #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install kidspiration #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#install Lockdown browser #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install MuseScore #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

################################
#
# Plugins
#
################################
echo "Status: Installing Plugins" >> /var/tmp/depnotify.log
sleep 3

#Install Shockwave #
echo "Status: Installing Shockwave" >> /var/tmp/depnotify.log

echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#Install Flash #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Java #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Silverlight #
echo "Status: Installing Silverlight" >> /var/tmp/depnotify.log

echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log


################################
#
#
# Printers
#
#
################################

# Install HP Printers #
echo "Status: Installing HP Printer Drivers"
sudo jamf policy -event hpprint
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#sudo jamf policy -event valleyprint
#echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Konica Drivers

echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log


echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log


echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

sudo pkill [Tt]eacher

echo "Status: Updating Computer Record" >> /var/tmp/depnotify.log
sudo jamf recon

# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log
