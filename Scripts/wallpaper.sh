#!/bin/sh
while true
do
let i=$(date +%H)
if  [ $i -ge 8 -a $i -le 20 ]
then
ShellVar="/Users/Shared/Mojave Day.jpg"
else
ShellVar="/Users/Shared/Mojave Night.jpg"
fi
/usr/bin/osascript << EOF
set MyVar to do shell script "echo '$ShellVar'"
set desktopImage to POSIX file MyVar
tell application "Finder"
set desktop picture to desktopImage
end tell
EOF
sleep 3600
done



