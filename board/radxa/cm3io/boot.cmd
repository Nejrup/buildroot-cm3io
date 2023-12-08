setenv bootargs root=/dev/mmcblk1p2 rw rootfstype=ext4 earlycon clk_ignore_unused console=ttyS2,115200n8 rootwait
fatload mmc 1:1 ${loadaddr} image.itb
bootm ${loadaddr}
