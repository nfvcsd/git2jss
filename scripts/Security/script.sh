#!/bin/bash
# All Security Script
# NFV 2018-2019
##################

# Enable automatic Updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -int 1

# Enable auto app Updates
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool TRUE

# enforce Updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true && sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

# Enforce restart Updates
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool TRUE

# Turn off bluetooth if no paired device exists
sudo defaults write /Library/Preferences/com.apple.Bluetooth \ ControllerPowerState -int 0
sudo killall -HUP blued

# Show blutooth status in menu Bar
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

# Ensure network time is set properly
sudo systemsetup -setnetworktimeserver time.apple.com
sudo systemsetup –setusingnetworktime on

# Disable ntp server on loopback
echo "restrict lo interface" >> /etc/ntp-restrict.conf
echo "ignore wildcard interface listen lo" >> /etc/ntp-restrict.conf


# set screensaver idle time to 10 minutes
defaults -currentHost write com.apple.screensaver idleTime -int 600

# Turn off remote events
sudo systemsetup -setremoteappleevents off

# Set Gatekeeper
sudo spctl --master-enable

# Enable Firewall
defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Set Firewall Stealth Mode
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Enable Location Services
sudo launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist

# Allow Printers & Scanners for Standard Accounts:
/usr/sbin/dseditgroup -o edit -a staff -t group _lpadmin

# Allow Energy Saver Access for Standard Accounts:
security authorizationdb write system.preferences allow;security authorizationdb write system.preferences.energysaver allow