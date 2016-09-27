#!/bin/bash
##ERAY ALPARSLAN (ruroot)
##contact: dusty_wind91@yahoo.com

function hey(){

clear

echo -n "Date: " 
date

echo
echo "IP Information"
echo "--------------"
echo -n "Internal IP: "

hostname -I


echo -n "External IP: "

curl icanhazip.com

echo -n "Broadcast Address: "

/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f3 | awk '{ print $1}'


echo -n "Mask: " 
/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f4 | awk '{ print $1}'

echo -n "IPv6 Address: "

/sbin/ifconfig eth0 |  awk '/inet6/{print $3}'

echo
echo
echo "DNS Settings:"
echo "-------------"
cat /etc/resolv.conf | grep  "."

echo
echo
echo "Real users having home directory: "
echo "-------------------------------"
cd /home
ls -d */
cd -
echo

echo
echo "Operating System Information"
echo "----------------------------"
echo -n "Kernel: "
uname -a | cut -d ' ' -f10

echo -n "Distrubiton: "
uname -a | cut -d ' ' -f6

echo -n "Sub-Distro: "
uname -a | cut -d ' ' -f2

echo -n "Release: "
uname -a | cut -d ' ' -f8

echo -n "Architecture: "
uname -a | cut -d ' ' -f9

echo -n "Desktop Environment (GUI): "
env | grep 'XDG_CURRENT_DESKTOP' | cut -d '=' -f2


echo
echo "Hardware Information"
echo "--------------------"
echo "Poduct Info:"
cd /sys/devices/virtual/dmi/id/
for f in *; do
            printf "$f "
                    cat $f 2>/dev/null || echo "***_Unavailable_***"
                done | grep 'sys_vendor'     | tr -d 'sys_vendor'  | tr -d ' '


 for f in *; do
             printf "$f "
                    cat $f 2>/dev/null || echo "***_Unavailable_***"
                done | grep 'product_name'   | tr -d 'product_name'| tr -d ' '


  for f in *; do
              printf "$f "
                    cat $f 2>/dev/null || echo "***_Unavailable_***"
                done | grep 'product_version'   | tr -d 'product_version'| tr -d ' '
cd -
echo


echo "1-) CPU: "
echo -n "      "
lscpu | grep "Model name"
echo -n "      "
lscpu | grep "CPU(s):" | head -1
echo -n "      "
lscpu | grep "Architecture:"
echo
echo "2-) RAM: "
echo -n "      "
cat /proc/meminfo | grep MemTotal
echo -n "      "
cat /proc/meminfo | grep MemFree
echo -n "      "
cat /proc/meminfo | grep MemAvailable
echo -n "      " 
cat /proc/meminfo | grep Buffers
echo -n "      "
cat /proc/meminfo | grep Cached | head -1
echo
echo "3-) Graphic Card (GPU):"
echo -n "     "
lspci -vnn | grep VGA -A 12 | cut -d '.' -f3 | cut -d ':' -f2 | head -2 | tail -1 | tr -d {[*}  
echo
echo "4-) Storage:  "
echo -n "      "
ls /dev/disk/by-id | head -2 | tail -1
lsblk -mlfan
echo
echo "5-) Audio:"
echo -n "     "
lspci -v | grep -i audio | head -1 | cut -d ':' -f3
echo -n "     "
lspci -v | grep -i audio | tail -1 | cut -d ':' -f3
echo
echo "6-) Network Interface Card (NIC):"
echo -n "     "
lspci | egrep -i --color 'network|ethernet' | head -1 | cut -d ':' -f3
echo -n "     "
lspci | egrep -i --color 'network|ethernet' | tail -1 | cut -d ':' -f3
echo
echo "Last Logins: "
echo "------------"
lastlog | grep -v "Never"
echo


echo
} # Function finishes 

hey


while true; do
    read -p "Do you want to keep a log in the current directory? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            hey > iplog.txt
            mv iplog.txt iplog_$(date +%d%m%y_%R).txt
            break;;
        [Nn]* ) exit;;
        * ) echo  "Please answer yes or no.";;

    esac
done



