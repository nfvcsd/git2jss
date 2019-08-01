#!/bin/sh

######################
#
#  setDVDauth
#
#  This script allows a non-administrator to set the DVD region code once
#
#  Shawn Peterson 5/4/15
#
#
#
########


# Copy system.device.dvd.setregion.initial to plist in temp folder

security authorizationdb read system.device.dvd.setregion.initial > /tmp/system.device.dvd.setregion.initial.plist

# Add the "class allow" into the copied plist

/usr/libexec/PlistBuddy -c "Set class allow" /tmp/system.device.dvd.setregion.initial.plist

# Copy new parameters back into the authorization db

security authorizationdb write system.device.dvd.setregion.initial < /tmp/system.device.dvd.setregion.initial.plist

# Copy new parameters back into the authorization db

security authorizationdb write system.device.dvd.setregion.change < /tmp/system.device.dvd.setregion.initial.change.plist