#!/bin/bash

# check if the current user is root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# update package manager cache
apt update

# install build dependencies
apt install -y build-essential dkms

# download RTL8188EU driver source
git clone https://github.com/lwfinger/rtl8188eu

# build and install driver
cd rtl8188eu-master
make
make install

# load the driver module
modprobe rtl8188eu

echo "Completed installing RTL8188EU drivers,Reboot your pc"
