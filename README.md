# Buildroot for RADCXA CM3IO

**Work in progress!**

Goal is too get a fully working boot using newest u-boot (2023.10) & mainline linux kernel (6.6)

## Build instructions
```
git clone https://github.com/buildroot/buildroot
git clone https://github.com/Nejrup/buildroot-cm3io
cd buildroot
make BR2_EXTERNAL=../buildroot-cm3io radxacm3io_defconfig
make
```

## Flashing

Flash buildroot/output/images/sdcard.img to an SD card and interact using the serial console (baudrate 115200n8).
