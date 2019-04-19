#!/bin/bash
#!/bin/sh

#  SaveNVRAM.sh
#  
#
#  Created by Rodion Shingarev on 19.04.19.
#
StartService() {
echo "$(date "+%Y-%m-%d") $(date "+%H:%M:%S") - start " >> /Library/Logs/CloverEFI/clover.daemon.log
}


StopService() {
echo "$(date "+%Y-%m-%d") $(date "+%H:%M:%S") - shutdown " >> /Library/Logs/CloverEFI/clover.daemon.log
#OpenCore
uuid=$(nvram 4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102:boot-path|  sed 's/.*GPT,\([^,]*\),.*/\1/');
if [[ ! $uuid ]]
then
#Clover
uuid=$(ioreg -lw0 -p IODeviceTree | grep boot-log | sed 's/.*<\(.*\)>.*/\1/' | xxd -r -p | grep SelfDevicePath | sed 's/.*GPT,\([^,]*\),.*/\1/');
fi
esp=$(LC_ALL=C diskutil info $UUID |  sed -n 's/.*Device Node: *//p');

if [[ ! $(mount | grep "$esp") ]]
then
mkdir /Volumes/efi
mount -t msdos $esp /Volumes/efi
fi
nvram -x -p > /Volumes/efi/nvram.plist
umount $esp
rmdir /Volumes/efi
exit 0
}

#trap StopService SIGTERM
#while true; do
#    sleep 86400 &
#    wait $!
#done

