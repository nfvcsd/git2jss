#!/bin/bash

pinresponse=$(osascript -e "set theResponse to display dialog \"What's your lunch number?\" default answer \"\" buttons {\"Cancel\", \"Continue\"} default button \"Continue\"")
pin=$( echo $pinresponse | cut -c 41-)
button=$( echo $pinresponse | cut -c 17- | cut -c -8)
echo $pin
echo $button
if [ "$button" == "Continue" ]; then
  #Set pin here
  echo $pin
  sudo defaults write /Library/Preferences/com.lanschool.teacher Channel -int $pin
  exit 0
elif [ "$button" == "Cancel" ]; then
  echo "Cancelled!"
  exit 1
else
  echo "Error"
  exit 1
fi
exit 1
