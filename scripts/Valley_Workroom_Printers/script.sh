#!/bin/bash

############################
#
# Script to add copier
#
############################


# Download Drivers and Install Drivers 

cd /Users/Shared

curl -LO http://casper.n-fayette.k12.ia.us/CasperShare/Packages/bizhub_C554_C364_109.pkg

curl -LO http://casper.n-fayette.k12.ia.us/CasperShare/Packages/bizhub_554e_109.pkg

curl -LO http://casper.n-fayette.k12.ia.us/CasperShare/Packages/bizhub_754_109.pkg

sudo installer -pkg bizhub_C554_C364_109.pkg -target / 

sudo installer -pkg bizhub_554e_109.pkg -target /

sudo installer -pkg bizhub_754_109.pkg -target /

################################################################

# Setup and Install new KM printer

 lpadmin -p MS_Copier -E -v lpd://192.168.5.20 -L MS_Copier -P /Library/Printers/PPDs/Contents/Resources/KONICAMINOLTAC554e.gz -o printer-is-shared=false -o PaperSources=PC410 -o Finisher=FS534_ZeusX -o KMPunchUnit=PK520-23_ZeusX -o PublicUserAccess=True -o KMDuplex=Single -o KMSection=True

 lpadmin -p Superintendant -E -v lpd://192.168.5.22 -L Superintendant -P /Library/Printers/PPDs/Contents/Resources/KONICAMINOLTA554e.gz -o printer-is-shared=false -o PaperSources=PC410 -o Finisher=FS534_ZeusX -o KMPunchUnit=PK520-23_ZeusX -o PublicUserAccess=True -o KMDuplex=Single -o KMSection=True

 lpadmin -p Elementary -E -v lpd://192.168.5.23 -L Elementary -P /Library/Printers/PPDs/Contents/Resources/KONICAMINOLTA754e.gz -o printer-is-shared=false -o Finisher=FS534SD -o KMPunchUnit=PK520-23 -o PublicUserAccess=True -o KMDuplex=Single -o KMSection=True


################################################################

rm /Users/Shared/bizhub_C554_C364_109.pkg

rm /Users/Shared/bizhub_554e_109.pkg

rm /Users/Shared/bizhub_754_109.pkg

exit