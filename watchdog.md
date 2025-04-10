---
created	:	Wed Apr 24 11:42:47 CST 2024

date	:	Fri Aug  9 10:34:30 CST 2024

---
# metadata
[ref](https://hackmd.io/UMjW7yJqTm-_Yba-f6JhXQ)
[[bbu]] [[watchdog]] [[bmc]]

---
# watchdog

一開始我測試這個BBU的時候 滿滿的疑惑
一直覺得 這個超級沒用...

後來跟brian說

他這個是 如果OS 爆炸 他可以重新啟動

我:那也可以用BASH 壓

如果OS爆炸就不能壓 (!!對耶...)

所以 為什麼有 watchdog 我的理解是

他就是給你可以寫完後

再用bash 一直下 `ipmitool mc watchdog reset`

> 每次看到  reset 都覺得可怕呢

這樣如果 OS 爆炸 那 就可以讓BMC 重啟 (一種 相愛相殺的概念-- )

好了 講完了 換開始 watchdog的部分了

基礎的先開始 ~~

`ipmitool mc watchdog get`
get WDT infomation

`ipmitool mc watchdog reset`
refresh WDT function

`ipmitool mc watchdog off`
close the watchdog


在下command 之前 可以去看 他們做的
`\\192.168.101.240\sd00軟體研發處\SD20SW二部\04_Project\IPMI\01_Aewin IPMI command list`

+ 0xAA : Time use
  + 0x01: BIOS FRB2
  + 0x02: BIOS/POST
  + 0x03: OS Load
  + 0x04: SMS/OS
  + 0x05: OEM
+ 0xZZ : Timeout action
  + 0x00: no action
  + 0x01: System hard reset
  + 0x02: system power off
  + 0x03: system power cycle
+ 0xQQ : Time Use Expiration flag clear
  + 0x02: BIOS FRB2
  + 0x04: BIOS/POST
  + 0x08: OS Load
  + 0x10: SMS/OS
  + 0x20: OEM
+ 0xDD 0xEE : 2 bytes count value
  + 0xDD(low)
  + 0xEE(high)

0xDD 0xEE
---
all use hex
假設 60 seconds -> 60x10=600
600->0x258
0x58 0x02

0xAA and 0xQQ
---
這個是說 兩個通常要一樣
我做過TEST
不同的也會表現
同樣的 .....
但是我還沒有時間 所以 現這樣吧!!!!
		:		.
        :       .

`ipmitool raw 0x06 0x24 0x04 0x01 0x01 0x10 0x58 0x02`
這是malo 用的 OS   Hard-reset 60sec

`ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 raw 0x06 0x24 0x04 0x03 0x01 0x10 0x64 0x00;`
this is my auto script 10seconds

`ipmitool raw 0x06 0x24 0x04 0x01 0x01 0x10 0xc8 0x00`
expand --> 20 secs

`ipmitool raw 0x06 0x24 0x03 0x03 0x01 0x10 0xc8 0x00`

```bash			================start================
#                          ┌──────────────────────┐        ┌────────────────────────────────┐
#                          │Time use: set role    │        │Time Use Expiration flag clear  │
#                          │0x01:BIOS FRB2        │        │0x02: BIOS FRB2                 │
#                          │0x02:BIOS/POST        │        │0x04: BIOS/POST                 │
#                          │0x03:OS Load          │        │0x08: OS Load                   │
#                          │0x04:SMS/OS           │        │0x10: SMS/OS                    │
#                          │0x05:OEM              │        │0x20: OEM                       │
#                          ├──────────────────────┘        ├────────────────────────────────┘
#                          │                               │
#  ipmitool raw 0x06 0x24  0xAA                  0xZZ 0x01 0xQQ 0xDD 0xEE
#                                                │
#                                                ├──────────────────────────┐
#                                                │Timeout action:           │
#                                                │0x00:no action            │
#                                                │0x01 : system hard reset  │ (warm boot)
#                                                │0x02 : system power off   │
#                                                │0x03 : system power cycle │
#                                                └──────────────────────────┘
#
# ├── power_S5.md
# ├─ipmitool raw 0x06 0x24 0xAA 0xZZ 0x01 0xQQ 0xDD 0xEE
```


```bash			================start================
ipmitool raw 0x06 0x24 0x03 0x03 0x01 0x10 0x64 0x00
    ### 10s
ipmitool raw 0x06 0x24 0x03 0x03 0x01 0x10 0x1e 0x00
    ### 3s
```

# table #

筆者這裡要說明新增 一個事件~

這也是後來才發現的

雖然筆者寫過`AA` and `QQ` 不同分為 還是可以正確執行

但是可能還是筆者這裡還是沒有 用不同的來TEST

畢竟這就是BBU TEST 的宿命

所以這裡筆者要 寫一個對照組別

####TODO : need to put AA and QQ terms!

| AA   | QQ   | name       |
|:----:|:----:|:----------:|
| 0x01 | 0x02 | BIOS FRRB2 |
| 0x02 | 0x04 | BIOS/POST  |
| 0x03 | 0x08 | OS Load    |
| 0x04 | 0x10 | SMS/OS     |
| 0x05 | 0x20 | OEM        |
