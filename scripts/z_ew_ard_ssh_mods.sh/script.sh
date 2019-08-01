#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin export PATH

# Enable SSH and ARD remote access for ladmin user
# Bob Frank, APS, 9/1/2011

DEBUG_LOG_FILE=/Library/Logs/ash.log
DEBUG=true
#DEBUG=false

# define version number
version='v. 1.1'

# define script name
scriptName='Enable SSH and ARD remote access for ladmin user'

function debugMessage()
{
	if ${DEBUG} ; then
		touch ${DEBUG_LOG_FILE}
		chown root:admin ${DEBUG_LOG_FILE}
		chmod 0600 ${DEBUG_LOG_FILE}
		echo "$*" >> ${DEBUG_LOG_FILE}
	fi
}

# Must be the root user to run this application
if [ `id -u` != 0 ]; then
	echo "$0: must be run as root"
    logger -t $0 "$0: must be run as root"
	exit 1
fi

now=`date "+%m.%d.%Y.%H.%M.%S"`
debugMessage ""
debugMessage "$scriptName $version $now"
debugMessage ""
	
# echo to console
echo ""
echo "$scriptName $version $now"
echo ""

# setting up ARD for user ladmin
debugMessage "Setting ARD permissions for ladmin user"
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users "ladmin" -privs -DeleteFiles -ControlObserve -TextMessages -OpenQuitApps -GenerateReports -RestartShutDown -SendFiles -ChangeSettings -clientopts -setmenuextra -menuextra no
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -specifiedUsers -restart -agent

# check if group com.apple.access_ssh-disabled exists
if [[ `dscl localhost -list /Local/Default/Groups | grep -c "com.apple.access_ssh-disabled"` -eq 1 ]]; then
	# change the records name
	debugMessage "Renaming group com.apple.access_ssh-disabled..."
	dscl localhost change /Local/Default/Groups/com.apple.access_ssh-disabled RecordName com.apple.access_ssh-disabled com.apple.access_ssh	
elif  [[ `dscl localhost -list /Local/Default/Groups | grep -c "com.apple.access_ssh"` -eq 0 ]]; then
	# no group, create the group
	debugMessage "Creating group com.apple.access_ssh..."
	dseditgroup -o create -n "/Local/Default" -r "Remote Login Group" -T group com.apple.access_ssh
fi

# restrict ssh remote access to enable acces only for ladmin user
echo "AllowUsers ladmin" >> /etc/sshd_config
/usr/sbin/sshd reload

# add user to group
debugMessage "Adding ladmin to group com.apple.access_ssh..."
dseditgroup -o edit -n "/Local/Default" -a "ladmin" -t user com.apple.access_ssh

# launch SSH
debugMessage "Turning on ssh..."
launchctl load -w /System/Library/LaunchDaemons/ssh.plist	

exit 0
