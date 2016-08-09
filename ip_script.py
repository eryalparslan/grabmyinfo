#!/bin/bash
##ERAY ALPARSLAN
##contact: dusty_wind91@yahoo.com
clear

date

echo

echo -n "Internal IP: "

hostname -I


echo -n "External IP: "

curl icanhazip.com

echo -n "Broadcast Adress: "

/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f3 | awk '{ print $1}'


echo -n "Mask: " 
/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f4 | awk '{ print $1}'

echo -n "IPv6 Address: "

/sbin/ifconfig eth0 |  awk '/inet6/{print $3}'



