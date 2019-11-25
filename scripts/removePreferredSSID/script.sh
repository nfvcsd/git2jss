#!/bin/bash
#----------VARIABLES---------	
undesiredNetwork="Guest" 
wifiOrAirport=$(/usr/sbin/networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)') 
echo $wifiOrAirport 
wirelessDevice=$(networksetup -listallhardwareports | awk "/$wifiOrAirport/,/Device/" | awk 'NR==2' | cut -d " " -f 2) 
echo $wirelessDevice 

#-----------SCRIPT-----------	
# Remove the  SSID from the list of preferred networks
networksetup -removepreferredwirelessnetwork "$wirelessDevice" "$undesiredNetwork"
