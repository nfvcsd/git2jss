#!/bin/sh
externalIP=$(curl ifconfig.me)
echo "<result>$externalIP</result>"
exit 0