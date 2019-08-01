#!/bin/sh

# This script uses the client's serial number to make an API call so we can store its assigned site.

serialNo=$(system_profiler SPHardwareDataType | grep 'Serial Number (system)' | awk '{print $NF}')

site=`curl -H "Content-Type: application/xml" -u read:readonly https://casper.nfvschools.com:8443/JSSResource/computers/serialnumber/$serialNo/subset/general -X GET | sed -e 's,.*<name>\([^<]*\)</name>.*,\1,g'`
echo "<result>$site</result>"