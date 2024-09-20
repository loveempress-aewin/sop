-------------------------------------------------------------------------------
created	:	Thu Sep 19 14:42:25 CST 2024
date	:	.

-------------------------------------------------------------------------------
# sd20  #
[ref](https://blog.csdn.net/Unknownfuture/article/details/104642043)

我用firefox  look DEV-tool
有確認過 他的確有問題

+ 我的電腦
![essence](./pic/sd20_essence_physical_computer.png)

長這樣!!

+ Virtual box
![ns_unknown_host](./pic/sd20_NS_ERROR_UNKNOWN_HOST.png)
很神奇對八 ?  在虛擬機器竟然有問題
但是我有確認IP 所以 我就只能想 是VM的問題

我看了一下 [this](https://thewindowsclub.blog/zh/fix-ns_error_unknown_host-error-when-cant-open-website-on-firefox/)

我一開始嘗試後 我重新啟動

```bash				================start================
root@bmc-VirtualBox:/mnt/AEWIN/codebase/ast2600evb# git clone --recurse-submodules http://git_user:$ae_git_token@sd20-server.aewin.com/core/lts/spx-13/crb/intel/archercity.git --branch IS-5121_Redfish                                                                                                                                                                                Cloning into 'archercity'...
remote: Enumerating objects: 2268, done.
remote: Counting objects: 100% (2268/2268), done.
remote: Compressing objects: 100% (1536/1536), done.
remote: Total 12168 (delta 739), reused 2141 (delta 618), pack-reused 9900                                                                                                                  Receiving objects: 100% (12168/12168), 243.46 MiB | 21.08 MiB/s, done.                                                                                                                      Resolving deltas: 100% (7147/7147), done.
Submodule 'packages/ast2600' (http://git_user:yDTvwx8kvymWQXVEH6mw@sd20-server.aewin.com/core/lts/spx-13/core/ast2600) registered for path 'packages/ast2600'
Submodule 'packages/bootloader' (http://git_user:yDTvwx8kvymWQXVEH6mw@sd20-server.aewin.com/core/lts/spx-13/core/bootloader) registered for path 'packages/bootloader'
Submodule 'packages/common' (http://git_user:yDTvwx8kvymWQXVEH6mw@sd20-server.aewin.com/core/lts/spx-13/core/common) registered for path 'packages/common'
Submodule 'packages/kernel' (http://git_user:yDTvwx8kvymWQXVEH6mw@sd20-server.aewin.com/core/lts/spx-13/core/kernel) registered for path 'packages/kernel'
Submodule 'packages/redfish-ast2600' (http://git_user:yDTvwx8kvymWQXVEH6mw@sd20-server.aewin.com/core/lts/spx-13/ext-packs/technologypack/redfish/redfish-ast2600.git) registered for path 'packages/redfish-ast2600'
Submodule 'packages/target' (http://git_user:yDTvwx8kvymWQXVEH6mw@sd20-server.aewin.com/core/lts/spx-13/core/target) registered for path 'packages/target'
Submodule 'packages/utilities/packages/vmcli' (http://git_user:yDTvwx8kvymWQXVEH6mw@sd20-server.aewin.com/core/lts/spx-13/utilities/vmcli) registered for path 'packages/utilities/packages/vmcli'                                                                                                                                                                                      Cloning into '/mnt/AEWIN/codebase/ast2600evb/archercity/packages/ast2600'...
fatal: unable to access 'http://git_user:yDTvwx8kvymWQXVEH6mw@sd20-server.aewin.com/core/lts/spx-13/core/ast2600/': Could not resolve host: sd20-server.aewin.com
fatal: clone of 'http://git_user:yDTvwx8kvymWQXVEH6mw@sd20-server.aewin.com/core/lts/spx-13/core/ast2600' into submodule path '/mnt/AEWIN/codebase/ast2600evb/archercity/packages/ast2600' failed
Failed to clone 'packages/ast2600'. Retry scheduled
```
我直擷取部分

**這裡的意思 我解釋一下**
**他前面有解析成功 後面直接失意**
**所以很特別的結果又出現在我這裡**
~~難到生為一個最美的程式女王就是這麼辛苦嗎?~~

這部分最神奇的PART是
他前面可以抓 後面有問題
> 前提是 我確定了 他們的IP address
>> 是同網域

後來我看到有人的解法
我真的很喜歡 那開始吧!!!

首先我是在 windows 下 `router`
+ windows  	`tracert`
+ linux		`traceroute`

得到基本info
然後我就開始 滲透了喔
在虛擬祭器下
`ping 192.168.120.241`
可以ping到!!!
那就開始修改

## add dns server  ##
`gedit /etc/resolv.conf`
```conf			================start================
#### filename : /etc/resolv.conf
# master dns
nameserver 8.8.8.8
nameserver 114.114.114.114
```
筆者我這裡只有用到這裡 然後重新啟動網路
