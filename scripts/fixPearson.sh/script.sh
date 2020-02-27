#!/bin/bash
# Sets the stupid Pearson directory to 777 because they don't understand their own permissions

loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
directory="/Users/${loggedInUser}/Library/Application Support/Pearson"
echo "$directory"
if [ -d "$directory" ]; then
    chmod -R 777 "$directory"
    exit 0
elif [ ! -d "$directory" ]; then
    mkdir -p "$directory"
    chown "$loggedInUser":"staff" "$directory"
    chmod -R 777 "$directory"
    exit 0
else
    echo "Error"
    exit 1
fi

exit 0