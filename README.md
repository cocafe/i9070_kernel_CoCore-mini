Kernel Source for Samsung Galaxy S Advance (GT-I9070)
=============================

 Compiling the source:


  1. Make sure you are building on a clean source

     $ ./build.sh clean


  2. Run the build script

     $ ./build.sh 



 The script will generate a zImage and will also create a odin flasheable package
 and it will put the files in a folder named 'out'.


 Then you can choose to 'dd' the zImage (named kernel.bin.md5) to mmcblk0p15
 or use odin and flash the tar file.
