#!/bin/bash

BASEDIR="/home/cocafe/Android/CoCore_mini/"
OUTDIR="$BASEDIR/out"
INITRAMFSDIR="$BASEDIR/ramdisk-twrp2.2"
#INITRAMFSDIR="$BASEDIR/ramdisk-twrp2.3"
TOOLCHAIN="/home/cocafe/Android/toolchains/arm-eabi-4.4.3/bin/arm-eabi-"
#TOOLCHAIN="/home/cocafe/Android/toolchains/arm-eabi-linaro-4.4.5/bin/arm-eabi-"
#TOOLCHAIN="/home/cocafe/Android/toolchains/arm-eabi-linaro-4.5.4/bin/arm-eabi-"
#TOOLCHAIN="/home/cocafe/Android/toolchains/arm-eabi-linaro-4.6.3/bin/arm-eabi-"
#TOOLCHAIN="/home/cocafe/Android/toolchains/arm-eabi-linaro-4.7.1/bin/arm-eabi-"
#TOOLCHAIN="/home/cocafe/Android/toolchains/arm-2009q3/bin/arm-none-eabi-"
#TOOLCHAIN="/home/cocafe/Android/toolchains/arm-2010q1/bin/arm-none-eabi-"

STARTTIME=$SECONDS

cd kernel
case "$1" in
	clean)
		echo -e "\n\n Cleaning Kernel Sources...\n\n"
		make mrproper ARCH=arm CROSS_COMPILE=$TOOLCHAIN
		rm -rf ${INITRAMFSDIR}/lib
		rm -rf ${OUTDIR}
		ENDTIME=$SECONDS
		echo -e "\n\n Finished in $((ENDTIME-STARTTIME)) Seconds\n\n"
		;;
	*)
		echo -e "\n\n Configuring I9070 Kernel...\n\n"
		make u8500_CoCore_mini_defconfig ARCH=arm CROSS_COMPILE=$TOOLCHAIN

		echo -e "\n\n Compiling I9070 Kernel and Modules... \n\n"
		make -j3 ARCH=arm CROSS_COMPILE=$TOOLCHAIN CONFIG_INITRAMFS_SOURCE=$INITRAMFSDIR

		echo -e "\n\n Copying Modules to InitRamFS Folder...\n\n"
		mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7
		mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/bluetooth/bthid
		mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/net/wireless/bcm4330
		mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/samsung/j4fs
		mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/samsung/param
		mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/scsi
		#mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/cifs
		#mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/smbfs
		#mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/net/ipv4/
		#mkdir -p $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/b2r2/

		#cp fs/cifs/cifs.ko $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/cifs/cifs.ko
		#cp fs/smbfs/smbfs.ko $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/smbfs/smbfs.ko
		cp drivers/bluetooth/bthid/bthid.ko $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/bluetooth/bthid/bthid.ko
		cp drivers/net/wireless/bcm4330/dhd.ko $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/net/wireless/bcm4330/dhd.ko
		cp drivers/samsung/param/param.ko $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/samsung/param/param.ko
		cp drivers/scsi/scsi_wait_scan.ko $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/scsi/scsi_wait_scan.ko
		cp drivers/samsung/j4fs/j4fs.ko $INITRAMFSDIR/lib/modules/2.6.35.7/kernel/drivers/samsung/j4fs/j4fs.ko

		echo -e "\n\n Creating zImage...\n\n"
		make ARCH=arm CROSS_COMPILE=$TOOLCHAIN CONFIG_INITRAMFS_SOURCE=$INITRAMFSDIR zImage

		mkdir -p ${OUTDIR}
		cp arch/arm/boot/zImage ${OUTDIR}/kernel.bin

		#echo -e "\n\n Generating Odin Flasheable Kernel...\n\n"
		echo -e "\n\n Pushing Kernel to OUT folder...\n\n"
		pushd ${OUTDIR}
		md5sum -t kernel.bin >> kernel.bin
		mv kernel.bin kernel.bin.md5

		cp $BASEDIR/kernel/fs/cifs/cifs.ko $OUTDIR/cifs.ko
		#cp $BASEDIR/kernel/fs/smbfs/smbfs.ko $OUTDIR/smbfs.ko

		#tar cf GT-I9070-Kernel-CoCore.tar kernel.bin.md5
		#md5sum -t GT-I9070-Kernel-CoCore.tar >> GT-I9070-Kernel-CoCore.tar
		#mv GT-I9070-Kernel-CoCore.tar GT-I9070-Kernel-CoCore.tar.md5
		popd

                ENDTIME=$SECONDS
                echo -e "\n\n = Finished in $((ENDTIME-STARTTIME)) Seconds =\n\n"
		;;
esac
