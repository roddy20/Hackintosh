#!/bin/sh
#  Created by Rodion Shingarev on 29.11.18.
cd "$(dirname "$0")"
kextlibs AppleHDA*.kext
sudo echo
for S in /Volumes/*
do
if [  -d "$S/System/Library/Extensions/" ]
then
echo
echo $S
sudo cp -Rv AppleHDA*.kext "$S/System/Library/Extensions/"
sudo touch "$S/System/Library/Extensions/"
fi
done
sudo kextcache -verbose -t -u /
