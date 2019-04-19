#!/bin/sh
#diskutil partitionDisk disk3 1 GPT hfs+  DUET R
#diskutil partitionDisk disk3 1 MBR fat32 DUET R

cd "$(dirname "$0")"
diskutil list
echo "Enter disk number:"
read N
bootdisk=$(diskutil info disk$N |  sed -n 's/.*Device Node: *//p');
bootrdisk=${bootdisk/disk/rdisk};
echo $bootdisk;
echo $bootrdisk;
PartitionScheme=$(diskutil info  ${bootdisk} |  sed -n 's/.*Content (IOContent): *//p');
Protocol=$(diskutil info  ${bootdisk} |  sed -n 's/.*Protocol: *//p');
PartitionType=$(diskutil info  ${bootdisk}s1 |  sed -n 's/.*Partition Type: *//p');
FileSystem=$(diskutil info  ${bootdisk}s1 |  sed -n 's/.*File System Personality: *//p');
BS=$(diskutil info  ${bootdisk}s1 |  sed -n 's/.*Device Block Size: *//p');

if [[ ! ${bootdisk} ]]
then
echo Disk $N not found
exit
fi

if [ '$FileSystem' != "FAT32" ]
then
echo "No FAT32 partition to install"
exit
fi

echo Clover Boot Sectors will be installed to :
echo ${bootdisk}s1
echo $PartitionScheme $Protocol
echo $PartitionType $FileSystem


exit
# Write MBR
sudo fdisk -f $boot0af -u -y ${bootrdisk};

# Write PBR
diskutil umount ${bootdisk}s1;
sudo /usr/local/bin/boot1-install -f $boot1f32 ${bootrdisk}s1;

echo Press Any key
read f
diskutil mount ${bootdisk}s1;
#cp -v $Duet  /Volumes/DUET/boot


# Make Active for MBR FAT32 only
if [ $TP == "FDisk_partition_scheme" ]; then
sudo fdisk -e ${bootrdisk} <<-MAKEACTIVE
print
f 1
w
y
q
MAKEACTIVE

active=$(sudo fdisk -d ${bootrdisk} | grep -n "*" | awk -F: '{print $1}');
echo "New Active Partition: ${active}";
echo "";
else
echo GPT found: "No Active Partition"
fi;


