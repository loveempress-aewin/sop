-------------------------------------------------------------------------------
created	:	Tue Jul  2 11:18:04 CST 2024

date	:	.

-------------------------------------------------------------------------------

# yafu success  #
```bash
FORCEKILL(7) : Unloading Modules :unloading uartroute [  359.242582] Unloading AST UARTROUTE Module ..............
[  359.248623] uartroute char device del
[  359.252782] AST2400 UARTROUTE module unloaded sucessfully.
unloading uartroute_mod unloading videocap rmmod: remove 'videocap': Resource temporarily unavailable
unloading reset rmmod: remove 'reset': Resource temporarily unavailable

[  359.418350] S52initcomplete (3486): drop_caches: 3
8192+0 records in
8192+0 records out
4194304 bytes (4.0MB) copied, 0.688546 seconds, 5.8MB/s
[1538 : 1538 INFO]
 Switching root to RAM.....
[1538 : 1538 INFO]Root FS MTD Blk is /dev/mtdblock2

[1538 : 1538 INFO]Copying /dev/mtdblock2 to /var/root.bin ...
[1538 : 1538 INFO]Set /var/root.bin to loop device...
[1538 : 1538 INFO]mount /dev/loop0 to /initrd
[1538 : 1538 INFO]Done

File system /
[1538 : 1538 INFO]Mount devname /dev/ram3 file system squashfs

[1538 : 1538 INFO]Copying /usr/local/www to /initrd...
[1538 : 1538 INFO]Done

[1538 : 1538 INFO]Unmounting /oldroot/usr/local/www/

[1538 : 1538 INFO]
 Switched root successfully.....
[207 : 237 INFO]Creating Thread for YafuTimerTask

[207 : 3494 INFO]YafuTimer has started with Timeout = 8917

[207 : 3494 INFO]Triggering the watchdog device 1 with 8917 timeout 8917


/oldroot/root #  echo " now is first stept--> Uploading Firmware Image : 14% 02:
25.22"
 now is first stept--> Uploading Firmware Image : 14% 02:25.22
/oldroot/root #
```
now is first step

####  I test --> time ####

25%  --> 03:48
50%  --> 07:18
75%  --> 10:47
90%  --> 12:54
96%  --> 13:44
100% --> 14:17

> 我用了 USB && STATA 我也為 USB 有速度限制 (結果是 速度差不多..)

```bash
### bmc console
Skipping the erase block 998
Skipping the erase block 999
Skipping the erase block 1000
Skipping the erase block 1001
Skipping the erase block 1002
Skipping the erase block 1003
Skipping the erase block 1004
Skipping the erase block 1005
Skipping the erase block 1006
Skipping the erase block 1007
Skipping the erase block 1008
Skipping the erase block 1009
Skipping the erase block 1010
Skipping the erase block 1011
Skipping the erase block 1012
Skipping the erase block 1013
Skipping the erase block 1014
Skipping the erase block 1015
Skipping the erase block 1016
Skipping the erase block 1017
Skipping the erase block 1018
Skipping the erase block 1019
Skipping the erase block 1020
Skipping the erase block 1021
Skipping the erase block 1022
Skipping the erase block 1023
[3503 : 3503 INFO]Entering Preserve Configuration ... !!!

[3503 : 3503 INFO]Preserving BIOS files --

[207 : 237 INFO]RestartBMC Invoked RebootState: 1 flashedimage: 1
No iptables conf found
[207 : 244 INFO]PendRestartServices Service: 3
Restarting system...
```
他後面會很快
然後就重新啟動
所以 我這邊測試 兩邊interrupt
1. uploading firmware
2. uploaded firmware

-------------------------------------------------------------------------------

uploading interrupt
====

uploaded interrupt
======
```bash
##### OS
root@aewin:~#  task
    PID TTY          TIME CMD
   1284 tty2     00:00:02 Xorg
   1331 tty2     00:00:00 gnome-session-b
   2464 pts/1    00:08:53 YafuflashV7
   2606 pts/2    00:00:00 ps
root@aewin:~#  kill -9 2464
```
and then look BMC console
```bash
###### execute session
+-----------------------------------------------------------+
|      YAFUFlash - Firmware Upgrade Utility v7.01.0059      |
| Copyright (c) 2020 American Megatrends International, LLC |
+-----------------------------------------------------------+
===============================================================================
                             Firmware Details
===============================================================================
                               RomImage         ExistingImage

    ModuleName   Description   Version          Version
1.  boot         BootLoader    13.5.000000      13.5.000000
2.  conf         ConfigParams  13.5.000000      13.5.000000
3.  root         Root          13.5.000000      13.5.000000
4.  osimage      Linux OS      13.5.000000      13.5.000000
5.  www          Web Pages     13.5.000000      13.5.000000
6.  arcity                     13.5.202302      13.5.202302
Existing Image and Current Image are Same
So, type (Y/y) to do Full Firmware Upgrade or (N/n) to exit
Enter your Option : Y
Error : While deactivating the device
Error : While deactivating the device
Error : While deactivating the device
Error : While deactivating the device
Error : While deactivating the device

****************************************************************************
 WARNING!
        FIRMWARE UPGRADE MUST NOT BE INTERRUPTED ONCE IT IS STARTED.
        PLEASE DO NOT USE THIS FLASH TOOL FROM THE REDIRECTION CONSOLE.
****************************************************************************
Preserving Env Variables...             done
Uploading Firmware Image : 100%... done
Skipping [boot] Module ....
Flashing [conf] Module ....
Killed
root@aewin:/home/oem/Desktop#
```

```bash
####### bmc console
Skipping the erase block 16
Upgrading the block =  17
Upgrading the block =  18
Skipping the erase block 19
Skipping the erase block 20
Skipping the erase block 21
Skipping the erase block 22
Skipping the erase block 23
Skipping the erase block 24
Skipping the erase block 25
Skipping the erase block 26
Skipping the erase block 27
Upgrading the block =  28
Upgrading the block =  29
Upgrading the block =  30
Skipping the erase block 31
Skipping the erase block 32
Skipping the erase block 33
Skipping the erase block 34
Skipping the erase block 35
Skipping the erase block 36
Skipping the erase block 37
Skipping the erase block 38
Skipping the erase block 39
Skipping the erase block 40
Skipping the erase block 41
Skipping the erase block 42
Skipping the erase block 43
Skipping the erase block 44
Skipping the erase block 45
Skipping the erase block 46
Upgrading the block =  47


AMI000D48569B95 login: sysadmin
login[3566]: PAM _pam_init_handlers: no default config other
login[3566]: PAM error reading PAM configuration file
login[3566]: PAM pam_start: failed to initialize handlers
login[3566]: pam_start call failed: Critical error - immediate abort (26)
Login incorrect
```

###  redo command ###
```bash
root@aewin:/home/oem/Desktop# yafu/LTS-v13/v7/Linux_x86_64/YafuflashV7 -kcs 5222/IS-5121_v1.1.27N.ima
INFO: Yafu INI Configuration File not found... Default options will not be applied...

+-----------------------------------------------------------+
|      YAFUFlash - Firmware Upgrade Utility v7.01.0059      |
| Copyright (c) 2020 American Megatrends International, LLC |
+-----------------------------------------------------------+
===============================================================================
                             Firmware Details
===============================================================================
                               RomImage         ExistingImage

    ModuleName   Description   Version          Version
1.  boot         BootLoader    13.5.000000      13.5.000000
2.  conf         ConfigParams  13.5.000000      13.5.000000
3.  root         Root          13.5.000000      13.5.000000
4.  osimage      Linux OS      13.5.000000      13.5.000000
5.  www          Web Pages     13.5.000000      13.5.000000
6.  arcity                     13.5.202302      13.5.202302
Existing Image and Current Image are Same
So, type (Y/y) to do Full Firmware Upgrade or (N/n) to exit
Enter your Option : Y
Warning: Device is already in Firmware Update Mode...
```

##  if bmc crash--> verify use bmc console ##
```
##### bmc console
AMI000D48569B95 login: sysadmin
login[2242]: PAM _pam_init_handlers: no default config other
login[2242]: PAM error reading PAM configuration file
login[2242]: PAM pam_start: failed to initialize handlers
login[2242]: pam_start call failed: Critical error - immediate abort (26)
```

# result #
| barracuda LED event         | power on LED | UID LED       | Inform action LED | Notice   |
|:---------------------------:|:------------:|:-------------:|:-----------------:|:--------:|
| BMC firmware update failed  | blinking     | Blinking      |                   | TEST     |
|-----------------------------|--------------|---------------|-------------------|----------|
| BMC firmware update failed  |              | Blinking@10Hz | Blinking@10Hz     | JOHN DOC |
|-----------------------------|--------------|---------------|-------------------|----------|
| BMC firmware update execute | blinking@2Hz | Blinking@2Hz  |                   | TEST     |
| BMC firmware update success | Light        |               |                   | TEST     |
