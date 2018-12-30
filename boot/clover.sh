#!/bin/sh
#
# https://raw.githubusercontent.com/roddy20/Hackintosh/master/boot/clover.sh
wget -O boot0af https://raw.githubusercontent.com/roddy20/Hackintosh/master/boot/boot0af
wget -O boot1f32 https://raw.githubusercontent.com/roddy20/Hackintosh/master/boot/boot1f32

fdisk -l | grep FAT32
read -p "disk? /dev/sd" a
dd if=/dev/sd$a count=1 of=origMBR
cp origMBR newMBR
dd if=boot0af of=newMBR bs=1 count=440 conv=notrunc
dd if=newMBR of=/dev/sd$a count=1

dd if=/dev/sd$a1 count=1 of=origbs
cp boot1f32 newbs
dd if=origbs of=newbs skip=3 seek=3 bs=1 count=87 conv=notrunc
dd if=newbs of=/dev/sd$a1 count=1
