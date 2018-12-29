#!/bin/sh
#
fdisk -l | grep FAT32
echo "enter disk letter, ex.: a for sda"
read s
dd if=/dev/sd$s count=1 of=origMBR
cp origMBR newMBR
dd if=boot0af of=/newMBR bs=1 count=440 conv=notrunc
dd if=newMBR of=/dev/sd$s count=1
dd if=/dev/sd$s1 count=1 of=origbs
cp boot1f32 newbs
dd if=origbs of=newbs skip=3 seek=3 bs=1 count=87 conv=notrunc
dd if=newbs of=/dev/sd$s1 count=1
echo "done"
