#!/bin/bash

# This script enables silent automatic updates for Adobe Flash Player

rm -f "/Library/Application Support/Macromedia/mms.cfg"
mkdir -p "/Library/Application Support/Macromedia/"
cat > "/Library/Application Support/Macromedia/mms.cfg" << EOF
AutoUpdateDisable=0
SilentAutoUpdateEnable=1

EOF

exit 0
