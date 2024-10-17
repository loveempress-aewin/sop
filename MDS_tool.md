-------------------------------------------------------------------------------
created	:	Mon Oct  7 15:02:52 CST 2024

date	:	Wed Oct  9 16:03:57 CST 2024

[[vm]] [[mds]] [[spx-paceage-line]] [[pyenv]]

-------------------------------------------------------------------------------

#  MDS_tool #
筆者的架構分為2種
1. buildsrc -> 用 spx_link
2. convert	->	用 完全分離的 (用這個方式 到時候 還要去你建立的 Devlopment 裡面做 git init)

先說 筆者這裡用的是 `spx-package-links`的方式
~~如果未來會慢慢補齊另外一種方式~~


開啟後 我們通常可以build code 一次
(但是筆者 在這裡 第一次build 的時候 花了 4小時= =)
後來 實在 無法 所以就重新裝一次 VM==

OSOS用MDS\_TOOL 我的共識 就是 我要改sensor
![only open mds](./pic/MDS_TOOL_open.png)
就會知道 他又給我多很多 奇怪的東西

> malo 會把東西直接退回去
>> 裡面改的東西有些 是版本號
>> 有些是多了 一個 很白癡的folder

我們的過程是

##  open-MDS ##

> 如果不能開 請確認要最高權縣
再開之前 筆者現階段的放置在
`/mnt/AEWIN/MDS_TOOLS` 這個可以想像成 USB的概念
這裡因為是virtual box的 vhd
```bash			================start================
.
├── 13.0	##  13.0 MDS install
├── 13.5	##  13.5 MDS install
├── 1946
│   ├── Development
│   └── Workspace
├── 5121_redfish
├── lost+found
└── tem_2_1946
    ├── Development
    └── Workspace
#### focus 1946 !!
#### 這個就是 專案的配置 這就是等等下面開啟MDS_TOOL interface
Workspace -> MDS(Workspace)
```

### put-spx-package-links ###
這裡的章節 會把
1. `config/*.PRJ`
2. `spx-package-links/` ||`spx_packages`
3. `Devlopment` -> 上一個章節的

一起說 畢竟 他們就是可能你 1可以 2不行 ....

> PRJ 就是很像 h 檔 有一些選想可以選

> 2. 本篇筆者會寫 spx-package-links  至於 spx_packages
> 我如果以後有時間會在另外寫一篇

> note : 筆者這裡用 1946 的時候 有開啟 `pyenv active .venv`
>> 以上是 pyenv 的 在MACOS python 很重要


