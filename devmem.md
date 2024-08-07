-------------------------------------------------------------------------------
created	:	Wed Aug  7 14:51:01 CST 2024
date	:	.

-------------------------------------------------------------------------------

# devmem #

## how to use DOC to find some special term ##

### find ASPEED version ###

+ ❗❗only use **BMC console**

這裡真的太難 我只在太容易忘記

這裡依照 EE涂的brian ~~他真的好強~~

首先這裡要先看你使用哪一塊板子

筆者這裡用的是 6101 (F3600) (另外一個是 ff2)

~~這就是另外一個故事了~~

因為我在monther board 看不到ATS的version

所以我就先去看他們的SPC 看 可以看到他一些資訊

`//192.168.101.240/sd00%E8%BB%9F%E9%AB%94%E7%A0%94%E7%99%BC%E8%99%95/SD20SW%E4%BA%8C%E9%83%A8/04_Project/IPMI/BAS-6101/02_Schematic/02_A1/DSN_AS6101A1-3_231030.pdf`
```
┌──────┐   ┌──────────┐
│ AMD  │   │ ASPEED   │
│ EPYC │───│ AST2600  │
└──────┘   └──────────┘
 │    │
 │    │   ┌──────┐
 │    └───│ BIOS │
 │        └──────┘
 │
┌────────┐
│ USB3   │
│ PIN    │
│ HEADER │
└────────┘
### 有點多 我就大概畫...
#### 可以得到 我們要的ASPEED AST2600
```
then

### find the register ###

####  introduce register ####
這裡要說明 這裡控制轉速的一些數值
OR anything 可能會放在這些register中

所以如果你要用 smart fan
可以很精準的看風扇的數值

如同前面說明的 我們是要看 溫度 -> 風扇
所以去燒CPU 然後 fan 就會相對升高

所以 前人都用這個方式
(我以前也是bmc console 派的 但是現在我都用 `ipmitool sdr` 的方式)

+ 因為方便
  + 有時來的是完整系統 很難用 bmc consolo port

####  increase the temperature  ####
+ 需要把溫度燒很高
  + [iperfool](./iperfool.md)
  (我還是不會用 他是用流量的方式 大量打封包)
  --> CPU temperature UP
  + stress

所以筆者這裡用的是
`stress --cpu 8 --timeout 20`
`stress --cpu 76 --timeout 30`
30 second
cpu --> thread!!
I use beatop look it
[stress](https://www.tecmint.com/linux-cpu-load-stress-test-with-stress-ng-tool/)

#### find PWM ####
file : `file://192.168.101.240/sd00%E8%BB%9F%E9%AB%94%E7%A0%94%E7%99%BC%E8%99%95/SD20SW%E4%BA%8C%E9%83%A8/05_%E6%8A%80%E8%A1%93%E6%96%87%E4%BB%B6%E8%88%87%E5%B7%A5%E5%85%B7/02_IPMI/ASPEED/AST2600%20Datasheet/AST2600_Datasheet_v13.pdf`
這是 AST2600 的PDF
1. search `PWM`
```
PWM & Fan Tacho Controller (PWM/TACHO)

47.1 Overview
Base Address of PWM & Fan Tach Controller = 0x1E61 0000
Physical address of register = (Base address of PWM & Fan Tach Controller) + Offset

47.1 Overview
Base Address of PWM & Fan Tach Controller = 0x1E61 0000
Physical address of register = (Base address of PWM & Fan Tach Controller) + Offset
PTCR000: PWM0 General Register
PTCR004: PWM0 Duty Cycle Register
PTCR008: TACH0 General Register
PTCR00C: TACH0 Status Register
PTCR010: PWM1 General Register
PTCR014: PWM1 Duty Cycle Register
PTCR018: TACH1 General Register
PTCR01C: TACH1 Status Register
PTCR020: PWM2 General Register
PTCR024: PWM2 Duty Cycle Register
PTCR028: TACH2 General Register
PTCR02C: TACH2 Status Register
```

可以看到 我們的東西
這裡的看法
先看到

1. 0x1E61
> 0x 是這裡工程師必備技能  ~~就像brian and albert 的愛情~~

2. 0000 可以看成 陣列
EX : PTCR000: PWM0 General Register => 0x1E610000 (後面擺3位)

3. fan --> `duty`
通常他們就是一起的 記得就好
