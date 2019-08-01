#!/bin/bash
#	Use this script to remove old n-fayette casper check script.
#	Run it before installing new casper check scripts.



#Variables
daemon="/Library/LaunchDaemons/com.company.caspercheck.plist"

scip="/Library/Scripts/caspercheck.sh"

# Remove old files

echo "Unloading Old Daemon"

/bin/launchctl unload /Library/LaunchDaemons/com.company.caspercheck.plist
/bin/launchctl stop /Library/LaunchDaemons/com.company.caspercheck.plist

echo "Removing Launch Daemon"

rm -rf "$daemon"

echo "Removing Old Script"

rm -rf "$scip"





