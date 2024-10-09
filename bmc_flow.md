-------------------------------------------------------------------------------
created	:	Mon Oct  7 09:37:14 CST 2024

date	:	.

[[bmc]] [[manual]] [[git]] [[submodule]]

-------------------------------------------------------------------------------
筆者的配置為
```bash			================start================
git version 2.17.1 (不好用==) (筆者習慣 git version 2.34.1)

 OS: Ubuntu 18.04.6 LTS x86_64
 Host: VirtualBox 1.2
 Kernel: 5.4.0-150-generic
 Packages: 1824
 Shell: bash 4.4.20
 Terminal: /dev/pts/1
 CPU: Intel i7-10510U (4) @ 2.304GHz
 GPU: VMware SVGA II Adapter
 Memory: 914MiB / 3931MiB
```
#  bmc_download_source_code #
筆者 用 筆者第一個 專案 CB-1946 開始
`git clone --recurse-submodules http://git_user:$ae_git_token@sd20-server.aewin.com/core/lts/spx-13/EVB/ast2600evb.git --branch CB-1946`
![gitlab-location](./pic/bmc_flow_clone.png)
這裡的位置 通常新的案子都會在
`2500evb` OR `2600evb`

# build_code  #
have two way
+ `git spx buildsrc <exsited.PRJ> <package folder> <anyname>`
+ `git spx covert <exsited package> <anyname>`

以上兩種是會產生不同的檔案 **但是筆者偏向用地一種**

第2種是給MDS tool 開啟的 而且不怕東西被搞砸
**適合新手相**
此文章會 專注在 **buildsrc**
MDS的文章 會另外寫
> buildsrc 是藉著docker 來build
> 所以如果要停止 要看 docker ps 的方式來 stop

當你拿到一個案子(過去寫過的)
當你抓好後 (請確認 git branch )(AND submodule branch 都正確)

`git checkout CB-1946` --> check branch

`git submodule foreach CB-1946` --> submodule branch

~~這裡筆者還在研究 git submodule~~

就開始build code --> (筆者這個案子 從 27 mins ~ 50 mins )
```bash			================start================
#                                        ┌───────────────────────────┐
#                                        │ (原本的 package folder)   │
#                                        └───────────────────────────┘
git  spx  buildsrc   <exsited.PRJ>         <package  folder>           <anyname>
#                  ┌─────────────────────┐
#                  │ (原本有PRJ的檔案)   │
#                  └─────────────────────┘
git spx buildsrc ./config/CB-1946.PRJ     ./package/                   ./workspace/
```
> 至於為什麼我的anyname 用 這個 因為 他在gitignore 裡面有
>> `workspace*`

成功就表示 你可以開始魔改他了!!!
~~甚麼比大帝的想法???~~

編譯成功後 一定會出現
一個matrix

此時我們來看 `status`
![git stats](./pic/bmc_flow_compiler.png)


確認好後會長這樣 我會依照我的工作流程
通常我是用 一個banch 所以變這樣
```bash			================start================
root@bmc-VirtualBox:/mnt/AEWIN/codebase/ast2600evb/new/ast2600evb#  git submodule foreach git branch
Entering 'packages/ast2600'
  CB-1946
* Dev
  IS-B135
Entering 'packages/bootloader'
  CB-1946
* Dev
  IS-B135
Entering 'packages/common'
  CB-1946
* Dev
  IS-B135
Entering 'packages/kernel'
  CB-1946
* Dev
  IS-B135
Entering 'packages/target'
  CB-1946
* Dev
  LTS-v13
Entering 'packages/utilities/packages/vmcli'
  CB-1946
* Dev
  LTS-v13
```

這裡的方式 是 當確認 都可以後 才會 進版!!

-------------------------------------------------------------------------------

###  if_submodule_error ###
如果你遇到 你都切換好後
`git status`
出現 有些檔案 有問題
那就用 `git submodule update`

原因 : 可能 前一個人在update時
只update 他改過的 submodue (理論 我們會有 5 各 submodue )
```bash			================start================
packages/ast2600
packages/bootloader
packages/common
packages/kernel
packages/target
packages/utilities/packages/vmcli
```
![submodue](./pic/bmc_flow_submodule.png)
[detail submodule error](./git_checkout_submodule_error.md)
