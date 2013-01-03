#!/sbin/busybox sh

# system partition
#mkdir /system;
#/sbin/busybox mount -o rw -t ext4 /dev/block/mmcblk0p3 /system;

# data partition
#mkdir /data;
#/sbin/busybox mount -o noatime,nosuid,crypt,nodev,noauto_da_alloc -t ext4 /dev/block/mmcblk0p5 /data;

# hidden partition
mkdir /hidden;
/sbin/busybox mount -o rw -t ext4 /dev/block/mmcblk0p9 /hidden;

# efs partition
#mkdir /efs;
#/sbin/busybox mount -o noatime,nosuid,nodev -t ext4 /dev/block/mmcblk0p7 /efs;

# modemfs partition
#mkdir /modemfs;
#/sbin/busybox mount -o noatime,nosuid,nodev -t ext4 /dev/block/mmcblk0p2 /modemfs;