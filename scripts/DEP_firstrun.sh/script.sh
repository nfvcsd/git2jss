#!/bin/bash
# NFV First Run DEP Script
# 2/4/19
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

echo "Command: DeterminateManual: 10" >> /var/tmp/depnotify.log
echo "Command: KillCommandFile:" >> /var/tmp/depnotify.log

# set computer name
echo "Status: Naming computer" >> /var/tmp/deponotify.log
sudo jamf policy -event setname
sudo jamf policy -event outset
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Enable ARD and hide <500 users
sudo jamf policy -event hide500

echo "Status: Enabling ARD" >> /var/tmp/deponotify.log
sudo jamf policy -event ARD
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Set Preferences
sudo jamf policy -event addprint

sudo jamf policy -event settz
echo "Status: Running Security Scripts" >> /var/tmp/deponotify.log
sudo jamf policy -event security
sudo jamf policy -event dockutil
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Install Lanschool
echo "Status: Installing Lanschool" >> /var/tmp/deponotify.log
sudo jamf policy -event hslanschool
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Install IBOSS
#echo "Status: Installing Iboss" >> /var/tmp/deponotify.log
#sudo jamf policy -event iboss
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Install cocoa
echo "Status: Installing Cocoa" >> /var/tmp/deponotify.log
sudo jamf policy -event cocoa
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
# Install Bit Bar
echo "Status: Installing BitBar" >> /var/tmp/deponotify.log
sudo jamf policy -event bitbar
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
#install Browsers
echo "Status: Installing FireFox" >> /var/tmp/deponotify.log
sudo jamf policy -event firefox
echo "Status: Installing Chrome" >> /var/tmp/deponotify.log
sudo jamf policy -event chrome
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
#install office
echo "Status: Installing Office 2016" >> /var/tmp/deponotify.log
sudo jamf policy -event office16
sudo jamf policy -event docksetup
echo "Status: Updating Computer Record" >> /var/tmp/deponotify.log
sudo jamf recon
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
echo "Command: DeterminateManualStep:" >> /var/tmp/depnotify.log
#echo "Command: Notification: Restarting in 10 seconds." >> /var/tmp/depnotify.log

sleep 10

#echo "Status: Restarting" >> /var/tmp/depnotify.log

#echo "Command: Quit" >> /var/tmp/depnotify.log

# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log
# rm -rf /var/tmp/depnotify.log

# sudo shutdown -r now