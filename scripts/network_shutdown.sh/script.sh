#!/bin/sh
if [ ! -f /Users/Shared/audiodevice ]
	then
		echo Getting audiodevice
		cd /Users/Shared
		curl -LO http://casper.nfvschools.com/CasperShare/Packages/audiodevice
		chmod 777 /Users/Shared/audiodevice
		echo audiodevice installed
	else
		echo "==============================================="
		echo audio device already installed!
fi
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`
MyWifi=`networksetup -getairportnetwork en0 | cut -c 24-`
Sound=/Users/Shared/Explosion_Sound_Effect.mp3
output=`/Users/Shared/audiodevice | sed 1,2d | cut -c 9-`

#play sound function
play_sound () {
	#if [ "$output" == "Headphones" ]
	#then
	#	echo "OUTPUT: $output"
	#	osascript -e "set Volume 3"
	#elif [ "$output" == "Internal Speakers" ]
	#then
		#echo "OUTPUT: $output"
		#osascript -e "set volume 10"
	#else 
		#echo Section not working
	#fi
	echo "==============================================="
	#echo "playing sound!"
	#su -l $loggedInUser -c "afplay /Users/Shared/Explosion_Sound_Effect.mp3"
	sudo shutdown -h now
}
echo "==============================================="

if [ ! -f $Sound ]
	then
		echo downloading sound effect
		curl -LO http://casper.nfvschools.com/CasperShare/Packages/Explosion_Sound_Effect.mp3
		echo "==============================================="
else
	echo Sound Effect Present
fi


echo "==============================================="

if [ "$MyWifi" == "Admin" ]
	then
		echo "Student on $MyWifi"
		play_sound

elif [ "$MyWifi" == "Guest" ]
	then
		echo "Student on $MyWifi"
		play_sound

elif [ "$MyWifi" == "Teacher" ]
	then
		echo "Student on $MyWifi"
		play_sound

elif [ "$MyWifi" == "Student" ]
	then
		echo "Student on $MyWifi"
		exit 1
else
	exit 0
fi