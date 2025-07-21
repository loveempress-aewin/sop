-------------------------------------------------------------------------------
created	:
2025-07-15_13:24:19 (Tue Jul 15 13:24:19 CST 2025)

date	:
2025-07-21_15:27:53 (Mon Jul 21 15:27:53 CST 2025)

-------------------------------------------------------------------------------

DPDK issue
==========
```bash ====sss================================================================
== Build lib/librte_eal/linux/eal
  CC eal_memory.o
/root/dpdk-stable-19.11.4/lib/librte_eal/linux/eal/eal_memory.c:32:10: fatal error: numa.h: No such file or directory
   32 | #include <numa.h>
      |          ^~~~~~~~
compilation terminated.
make[7]: *** [/root/dpdk-stable-19.11.4/mk/internal/rte.compile-pre.mk:116: eal_memory.o] Error 1
make[6]: *** [/root/dpdk-stable-19.11.4/mk/rte.subdir.mk:37: eal] Error 2
make[5]: *** [/root/dpdk-stable-19.11.4/mk/rte.subdir.mk:37: linux] Error 2
make[4]: *** [/root/dpdk-stable-19.11.4/mk/rte.subdir.mk:37: librte_eal] Error 2
make[3]: *** [/root/dpdk-stable-19.11.4/mk/rte.sdkbuild.mk:48: lib] Error 2
make[2]: *** [/root/dpdk-stable-19.11.4/mk/rte.sdkroot.mk:99: all] Error 2
make[1]: *** [/root/dpdk-stable-19.11.4/mk/rte.sdkinstall.mk:61: pre_install] Error 2
make: *** [/root/dpdk-stable-19.11.4/mk/rte.sdkroot.mk:77: install] Error 2
------------------------------------------------------------------------------
 RTE_TARGET exported as x86_64-native-linuxapp-gcc
------------------------------------------------------------------------------
```

24.11.2
`meson build`
```bash ====sss================================================================
Fetching value of define "__AVX512BW__" : 1
Fetching value of define "__AVX512CD__" : 1
Fetching value of define "__AVX512DQ__" : 1
Fetching value of define "__AVX512F__" : 1
Fetching value of define "__AVX512VL__" : 1
Fetching value of define "__PCLMUL__" : 1
Fetching value of define "__RDRND__" : 1
Fetching value of define "__RDSEED__" : 1
Fetching value of define "__VPCLMULQDQ__" : 1

config/meson.build:441:4: ERROR: Problem encountered:
No NUMA library (development package) found, yet DPDK configured for multiple NUMA nodes.
Please install libnuma, or set 'max_numa_nodes' option to '1' to build without NUMA support.

A full log can be found at /root/dpdk-stable-24.11.2/build/meson-logs/meson-log.txt
WARNING: Running the setup command as `meson [options]` instead of `meson setup [options]` is ambiguous and deprecated.
```

### solution-1 ###
maybe it is loss open MPI ...not NUMA issue[.](https://cloud.tencent.com/developer/ask/sof/108799564)
+ not working....

### solution-2 ###
[`apt install libnuma-dev`](https://juejin.cn/post/7413418434573910025)
+ ✅ work
```bash ====sss================================================================
crypto:
        bcmfs, caam_jr, cnxk, dpaa_sec, dpaa2_sec, ionic, nitrox, null,
        octeontx, scheduler, virtio,
compress:
        nitrox, octeontx, zlib,
regex:
        cn9k,
ml:
        cnxk,
vdpa:
        ifc, nfp, sfc,
event:
        cnxk, dlb2, dpaa, dpaa2, dsw, opdl, skeleton, sw,
        octeontx,
baseband:
        acc, fpga_5gnr_fec, fpga_lte_fec, la12xx, null, turbo_sw,
gpu:

power:
        acpi, amd_pstate, cppc, intel_pstate, intel_uncore, kvm_vm,

Message:
=================
Content Skipped
=================

apps:
        dumpcap:        missing dependency, "libpcap"

libs:

drivers:
        common/mvep:    missing dependency, "libmusdk"
        common/mlx5:    missing dependency, "mlx5"
        crypto/qat:     missing dependency, libipsecmb or libcrypto
        net/af_xdp:     missing dependency, "libxdp >=1.2.2" and "libbpf"
        net/ipn3ke:     missing dependency, "libfdt"
        net/mana:       missing dependency, "ibverbs"
        net/mlx4:       missing dependency, "mlx4"
        net/mlx5:       missing internal dependency, "common_mlx5"
        net/mvneta:     missing dependency, "libmusdk"
        net/mvpp2:      missing dependency, "libmusdk"
        net/nfb:        missing dependency, "libnfb"
        net/pcap:       missing dependency, "libpcap"
        raw/ifpga:      missing dependency, "libfdt"
        crypto/armv8:   missing dependency, "libAArch64crypto"
        crypto/ccp:     missing dependency, "libcrypto"
        crypto/ipsec_mb:        missing dependency, "libIPSec_MB"
        crypto/mlx5:    missing internal dependency, "common_mlx5"
        crypto/mvsam:   missing dependency, "libmusdk"
        crypto/openssl: missing dependency, "libcrypto"
        crypto/uadk:    missing dependency, "libwd"
        compress/isal:  missing dependency, "libisal"
        compress/mlx5:  missing internal dependency, "common_mlx5"
        compress/uadk:  missing dependency, "libwd"
        regex/mlx5:     missing internal dependency, "common_mlx5"
        vdpa/mlx5:      missing internal dependency, "common_mlx5"
        gpu/cuda:       missing dependency, "cuda.h"
        power/amd_uncore:       missing dependency, "libe_smi"


Message: DPDK build config complete:
  source path = "/root/dpdk-stable-24.11.2"
  build path  = "/root/dpdk-stable-24.11.2/build"
Build targets in project: 703

Found ninja-1.11.1.git.kitware.jobserver-1 at /usr/local/bin/ninja
WARNING: Running the setup command as `meson [options]` instead of `meson setup [options]` is ambiguous and deprecated.
```

```bash ====sss================================================================
root 14:56:56 ~/dpdk-stable-24.11.2/build --> ninja
[2829/2829] Linking target app/dpdk-test
```

```bash ====sss================================================================
sodu apt install build-essential meson python3-pyelftools libnuma-dev

sudo apt install pkgconf
```
[yt](https://www.youtube.com/watch?v=0yDdMWQPCOI)

all lib install in dir `/usr/local/lib/x86_64-linux-gnu/`
can excute `/usr/local/bin`
[ref-important](https://juejin.cn/post/7413418434573910025)

-------------------------------------------------------------------------------

use dpdk-devbind.py
===================

```bash ====sss================================================================
root@updatetool:~/dpdk-stable-24.11.2/usertools#  ./dpdk-devbind.py --bind=vfio-pci 0000:0a:00.0
Error: IOMMU support is disabled, use --noiommu-mode for binding in noiommu mode
root@updatetool:~/dpdk-stable-24.11.2/usertools#  ./dpdk-devbind.py --noiommu-mode 0000:0a:00.0
Error: No action specified for devices. Please give a --bind, --ubind or --status option
usage: dpdk-devbind.py [-h] [-s] [--status-dev {baseband,compress,crypto,dma,event,mempool,misc,net,regex,ml}] [-b DRIVER | -u]
                       [--noiommu-mode] [--force]
                       [DEVICE ...]
root@updatetool:~/dpdk-stable-24.11.2/usertools#  ./dpdk-devbind.py --bind=noiommu-mode 0000:0a:00.0
Error: Driver 'noiommu-mode' is not loaded.
root@updatetool:~/dpdk-stable-24.11.2/usertools#
root@updatetool:~/dpdk-stable-24.11.2/usertools# dmesg |grep iommu
[    0.937108] iommu: Default domain type: Translated
[    0.937116] iommu: DMA domain TLB invalidation policy: lazy mode
```

## check iommu is enable ##

check iomm is enable
```bash ====sss================================================================
root@updatetool:~#  dmesg | grep iomm
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.15.0-143-generic root=UUID=75fa57cf-3e23-471a-af4d-85958992b23b ro console=tty0 console=ttyS0,115200 default_hugepagesz=1G hugepagesz=1G hugepages=8 intel_iommu=on quiet splash isolcpus=2,3 vt.handoff=7
[    0.195809] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.15.0-143-generic root=UUID=75fa57cf-3e23-471a-af4d-85958992b23b ro console=tty0 console=ttyS0,115200 default_hugepagesz=1G hugepagesz=1G hugepages=8 intel_iommu=on quiet splash isolcpus=2,3 vt.handoff=7
[    0.924358] iommu: Default domain type: Translated
[    0.924366] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.036573] pci 0000:00:00.0: Adding to iommu group 0
[    1.036617] pci 0000:00:04.0: Adding to iommu group 1
[    1.036655] pci 0000:00:05.0: Adding to iommu group 2
[    1.036692] pci 0000:00:06.0: Adding to iommu group 3
[    1.036736] pci 0000:00:09.0: Adding to iommu group 4
[    1.036775] pci 0000:00:0a.0: Adding to iommu group 5
[    1.036847] pci 0000:00:0b.0: Adding to iommu group 6
[    1.036890] pci 0000:00:0c.0: Adding to iommu group 7
[    1.036934] pci 0000:00:0e.0: Adding to iommu group 8
[    1.036978] pci 0000:00:10.0: Adding to iommu group 9
[    1.037027] pci 0000:00:11.0: Adding to iommu group 10
[    1.037068] pci 0000:00:12.0: Adding to iommu group 11
[    1.037112] pci 0000:00:13.0: Adding to iommu group 12
[    1.037150] pci 0000:00:15.0: Adding to iommu group 13
[    1.037189] pci 0000:00:16.0: Adding to iommu group 14
[    1.037226] pci 0000:00:17.0: Adding to iommu group 15
[    1.037285] pci 0000:00:18.0: Adding to iommu group 16
[    1.037325] pci 0000:00:1c.0: Adding to iommu group 17
[    1.037421] pci 0000:00:1f.0: Adding to iommu group 18
[    1.037461] pci 0000:00:1f.2: Adding to iommu group 18
[    1.037501] pci 0000:00:1f.4: Adding to iommu group 18
[    1.037552] pci 0000:00:1f.5: Adding to iommu group 18
[    1.037596] pci 0000:01:00.0: Adding to iommu group 19
[    1.037638] pci 0000:02:00.0: Adding to iommu group 20
[    1.037679] pci 0000:03:00.0: Adding to iommu group 21
[    1.037725] pci 0000:04:00.0: Adding to iommu group 22
[    1.037768] pci 0000:05:00.0: Adding to iommu group 23
[    1.037813] pci 0000:09:00.0: Adding to iommu group 24
[    1.037856] pci 0000:09:00.1: Adding to iommu group 25
[    1.037908] pci 0000:0a:00.0: Adding to iommu group 26
[    1.037955] pci 0000:0a:00.1: Adding to iommu group 27
```

## the dpdk-devbind is another  ##
這裡的 dpdk-devbind 是有一套自己的底層工具鏈

這也說明 可能在OS 認不到設備的網口

但在 dpdk-devbind 中 會認到

所以在做確認的時候 要注意這些事情

```bash ====sss================================================================
./dpdk-stable-24.11.2/usertools/dpdk-devbind.py --status

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

No 'Baseband' devices detected
==============================

Crypto devices using kernel driver
==================================
0000:01:00.0 'Atom Processor C3000 Series QuickAssist Technology 19e2' drv=c3xxx unused=qat_c3xxx,vfio-pci

No 'DMA' devices detected
=========================

No 'Eventdev' devices detected
==============================

No 'Mempool' devices detected
=============================

No 'Compress' devices detected
==============================

No 'Misc (rawdev)' devices detected
===================================

No 'Regex' devices detected
===========================

No 'ML' devices detected
========================
```

> dpdk-devbind.py 綁定是看 pci 的唯一編碼


```bash ====sss================================================================
root@updatetool:~/dpdk-stable-24.11.2/usertools# dpdk-devbind.py --bind=vfio-pci 0000:0a:00.0
root@updatetool:~/dpdk-stable-24.11.2/usertools# dpdk-devbind.py --bind=vfio-pci 0000:0a:00.1
root@updatetool:~/dpdk-stable-24.11.2/usertools# ./dpdk-devbind.py --status

Network devices using DPDK-compatible driver
============================================
0000:0a:00.0 'Ethernet Connection X553 1GbE 15e5' drv=vfio-pci unused=ixgbe
0000:0a:00.1 'Ethernet Connection X553 1GbE 15e5' drv=vfio-pci unused=ixgbe

Network devices using kernel driver
===================================
0000:02:00.0 'I211 Gigabit Network Connection 1539' if=enp2s0 drv=igb unused=vfio-pci
0000:03:00.0 'I211 Gigabit Network Connection 1539' if=enp3s0 drv=igb unused=vfio-pci *Active*
0000:04:00.0 'I211 Gigabit Network Connection 1539' if=enp4s0 drv=igb unused=vfio-pci
0000:05:00.0 'I211 Gigabit Network Connection 1539' if=enp5s0 drv=igb unused=vfio-pci
0000:09:00.0 'Ethernet Connection X553 10 GbE SFP+ 15c4' if=enp9s0f0 drv=ixgbe unused=vfio-pci
0000:09:00.1 'Ethernet Connection X553 10 GbE SFP+ 15c4' if=enp9s0f1 drv=ixgbe unused=vfio-pci

No 'Baseband' devices detected
==============================

Crypto devices using kernel driver
==================================
0000:01:00.0 'Atom Processor C3000 Series QuickAssist Technology 19e2' drv=c3xxx unused=qat_c3xxx,vfio-pci

No 'DMA' devices detected
=========================

No 'Eventdev' devices detected
==============================

No 'Mempool' devices detected
=============================

No 'Compress' devices detected
==============================

No 'Misc (rawdev)' devices detected
===================================

No 'Regex' devices detected
===========================

No 'ML' devices detected
========================
```

這部分是筆者在開啟 mod `iommu` 後確認

~~很詭異的事情...是沒有顯示 iomm~~

> 這個沒有顯示筆者也一頭霧水...



```bash ====sss================================================================
lsmod
Module                  Size  Used by
ipmi_devintf           20480  0
ipmi_msghandler       122880  1 ipmi_devintf
binfmt_misc            24576  1
nls_iso8859_1          16384  1
intel_rapl_msr         20480  0
intel_rapl_common      40960  1 intel_rapl_msr
x86_pkg_temp_thermal    20480  0
intel_powerclamp       24576  0
coretemp               24576  0
ppdev                  24576  0
kvm_intel             372736  0
qat_c3xxx              16384  0
kvm                  1040384  1 kvm_intel
rapl                   20480  0
intel_qat             180224  1 qat_c3xxx
intel_cstate           20480  0
authenc                16384  1 intel_qat
ee1004                 20480  0
mac_hid                16384  0
parport_pc             49152  0
parport                69632  2 parport_pc,ppdev
dm_multipath           40960  0
scsi_dh_rdac           20480  0
scsi_dh_emc            16384  0
scsi_dh_alua           20480  0
sch_fq_codel           20480  17
drm                   622592  0
efi_pstore             16384  0
ip_tables              32768  0
x_tables               53248  1 ip_tables
autofs4                49152  2
btrfs                1564672  0
blake2b_generic        20480  0
zstd_compress         229376  1 btrfs
raid10                 69632  0
raid456               163840  0
async_raid6_recov      24576  1 raid456
async_memcpy           20480  2 raid456,async_raid6_recov
async_pq               24576  2 raid456,async_raid6_recov
async_xor              20480  3 async_pq,raid456,async_raid6_recov
async_tx               20480  5 async_pq,async_memcpy,async_xor,raid456,async_raid6_recov
xor                    24576  2 async_xor,btrfs
raid6_pq              122880  4 async_pq,btrfs,raid456,async_raid6_recov
libcrc32c              16384  2 btrfs,raid456
raid1                  49152  0
raid0                  24576  0
multipath              20480  0
linear                 20480  0
uas                    28672  0
usb_storage            77824  3 uas
crct10dif_pclmul       16384  1
crc32_pclmul           16384  0
ghash_clmulni_intel    16384  0
sha256_ssse3           32768  0
igb                   266240  0
sha1_ssse3             32768  0
aesni_intel           376832  0
crypto_simd            16384  1 aesni_intel
cryptd                 24576  2 crypto_simd,ghash_clmulni_intel
ixgbe                 409600  0
sdhci_pci              69632  0
cqhci                  36864  1 sdhci_pci
ahci                   49152  0
xfrm_algo              16384  1 ixgbe
dca                    16384  2 igb,ixgbe
i2c_i801               36864  0
xhci_pci               24576  0
sdhci                  81920  1 sdhci_pci
libahci                49152  1 ahci
mdio                   16384  1 ixgbe
i2c_smbus              20480  1 i2c_i801
i2c_ismt               32768  0
xhci_pci_renesas       20480  1 xhci_pci
i2c_algo_bit           16384  1 igb
```

```bash ====sss================================================================
 dmesg |grep -i vfio
[    1.168890] VFIO - User Level meta-driver version: 0.3
```

```bash ====sss================================================================
Model name:             Intel(R) Atom(TM) CPU C3558R @ 2.40GHz
```

[.](https://mahumac.github.io/posts/DPDK-vfio-pci%E6%A8%A1%E5%BC%8F%E4%B8%8Biommu(N+Y)-Huge-&-numa%E9%85%8D%E7%BD%AE/#%E8%AE%BE%E7%BD%AE2m%E5%86%85%E5%AD%98%E9%A1%B5)

-------------------------------------------------------------------------------


correct DQA
===========
以下是 DQA所使用的指令
但是只支援版本 `23.03.0`

筆者用 `DPDK 24.11.2 (LTS)` 無法使用

```bash ====install pkg================================================================
apt-get update
apt-get install -y gcc
apt-get install -y ethtool screen ipmitool pkg-config net-tools make smartmontools python3.9
apt-get install -y libi2c-dev libnuma-dev build-essential numactl*
apt-get install -y python3-pip
pip3 install meson ninja
apt-get install python3-pyelftools
apt-get install ninja-build
apt-get install meson
```

```bash ====sss================================================================
cd dpdk-sta
meson build
cd build
ninja
ninja install
ldconfig
cd ..
meson configure -Dexamples=build
cd examples/l3fwd/
export RTE_SDK=/root/dpdk-23.03
export RTE_TARGET=build
make clean
make
```
