#!/bin/bash
#
#
# This script is used to uninstall components of Corel Draw when
# upgrading from a trial to a paid enterprise edition.
#
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin export PATH

loggedInUser=$(stat -f %Su /dev/console)

declare -a apps_a

apps_a[0]="CorelDRAW 2020.app"
apps_a[1]="Corel PHOTO-PAINT 2020.app"
apps_a[2]="Corel Font Manager 2020.app"

declare -a folders_a
folders_a[0]="/Library/Application Support/Corel"
folders_a[1]="/users/${loggedInUser}/Library/Application Support/Corel"
folders_a[2]="/Library/Corel"
# loop through apps
for i in "${apps_a[@]}"; do
    filepath="/Applications/CorelDraw Graphics Suite 2020/${i}"

    # if the app exists, delete it
    if [[ -e "${filepath}" ]]; then
        rm -rf "${filepath}"
        fi
done

# loop through folders
for i in "${folders_a[@]}"; do
    filepath=${i}
    # if the folder exists, nuke it
    if [[ -d "${filepath}" ]]; then
        rm -rf "${filepath}"
    fi
done

exit 0
