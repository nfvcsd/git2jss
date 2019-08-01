#!/bin/sh
CFBundleVersion=""
if [ -f "/Applications/Google Earth.app/Contents/Info.plist" ]; then
    CFBundleVersion=$(defaults read "/Applications/Google Earth.app/Contents/Info.plist" CFBundleVersion)
fi
echo "<result>$CFBundleVersion</result>"
exit 0