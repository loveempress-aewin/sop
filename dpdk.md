-------------------------------------------------------------------------------
created	:
2025-07-18_15:06:17 (Fri Jul 18 15:06:17 CST 2025)

date	:
.

-------------------------------------------------------------------------------
auto : lovequeen

## machine info ##
![cpu-info](./pic/dpdk_cpu_info.png)

| BIOS      | C7910004                                                                    |
|:---------:|:---------------------------------------------------------------------------:|
| OS        | Ubuntn 22.04.4 LTS                                                          |
| Kernel    | 5.15.0-143-generic                                                          |
| CPU       | Intel(R) Atom(TM) CPU C3558R @ 2.40GHz                                      |
| RAM       | 16GiB DIMM DDR4 Synchronous Unbuffered (Unregistered) 2666 MHz (0.4 ns) * 1 |
| 機板 型號 | 774-7910A01-010-E2211Y08072                                                 |


![cpu-pic](./pic/dpdk_cpu_uuid.jpg)
![ram](./pic/dpdk_ram.jpg)

-------------------------------------------------------------------------------

DPDK
====
DPDK（Data Plane Development Kit） 是一套用於高速封包處理的開發工具組，
主要用於繞過 Linux 核心網路堆疊
直接在使用者空間處理封包
達到極高的效能
常見應用包括

+ 軟體路由器
+ 防火牆
+ 負載平衡器
+ SDN/NFV 解決方案

Preparatory work is required before using DPDK
==============================================

在DPDK前要先前置作業

```bash ====sss================================================================
sudo apt update
sudp apt-get install -y gcc
sudo apt-get install -y ethtool screen ipmitool pkg-config net-tools make smartmontools python3.9
sudo apt-get install -y libi2c-dev libnuma-dev build-essential numactl
sudo apt-get install -y python3-pip
pip3 install meson ninja
sudo apt-get install python3-pyelftools
sudo apt-get install ninja-build
sudo apt-get install meson
```


install DPDK
============
[DPDK official website](https://core.dpdk.org/download/)
[linux download website](http://fast.dpdk.org/rel/)
![dpdk-download](./pic/dpdk_download.png)

筆者一開始用 `dpdk-24.11.2 LTS`
但是無法正常meson ninja!!
但是有產出一個版本 是用make的

> 最新的專案聽說都用 meson + ninja 但是因為太忙找的資料太多 筆者找不到原文了....==

在DQA 使用的是這個
這裡只用 **`dpdk23.03`**
筆者就是用這個就可以正常編譯

```bash ====sss================================================================
#### download dpdk
#### wget http://fast.dpdk.org/rel/dpdk-24.11.2.tar.gz
wget http://fast.dpdk.org/rel/dpdk-23.03.tar.xz
tar xvf dpdk-23.03

#### cd spcific version dpdk
cd dpdk-23.03
```

```bash ====sss================================================================
cd dpdk-23.02
meson build
cd build
ninja
ninja install
ldconfig
cd ..

cd examples/l3fwd
export RTE_SDK=/root/dpdk-23.03
export RTE_TARGET=build
make clean
make
```

need modify grub
================

再來要配置3個部分
1. [isolate CPU](#1-isolate-cpu)
在 Linux 中「隔離 CPU」通常是指將某些 CPU 核心從一般的系統排程中隔離出來
讓它們專門用於特定任務
2. [DPDK hugepages](#2-dpdk-hugepages)
Hugepages是DPDK用於提升性能的重要手段
3. [啟用vfio-pci iommu](#3-vifo-pci-iommu)
在後續用 `l3fwd` 需要用!!!!

### 1-isolate-cpu ###

在 Linux 中「隔離 CPU」通常是指將某些 CPU 核心從一般的系統排程中隔離出來
讓它們專門用於特定任務（例如 DPDK、實時應用程式、容器等）
以提升效能與穩定性
以下是幾種常見的隔離方式：

#### Inspect CPU core count ####

選取 isolcpus 的核心是根據 CPU 的核心編號（core ID），而不是單純看數量
[view the number of CPU cores](https://blog.csdn.net/weixin_59113684/article/details/142134004#:~:text=%E9%80%9A%E8%BF%87%20lscpu%20%E5%92%8C%20nproc%20%E5%91%BD%E4%BB%A4%EF%BC%8C%E6%88%91%E4%BB%AC%E5%8F%AF%E4%BB%A5%E5%BF%AB%E9%80%9F%E6%9F%A5%E7%9C%8B%20CPU%20%E7%9A%84%E6%A0%B8%E6%95%B0%E4%BB%A5%E5%8F%8A%E7%BA%BF%E7%A8%8B%E6%95%B0%EF%BC%9B%E8%80%8C%E9%80%9A%E8%BF%87,free%20-h%20%E5%91%BD%E4%BB%A4%EF%BC%8C%E6%88%91%E4%BB%AC%E5%8F%AF%E4%BB%A5%E5%BF%AB%E9%80%9F%E8%8E%B7%E5%8F%96%E5%86%85%E5%AD%98%E7%9A%84%E6%80%BB%E9%87%8F%E4%BB%A5%E5%8F%8A%E5%BD%93%E5%89%8D%E7%9A%84%E4%BD%BF%E7%94%A8%E6%83%85%E5%86%B5%E3%80%82%20%E6%8E%8C%E6%8F%A1%E8%BF%99%E4%BA%9B%E5%91%BD%E4%BB%A4%E5%90%8E%EF%BC%8C%E4%BD%A0%E5%B0%B1%E5%8F%AF%E4%BB%A5%E8%BD%BB%E6%9D%BE%E4%BA%86%E8%A7%A3%E6%9C%BA%E5%99%A8%E7%9A%84%E7%A1%AC%E4%BB%B6%E9%85%8D%E7%BD%AE%EF%BC%8C%E4%BB%8E%E8%80%8C%E6%9B%B4%E5%A5%BD%E5%9C%B0%E8%BF%9B%E8%A1%8C%E7%B3%BB%E7%BB%9F%E8%B0%83%E4%BC%98%E5%92%8C%E8%B5%84%E6%BA%90%E7%AE%A1%E7%90%86%E3%80%82%20%E5%B8%8C%E6%9C%9B%E8%BF%99%E7%AF%87%E5%8D%9A%E5%AE%A2%E8%83%BD%E5%A4%9F%E5%B8%AE%E5%8A%A9%E4%BD%A0%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%20Linux%20%E7%9A%84%E7%A1%AC%E4%BB%B6%E6%9F%A5%E7%9C%8B%E5%B7%A5%E5%85%B7%EF%BC%8C%E5%81%9A%E5%A5%BD%E7%B3%BB%E7%BB%9F%E6%80%A7%E8%83%BD%E7%9A%84%E7%9B%91%E6%8E%A7%E4%B8%8E%E8%B0%83%E4%BC%98%EF%BC%81)
`lscpu` or `nproc` or `cat /proc/cpuinfo`

編輯前的樣式 筆者這裡用 監視器的方式確認

可以看到有4個CPU
![cpu-0](./pic/dpdk_cpu_0.png)

那麼系統就不會排程一般任務到 CPU 2 和 3，這樣 DPDK 使用 -l 2,3 就能獨佔這些核心。
`isolcpus=2,3`

![iso23](./pic/dpdk_cpu_isol.png)

perfect !! U did it! 👍👍

### 2-dpdk-hugepages ###

在Linux上設置Hugepages
有兩種大小：2MB 和 1GB
配置大頁記憶體，有兩個時機：
+ boot time （推薦）
boot time 修改Kernel cmdline傳遞給內核`/etc/default/grub `

+ run time
修改sysfs節點 `/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages`

筆者這裡使用 `boot time`
`/etc/default/grub`
`GRUB_CMDLINE_LINUX`
```bash ====sss================================================================
default_hugepagesz=1G hugepagesz=1G hugepages=8
```

### 3-vifo-pci-iommu ###

l3fwd運行綁定網卡方式：（啟用vfio-pci、iommu啟用）VFIO
它更加強大和安全，依賴於IOMMU
+ Linix kernel version>=3.6.0
+ 內核和BIOS必須支援並配置為使用（例如Intel®VT-d）IO virtualization

> 在修改前請先確認你的CPU 是否支援

![os](./pic/dpdk_os_info.png)

```bash ====sss================================================================
dmesg | grep iommu
```
`/etc/default/grub` <-- modify
`GRUB_CMDLINE_LINUX`

`intel_iommu=on`

## 🧰 conclude: isolcpus+hugepages+VFIO+iommu ##

編輯 GRUB 設定檔
```bash ====ss================================================================
sudo nano /etc/default/grub
```
edit the file
```bash =sss================================================================
#### 加入 isolcpus 參數，例如要隔離 CPU 2 和 3
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash isolcpus=2,3"

#### hugepages setting + iommu
GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0,115200 default_hugepagesz=1G hugepagesz=1G hugepages=8 intel_iommu=on"
```

```bash ====sss================================================================
#### 更新 GRUB
sudo update-grub
####====output====>
#   Sourcing file `/etc/default/grub'
#   Sourcing file `/etc/default/grub.d/init-select.cfg'
#   Generating grub configuration file ...
#   Found linux image: /boot/vmlinuz-5.15.0-143-generic
#   Found initrd image: /boot/initrd.img-5.15.0-143-generic
#   Found linux image: /boot/vmlinuz-5.15.0-142-generic
#   Found initrd image: /boot/initrd.img-5.15.0-142-generic
#   Found linux image: /boot/vmlinuz-5.15.0-113-generic
#   Found initrd image: /boot/initrd.img-5.15.0-113-generic
#   Warning: os-prober will not be executed to detect other bootable partitions.
#   Systems on them will not be added to the GRUB boot configuration.
#   Check GRUB_DISABLE_OS_PROBER documentation entry.
#   Adding boot menu entry for UEFI Firmware Settings ...
#   done

#### reboot OS
sudo reboot
```

-------------------------------------------------------------------------------

### check isolate CPU ###
![dpdk-check-cpu](./pic/dpdk_cpu_isol.png)

-------------------------------------------------------------------------------

all step Layer 3 forwarding
===========================

## pre-setiing ##
這裡要先準備3個步驟

~~筆者這裡不寫錯誤處理~~
~~錯誤處理方式會另外寫~~

+ [step 1 Verify that each MAC address](#step-1-mac-address)
shown by ifconfig is unique and not duplicated

> 因為可能會發生相同mac address 而造成問題

+ [step 2 use `dpdk-devbind.py --status`](#step-2-dpdk-status)
to identify the target devices you want

+ [step 3 Use `dpdk-devbind.py --bind=vfio-pci <pci-id>`](#step-3-dpdk-bind)
to bind a specific prot


### step-1-mac-address ###

```bash ====sss================================================================
6: enp9s0f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 00:a0:c9:00:00:cd brd ff:ff:ff:ff:ff:ff
7: enp9s0f1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 00:a0:c9:00:00:ef brd ff:ff:ff:ff:ff:ff
```
> make sure each mac address is unique

### step-2-dpdk-status ###

```bash ====sss================================================================
 ./usertools/dpdk-devbind.py --status

Network devices using kernel driver
===================================
0000:02:00.0 'I211 Gigabit Network Connection 1539' if=enp2s0 drv=igb unused=vfio-pci
0000:03:00.0 'I211 Gigabit Network Connection 1539' if=enp3s0 drv=igb unused=vfio-pci *Active*
0000:04:00.0 'I211 Gigabit Network Connection 1539' if=enp4s0 drv=igb unused=vfio-pci
0000:05:00.0 'I211 Gigabit Network Connection 1539' if=enp5s0 drv=igb unused=vfio-pci
0000:09:00.0 'Ethernet Connection X553 10 GbE SFP+ 15c4' if=enp9s0f0 drv=ixgbe unused=vfio-pci
0000:09:00.1 'Ethernet Connection X553 10 GbE SFP+ 15c4' if=enp9s0f1 drv=ixgbe unused=vfio-pci
0000:0a:00.0 'Ethernet Connection X553 1GbE 15e5' if=enp10s0f0 drv=ixgbe unused=vfio-pci
0000:0a:00.1 'Ethernet Connection X553 1GbE 15e5' if=enp10s0f1 drv=ixgbe unused=vfio-pci
```

![mac-and-dpdk-status](./pic/dpdk_mac_address_status_1.png)

### step-3-dpdk-bind ###

```bash ====sss================================================================
root@updatetool:~/dpdk-23.03#   ./usertools/dpdk-devbind.py --bind=vfio-pci 0000:09:00.0 0000:09:00.1
root@updatetool:~/dpdk-23.03#  ./usertools/dpdk-devbind.py --status

Network devices using DPDK-compatible driver
============================================
0000:09:00.0 'Ethernet Connection X553 10 GbE SFP+ 15c4' drv=vfio-pci unused=ixgbe
0000:09:00.1 'Ethernet Connection X553 10 GbE SFP+ 15c4' drv=vfio-pci unused=ixgbe

Network devices using kernel driver
===================================
0000:02:00.0 'I211 Gigabit Network Connection 1539' if=enp2s0 drv=igb unused=vfio-pci
0000:03:00.0 'I211 Gigabit Network Connection 1539' if=enp3s0 drv=igb unused=vfio-pci *Active*
0000:04:00.0 'I211 Gigabit Network Connection 1539' if=enp4s0 drv=igb unused=vfio-pci
0000:05:00.0 'I211 Gigabit Network Connection 1539' if=enp5s0 drv=igb unused=vfio-pci
0000:0a:00.0 'Ethernet Connection X553 1GbE 15e5' if=enp10s0f0 drv=ixgbe unused=vfio-pci
0000:0a:00.1 'Ethernet Connection X553 1GbE 15e5' if=enp10s0f1 drv=ixgbe unused=vfio-pci
```
![dpdk-bind](./pic/dpdk_bind_done.png)

## lauch-l3fwd ##

> 請在dpdk 的root目錄
```bash ====sss================================================================
./examples/l3fwd/build/l3fwd -l {core_num} -n {memory_channel} {EAL} -P -p 0x3 --config="(0,0,1),(1,0,2)

./examples/l3fwd/build/l3fwd -l 1-2 -n 1 -- -P -p 0x3 --config="(0,0,1),(1,0,2)

```

`-l 1-2`
This tells DPDK to use logical cores 1 and 2.
Core 0 is often reserved for the OS, so we skip it.

`-n 1`
This sets the number of memory channels to 1.
It should match your system’s configuration.

`--`
This separates
EAL (Environment Abstraction Layer)
arguments from application-specific arguments.

`5. -P`
Enables promiscuous mode on the ports,
> meaning the NIC will accept all packets,

not just those addressed to it.

`6. -p 0x3`
This is a bitmask that tells DPDK which ports to use.

0x3 in binary is 11, so it enables port 0 and port 1.

`7. --config="(0,0,1),(1,0,2)"`
This configures how packets are forwarded. Each tuple is in the format:

(port, queue, destination core)

(0,0,1) means: traffic from port 0, queue 0, will be handled by core 1
(1,0,2) means: traffic from port 1, queue 0, will be handled by core 2



```bash ====sss================================================================
./examples/l3fwd/build/l3fwd -l 1-2 -n 1 -- -P -p 0x3 --config="(0,0,1),(1,0,2)"
####====output====>
##EAL: Detected CPU lcores: 4
##EAL: Detected NUMA nodes: 1
##EAL: Detected shared linkage of DPDK
##EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
##EAL: Selected IOVA mode 'VA'
##EAL: VFIO support initialized
##EAL: Using IOMMU type 1 (Type 1)
##EAL: Probe PCI driver: net_ixgbe (8086:15c4) device: 0000:09:00.0 (socket -1)
##EAL: Probe PCI driver: net_ixgbe (8086:15c4) device: 0000:09:00.1 (socket -1)
##TELEMETRY: No legacy callbacks, legacy socket not created
##Neither ACL, LPM, EM, or FIB selected, defaulting to LPM
##L3FWD: Missing 1 or more rule files, using default instead
##Initializing port 0 ... Creating queues: nb_rxq=1 nb_txq=2... Port 0 modified RSS hash function based on hardware support,requested:0xa38c configured:0x8104
## Address:00:A0:C9:00:00:CD, Destination:02:00:00:00:00:00, Allocated mbuf pool on socket 0
##LPM: Adding route 198.18.0.0 / 24 (0) [0000:09:00.0]
##LPM: Adding route 198.18.1.0 / 24 (1) [0000:09:00.1]
##LPM: Adding route 2001:200:: / 64 (0) [0000:09:00.0]
##LPM: Adding route 2001:200:0:1:: / 64 (1) [0000:09:00.1]
##txq=1,0,0 txq=2,1,0
##Initializing port 1 ... Creating queues: nb_rxq=1 nb_txq=2... Port 1 modified RSS hash function based on hardware support,requested:0xa38c configured:0x8104
## Address:00:A0:C9:00:00:EF, Destination:02:00:00:00:00:01, txq=1,0,0 txq=2,1,0
##
##Initializing rx queues on lcore 1 ... rxq=0,0,0
##Initializing rx queues on lcore 2 ... rxq=1,0,0
```

當開啟成功後 他會進入一個 loop 中
表示成功

要離開 就用一個
`^C` `Ctrl+c`


```bash ====exit================================================================
^C

Signal 2 received, preparing to exit...
Closing port 0... Done
Closing port 1... Done
Bye...
```

-------------------------------------------------------------------------------


