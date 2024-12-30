-------------------------------------------------------------------------------
created	:	(old)

date	:	Tue Oct  8 16:52:26 CST 2024

[[os]] [[vm]]

-------------------------------------------------------------------------------


在每一個如果再VM 你需要把它變成 linux 掛載的模式
那需要 先做 file system 的格式化
> 就像 如果你要做 MACOS and WINDOWS system data 互傳
> 也需要做通用的格式
>> WINDOWS : NTFS (MACOS only read)

VM 我們是用LINUX 所以! 就用LINUX的內建指令
讓他變成 LINUX 的形狀
```bash			================start================
root@bmc-VirtualBox:~# mkfs.ext4 /dev/sdc
mke2fs 1.44.1 (24-Mar-2018)
Creating filesystem with 17301504 4k blocks and 4325376 inodes
Filesystem UUID: 49420e39-bf17-4df3-9641-066cfb852de3
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424

Allocating group tables: done
Writing inode tables: done
Creating journal (131072 blocks): done
Writing superblocks and filesystem accounting information: done

root@bmc-VirtualBox:~# mkfs.ext4 /dev/sdd
mke2fs 1.44.1 (24-Mar-2018)
Creating filesystem with 27525120 4k blocks and 6881280 inodes
Filesystem UUID: 0684b79b-6acb-4a2a-a413-a8a095737744
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done
Writing inode tables: done
Creating journal (131072 blocks): done
Writing superblocks and filesystem accounting information: done

root@bmc-VirtualBox:~# mkfs.ext4 /dev/sde
mke2fs 1.44.1 (24-Mar-2018)
Creating filesystem with 32768000 4k blocks and 8192000 inodes
Filesystem UUID: c2f480b8-ace0-4a2b-972c-b4bccf6c3718
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done
Writing inode tables: done
Creating journal (131072 blocks): done
Writing superblocks and filesystem accounting information: done
```
