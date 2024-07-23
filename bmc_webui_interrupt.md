-------------------------------------------------------------------------------
created	:	Wed Jul  3 09:34:18 CST 2024
date	:	.

-------------------------------------------------------------------------------

#  bmc update WEBUI  #
upload Image file (the case is 65536KB --> IS-5121_v1.1.27N.iam)
in WEBUI `https://192.168.199.6/#maintenance/firmware_update_wizard`
`Proceed to Flash`
```bash
###### BMC console
Stopping Redfish Server[I 2024/07/03 01:41:00] luajit server.lua deregistered with procmanger
.
Stopping Task Service
OK
(integer) 0
[I 2024/07/03 01:41:00] luajit ./task-service/task-service.lua deregistered with procmanger
.
Stopping redis-server: All redis processes deregistered with procmanger
[1561 : 1561 INFO]KILLING THREADS

redis-server.
Stopping redisrsync configuration Service...
.
Stopping Remote Media Server.
Stopping redisrsync configuration Service...
kill: you need to specify whom to kill
.
Stopping SNMP Daemons : snmpd.
Stopping enhanced syslogd: rsyslogd.
Stopping SOL application..
Stopping UART Mirror Log applicationsh: you need to specify whom to kill
killall: inotifywait: no process killed
.
FORCEKILL(8): Killing Processes ...
FORCEKILL(8) : Unloading Modules :unloading uartroute [  182.752889] Unloading AST UARTROUTE Module ..............
[  182.758929] uartroute char device del
[  182.763085] AST2400 UARTROUTE module unloaded sucessfully.
unloading uartroute_mod unloading videocap rmmod: remove 'videocap': Resource temporarily unavailable
unloading reset [  182.840265] reset char device del
[  182.844939] Reset Common module unloaded successfully
unloading netmon
[  183.036140] S52initcomplete (3492): drop_caches: 3
8192+0 records in
8192+0 records out
4194304 bytes (4.0MB) copied, 0.679521 seconds, 5.9MB/s
[1676 : 1676 INFO]
 Switching root to RAM.....
[1676 : 1676 INFO]Root FS MTD Blk is /dev/mtdblock2

[1676 : 1676 INFO]Copying /dev/mtdblock2 to /var/root.bin ...
[1676 : 1676 INFO]Set /var/root.bin to loop device...
[1676 : 1676 INFO]mount /dev/loop0 to /initrd
[1676 : 1676 INFO]Done

File system /
[1676 : 1676 INFO]Mount devname /dev/ram3 file system squashfs

[1676 : 1676 INFO]Copying /usr/local/www to /initrd...
[1676 : 1676 INFO]Done

[1676 : 1676 INFO]Unmounting /oldroot/usr/local/www/

[1676 : 1676 INFO]
 Switched root successfully.....
[1676 : 1676 INFO]VerifyImage
```
when Image file com
`Flash to Proceed`
```bash
####### BMC console
/oldroot/root # FULL Firmware Upgrade
[1676 : 1676 INFO]InitENV: u-boot environment variables
[1676 : 1676 INFO]WriteENV: u-boot environment variables
[1676 : 1676 INFO]DoFlash SUCCESS
[1676 : 1676 INFO]FlashVerifying : Skipping verifying env section(f0000)
[3555 : 3555 INFO]Entering Preserve Configuration ... !!!

[3555 : 3555 INFO]Preserving BIOS files --

[1676 : 1676 INFO]FLSH_CMD_VERIFY_FLASH DoPostFlashActions
[1676 : 1676 INFO]PostFlash Invoked RebootState: 1 flashedimage: 0
[1676 : 1676 CRITICAL][main.c:1116]Online Flash Reinitialize  failed

Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
No iptables conf found
Restarting system...
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
Flash All Complete!!
[  305.643218] reboot: Restarting system

```

# result #
| baracuda LED Event              | Power on LED | UID LED      | Inform action LED | Notice                                               |
|:--------------------------------|:------------:|:------------:|:-----------------:|:----------------------------------------------------:|
| BMC WEBUI upload interrupt      | Bliking@2Hz  | Blinking@2Hz |                   | 25min still blocked                                  |
| bmc WEBUI upload 100% interrupt | Light        |              |                   | when upload Image 100% shutdown - can reupload image |
| bmc webui process interrupt     | Light        |              |                   | it well done it(just success)                        |

> bmc not broken
