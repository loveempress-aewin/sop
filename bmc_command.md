-------------------------------------------------------------------------------
created	:	Fri Aug  2 16:05:24 CST 2024
date	:	.

-------------------------------------------------------------------------------

#  introduce #
因為原本指令都在 excel 中
但是我覺得 excel 不好用 不好維護
我需要把東西簡單化 就覺得 git 的形式最好
> 沒有最好的工具 只有最美麗的自己用法

-------------------------------------------------------------------------------

## command list ##
| command                            | tag             | ref                         |
|:----------------------------------:|:---------------:|:---------------------------:|
| ipmitool user list 1               | change password | [change](#change_password)  |
| ipmitool user set name 2 admin     | change password | [change](#change_password)  |
| ipmitool user set password 2 admin | change password | [change](#change_password)  |
|====================================|=================|=============================|

-------------------------------------------------------------------------------
## change_password ##
Fri Aug  2 16:07:44 CST 2024
from : Black Brian song (宋恩碩大神 -- EE涂的brian  蟲王)
這裡是要說明改密碼的部分
當然我有寫自動化測試 用`playwright`來寫
但是 如果此時你覺得 不想要看到網路 就用 `ipmitool`的方式 來改吧!!!
```bash
[15:47] Brian.ES.Song宋恩碩
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
>> 可能會遇到沒有user 的局面 ( 起碼筆者 我還遇到)
