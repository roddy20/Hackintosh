#!/bin/sh
#  Created by Rodion Shingarev on 29.11.18.
cd "$(dirname "$0")"
sudo echo
sudo cp -v LogoutHook '/Volumes/Macintosh HD/.LogoutHook'
for S in /Volumes/*
do
if [  -f "$S/System/Library/CoreServices/boot.efi" ]
then
echo
echo $S
sudo defaults write "$S/private/var/root/Library/Preferences/com.apple.loginwindow.plist" LogoutHook '/Volumes/Macintosh HD/.LogoutHook'
sudo defaults read "$S/private/var/root/Library/Preferences/com.apple.loginwindow.plist"
fi
done
