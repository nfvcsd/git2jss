#!/bin/bash
# Alex Snyder
# This Script pulls the Room ID from the JSS and uses it to write the channel
# Number to the Lanschool Teacher plist

user=read
pass=readonly
serialnumber=$( system_profiler SPHardwareDataType | awk '/Serial Number \(system\)/ { print $NF }' )
baseurl=$( defaults read /Library/Preferences/com.jamfsoftware.jamf jss_url )
apiurl=${baseurl}JSSResource/
opts=( --silent --show-error --connect-timeout 30 )
data=$( curl "${opts[@]}" --request GET --user "$user:$pass" -H "content-Type: application/xml" -X 'GET' "${apiurl}computers/serialnumber/$serialnumber"| xmllint --format - | awk -F '[<>]' '/room/ { print $3 }' )
sudo defaults write /Library/Preferences/com.lanschool.teacher Channel -int $data
