---
created	:	Thu Apr 25 14:59:56 CST 2024

date	:	Tue Oct  8 16:30:57 CST 2024
[[bbu]] [[bmc]] [[ipmitool]]

---
# mac_address.md

這裡是說明 mac address 的part

首先 要改的時候 需要先開啟 mac address 的確認選項

> 但是開啟後 他不會顯示甚麼東西 = = 甚至沒辦法看是不是開啟甚麼...

`ipmitool raw 0x0c 0x01 0x01 0xc2`
`ipmitool -I lanplus -H192.168.199.42 -Uadmin -P11111111 raw 0x0c 0x01 0x01 0xc2`
> IP location -> 是要用 BMC的!!! (如果可以我在說明 BMC AND OS 是不同IP的概念 )
>> 現在只要知道是不同的就好

> `-H192.168.199.42` same `-H 192.168.199.42` 這是看 6102 allen Cheng 做的!!!它讓我知道 可以不用space!!

然後 開啟後 才是重點PART

##  use mac address ##
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

-------------------------------------------------------------------------------

#### error ####
+ error 1
```
ipmitool -I lanplus -H192.168.199.52 -Uadmin -P11111111 raw 0x0c 0x01 0x01 0x05 0x00 0xff 0x00 0xff 0x00 0xff
Unable to send RAW command (channel=0x0 netfn=0xc lun=0x0 cmd=0x1 rsp=0x82): Unknown (0x82)

---
# 這裡是我故意做的
# 如果沒有開啟mac address can write -->
```
> 這裡如果你成功寫好後 那你就需要再開啟一次 (如果沒有開啟 就會跑上面的錯誤)

+ error 2
```
ipmitool -I lanplus -H192.168.199.14 -Uadmin -P11111111 raw 0x0c 0x01 0x01 0x05 0x01 0x10 0x01 0x10 0x01 0x10
Unable to send RAW command (channel=0x0 netfn=0xc lun=0x0 cmd=0x1 rsp=0xcc): Invalid data field in request
```
這我測試超久...後來我也問 brian 才知道 (他前面不能用0xff )
> 但是 實際上只能 0x00
`ipmitool -I lanplus -H192.168.199.4 -Uadmin -P11111111 raw 0x0c 0x01 0x01 0x05 0x00`
**這裡要說的是 --> 只能0x00 開頭 其他5bytes都是 Invalid data field in request**
`0x__ 0x__ 0x__ 0x__ 0x__`

`ipmitool -I lanplus -H192.168.199.4 -Uadmin -P11111111 raw 0x0c 0x01 0x01 0x05 0x00 0x__ 0x__ 0x__ 0x__ 0x__ `


 0x02 0x04 0x06 0x08 0x0a 0xfe

`ipmitool  raw 0x0c 0x01 0x01 0x05 0x00 0x02 0x__ 0x__ 0x__ 0x__ `
`ipmitool -I lanplus -H<ip> -Uadmin -P11111111 raw 0x0c 0x01 0x01 0x05 0x00 0x04 0x__ 0x__ 0x__ 0x__ `

`ipmitool -I lanplus -H192.168.199.4 -Uadmin -P11111111 raw 0x0c 0x01 0x01 0x05 0x00 0x08 0x__ 0x__ 0x__ 0x__ `
`ipmitool -I lanplus -H192.168.199.4 -Uadmin -P11111111 raw 0x0c 0x01 0x01 0x05 0x00 0xfe 0x__ 0x__ 0x__ 0x__ `

 0x01 0x03 0x05 0x07 0xff
(這些是 不能使用的 -- `ipmitool raw 0x0c 0x01 0x01 0x05 0x00 0x02` `0x_01 0x__ 0x__ 0x__ 0x__ `    )
一開始我以為只有 0x00
but!!!
是  %2==0 才對
(天啊!! 真的是I2C 只喜歡 偶數 ....)

-------------------------------------------------------------------------------
筆者這裡用 ssh OS下 ipmitool
優點不會變動 但是筆者只有事過一次 所以也不清楚
```bash			================stqrt================
root 13:46:32 ~ -->ipmitool lan print 1
Set in Progress         : Set Complete
Auth Type Support       :
Auth Type Enable        : Callback :
                        : User     :
                        : Operator :
                        : Admin    :
                        : OEM      :
IP Address Source       : DHCP Address
IP Address              : 192.168.199.15
Subnet Mask             : 255.255.255.0
MAC Address             : 00:0d:48:56:a1:83
SNMP Community String   : AMI
IP Header               : TTL=0x40 Flags=0x40 Precedence=0x00 TOS=0x10
BMC ARP Control         : ARP Responses Enabled, Gratuitous ARP Disabled
Gratituous ARP Intrvl   : 1.0 seconds
Default Gateway IP      : 192.168.199.1
Default Gateway MAC     : c4:6e:1f:b4:8e:d0
Backup Gateway IP       : 0.0.0.0
Backup Gateway MAC      : 00:00:00:00:00:00
802.1q VLAN ID          : Disabled
802.1q VLAN Priority    : 0
RMCP+ Cipher Suites     : 3,17
Cipher Suite Priv Max   : XXXaXXXXXXXaXXX
```

```bash			================start================
root 13:54:06 ~ -->  ipmitool raw 0x0c 0x01 0x01 0xc2

root 13:54:32 ~ -->  ipmitool raw 0x0c 0x01 0x01 0x05 0x00 0x0d 0x48 0x56 0xa1 0x83

root 13:54:39 ~ -->  ipmitool lan print 1
Set in Progress         : Set Complete
Auth Type Support       :
Auth Type Enable        : Callback :
                        : User     :
                        : Operator :
                        : Admin    :
                        : OEM      :
IP Address Source       : DHCP Address
IP Address              : 192.168.199.15
Subnet Mask             : 255.255.255.0
MAC Address             : 00:0d:48:56:a1:83
SNMP Community String   : AMI
IP Header               : TTL=0x40 Flags=0x40 Precedence=0x00 TOS=0x10
BMC ARP Control         : ARP Responses Enabled, Gratuitous ARP Disabled
Gratituous ARP Intrvl   : 1.0 seconds
Default Gateway IP      : 192.168.199.1
Default Gateway MAC     : c4:6e:1f:b4:8e:d0
Backup Gateway IP       : 0.0.0.0
Backup Gateway MAC      : 00:00:00:00:00:00
802.1q VLAN ID          : Disabled
802.1q VLAN Priority    : 0
RMCP+ Cipher Suites     : 3,17
Cipher Suite Priv Max   : XXXaXXXXXXXaXXX
                        :     X=Cipher Suite Unused
                        :     c=CALLBACK
                        :     u=USER
                        :     o=OPERATOR
                        :     a=ADMIN
                        :     O=OEM
Bad Password Threshold  : 0
Invalid password disable: no
Attempt Count Reset Int.: 0
User Lockout Interval   : 0
```

