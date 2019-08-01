#!/bin/bash

#Variables


#Setup Printer Functions

ES_Office () {

cd /Users/Shared

curl -LO http://casper.n-fayette.k12.ia.us/CasperShare/Packages/bizhub_554e_109.pkg

sudo installer -pkg bizhub_554e_109.pkg -target /


lpadmin -p WUELEM_Office_Copier -E -v lpd://10.140.124.19/queue -L WUELEM_Office -P /Library/Printers/PPDs/Contents/Resources/KONICAMINOLTAC554e.gz -o printer-is-shared=false -o PaperSources=PC410 -o Finisher=FS534_ZeusX -o KMPunchUnit=PK520-23_ZeusX -o PublicUserAccess=True -o KMDuplex=Single -o KMSection=True

rm /Users/Shared/bizhub_554e_109.pkg
}


ES_Basement () {

cd /Users/Shared

curl -LO http://casper.n-fayette.k12.ia.us/CasperShare/Packages/bizhub_C554_C364_109.pkg

sudo installer -pkg bizhub_C554_C364_109.pkg -target / 

lpadmin -p WUELEM_Basement_Copier -E -v lpd://10.140.121.23/queue -L WUELEM_Basement -P /Library/Printers/PPDs/Contents/Resources/KONICAMINOLTA364e.gz -o printer-is-shared=false -o PublicUserAccess=True -o KMSection=True -o KMDuplex=Single

rm /Users/Shared/bizhub_C554_C364_109.pkg
}


HS_Library () {

cd /Users/Shared

curl -LO http://casper.n-fayette.k12.ia.us/CasperShare/Packages/bizhub_554e_109.pkg

sudo installer -pkg bizhub_554e_109.pkg -target /

lpadmin -p NFVHS_Library_Copier -E -v lpd://10.140.104.15 -L NFVHS_Library -P /Library/Printers/PPDs/Contents/Resources/KONICAMINOLTA554e.gz -o printer-is-shared=false -o PaperSources=PC410 -o Finisher=FS534_ZeusX -o KMPunchUnit=PK520-23_ZeusX -o PublicUserAccess=True -o KMDuplex=Single -o KMSection=True

rm /Users/Shared/bizhub_554e_109.pkg
}




HS_Office () {

cd /Users/Shared

curl -LO http://casper.n-fayette.k12.ia.us/CasperShare/Packages/bizhub_754_109.pkg

sudo installer -pkg bizhub_754_109.pkg -target /

lpadmin -p NFVHS_Office_Copier -E -v lpd://10.140.104.14 -L NFVHS_Office -P /Library/Printers/PPDs/Contents/Resources/KONICAMINOLTA754e.gz -o printer-is-shared=false -o Finisher=FS534SD -o KMPunchUnit=PK520-23 -o PublicUserAccess=True -o KMDuplex=Single -o KMSection=True

rm /Users/Shared/bizhub_754_109.pkg
}


F_Office () {

cd /Users/Shared

curl -LO http://casper.n-fayette.k12.ia.us/CasperShare/Packages/bizhub_554e_109.pkg

sudo installer -pkg bizhub_554e_109.pkg -target /


lpadmin -p Fayette_Office_Copier -E -v lpd://10.141.144.20/queue -L Fayette_Office -P /Library/Printers/PPDs/Contents/Resources/KONICAMINOLTA454e.gz -o printer-is-shared=false -o PublicUserAccess=True -o KMDuplex=Single -o KMSection=True

rm /Users/Shared/bizhub_554e_109.pkg
}


D_Office () {

cd /Users/Shared

curl -LO http://casper.n-fayette.k12.ia.us/CasperShare/Packages/bizhub_C554_C364_109.pkg

sudo installer -pkg bizhub_C554_C364_109.pkg -target / 

lpadmin -p District_Office_Copier -E -v lpd://10.140.130.15/queue -L District_Office -P /Library/Printers/PPDs/Contents/Resources/KONICAMINOLTAC364e.gz -o printer-is-shared=false -o PublicUserAccess=True -o KMDuplex=Single -o KMSection=True -o Finisher=FS533

rm /Users/Shared/bizhub_C554_C364_109.pkg
}

Remove_Printers () {

####################################################

# Delete old Copiers

echo "--Current printers"
lpstat -a | cut -d" " -f1 | while read PRTA
do
echo "-"$PRTA
done

lpstat -a | cut -d" " -f1 | grep "HS_Library" | while read PRTB
do
echo "-- Library printer detected attempting to delete: "$PRTB
lpadmin -x $PRTB
sleep 1
done

lpstat -a | cut -d" " -f1 | grep "Office" | while read PRTB
do
echo "-- Library printer detected attempting to delete: "$PRTB
lpadmin -x $PRTB
sleep 1
done

lpstat -a | cut -d" " -f1 | grep "Copier" | while read PRTB
do
echo "-- Library printer detected attempting to delete: "$PRTB
lpadmin -x $PRTB
sleep 1
done

echo "--Remaining printers"
lpstat -a | cut -d" " -f1 | while read PRTC
do
echo "-"$PRTC
done

##########################################################
}






# set multiple site enrollment via one quick add package

getSite() {

theSite=$(osascript <<AppleScript

set mySites to {"ES Office", "ES Basement", "HS Office", "HS Library", "D Office", "Fayette", "Remove Printers"}

set selectedSite to {choose from list mySites}

AppleScript

echo "${theSite}"
)
}

getSite

echo "${theSite}"

# now select invitation codes
# put site names with spaces in single quotes

case ${theSite} in
    'ES Office') 
        invCode='ES_Office';;
    'ES Basement')
        invCode='ES_Basement';;
    'HS Office')
        invCode='HS_Office';;
    'HS Library')
        invCode='HS_Library';;
    'D Office')
        invCode='D_Office';;
    'Fayette')
        invCode='F_Office';;
    'Remove Printers')
    	invCode='Remove_Printers';;
esac

${invCode}

osascript -e 'tell application "Terminal" to close (every window whose name contains ".command")' & exit