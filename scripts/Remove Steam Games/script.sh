#!/bin/bash
loggedInUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

rm -rf "/Applications/3DiLLUSTRATOR for iBooks Author.app"
rm -rf "/Applications/Agenda.app"
rm -rf "/Applications/Agenda.app/Applications/Apowersoft Screen Recorder.app"
rm -rf "/Applications/AV for Digital Performer 8 100 - What's New In DP8.app"
rm -rf "/Applications/Bear.app"
rm -rf "/Applications/Camera Record HD - Capture Video Recorder Lite.app"
rm -rf "/Applications/Camera Recorder Lite.app"
rm -rf "/Applications/CB Adware & Malware Cleaner.app"
rm -rf "/Applications/Chaotica Free.app"
rm -rf "/Applications/ConvertAV.app"
rm -rf "/Applications/CoreMelt Motion Templates For Final Cut Pro 1.app"
rm -rf "/Applications/DaVinci Resolve.app"
rm -rf "/Applications/Draw on My Screen EZ.app"
rm -rf "/Applications/EazyDraw.app"
rm -rf "/Applications/FCPX 10.3 New Features.app"
rm -rf "/Applications/Fotogenic.app"
rm -rf "/Applications/Garmin VIRB Edit.app"
rm -rf "/Applications/Inkist Lite.app"
rm -rf "/Applications/iVinci Express.app"
rm -rf "/Applications/LiveQuartz Lite.app"
rm -rf "/Applications/Mischief-Free.app"
rm -rf "/Applications/Monosnap.app"
rm -rf "/Applications/Movie Clips Free.app"
rm -rf "/Applications/Movie Edit-Video Editor Video.app"
rm -rf "/Applications/MovieMator Video Editor.app"
rm -rf "/Applications/New Paint X.app"
rm -rf "/Applications/Painnt.app"
rm -rf "/Applications/Paint Pad Lite.app"
rm -rf "/Applications/Paint S.app"
rm -rf "/Applications/Paint Shape Girl.app"
rm -rf "/Applications/Paint X Lite.app"
rm -rf "/Applications/Paper.app"
rm -rf "/Applications/Pencil Sketch EZ.app"
rm -rf "/Applications/Photo show - Movie Maker.app"
rm -rf "/Applications/Photo Theater Lite.app"
rm -rf "/Applications/Photobricks.app"
rm -rf "/Applications/PhotoScapeX.app"
rm -rf "/Applications/RAWMagic Lite.app"
rm -rf /Users/"${loggedInUser}"/Applications/
rm -rf /Users/"${loggedInUser}"/Desktop/Roblox.app
rm -rf "/Applications/Screen Record HD - Screen Lite.app"
rm -rf "/Applications/ScreenRecordLite.app"
rm -rf "/Applications/Screeny.app"
rm -rf "/Applications/Shred Video.app"
rm -rf "/Applications/SketchBook.app"
rm -rf /Users/"${loggedInUser}"/Desktop/Sky.app
rm -rf "/Applications/Tayasui Sketches.app"
rm -rf "/Applications/Total Video Converter Lite.app"
rm -rf "/Applications/Video Acceleration.app"
rm -rf "/Applications/Video Compress Lite - Compressor Smaller Movie.app"
rm -rf "/Applications/Video Convertor Lite.app"
rm -rf "/Applications/Video Edit - Cut Rotate Crop Mosaic Lite.app"
rm -rf "/Applications/Video Edit Lite - Video Trim.app"
rm -rf "/Applications/Video Editor Robot Lite.app"
rm -rf "/Applications/Video Editor-Movie Edit Video.app"
rm -rf "/Applications/VideoPad Video Editor.app"
rm -rf "/Applications/Viking Recorder Lite.app"
rm -rf "/Applications/Write-on Video.app"
rm -rf "/Applications/XnSketch.app"
rm -rf "/Applications/Zen Coloring Book For Adults.app"
rm -rf /Users/"${loggedInUser}"/Desktop/xSteame.app
rm -rf /Users/"${loggedInUser}"/Desktop/Wondershare Filmora9.app