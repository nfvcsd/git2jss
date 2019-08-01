#!/bin/sh
loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
echo "$loggedInUser"

sudo -u $loggedInUser defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 79 "{enabled = 0; value = {parameters = (65535,123, 262144); type = standard; }; }"
sudo -u $loggedInUser defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 80 "{enabled = 0; value = { parameters = (65535, 123, 393216); type = 'standard'; }; }"
sudo -u $loggedInUser defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 81 "{enabled = 0; value = { parameters = (65535, 124, 262144); type = 'standard'; }; }"
sudo -u $loggedInUser defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 82 "{enabled = 0; value = { parameters = (65535, 124, 393216); type = 'standard'; }; }"
