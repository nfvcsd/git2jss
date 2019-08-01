#!/bin/bash

#Set arguements for script
loggedInUser=""

#Writes current user that is logged-in into terminal
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`

#Need this to ensure user is logged into system, had some errors state user was not logged in randomly
sleep 2

#Sets defaults for Trackpad Two Finger Swipe Gestures (Overlay from right side can cause test false postive cheat)
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadTwoFingerFromRightEdgeSwipeGesture -int 0"

#Sets defaults for Trackpad Three Finger swipe Gestures
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadThreeFingerHorizSwipeGesture -int 0"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadThreeFingerHorizGesture -boolean false"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadThreeFingerVertSwipeGesture -int 0"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadThreeFingerVertGesture -boolean false"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadThreeFingerGesture -int 0"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadThreeFingerDrag -boolean false"

#Sets defaults for Trackpad Three tap gesture (Dictonary use that is not allowed during testing)
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadThreeFingerTapGesture -int 0"

#Sets defaults for Trackpad Four Finger swipe Gestures
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadFourFingerVertSwipeGesture -int 0"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadFourFingerVertGesture -boolean false"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadFourFingerHorizSwipeGesture -int 0"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadFourFingerHorizGesture -boolean false"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadFourFingerDrag -boolean false"
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadFourFingerPinchSwipeGesture -int 0"

#Sets defaults for Trackpad Five Finger Pinch Gesture
su -l "$loggedInUser" -c "defaults write com.apple.AppleMultitouchTrackpad.plist TrackpadFiveFingerPinchGesture -int 0"

#Sets defaults to symbolichotkeys to disable control+arrow keys to swipe in full screen
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 79 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 80 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 81 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 82 '<dict><key>enabled</key><false/></dict>'

#Sets defaults to symbolichotkeys to disable mission control, show desktop, application windows and dashboard
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 32 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 33 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 34 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 35 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 36 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 37 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 62 '<dict><key>enabled</key><false/></dict>'
defaults write /Users/"$loggedInUser"/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 63 '<dict><key>enabled</key><false/></dict>'

#System must restart in order for all settings to take affect, take comment out below to have script restart system
reboot