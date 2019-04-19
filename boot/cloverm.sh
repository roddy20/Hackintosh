#!/bin/bash
#
# https://raw.githubusercontent.com/roddy20/Hackintosh/master/boot/cloverm.sh
curl -O https://raw.githubusercontent.com/roddy20/Hackintosh/master/boot/boot0af
curl -O https://raw.githubusercontent.com/roddy20/Hackintosh/master/boot/boot1f32

diskutil list
read -p "install bootsectors to disk*s1 ?" a

#sudo dd if=/dev/rdisk$a count=1 of=origMBR
#sudo cp origMBR newMBR
#sudo dd if=boot0af of=newMBR bs=1 count=440 conv=notrunc
#sudo dd if=newMBR of=/dev/rdisk$a count=1
#
#sudo dd if=/dev/rdisk$as1 count=1 of=origbs
#sudo cp boot1f32 newbs
#sudo dd if=origbs of=newbs skip=3 seek=3 bs=1 count=87 conv=notrunc
#sudo dd if=newbs of=/dev/rdisk$as1 count=1

diskutil unmountdisk ${bootdisk}

sudo fdisk -u -f boot0af  -y ${bootdisk}
sudo boot1-install -f boot1f32 ${bootdisk}s1
