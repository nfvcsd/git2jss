#!/bin/bash
# NFV First Run DEP Script
# 6/12/19
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
echo "Status: Installing LanSchool Teacher - TRACY EDITED THIS SCRIPT" >> /var/tmp/depnotify.log
sudo jamf policy -event lanschoolteacher
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
echo "Status: Installing Audacity" >> /var/tmp/depnotify.log
sudo jamf policy -event audacity
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Audacity Plugins" >> /var/tmp/depnotify.log
sudo jamf policy -event audacitylame
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Digital Editions #
echo "Status: Installing Adobe Digital Editions" >> /var/tmp/depnotify.log
sudo jamf policy -event digitaleditions	
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Skype #
echo "Status: Installing Skype" >> /var/tmp/depnotify.log
sudo jamf policy -event skype
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install VLC #
echo "Status: Installing VLC Media Player" >> /var/tmp/depnotify.log
sudo jamf policy -event vlc
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Adobe Reader #
echo "Status: Installing Adobe Reader" >> /var/tmp/depnotify.log
sudo jamf policy -event adobereader 
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Dropbox #
echo "Status: Installing Dropbox" >> /var/tmp/depnotify.log
sudo jamf policy -event dropbox
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install GIMP #
echo "Status: Installing Gimp" >> /var/tmp/depnotify.log
sudo jamf policy -event gimp
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Hackety Hack #
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Google Earth #
echo "Status: Installing Google Earth" >> /var/tmp/depnotify.log
sudo jamf policy -event googleearth
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Inspiration #
echo "Status: Installing Inspiration" >> /var/tmp/depnotify.log
sudo jamf policy -event inspiration
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install kidspiration #
echo "Status: Installing Kidspiration" >> /var/tmp/depnotify.log
sudo jamf policy -event kidspiration
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#install Lockdown browser #
echo "Status: Installing Lockdown Browser" >> /var/tmp/depnotify.log 
sudo jamf policy -event lockdownbrowser
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install MuseScore #
echo "Status: Installing MuseScore" >> /var/tmp/depnotify.log
sudo jamf policy -event musescore
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#############    WE NEED SKETCHUP IN HERE STILL ##############################

# Install Type to Learn 4 #
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
echo "Status: Installing HP Printer Drivers"
sudo jamf policy -event hpprint
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

#sudo jamf policy -event valleyprint
#echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

# Install Konica Drivers
echo "Status: Installing Elementary Konica Minolta Printer" >> /var/tmp/depnotify.log
sudo jamf policy -event valleyesprinter
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Middle School Konica Minolta Printer" >> /var/tmp/depnotify.log
sudo jamf policy -event valleymsprinter
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

echo "Status: Installing Admin Konica Minolta Printer" >> /var/tmp/depnotify.log
sudo jamf policy -event valleyadminprinter
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log

sudo pkill [Tt]eacher
sudo pkill "Adobe Digital Editions"
echo "Status: Updating Computer Record" >> /var/tmp/depnotify.log
sudo jamf recon

# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log
