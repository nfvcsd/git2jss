#!/bin/sh

WirelessPort=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $NF}')

PreferredNetworks=$(networksetup -listpreferredwirelessnetworks "$WirelessPort" | sed 's/^   //g')

echo "<result>$PreferredNetworks</result>"