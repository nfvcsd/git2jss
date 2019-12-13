#!/bin/bash
# Ensure AutoUpdates are on
defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -int 1
# Ensure App updates installs are on
defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool TRUE
# Enable system data files and security update installs
defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
# Turn off bluetooth when no connectable device present
defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0
killall -HUP blued
# Show Bluetooth in the status bar
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"
# Disable Remote Apple Events
systemsetup -setremoteappleevents off
# Enable Gatekeeper
spctl --master-enable
# Enable Firewall
defaults write /Library/Preferences/com.apple.alf globalstate - int 2
# Enable Location Services
launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist
# Disable Wake on Lan and Power Nap
pmset -a womp 0
# Disable IR Receiver
defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool no
# Enable secure keyboard entry in terminal
defaults write -app Terminal SecureKeyboardEntry -bool True
# Ensure AuditD is running
launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist
# Make sure Firewall Logging is on
/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
# Ensure apache is not running
apachectl stop
# Make sure apache does not autostart
defaults write /System/Library/LaunchDaemons/org.apache.httpd Disabled - bool true
# Diable NFS Server
nfsd disable
# Remove NFS Exports Folder
rm /etc/exports
# Remove Password Hints
defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0
# Disable Guest Account
defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled - bool NO
# Disable AFP connection from Guests
defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool no
# Disable SMB connection from Guests
defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool no
# Remove Guest Home Folder
rm -R /Users/Guest
# Enable Filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Disable the automatic run of safe files in safari
defaults write com.apple.Safari AutoOpenSafeDownloads -boolean no