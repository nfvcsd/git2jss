#!/bin/sh

## Hide Users with UID's under 500

/usr/libexec/PlistBuddy -c "Add:Hide500Users bool" /Library/Preferences/com.apple.loginwindow.plist

/usr/libexec/PlistBuddy -c "Set:Hide500Users true" /Library/Preferences/com.apple.loginwindow.plist
