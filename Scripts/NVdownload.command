#!/bin/sh

#  NVdownload.command
#  Created by Rodion Shingarev on 30.11.17.
Found=false
curl https://gfe.nvidia.com/mac-update -o ~/Desktop/nv.xml
MyOS=$(sw_vers -buildVersion)
echo $MyOS "detected"
theFile=~/Desktop/nv.xml

Cnt=$(/usr/libexec/PlistBuddy -c "Print updates" ${theFile} | grep "Dict" | wc -l)
Cnt=$((Cnt - 1))

for idx in $(seq 0 $((Cnt)))
do
OS=$(/usr/libexec/PlistBuddy -c "Print updates:${idx}:OS" ${theFile})

if [[ $OS == $MyOS ]]
then
downloadURL=$(/usr/libexec/PlistBuddy -c "Print updates:${idx}:downloadURL" ${theFile})
echo $downloadURL
open $downloadURL
Found=true
fi
done
rm $theFile
echo
echo
if $Found
then
echo Web-driver for $MyOS is downloading from URL:
echo $downloadURL
else
echo Web-driver for $MyOS is not found
fi
