# Buildroot for RADXA CM3IO

The goal is to achieve a fully functional boot using the latest u-boot (2023.10) and mainline Linux kernel (6.6).

Progress:
- [x] Succesfully booting to root

## Info
- Modifications to the default cm3io defconfigs for U-Boot or Linux Kernel can be made in the .fragment files.
- Modify extlinux.conf to assign the root disk:
  - eMMC:  ```root=/dev/mmcblk0p2```
  - SD:    ```root=/dev/mmcblk1p2```
 
## Known Issues
- eDP controller & eDP Phy is not yet ported to mainline, so wont work for now.
  - To enable eDP use radxa kernel instead: https://github.com/radxa/kernel/tree/linux-5.10-gen-rkr4.1

## Build instructions
```
git clone https://github.com/buildroot/buildroot
git clone https://github.com/Nejrup/buildroot-cm3io
cd buildroot
make BR2_EXTERNAL=../buildroot-cm3io radxacm3io_defconfig
make -j$(nproc)
```

## Flashing

Flash buildroot/output/images/sdcard.img to an SD card or eMMC.
Interact using the serial console (baudrate set to 115200n8).
