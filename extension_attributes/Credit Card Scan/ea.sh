#!/bin/sh
########################################################################################################
#
# Copyright (c) 2017, JAMF Software, LLC.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the JAMF Software, LLC nor the
#                 names of its contributors may be used to endorse or promote products
#                 derived from this software without specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
####################################################################################################
# PURPOSE
# - Extension attribute for finding potential privacy treats as credit card numbers in Stickies
# - Create extension attribute in Jamf Pro with this script. Edit name of attribute and found result
# to your liking. (i.e. Potential Credit Card in Stickies: Yes) 
#
# HISTORY
#   Version: 1.0
#   - Created by Jonathan Yuresko November 1, 2017
# 
####################################################################################################

currentUser=$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')

# Creates temporary directory in users home directory
mkdir /Users/$currentUser/Library/tmp

# Creates temporary file in new directory
cp /Users/$currentUser/Library/StickiesDatabase /Users/$currentUser/Library/tmp/StickiesDatabase1.txt

# Formats data in file
fileData=$(cat /Users/$currentUser/Library/tmp/StickiesDatabase1.txt)
cleanData=${fileData//[^[:alnum:]]/}
formattedData=$(echo "$cleanData"| LC_ALL=C tr -d -c '[:alnum:]')

# Searches for any 16+ digit strings (credit card number)
search=$(echo "$formattedData" | grep -o '[0-9]\{16\}')
if [[ $search != "" ]]; then
	# If finds longer than 16+ digit string, result is 1
	found=1
else
	# If does not find any 16+ digit string, result is 0
	found=0
fi

rm -rf /Users/$currentUser/Library/tmp/

echo "<result>$found</result>"