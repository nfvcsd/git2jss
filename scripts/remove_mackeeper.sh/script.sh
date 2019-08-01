#!/bin/sh

#stopping MacKeeper
killall "MacKeeper Helper"
killall MKCleanService
killall MacKeeper

#stopping the daemons
launchctl unload com.mackeeper.MacKeeper.MacKeeperPrivilegedHelper
launchctl unload com.mackeeper.AdwareAnalyzer.AdwareAnalyzerPrivilegedHelper
launchctl unload com.mackeeper.Cerberus

#remove main app
rm -Rf /Applications/MacKeeper.app

# remove mackeeper from HomeDirectories
rm -Rf /Users/*/Library/Application\ Support/*mackeeper*
rm -Rf /Users/*/Library/Application\ Support/*MacKeeper*
rm -Rf /Users/*/Library/LaunchAgents/com.mackeeper*
rm -Rf /Users/*/Library/Logs/MacKeeper*
rm -Rf /Users/*/Library/Preferences/com.mackeeper*
rm -Rf /Users/*/MacKeeper*
rm -Rf /Users/*/Library/Saved\ Application\ State/com.zeobit.MacKeeper.savedState
rm -Rf /Users/*/Library/Preferences/com.zeobit.MacKeeper*
rm -Rf /Users/*/Library/Preferences/.3FAD0F65-FC6E-4889-B975-B96CBF807B78

#remove mackeeper from systemdirectories
rm -Rf /Library/LaunchDaemons/com.mackeeper*
rm -Rf /Library/PrivilegedHelperTools/com.mackeeper*
rm -Rf /Library/Preferences/.3FAD0F65-FC6E-4889-B975-B96CBF807B78
