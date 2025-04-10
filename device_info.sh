#!/bin/bash

## Filename: device_info.sh
## Author: yu1
## Date: 2024-08-30 14:43:45 +0800
## change: Tue Mar 25 11:32:42 CST 2025
##
## Description:
## 		showing device hardware information
##		excution-environment: ubuntu 22.04 LTS
##		install lshw before use it
##


device_name=$(dmidecode -t 1| grep -i system\ information -A 2| grep Name| awk -F ":" '{print $2}')
cpu_info=$(cat /proc/cpuinfo | grep -i model\ name | awk -F ":" '{print $2}' | head -n 1)
os_distribution=$(cat /etc/os-release | head -n 1 | awk -F "=" '{print $2}')
os_kernel=$(uname -a | awk  '{print $3}')
disk_info=$(fdisk -l |grep "$(fdisk -l |grep "Linux filesystem" | awk '{print $1}')" -B 10| grep Disk)
ram_info=$(lshw -short -C memory| grep MHz| awk '{$1="";$2="";print $0}'| head -n 1)
ram_count=$(lshw -short -C memory| grep MHz| awk '{$1="";$2="";print $0}'| wc -l)
read_bios=$(dmidecode -t bios | grep Version | awk -F ":" '{print $2}')
read_bmc=$(echo $((16#$(ipmitool raw 0x1e 0x01 0x00| awk {'print $1'}))).$((16#$(ipmitool raw 0x1e 0x01 0x00| awk {'print $2'}))).$((16#$(ipmitool raw 0x1e 0x01 0x00| awk {'print $3'}))))
love_bmc=$(ipmitool raw 0x1e 0x01 0x00)

echo -e "\n\033[1mDevice name\033[0m:\n $device_name"
echo -e "\033[1mBIOS:\033[0m\n  $read_bios"
echo -e "\033[1mBMC:\033[0m\n  $read_bmc "
echo -e "RAW bmc : \n  $love_bmc\n"
echo -e "\033[1mOS:\033[0m\n  $os_distribution"
echo -e "\033[1mKernel:\033[0m\n  $os_kernel"
echo -e "\033[1mCPU:\033[0m\n $cpu_info"
echo -e "\033[1mStorage:\033[0m\n$disk_info"
echo -e "\033[1mRAM:\033[0m\n$ram_info * $ram_count"
