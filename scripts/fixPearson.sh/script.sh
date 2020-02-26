#!/bin/bash
# Sets the stupid Pearson directory to 777 because they don't understand their own permissions

loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

chmod -R 777 "/Users/${loggedInUser}/Library/Application Support/Pearson"