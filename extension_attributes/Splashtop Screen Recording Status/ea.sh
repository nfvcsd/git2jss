#!/bin/bash

splashtopStatus=$(sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db 'select * from access' |grep "kTCCServiceScreenCapture" | awk '{split($0,a,"|"); print a[2]}' |grep splashtop)

# Check to see if NetRef exists in the TCC database
if [[ "$splashtopStatus" == "" ]]
    then
        result="Not Prompted"
# If it exists in the database, check it's status
elif [[ "$splashtopStatus" == "com.splashtop.Splashtop-SOS" ]]
    then
        # Check the approval status
        splashtopApproval=$(sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db 'select * from access' |grep "kTCCServiceScreenCapture" |grep splashtop| awk '{split($0,a,"|"); print a[4]}')
        # if it returns 2 it has been approved
        if [[ "$splashtopApproval" == '2' ]]
            then
                result="Approved"
        # If it returns 0 is has not been approved
        elif [[ "$splashtopApproval" == '0' ]]
            then
                result="Not Approved"
        fi
fi
echo "<result>$result</result>"