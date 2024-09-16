-------------------------------------------------------------------------------
created	:	Fri Sep 13 08:54:12 CST 2024
date	:	.

-------------------------------------------------------------------------------

# metadata #
[[git]]
[[MDS]]
[ref-MDS13.1](http://sd20-server.aewin.com:3000/pncIlBpCQrGJpcJxyQ-MAQ?view#Install-MDS-Tool)
[ref-MDS13.5](http://sd20-server.aewin.com:3000/v2TZwIWbQfuphqjsxzg-pQ#GIT-SPX-plugin-installation)

-------------------------------------------------------------------------------
~~首先這是我這個程式小天才女王做了好多次才來寫的...第一次碰 我完全不知道我在幹嗎?~~
MDS TOOL 是AMI 開發出來的工具
可以讓我們在這個環境中來改BMC的code
不過他是會 clone -->

# MDS tool installation #
筆者這裡用我的寫法
因為是用virtualbox 的linux
但是一定要掛載VHD
因為空間會一直不夠
~~本宮就是 因為空間爆炸~~
~~還有這是VM的問題 如果你空間爆炸 就全部會crash~~
所以 筆者這裡是把 這些安裝檔 && 後面的工具 都放都 外接虛擬VHD
`/mnt/AEWIN/projects` (/dev/sdc)(VHD)

####TODO --> VM VHD (VM all install)


MDS-TOOL 需要下載兩個version (就像 pythong ==)
+ 13.1
+ 13.5

## MDSTOOL 13.1 install ##
首先我們放置的位置 `/mnt/AEWIN/MDS_TOOL/v13.1`
(這裡是筆者的用法)

```bash				================start================================================================
git clone https://git_user:$ami_us_git_token@git.ami.com/tools/mds/releases/13.5.git

##================result================>
##13.1/
##├── Linux
##│   ├── mds-13.1-deb-x86_64.run			<--(0x0001)
##│   ├── VERSION
##│   └── x86_64
##│       ├── Common
##│       │   ├── ipmi.tar.gz
##│       │   ├── mds-base.tar.gz
##│       │   ├── pmcpsimulator.tar.gz
##│       │   └── pmpmcp.tar.gz
##│       ├── install.sh  .....<--(0xaaaa)
##│       ├── log.txt
##│       └── SPX
##│           ├── spx-builder.tar.gz
##│           └── svnspx.tar.gz
##├── MDS_Installation_Guide.pdf
##├── README.md
##├── ReleaseNotes.pdf
##└── UserGuides
##    ├── MDS_Framework_UserGuide.pdf
##    ├── MDS_PMC_Simulator_UserGuide.pdf
##    ├── MDS_PM_PMC_UserGuide.pdf
##    ├── MDS_PM_Studio_UserGuide.pdf
##    ├── MDS_SPX_SVN_UserGuide.pdf
##    ├── MDS_SPX_UserGuide.pdf
##    └── MDS_UserGuide.pdf
```
所以等等就會執行
+ (0x0001)
```bash	.		================start================================================================
./Linux/mds-13.1-deb-x86_64.run
##================output====>
##Verifying archive integrity... All good.
##Uncompressing mds-13.1  100%
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##gdebi-core is already the newest version (0.9.5.7+nmu2).
##0 upgraded, 0 newly installed, 0 to remove and 2 not upgraded.
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##This package is uninstallable
##A later version is already installed
##Please refer MDS Installation Guide. Exiting...
```
+ (0xaaaa)
```bash	.		================start================================================================
root@bmc-VirtualBox:/mnt/AEWIN/projects/MDS_TOOL_install/13.1#  ./Linux/x86_64/install.sh -d=/mnt/AEWIN/projects/MDS_TOOL_install/13.1
##====output================>
##Installing MDS in /mnt/AEWIN/projects/MDS_TOOL_install/13.1...
##
##Installing MDS...
##
##Installing MDS Base...DONE!!!
##
##Installing IPMI plugin...DONE!!!
##
##Installing PMCP Simulator plugin...DONE!!!
##
##Installing SPX Builder plugin...DONE!!!
##
##Installing SVN SPX plugin...DONE!!!
##
##MDS Installation completed!
##
##Run '/mnt/AEWIN/projects/MDS_TOOL_install/13.1/MDS/MDS -clean' to invoke the application.
```
這個後 會產生 一個 folder `MDS/`

-------------------------------------------------------------------------------

## MDSTOOL 13.5 install ##
```bash	.		================start================
git clone https://git_user:$ami_us_git_token@git.ami.com/tools/mds/releases/13.5.git
##================result====>
##13.5/
##├── Linux
##│   ├── mds-13.5-deb-x86_64.run (step1)
##│   ├── pre-requisites.sh
##│   ├── VERSION
##│   └── x86_64
##│       ├── Common
##│       │   ├── ipmi.tar.gz
##│       │   ├── mds-base.tar.gz
##│       │   ├── pmcpsimulator.tar.gz
##│       │   └── pmpmcp.tar.gz
##│       ├── install.sh (step2)
##│       ├── log.txt
##│       └── SPX
##│           ├── spx-builder.tar.gz
##│           └── svnspx.tar.gz
##├── MDS_Installation_Guide.pdf
##├── README.md
##├── ReleaseNotes.pdf
##└── UserGuides
##    ├── MDS_Framework_UserGuide.pdf
##    ├── MDS_GDB_Remote_Debugging_User_Guide.pdf
##    ├── MDS_PMC_Simulator_UserGuide.pdf
##    ├── MDS_PM_PMC_UserGuide.pdf
##    ├── MDS_PM_Studio_UserGuide.pdf
##    ├── MDS_SPX_SVN_UserGuide.pdf
##    ├── MDS_SPX_UserGuide.pdf
##    └── MDS_UserGuide.pdf
```
> 需要把 ./13.5/Linux/mds-13.5-deb-x86_64.run -->變執行檔

> 需要把 ./13.5/Linux/x86_64/install.sh    ----->變執行檔

如果你去執行不是執行檔
~~就像那些有緣無份的故事~~
`sudo chmod 777 ./Linux/mds-13.5-deb-x86_64.run`
`sudo chomod 777 ./Linux/x86_64/install.sh`
```bash	.		================start===============
-rw-r--r-- 1 root root 238456479 Sep 13 10:48 mds-13.5-deb-x86_64.run
  | |
  | |
\\   //
 \\ //
  \v/
-rwxrwxrwx 1 root root 238456479 Sep 13 10:48 mds-13.5-deb-x86_64.run

-rw-r--r-- 1 root root   19235 Sep 13 10:49 install.sh

-rwxrwxrwx 1 root root   19235 Sep 13 10:49 install.sh
```
![pic:the-diff](./pic/VM_MDS_install.png)

```bash	.		================start================
./Linux/mds-13.5-deb-x86_64.run
##================output================>
##Verifying archive integrity...  100%   All good.
##Uncompressing mds-13.5  100%
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##gdebi-core is already the newest version (0.9.5.7+nmu2).
##0 upgraded, 0 newly installed, 0 to remove and 2 not upgraded.
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##Reading state information... Done
##(Reading database ... 180321 files and directories currently installed.)
##Preparing to unpack mds-13.5-x86_64.deb ...
##
##Checking Pre-requsites...
##Checking Java Version...
##Java Version Requirement matched.
##Unpacking mds (13.5) over (13.5) ...
##Setting up mds (13.5) ...
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##Reading state information... Done
##(Reading database ... 180321 files and directories currently installed.)
##Preparing to unpack mds-13.5-x86_64.deb ...
##
##Checking Pre-requsites...
##Checking Java Version...
##Java Version Requirement matched.
##Unpacking mds (13.5) over (13.5) ...
##Setting up mds (13.5) ...
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##Reading state information... Done
##(Reading database ... 180321 files and directories currently installed.)
##Preparing to unpack ipmi-13.5-x86_64.deb ...
##Unpacking ipmi (13.5) over (13.5) ...
##Setting up ipmi (13.5) ...
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##Reading state information... Done
##(Reading database ... 180321 files and directories currently installed.)
##Preparing to unpack pmcpsimulator-13.5-x86_64.deb ...
##Unpacking pmcpsimulator (13.5) over (13.5) ...
##Setting up pmcpsimulator (13.5) ...
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##cppcheck is already the newest version (1.82-1).
##0 upgraded, 0 newly installed, 0 to remove and 2 not upgraded.
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##Reading state information... Done
##(Reading database ... 180321 files and directories currently installed.)
##Preparing to unpack spx-builder-13.5-x86_64.deb ...
##Unpacking spx-builder (13.5) over (13.5) ...
##Setting up spx-builder (13.5) ...
##Reading package lists... Done
##Building dependency tree
##Reading state information... Done
##Reading state information... Done
##(Reading database ... 180321 files and directories currently installed.)
##Preparing to unpack svnspx-13.5-x86_64.deb ...
##Unpacking svnspx (13.5) over (13.5) ...
##Setting up svnspx (13.5) ...
##
##Cppcheck Version Requirement matched.
##
##To launch MDS use: sudo MDS -clean
```

