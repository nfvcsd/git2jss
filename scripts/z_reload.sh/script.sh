#!/bin/bash

echo "Loading New Daemon"


/bin/launchctl load /Library/LaunchDaemons/com.company.caspercheck.plist
/bin/launchctl start /Library/LaunchDaemons/com.company.caspercheck.plist

