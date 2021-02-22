#!/bin/bash
globalFilesToLookFor=(
    "/tmp/agent.sh"
    "/tmp/version.json"
    "/tmp/version.plist"
    "/tmp/agent"
    "/tmp/verx"   
)
userFilesToLookFor=( # relative to ~/
    "Library/._insu"
    "Library/Application Support/agent_updater/agent.sh"
    "Library/Launchagents/agent.plist"
    "Library/Launchagents/init_agent.plist"
    "Library/Application Support/verx_updater/verx.sh"
    "Library/Launchagents/verx.plist"
    "Library/Launchagents/init_verx.plist"
)
result=()
filesFound=0
for globalFile in "${globalFilesToLookFor[@]}"; do
    #echo "Looking for $globalFile"
    if [ -e "$globalFile" ]; then
        filesFound=$(expr $filesFound + 1)
        result+=("$globalFile")
    fi
done
allUsers=$(dscl . list /Users UniqueID | awk '$2 >= 500 {print $1}')
for username in $allUsers; do
    homeDir=$(dscl . read /Users/"$username" NFSHomeDirectory | awk -F ": " '{print $2}')
    for userFile in "${userFilesToLookFor[@]}"; do
        #echo "Looking in $homeDir for $userFile"
        if [ -e "${homeDir}/${userFile}" ]; then
            filesFound=$(expr $filesFound + 1)
            result+=("$userFile")
        fi
    done
done
if [ $filesFound -ne 0 ]; then
    echo "<result>${result[@]}</result>"
else
    echo "<result>None</result>"
fi
