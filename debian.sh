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
make all
make install

# load the driver module
modprobe rtl8188eu

echo "Completed installing RTL8188EU drivers,Reboot your pc"
echo "uncomment the next commands in the sh file to use the troubleshooting steps given in the original repo by lwfinger"

#cp rtl8188eu.bin /lib/firmware/rtlwifi/
#echo "add [device]"
#echo "wifi.scan-rand-mac-address=no"
#echo "the two previous lines of text, need to be on seperate lines, in the file that nano creates next"
#nano /etc/NetworkManager/conf.d/80-wifi.conf
#systemctl restart NetworkManager
