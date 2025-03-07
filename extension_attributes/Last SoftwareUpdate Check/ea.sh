#!/bin/bash
lastUpdate=$(defaults read /Library/Preferences/com.apple.SoftwareUpdate | grep -e LastFullSuccessfulDate |awk '{print $3, $4}' | cut -c2-)
echo "<result>$lastUpdate</result>"