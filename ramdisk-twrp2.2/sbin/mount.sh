#!/sbin/busybox sh

# Do this in recovery.rc
#mkdir emmc;

# Mount emmc partition
/sbin/busybox mount -o rw -t auto /dev/block/mmcblk0p8 /emmc;

# Mount hidden partition
/sbin/busybox mount -o rw -t auto /dev/block/mmcblk0p9 /hidden;
