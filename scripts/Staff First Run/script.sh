#!/bin/bash
# NFV First Run DEP Script
# 10/23/17
# asnyder@nfv.k12.ia.us

# Install Rosetta if required

arch=$(/usr/bin/arch)
if [ "$arch" == "arm64" ]; then
    echo "Apple Silicon - Installing Rosetta"
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
elif [ "$arch" == "i386" ]; then
    echo "Intel - Skipping Rosetta"
else
    echo "Unknown Architecture"
fi

sudo jamf policy -event depnotify

sudo jamf policy -event nomad

# Wait for user to be logged in
dockStatus=$(pgrep -x Dock)
echo "Waiting for Desktop"
while [ "$dockStatus" == "" ]; do
  echo "Desktop is not loaded. Waiting."
  sleep 2
  dockStatus=$(pgrep -x Dock)
done

# Call DEPNotify

/Applications/Utilities/DEPNotify.app/Contents/MacOS/DEPNotify -fullScreen &>/dev/null &

installs=(setname hide500 ARD addprint settz security bitbar munki)
# Get array length for the progress bar
echo "Command: DeterminateManual: ${#installs[@]}" >> /var/tmp/depnotify.log
echo "Command: KillCommandFile:" >> /var/tmp/depnotify.log
# Loop over installs array and install items
for i in ${installs[@]}; do
    echo "Status: Installing ${i}" >> /var/tmp/deponotify.log
    jamf policy -event ${i}
    echo "Command: DeterminateManualStep" >> /var/tmp/deponotify.log
done
echo "Status: Updating Computer Record" >> /var/tmp/depnotify.log
sudo jamf recon

# Remove DEPNotify Log
echo "Command: Restart: Your computer will now restart." >> /var/tmp/depnotify.log
