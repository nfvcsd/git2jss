#!/bin/bash

DOCKUTIL_BINARY=$(which dockutil)
echo $DOCKUTIL_BINARY
# Removal of Apple Default Dock Applications
#####################################################

$DOCKUTIL_BINARY --remove 'Siri' --allhomes
#
# $DOCKUTIL_BINARY --remove 'Launchpad' --allhomes
#
$DOCKUTIL_BINARY --remove 'Safari' --allhomes
#
$DOCKUTIL_BINARY --remove 'Mail' --allhomes
#
$DOCKUTIL_BINARY --remove 'Contacts' --allhomes
#
# $DOCKUTIL_BINARY --remove 'Calendar' --allhomes
#
# $DOCKUTIL_BINARY --remove 'Notes' --allhomes
#
$DOCKUTIL_BINARY --remove 'Reminders' --allhomes
#
$DOCKUTIL_BINARY --remove 'Maps' --allhomes
#
$DOCKUTIL_BINARY --remove 'Photos' --allhomes
#
$DOCKUTIL_BINARY --remove 'Messages' --allhomes
#
$DOCKUTIL_BINARY --remove 'FaceTime' --allhomes
#
$DOCKUTIL_BINARY --remove 'iTunes' --allhomes
#
$DOCKUTIL_BINARY --remove 'iBooks' --allhomes
#
$DOCKUTIL_BINARY --remove 'App Store' --allhomes
#
$DOCKUTIL_BINARY --remove 'News' --allhomes
#
$DOCKUTIL_BINARY --remove 'System Preferences' --allhomes
#
$DOCKUTIL_BINARY --remove 'Notes' --allhomes
#
$DOCKUTIL_BINARY --add '/Applications/Self Service.app' --position 5 --allhomes
#
$DOCKUTIL_BINARY --add '/Applications/Google Chrome.app' --position 4 --allhomes