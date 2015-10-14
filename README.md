RDPkiosk is a tiny Linux distribution which acts as RDP thin client and/or recovery toolkit.

 - Licence: GPLv3+
 - Image size: 42MB
 - System requirements: 512MB of RAM and 686-compatible CPU
 - Built with Buildroot http://buildroot.uclibc.org So it is very simple to rebuild the entire distro with my configs and init script. Look for rebiuld manual in 'Rebuild_howto' directory.
 - The project was launched because of Thinstation's deprecation and inability just to build. Anyway the majority of thin clients need rdp only an can work using a simplier solution.
 - You can start the 'kiosk' image with any bootloaders you know. Typical case is network (PXE, with pxelinux), but you can also start from flash-drive or HDD with syslinux, isolinux, grub(1|2) or any other bootloader.
 - SSH server (dropbear) is up, user: root, password: ololo
 
 Kiosk modes are set via kernel parameters.
  - RDP client mode: rdesktop=192.168.0.2 startx=1 or xfreerdp=192.168.0.2 startx=1 depending on client you prefer to use an your server's IP address
  - Desktop mode: startx=1
  - Terminal mode needs no parameters
 
Packages included:
 - Graphics: xfreerdp, rdesktop, xterm, fluxbox, xeyes(the greatest X application ever!!!!)
 - Busybox-based userspace
 - Filesystem utilities: ncdu and mdadm, suitable for recovery needs
 - Browser: dillo
 - HW tools: dmidecode, hwdata, lshw, pciutils
 - Network: mtr, rsync, dropbear, p910nd
 - bc

Test in QEMU before use:
$ qemu-system-x86_64 -kernel kiosk -append "rdesktop=192.168.0.2 startx=1" -m 512
$ qemu-system-x86_64 -kernel kiosk -append "xfreerdp=192.168.0.2 startx=1" -m 512
$ qemu-system-x86_64 -kernel kiosk -append "startx=1" -m 512

To force resolution(useful for CRT displays) add parameter: xrandr="--output default --mode 640x480" 