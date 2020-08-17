#!/bin/bash

loggedInUser=$(/opt/nfv/bin/python3.8 -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

dscl . -append /groups/admin GroupMembership $loggedInUser