#!/bin/bash
tempvar=$(dirname "$0")
cd "$tempvar"

echo "Uninstalling iBoss Mobile Agent (Mac 10.7-10.11), must be run as root..."

sudo sed -i '/^[#].*ibmc/d' /etc/hosts

sudo launchctl unload /Library/LaunchDaemons/ibossmobile.plist > /dev/null 2>&1
sudo launchctl unload /Library/LaunchDaemons/ibossmobile.monitor.plist > /dev/null 2>&1
sudo launchctl unload /Library/LaunchDaemons/iboss.mobile.reload.plist > /dev/null 2>&1
sudo launchctl unload /Library/LaunchDaemons/iboss.mobile.agent.plist > /dev/null 2>&1
sudo launchctl unload /Library/LaunchDaemons/iboss.mobile.client.plist > /dev/null 2>&1

sudo rm -f /bin/ibmc_*  
sudo rm -f /bin/iboss*version
sudo rm -rf /usr/share/ibmblock
sudo rm -f /bin/IMC
sudo rm -f /bin/IBMC
sudo rm -f /bin/ibossmobile.sh
sudo rm -f /bin/ibossmobile-monitor.sh
sudo rm -f /bin/ibmc-reload.sh
sudo rm -f /Library/LaunchDaemons/ibossmobile.plist
sudo rm -f /Library/LaunchDaemons/ibossmobile-monitor.plist
sudo rm -f /bin/iboss.mobile.agent.sh
sudo rm -f /bin/iboss.mobile.reload.sh
sudo rm -f /bin/iboss.mobile.client.sh
sudo rm -f /Library/LaunchDaemons/iboss.mobile.reload.plist
sudo rm -f /Library/LaunchDaemons/iboss.mobile.agent.plist
sudo rm -f /Library/LaunchDaemons/iboss.mobile.client.plist
sudo rm -f /etc/iboss.conf
sudo rm -f /etc/ibmc.conf
sudo rm -f /var/log/ibmc*.log /var/log/iboss*
# Yosemtite 10/10
sudo rm -f \
/bin/IBNID_im /usr/local/bin/IBNID_un /usr/local/bin/IBNID_cn /usr/local/bin/IBNID_hid \
/bin/iboss.netid.sh \
/bin/iboss.setPAC.sh \
/Library/LaunchDaemons/iboss.netid.plist \
/Library/LaunchDaemons/iboss.setPAC.plist \
/etc/iboss.conf \
/var/log/iboss.*

# El Capitan 10.11
sudo rm -f \
/usr/local/bin/IBNID_im /usr/local/bin/IBNID_un /usr/local/bin/IBNID_cn /usr/local/bin/IBNID_hid \
/usr/local/bin/iboss.netid.sh \
/usr/local/bin/iboss.setPAC.sh 


sudo defaults delete com.apple.loginwindow LoginHook > /dev/null 2>&1

sudo ipfw delete 1 > /dev/null 2>&1
sudo ipfw delete 2 > /dev/null 2>&1
sudo ipfw delete 3 > /dev/null 2>&1
sudo ipfw delete 4 > /dev/null 2>&1
sudo ipfw delete 5 > /dev/null 2>&1
sudo ipfw -f flush
sudo ip6fw -f flush

#killall IMC
killall IBMC > /dev/null 2>&1

echo "Uninstall Complete!"


