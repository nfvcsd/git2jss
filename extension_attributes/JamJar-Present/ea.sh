#!/usr/bin/env bash

RESULT="False"

if [ -f "/usr/local/munki/postflight" ] ; then
  RESULT="True"
fi
/bin/echo "<result>$RESULT</result>"