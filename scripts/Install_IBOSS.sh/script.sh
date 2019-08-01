#!/bin/bash

#Mount JSS Server
#osascript -e "tell application \"Finder\" to mount volume \"afp://10.140.1.160/CasperShare\" as user name \"kschmitz\" with password \"diamond\""

#Make Temp Directory
mkdir -p /Volumes/Macintosh\ HD/Users/Shared/temp

#Go to temp
cd /Volumes/Macintosh\ HD/Users/Shared/temp

#download iboss zip
curl -LO http://casper.nfvschools.com/CasperShare/Packages/IBOSS3.zip

#copy IBOSS Zip
#sudo cp /Volumes/CasperShare/Packages/IBOSS.zip /Volumes/Macintosh\ HD/Users/Shared/temp

#Move to temp directory
#cd /Volumes/Macintosh\ HD/Users/Shared/temp

#Unzip files
unzip IBOSS3.zip 
#-d /Volumes/Macintosh\ HD/Users/Shared/temp

#Run IBOSS Installer
bash /Volumes/Macintosh\ HD/Users/Shared/temp/IBOSS/install.sh

sleep 10

#Remove Temp Directory
rm -rf /Volumes/Macintosh\ HD/Users/Shared/temp

#Unmount JSS
#osascript -e "tell application \"Finder\" to eject \"CasperShare\"" 

#Close Install.cmd
osascript -e 'tell application "Terminal" to close (every window whose name contains ".command")' & exit

exit