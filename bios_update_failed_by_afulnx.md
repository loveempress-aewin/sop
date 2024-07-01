-------------------------------------------------------------------------------
created	:	Fri Jun 28 14:17:47 CST 2024
date	:	Mon Jul  1 15:37:51 CST 2024

-------------------------------------------------------------------------------
#  afulnx_update #
這裡是要說明 我用 工具 `afulnx`

在做 update 的時候

如果都成功 我們來看 bmc console

```bash
~ # CMD BIOS update: on progress
update_timeout_sec = 600
CMD BIOS update: success
```
很顯然 最後一段 當然是 bios update success!

如果失敗 的話 那就要等 10 分鐘 就會開始 閃爍 red light

然後 bmc console 會 顯示甚麼呢??



intentional human error
=======================
首先 我們先看 OS 的部分
```bash
root@updatetool:/home/update/bbu/5222#   /root/afulnx_64 5222R10C.bin /P /R /N /X /R /K
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
Updateing Main Block ................ 0x001F9000 (9%)

```

當然我們要 插斷 就需要用 另外一個 session 來完成

> 當然如果 你要丟入 BK中 也可喔~~ []~(￣▽￣)~*

```bash
root@updatetool:~#  ps  -a
s    PID TTY          TIME CMD
   1163 tty1     00:00:00 bash
   1691 pts/0    00:00:52 afulnx_64
   2148 pts/1    00:00:00 ps
root@updatetool:~#   kill  1691
```

很即時的你會看到 當我下kill
他就直接變成
```bash
root@updatetool:/home/update/bbu/5222#   /root/afulnx_64 5222R10C.bin /P /R /N /X /R /K
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
Killeding Main Block ................ 0x001F9000 (9%)

real    1m25.585s
user    0m5.088s
sys     1m8.161s
```

我最後才要放 BMC CONSOLE (因為資訊很少)
如果失敗的話
```bash
~ # CMD BIOS update: on progress
update_timeout_sec = 600
BIOS update timeout
BIOS update timeout
```
不過也是從**BMC console** 我才知道原來他有 設定time
![](./pic/bios_update_failed_by_afulnx_result.png)

