GeoG Draguino/Linduino OpenWRT Distribution
-------------------------------------------

###Introduction

This Serves as the firmware for Arduino Yun/Seeeduino
devices based on OpenWRT.

### Building

Ensure you have Debian Wheezy installed in LXC/Docker/VM.

Run:

make

It will tell you what dependencies are required. Install them with apt-get.

Now run:

 make toolchain/clean
 make toolchain/install

Now run:

 make

### Contact

In case you get an error when building, run with:

make V=s 

and copy the relevant error snippet at the end of the output.

Email it to support@geog.co
