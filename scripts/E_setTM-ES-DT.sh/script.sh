#!/bin/sh

######################
#
#  set TimeMachine, EnergySaver, and Date and Time
#
#  This script allows a non-administrator to set the TimeMachine, EnergySaver, and Date and Time
#
#  Shawn Peterson 5/18/15
#
#
#
########

# Make backup of current database entry for system preferences
security authorizationdb read system.preferences > /tmp/system.preferences.plist
cp /tmp/system.preferences.plist /tmp/system.preferences.plist.bkp

# Set all prefs to "allow" so that we can turn on what we want
defaults write /tmp/system.preferences.plist group everyone

# Write new plist settings from file
security authorizationdb write system.preferences < /tmp/system.preferences.plist

# Read each settings area
security authorizationdb read system.preferences.energysaver > /tmp/system.preferences.energysaver.plist
security authorizationdb read system.preferences.datetime > /tmp/system.preferences.datetime.plist
security authorizationdb read system.preferences.timemachine > /tmp/system.preferences.timemachine.plist

# Make Backups
cp /tmp/system.preferences.energysaver.plist /tmp/system.preferences.energysaver.plist.bkp
cp /tmp/system.preferences.datetime.plist /tmp/system.preferences.datetime.plist.bkp
cp /tmp/system.preferences.timemachine.plist /tmp/system.preferences.timemachine.plist.bkp

# Make changes
defaults write /tmp/system.preferences.energysaver.plist group everyone
defaults write /tmp/system.preferences.datetime.plist group everyone
defaults write /tmp/system.preferences.timemachine.plist group everyone

# Write new changes
security authorizationdb write system.preferences.energysaver < /tmp/system.preferences.energysaver.plist
security authorizationdb write system.preferences.datetime < /tmp/system.preferences.datetime.plist
security authorizationdb write system.preferences.timemachine < /tmp/system.preferences.timemachine.plist

# Change system prefs back to admin to prevent other changes
# defaults write /tmp/system.preferences.plist group admin

# Write plist settings from file
# security authorizationdb write system.preferences < /tmp/system.preferences.plist


