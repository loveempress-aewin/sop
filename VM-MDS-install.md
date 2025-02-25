-------------------------------------------------------------------------------
created	:	Fri Sep 13 08:54:12 CST 2024

date	:	Wed Jan 15 17:23:25 CST 2025

-------------------------------------------------------------------------------

# metadata #
[[git]] [[MDS]] [[vm]]
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
首先我們放置的位置 `/mnt/AEWIN/projects/MDS_TOOL_install`
(這裡是筆者的用法)
```bash				================start================================================================
## the structure  /mnt/AEWIN/projects/MDS_TOOL_install
#### ./MDS_TOOL_install/
#### ├── 13.1
#### └── 13.5
```


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

>> 只有13.5的需要改變他的執行權限

如果你去執行不是執行檔
~~就像那些有緣無份的故事~~
`sudo chmod 777 ./Linux/mds-13.5-deb-x86_64.run`
`sudo chomod 777 ./Linux/x86_64/install.sh`
```bash	.		================start===============
-rw-r--r-- 1 root root 238456479 Sep 13 10:48 mds-13.5-deb-x86_64.run
####  | |
####  | |
####\\   //
#### \\ //
####  \v/
-rwxrwxrwx 1 root root 238456479 Sep 13 10:48 mds-13.5-deb-x86_64.run

-rw-r--r-- 1 root root   19235 Sep 13 10:49 install.sh
####  |
####  |
####  V
-rwxrwxrwx 1 root root   19235 Sep 13 10:49 install.sh
```


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
這裡就是安裝完成

##  config_MDS ##
[config_MDS_by_malo](http://sd20-server.aewin.com:3000/pncIlBpCQrGJpcJxyQ-MAQ?view#%E5%B7%A5%E5%85%B7%E5%AE%89%E8%A3%9D)
+ {your path}/MDS/spx/spxconfs.xml
+ {your path}/MDS/spx/utils/Group.dsc
+ add LICENSE.AEWIN (LICENSE.AEWIN in )


##  再來是要給他們一個位置!!   ##
這裡是經過 malo 的 經驗 與教法
```bash				================start================
/mnt/AEWIN/project/1937_MDSTOOL/

## 1937_MDSTOOL/
## ├── Development
## └── Workspace
```
因為後續要執行 MDS
> MDS 檔案 當我上面安裝好後
> 都會放在 MDS/

筆者這裡MDS 的位置是
+ 13.1
`/mnt/AEWIN/MDS_TOOL_install/13.1/MDS/MDS`
+ 13.5
`/mnt/AEWIN/MDS_TOOL_install/13.5/MDS/MDS`

> 記得我是用 外掛的方式 MDS TOOL 但放在 /mnt/AEWIN/MDS_TOOL/

看是那一個version 就在哪一個folder下喔

> 在執行前 記得權限是 root

`./MDS -clean`

> 筆者用的是虛擬機器連結到虛擬機 (所以如果用這個指令 具需要直接在 VM的虛擬機)


-------------------------------------------------------------------------------

## mds-tool-error-npm-ssh ##
```bash			================start================
Grunt/Bower/coveralls are required and one or more is not present. Installing them now...
▌ ╢░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░╟
WARN engine grunt-cli@1.5.0: wanted: {"node":">=10"} (current: {"node":"8.10.0","npm":"3.5.2"})
npm WARN deprecated request@2.88.2: request has been deprecated, see https://github.com/request/request/issues/3142
npm WARN deprecated uuid@3.4.0: Please upgrade  to version 7 or higher.  Older versions may use Math.random() in certain circumstances, which is known to be problematic.  See https://v8.dev/blog/math-random for details.
npm WARN deprecated har-validator@5.1.5: this library is no longer supported
npm ERR! Linux 5.4.0-150-generic
npm ERR! argv "/usr/bin/node" "/usr/bin/npm" "i" "-gq" "grunt-cli" "bower" "coveralls"
npm ERR! node v8.10.0
npm ERR! npm  v3.5.2
npm ERR! code EMISSINGARG

npm ERR! typeerror Error: Missing required argument #1
npm ERR! typeerror     at andLogAndFinish (/usr/share/npm/lib/fetch-package-metadata.js:31:3)
npm ERR! typeerror     at fetchPackageMetadata (/usr/share/npm/lib/fetch-package-metadata.js:51:22)
npm ERR! typeerror     at resolveWithNewModule (/usr/share/npm/lib/install/deps.js:456:12)
npm ERR! typeerror     at /usr/share/npm/lib/install/deps.js:457:7
npm ERR! typeerror     at /usr/share/npm/node_modules/iferr/index.js:13:50
npm ERR! typeerror     at /usr/share/npm/lib/fetch-package-metadata.js:37:12
npm ERR! typeerror     at addRequestedAndFinish (/usr/share/npm/lib/fetch-package-metadata.js:82:5)
npm ERR! typeerror     at returnAndAddMetadata (/usr/share/npm/lib/fetch-package-metadata.js:117:7)
npm ERR! typeerror     at pickVersionFromRegistryDocument (/usr/share/npm/lib/fetch-package-metadata.js:134:20)
npm ERR! typeerror     at /usr/share/npm/node_modules/iferr/index.js:13:50
npm ERR! typeerror This is an error with npm itself. Please report this error at:
npm ERR! typeerror     <http://github.com/npm/npm/issues>

npm ERR! Please include the following file with any support request:
npm ERR!     /tmp/selfgz1965128359/npm-debug.log
Done
Reading package lists... Done
Building dependency tree
Reading state information... Done
Reading state information... Done
Selecting previously unselected package spx-builder.
(Reading database ... 174434 files and directories currently installed.)
Preparing to unpack spx-builder-13.0-x86_64.deb ...
Unpacking spx-builder (13.0) ...
Setting up spx-builder (13.0) ...
Reading package lists... Done
Building dependency tree
Reading state information... Done
Reading state information... Done
Selecting previously unselected package svnspx.
(Reading database ... 174845 files and directories currently installed.)
Preparing to unpack svnspx-13.0-x86_64.deb ...
Unpacking svnspx (13.0) ...
Setting up svnspx (13.0) ...

Cppcheck Version Requirement matched.

To launch MDS use: sudo MDS -clean
```
