#!/bin/bash
cp initrd.img-* initrd.img
mkdir boot

mkdir kernel-dtb
echo 开始合成boot

for i in $( ls *.dtb ); do
echo $i  正在合成……
cat Image.gz $i > $i-kernel-dtb
        


mkbootimg \
--base 0x80000000 \
--kernel_offset 0x00080000 \
--ramdisk_offset 0x02000000 \
--tags_offset 0x01e00000 \
--pagesize 2048 \
--second_offset 0x00f00000 \
--ramdisk initrd.img \
--cmdline "earlycon root=PARTUUID=a7ab80e8-e9d1-e8cd-f157-93f69b1d141e console=ttyMSM0,115200 no_framebuffer=true rw" \
--kernel $i-kernel-dtb \
-o $i-boot.img


mv *boot.img boot
sleep 1
mv *-kernel-dtb kernel-dtb



done
