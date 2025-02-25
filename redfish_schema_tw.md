-------------------------------------------------------------------------------
created	:	Tue Feb 25 16:54:37 CST 2025

date	:	.

-------------------------------------------------------------------------------
[ref-bing-GPT]
| [[redfish]] | [[study]] |

-------------------------------------------------------------------------------

schema 定義用於管理和控制數據中心中硬件的數據的結構和格式

1. redfish schema 目標:
提供了一種標準化的方式來表示各種硬件組件及其屬性
這確保了不同系統和供應商之間的一致性和互操作性

> 可以想像成 API的概念

2. 提供的各式:
CSDL (Common Schema Definition Language): An XML-based format.
JSON Schema: A JSON-based format.
OpenAPI Schema: Used for defining RESTful APIs.

> 筆者看過影片 好像RESTful APIs 據說用很多

3. 每一個 schema 對應著相對應的資源(這裡筆者翻譯成數據)
 servers, storage, or networking devices
+ AccountService	: 管理用戶帳戶及其屬性
+ Chassis			: 全部硬體組合成的機箱
+ System			:
