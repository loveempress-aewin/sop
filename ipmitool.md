-----------------------------------------------------------------------------
created	:	Wed Jan 22 11:08:43 CST 2025

date	:	.

-------------------------------------------------------------------------------
[ref](https://www.dinghui.org/ipmitool-bmc.html)
| [[ipmitool]] | [[basic]] | [[kcs]] |

-------------------------------------------------------------------------------
# ipmitool #

備註：IPMITool可以用來獲取和設置伺服器帶外管理口的網路配置 使用者配置 感測器 重啟BMC等等

IPMItool是一款支援 IPMI 1.5/2.0 規範的系統命令行工具  通過KCS通道時 IPMItool必須運行在伺服器本機的操作系統上
當基於LAN時 IPMItool等工具可以遠端管理伺服器

IPMI（Intelligent Platform Management Interface，智慧平臺管理介面）是一項應用於伺服器管理系統設計的標準
由Intel、HP、Dell和NEC公司於1998年共同提出  IPMI 的主要特性是可獨立於處理器 BIOS 和操作系統
利用此標準 有助於在不同類伺服器系統硬體上實施系統管理 使不同平臺的集中管理成為可能

在IPMI管理平臺中 BMC(Baseboard Management Controller 基板管理控制器)是核心控制器
系統管理軟體對各個器件的管理都是通過與BMC通信來實現的。
BMC與主處理器和板上各元件相連接，監控或管理各物理部件。

