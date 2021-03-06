#!/bin/sh

Wireless=$(networksetup -getairportnetwork $(networksetup -listallhardwareports | awk '/AirPort|Wi-Fi/{getline; print $NF}') | awk -F'Network: ' '{print $NF}')

if [[ "$Wireless" =~ "not associated" ]] || [[ "$Wireless" =~ "currently off" ]]; then
    echo "<result>No current wireless network</result>"
else
    echo "<result>$Wireless</result>"
fi