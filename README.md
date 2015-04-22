GeoG Draguino/Linduino OpenWRT Distribution
-------------------------------------------

### Introduction

This Serves as the firmware for Arduino Yun/Seeeduino
devices based on OpenWRT.

### Prepare for Building

Ensure you have Debian Wheezy installed Natively/LXC. Ensure this directory is 
set up at /geog-linino

You must be running as non-root user. In case you want to know the dependencies
when compiling on a bare minimum new Debian installation, run:

    make

It will tell you what build dependencies are required. Install them with apt-get.

### Building

First run:

    make toolchain/clean
    make toolchain/install

Now run:

    make

### Image

The Built Image will be found in:

    bin/ar71xx/openwrt-ar71xx-generic-linino-16M-rootfs-squashfs.bin
    bin/ar71xx/openwrt-ar71xx-generic-linino-16M-kernel.bin
    bin/ar71xx/openwrt-ar71xx-generic-linino-16M-rootfs-squashfs.bin

And Upgrade Image will be found in:

    bin/ar71xx/openwrt-ar71xx-generic-linino-16M-squashfs-sysupgrade.bin

### Contact

In case you get an error when building, run with:

    make V=s 

Copy the relevant error snippet at the end of the output.

Email it to support@geog.co
