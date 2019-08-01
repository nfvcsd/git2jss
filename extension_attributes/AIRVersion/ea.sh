#!/bin/bash
AIRVersion=""
if [ -f /Library/Frameworks/Adobe\ AIR.framework/Resources/Info.plist ]
	then
		AIRVersion=$(defaults read /Library/Frameworks/Adobe\ AIR.framework/Resources/Info.plist CFBundleVersion)
fi

echo "<result>$AIRVersion</result>"

exit 0