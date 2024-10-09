-------------------------------------------------------------------------------
created	:	Wed Aug  7 11:33:20 CST 2024

date	:	.
[[bbu]] [[fan]]

-------------------------------------------------------------------------------

#  smart fan  #


這裡用john 的話來說明 `\\192.168.101.240\sd00軟體研發處\SD20SW二部\05_技術文件與工具\02_IPMI\IPMI規範\BBU\CB-XXXX_v1.0.8 IPMI BBU.xlsx`
> Test BMC PWM. All fans can change speed at different temperature.

這裡的smart fan  BBU
是要測 溫度與fan轉速的關係

前人的做法都是在 BMC console 下
`devmem`
EX: `devmem 0x1e78600c`
[how to use devmen](./devmem.md)


1. [升高CPU溫度](./devmem.md#increase-the-temperature)
   + iperfool 大量打封包 + 物理擋風
   + stress (wick的方式)
2. detech fan speed
   + `devmem`
   + `ipmitool sdr`

上述的說法[詳細](./devmem.md)
