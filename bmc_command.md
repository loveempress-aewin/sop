-------------------------------------------------------------------------------
created	:	Fri Aug  2 16:05:24 CST 2024
date	:	.
expand : UR BMC network CSM  ##TODO

-------------------------------------------------------------------------------

#  introduce #
因為原本指令都在 excel 中
但是我覺得 excel 不好用 不好維護
我需要把東西簡單化 就覺得 git 的形式最好
> 沒有最好的工具 只有最美麗的自己用法

-------------------------------------------------------------------------------

## command list ##
OS| command                                              | tag                | ref                        |
|:----------------------------------------------------:|:------------------:|:--------------------------:|
| ipmitool user list 1                                 | change password    | [change](#change_password) |
| ipmitool user set name 2 admin                       | change password    | [change](#change_password) |
| ipmitool user set password 2 admin                   | change password    | [change](#change_password) |
|                                                      |                    |                            |
| ipmitool power status                                |                    | .                          |
| ipmitool power off                                   |                    | .                          |
| ipmitool power on                                    |                    | .                          |
| ipmitool power cycle                                 |                    | .                          |
|                                                      |                    |                            |
| ipmitool raw 0x1c 0x0f 0x01 0x02 0x16 0x06 0x04      | manufacturing mode | [ref](#manufacturing_mode) |
|                                                      |                    |                            |
| ipmitool sensor thresh "CPU0 Temp." upper 40 50 60   |                    |                            |
|                                                      |                    |                            |
| ipmitool raw 0x06 0x24 0xAA 0xZZ 0x01 0xQQ 0xDD 0xEE | watchdog           |                            |
|                                                      |                    |                            |
| ipmitool raw 0x0c 0x01 0x01 0xc2                     | mac address        |                            |
| ipmitool raw 0x0c 0x01 0x01 0x05 (0x__)*6            | mac address        |                            |

-------------------------------------------------------------------------------
## change_password ##
Fri Aug  2 16:07:44 CST 2024
from : Black Brian song (宋恩碩大神 -- EE涂的brian  蟲王)

這裡是要說明改密碼的部分
當然我有寫自動化測試 用`playwright`來寫

但是 如果此時你覺得 不想要看到網路 就用 `ipmitool`的方式 來改吧!!!
```bash
####[15:47] Brian.ES.Song宋恩碩
#!/bin/bash
ipmitool user list 1
ipmitool user set name 2 admin
ipmitool user set password 2 admin
ipmitool user enable 2
ipmitool user priv 2 4 1
ipmitool channel setaccess 1 2 callin=on ipmi=on link=on privilege=4
################ this is all by brian
```
> ipmitool user set name 2 admin
> **2** 因為 1不能使用 (我們預設是 admin)
> (這個觀點有點像是 computer hacker common)
>> 可能會遇到沒有user 的局面 ( 起碼筆者 還沒遇到)

#  manufacturing_mode #
+ 如果 沒有開啟 manufacturing_mode
  + 訊號會被BMC 可能拉掉
- 如果開啟 manufacturing_mode 就是給使用者看狀態
  + 此時的設備不會被BMC其他設備拉掉

~~+ 意思是可以給BMC其他設備也有控制權
    + 換句話說 就是如果你是單純追中device狀態 就開啟 (但是可能很多device 控制這樣)~~
這邊筆者用到的指令 有兩個
先來說 一個是 5121 (no red fish) 也是在
`\\192.168.101.240\sd00軟體研發處\SD20SW二部\04_Project\IPMI\01_Aewin IPMI command list\Aewin IPMI command list_v3.8_2024_0617.xlsx`
裡面的

##  change_sensor ##
################ TODO

## watchdog ##
################ TODO

## macaddress ##
[mac address](./bbu_mac_address.md)
mac address
+ step 1:
`ipmitool raw 0x0c 0x01 0x01 0xc2` (open the BMC mac address triger)
+ step 2:
```
ipmitool raw 0x0c 0x01 0x01 0x05 0xaa 0xbb 0xcc 0xdd 0xee 0xff
ipmitool raw 0x0c 0x01 0x01 0x05 0x00 0x01 0x00 0x01 0x00 0x01

┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│  ipmitool   raw   0x0c   0x01   0x01   0x05   0xaa               0xbb   0xcc   0xdd   0xee   0xff│
└────────────────────────────────────────────┼──────────────────┼──────────────────────────────────┘
                                             │ 只有這裡要       │
                                             │ 需要特定偶數     │
                                             │ 0x00 0x02 0x04.. │
                                             └──────────────────┘

```
