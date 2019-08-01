#!/bin/bash

loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`


rm -rf "/Applications/CleanMyMac 3.app"

rm -rf "/Users/$loggedInUser/Library/Application Support/CleanMyMac 3/CleanMyMac 3 Scheduler.app"

jamf recon