-----------------------------------------------------------------------------
created	:	Fri Jun 28 13:21:19 CST 2024
date	:	.

-------------------------------------------------------------------------------

#  BIOS UPDATE WITH afulnx in linux #

在BMC中 可以用  [ Yafu](./yafuflash.md "Yafu") 來更新
但是我們都沒有做到 BIOS的

今天來介紹 `afulnx`

你們的第一直覺 也一定是 著甚麼對不對!!!
沒關係 我不是 ~~????~~

其實我用這個也是因為要TEST
BIOS / BMC update failed 時 的一些表現態 ~~(這是題外話 就不展開說名)~~

其實要做failed 我們的做法 就是 當yafu or afulnx 到一半
給她剪掉 (人為介入)
所以 一樣 先來說 他怎麼更新

```bash
afulnx_x64 <update file> /P /B /N /R /K
```

所以我這邊的是

```shell
root@testtool:~# /root/afulnx_64 /root/bios/tmp/5222R10C.bin /P /B /N /X /R /K
+---------------------------------------------------------------------------+
|                 AMI Firmware Update Utility v5.16.01.0109                 |
|      Copyright (c) 1985-2023, American Megatrends International LLC.      |
|         All rights reserved. Subject to AMI licensing agreement.          |
+---------------------------------------------------------------------------+
 Reading flash ...................... Done
 - ME Data Size Checking ............ Pass
 - FFS Checksums .................... Pass
 - Check RomLayout .................. Pass
 Erasing Main Block ................. Done
 Updating Main Block ................ Done
 Verifying Main Block ............... Done
 Erasing Boot Block ................. Done
 Updating Boot Block ................ Done
 Verifying Boot Block ............... Done
 Erasing NVRAM Block ................ Done
 Updating NVRAM Block ............... Done
 Verifying NVRAM Block .............. Done
 Erasing NCB Block .................. Done
 Updating NCB Block ................. Done
 Verifying NCB Block ................ Done

 Process completed.
```
我真心覺得很美 天啊 美哭我 (❁´◡`❁)

此時 我的 bmc console
```bash
###### bmc console
~ # CMD BIOS update: on progress
update_timeout_sec = 600
CMD BIOS update: success
```
