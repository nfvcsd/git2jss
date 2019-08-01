#!/bin/sh
CFBundleVersion=""
if [ -f "/Applications/Skype.app/Contents/Info.plist" ]; then
    CFBundleVersion=$(defaults read "/Applications/Skype.app/Contents/Info.plist" CFBundleVersion)
fi
echo "<result>$CFBundleVersion</result>"
exit 0