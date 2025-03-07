#!/bin/bash
# NFV First Run DEP Script
# 4/14/21
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

dockStatus=$(pgrep -x Dock)
log "Waiting for Desktop"
while [ "$dockStatus" == "" ]; do
  log "Desktop is not loaded. Waiting."
  sleep 2
  dockStatus=$(pgrep -x Dock)
done
jamf policy -event munki
jamf recon
jamf policy -event jamjar
jamf recon
jamf policy -event depnotify
jamf policy -event nfvpython
# Call DEPNotify
/Applications/Utilities/DEPNotify.app/Contents/MacOS/DEPNotify -fullScreen -jamf &>/dev/null &
/usr/local/munki/bin/managedsoftwareupdate -a
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


# Install Bit Bar
jamf policy -event bitbar
jamf recon

jamf policy

jamf policy

jamf policy

sleep 10

# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log