#!/bin/sh

# adminUser = Admin User Name for Remote Acces

adminUser="ladmin,northfayette"

##################################
# Do Not Modify Below This Line  #
##################################

if [ "$4" != "" ] && [ "$adminUser" == "" ];then
    adminUser=$4
fi

# DEFINE CONTROL SETTINGS

privs="-DeleteFiles -ControlObserve -TextMessages -OpenQuitApps -GenerateReports -RestartShutDown -SendFiles -ChangeSettings"

# Do Not Modify Below This Line

if [ "$adminUser" != "" ]; then
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -specifiedUsers
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -access -on -privs $privs -users $adminUser
fi