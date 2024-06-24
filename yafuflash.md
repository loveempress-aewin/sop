---
created	: Thu Mar 28 11:06:42 CST 2024
date	:	Thu Mar 28 11:07:40 CST 2024

---
# yafuflah birned BMC FW SOP

[ref](https://hackmd.io/@Malo850423/BJJ6HtAGh)

##  first look version and match
在這個之前 先確認 一下你的codebase
[codebase](https://hackmd.io/@Malo850423/ryswMUmT2?fbclid=IwAR2WuL4Ok3NhaLGBqsc8urfDPcod8r46a9rhWOxTwOgkDi1lovUJJCvcRwY_aem_AVfvCan778pw4fy5mjUnzqzO-c8LUOXFKJOmr-8CyrdEW1n83_cyzkF3n6qnVz5yDdGWNyGTfbj-GrmzwpHXQHou)

| BMC chip | Codebase | CPU type        | Project ex        |
|:--------:|:--------:|:---------------:|:-----------------:|
| 2500     | RR11_7   |                 | CB-1927,CP-1925   |
| 2500     | LTS-v12  | ast2500evb      | CB-1939           |
|          |          | ethanol-x(AMD)  | CB-1937,CB-1939   |
|          |          | wolfpass(intel) | 5221              |
| 2600     | LTS-v13  | ast2600evb      | IS-B135,5121,5222 |

<補充>
1. BMC chip -> look BMC "**IC chip** type" . usually we use AST2500 AST2600
2. CPU type "evb"==="公版"  AMD OR Intel CPU all can use
ethanol-x && wolfpass is only AMD Intel

## step
#### Step 1
NAS `\\192.168.101.240\sd00軟體研發處\SD20SW二部\04_Project\IPMI\YafuFlash update`
依據自己當前的開發環境選擇要使用哪個資料夾做使用
(EX : 6102 ) 它的晶片 是  `AST2500`  ==> LTS-v12

> 注意喔 這裡有說晶片 其實就像是 CPU 但是是FOR BMC 用的喔

> 小小補充一下 也可以用 gitlab 的方式去看

現在知道要哪個version 後 就點進去 選 `Linux_x86_64`

~~你不會想用WINDOWS 吧.... 想用的 可以這裡關閉.. \(￣︶￣*\))~~

#### Step 2
把這個資料和 你要跟新的BMC檔案 (反正就是 CB6102_......ima)
放在一個資料夾中 然後 就可以把這些放入 USB裡面
> 在來會用 BMC 外接的OS (我的OS 是linux 所以 需要搞一下東西 )

#####  OS of the external BMC is Linux
現在你到了這步驟 代表你的USB  已經有了

```
/shi /
├── Linux_x86_64
│   ├── BAS-6102_v1.0.12N_EA89.ima
│   └── Yafuflash
```

這是我 USB 內 是這樣喔

現在把目光看到 對面的 BMC 版子 (其實就是 IC版才對XD)

然後 就用 `ls /dev/sd*`

> 這是因為linux all is file

所以 先看 然後在插入USB 你會發現
他多了一個 `/dev/sdc` `/dev/sdc1`
> 我不知道WHY 拉 但是這個坑 我以後再填

然後就是用 `mount` 來掛載

這時候的動作通常是

先做 `mkdir hern_handsome` ~~當然名稱隨你~~

然後 就 `mount /dev/sdc1 hern_handsome` 然後你在進入

created folder look have file
+ if have file just all `cp` to another file XD

`cp hern_handsome love_it`

---
---

再來就是 要開啟權限

`chmod 777 -R love_it`
這裡就是 知識量了 !!!

#### Step 3 excute it
`./yafuflashV7 -kcs BAS-6102_v1.0.12N_EA89.ima`

中間會有 選項 && 可能有錯誤 但還是可能繼續執行



