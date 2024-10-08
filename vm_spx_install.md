-------------------------------------------------------------------------------
created	:	Thu Sep 26 10:24:33 CST 2024
date	:	.
[[vm]] [[spx]]

-------------------------------------------------------------------------------

#  spx   #
這裡是安裝SPX (比討厭的 MDSTOOL 哈好多了==)
這個就是跟 MDS tool 一樣 可以編譯code的

對於現在 有兩個 spx version
+ v1.0
  - new (現在可以用ami來抓他們(Thu Sep 26 10:38:54 CST 2024))
  - ast2600evb
+ v1.0-beta8
  - old (現在抓不到)
  `\\192.168.101.240\sd00軟體研發處\SD20SW二部\03_Personal\ChiangChiang\VM\SPX`
  - ast2500evb
> 筆者這裡的作法 也是用 外掛的方式來安裝
>> 像是 USB (在linux 就可以當檔案 這是系統哲學)

> 意思是可以在os 切換 兩總SPX version
~~malo brian 是 一個系統 一個SPX => 他有兩個系統~~
如果要確認  `spx version` 就下這個

#  spx install #
```bash			================start================
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
```

```bash			================start================
apt-get -y install git-lfs gnutls-bin && apt-get update
```

```bash			================start================
#### spx v1.0
Deleted: sha256:76c3db26acb26ce1f1bd749b4a988bcf01719e8ea822b0414c33f91ba1266f43
Deleted: sha256:d537e742004350c858d31cdf134ef8d8bbe9602931e5e6f38b415b18bfa2b849
Deleted: sha256:8651d5f9ffe8a832fc565de65e75298b8b1bf4bbd6c31a2c4308fb32cedeb95d
Deleted: sha256:2fa57a815c6895e82f5c07111c6f17a104392ef04e096b19315e5fc3c5b0bf6a
Deleted: sha256:f8e76f27645b012095fbd7783ee5a8d8aa3cf4eb38507636fe3c0209bf7328ba
Deleted: sha256:c8d8d05c718b92778b5d5852d71023fa144f3cd806f1761a67fc121471ab00e6
Deleted: sha256:8bfdc6dc49b13e9820d1baeb8ba498663aa12d3fbfaac7f92c1dd1416a921bc0
Deleted: sha256:fe2a9af93450dc42b5084951305daa43b1b3ddf5b47ce90e726e977dff42dd92
Deleted: sha256:b31a046bdaa76f3abda9aad5dc5b10dfda6976c4ccb572c5fbb750b4c0c49a30
Deleted: sha256:fdd02ef8f6284be82c0469cb826581d450751634c8159e54d9a34f8c7044ce75
Deleted: sha256:a412d85185f6ce8c86c8fa8397da103da0a858630580460f4a0b809493a673a5
Deleted: sha256:cbc4467966135372e94c9b4273aa0e7b48ceede5e1c18f21b3af9b725676af59
Deleted: sha256:c1d1d9da605b9e8df0daa35dfb5ddef3ea2b452574137fbb425f43bee509568c
Deleted: sha256:60db3f0c5d2057f1ca71270cc137c60313f74ae466a7765e12b6a88ba82023fc
Deleted: sha256:d912b5e4480d3517f2ef887b11aa5cd0cc29c5671423ade238d8540c139cb98e
Deleted: sha256:ea69392465ad72ace1216ca2f49a372c7d6f10ec031ab53a94a17699c9ab4185
 ✔ GitSPX plugin installed successfully

all     34m3.123s
1       0m1.463s
2       0m7.718s
root@bmc-VirtualBox:/mnt/AEWIN/SPX/v1.0#
```
這樣就是


```bash			================start================
#### change spx version v1.0 -> v1.0-beta8
2c020d9a47d4: Loading layer [==================================================>]  23.55kB/23.55kB
d6168237e18c: Loading layer [==================================================>]  36.35kB/36.35kB
6996f38fb646: Loading layer [==================================================>]  13.82kB/13.82kB
d97a317aafad: Loading layer [==================================================>]  11.26kB/11.26kB
0e91f2ab3d32: Loading layer [==================================================>]  28.67kB/28.67kB
b3446a59614d: Loading layer [==================================================>]   5.12kB/5.12kB
652eae93e7a1: Loading layer [==================================================>]  4.096kB/4.096kB
058c59e84a5f: Loading layer [==================================================>]  4.096kB/4.096kB
518ae341614f: Loading layer [==================================================>]    150kB/150kB
2534306d1832: Loading layer [==================================================>]  6.144kB/6.144kB
2e38dba3e86a: Loading layer [==================================================>]   2.56kB/2.56kB
c88b5f364851: Loading layer [==================================================>]  3.584kB/3.584kB
3ccb5ce45023: Loading layer [==================================================>]  4.096kB/4.096kB
Loaded image: gitspxlts:latest
[ Done ]
Now you can customize docker image environment variables and setup custom alias inside it.
A file with name spx-bashrc will be created and user can customize it as they want.
This file will be sourced to take effect inside the docker image before processing any command

Do you want to set it now [Y/N] ( Default - N ):
You can use 'git spx setbashrc [path]' to setup spx-bashrc anytime


all    7m9.437s
1      0m2.468s
2      0m53.717s
```
