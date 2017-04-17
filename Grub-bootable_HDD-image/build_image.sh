#!/bin/bash

# Thanks to:
#https://tomermargalit.wordpress.com/tag/create-grub2-bootable-image-over-loopback-device/
dd if=/dev/zero of=out.img seek=80MB count=1k bs=1
outlo=`sudo losetup -f --show out.img`
echo "Working with: $outlo"
sudo parted ${outlo} mklabel msdos
sudo parted ${outlo} mkpart primary ext2 32k 100% -a minimal
sudo parted ${outlo} set 1 boot on
sudo partx -a ${outlo}
sudo mke2fs ${outlo}p1
sudo mkdir -p /mnt/out
sudo mount -t ext2 ${outlo}p1 /mnt/out
#sudo mkdir -p /mnt/out/boot/grub2

cat > grub.cfg << EOF 
set timeout=10
set default=0

menuentry 'RDPKiosk Graphical mode' {
        set gfxpayload=keep
        linux /vmlinuz  startx=1
}
menuentry 'RDPKiosk' {
        set gfxpayload=keep
        linux /vmlinuz
}
EOF

sudo cp ../kiosk-i686-1 /mnt/out/vmlinuz
sudo grub-install --boot-directory=/mnt/out/boot/ --modules="ext2 part_msdos" ${outlo} --root-directory=/mnt/out
sudo cp grub.cfg /mnt/out/boot/grub/
sudo umount /mnt/out
sudo partx -d ${outlo}p1
sudo losetup -d ${outlo}
sudo rm -rf /mnt/out

