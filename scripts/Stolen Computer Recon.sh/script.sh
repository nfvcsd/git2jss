#!/bin/sh
cat << EOF > /Library/LaunchDaemons/com.nfvschools.stolenComputer.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.nfvschools.stolenComputer</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/bin/sudo</string>
		<string>/usr/local/bin/jamf</string>
    <string>recon</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>StartInterval</key>
	<integer>300</integer>
</dict>
</plist>
EOF

sudo chown root:wheel /Library/LaunchDaemons/com.nfvschools.stolenComputer.plist

sudo chmod 644 /Library/LaunchDaemons/com.nfvschools.stolenComputer.plist

sudo launchctl load -w /Library/LaunchDaemons/com.nfvschools.stolenComputer.plist

exit 0