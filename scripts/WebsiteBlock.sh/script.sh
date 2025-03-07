#!/bin/bash
# Please test before using in your environment
##########################################################
# Modified from
# https://www.jamf.com/jamf-nation/discussions/18184/how-to-update-host-file-via-composer
#
# Use Jamf Script Parameter 4 for domain (youtube.com) and 5 for subdomain (images.google.com) and 6 for file (/etc/hosts)
# Set base variables
domain=""
subdomain=""
filename=""
SUCCESS=0

# Setup Jamf variables
if [ "$4" != "" ] && [ "$domain" = "" ]
   then
    domain="$4"
fi

if [ "$4" = "" ] && [ "$domain" = "" ]
    then
        echo "No Domain Variable Configured"
        exit 1
fi

if [ "$5" != "" ] && [ "$subdomain" = "" ]
    then subdomain="$5"
fi

if [ "$5" = "" ] && [ "$subdomain" = "" ]
    then
        echo "No subdomain Variable Configured, continuing anyway."
fi

if [ "$6" != "" ] && [ "$filename" = "" ]
    then filename="$6"
fi

if [ "$6" = "" ] &&  [ "$filename" = "" ]
    then
        echo "No filename Variable Configured"
        exit 1
fi

#Set Needle Variable
if [ "$subdomain" = "" ]
    then
        needle="$domain"
    else
        needle="$subdomain.$domain"
fi
# set hostline variable
hostline="127.0.0.1 $needle"

# Determine if the line already exists in /etc/hosts
grep -q "$needle" "$filename"

# Grep's return error code can then be checked.
if [ $? -eq $SUCCESS ]
then
  exit 0
else
  # If the line wasn't found, add it using an echo append >>
  echo "$hostline" >> "$filename"
    # Let's recheck to be sure it was added.
    grep -q "$needle" "$filename"

    if [ $? -eq $SUCCESS ]
        then
        	sudo dscacheutil -flushcache
            exit 0
        else
            exit 1
    fi
fi