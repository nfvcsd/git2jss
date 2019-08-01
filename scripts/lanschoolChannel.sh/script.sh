#!/bin/sh
CD="/Users/Shared/CocoaDialog.app/Contents/MacOS/cocoaDialog"


if [ -e $CD ]
	then

$CD bubble --debug --title "Lanschool Alert!" --text "You haven't set your lanschool channel yet. Do this by Monday!" --x-placement center --timeout 30 --background-top "FF0505" --background-bottom "FF0505" --icon "hazard"

else
exit 1
fi
exit 0
