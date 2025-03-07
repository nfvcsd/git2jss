#!/bin/bash

loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
echo $loggedInUser
dscl . -append /groups/admin GroupMembership $loggedInUser