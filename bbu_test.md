-------------------------------------------------------------------------------
created	:	Mon Aug  5 11:39:43 CST 2024

date	:	.

<!-- [ref](\\192.168.101.240\sd00軟體研發處\SD20SW二部\05_技術文件與工具\02_IPMI\IPMI規範\BBU) -->

[[bbu]]

-------------------------------------------------------------------------------

規範是由 john 大大來設計的
會更新 技術就是要隨著時間而改變
不管外力是需求還是技術疊代
`\\192.168.101.240\sd00軟體研發處\SD20SW二部\05_技術文件與工具\02_IPMI\IPMI規範\BBU`

# list    #
| BBU                          | connect  | bmc console |
|:----------------------------:|:--------:|:-----------:|
| VGA                          | physical |             |
| COM1                         | physical |             |
| COM2                         | physical |             |
| Buzzer Function              | .        |             |
| IPMITOOL                     | .        |             |
| Sensor values are reasonable | .        |             |
| Log in WebUI                 | .        |             |
| Remote/Manual Power Conteol  | .        |             |
| BMC I2C bus                  | physical | only        |
| BMC WDT                      | .        |             |
| "Updata BMC (WebUI)"         | .        |             |
| "Update BMC (yafufalsh)"     | .        |             |
| KVM                          | .        |             |
| SOL                          | .        |             |
| eMMC                         | .        |             |
| VBAT                         | .        |             |
| "Update BIOS (WebUI)"        | .        |             |
| Smart Fan                    | .        |             |
| Store MAC address            | .        |             |
| LCM                          | .        |             |
| I2C Bus Recovery             | physical |             |
| Slots Verification           |          |             |
| ipmitool stress test         | .        |             |
| Fan SEL                      | .        |             |
| 1 Fna Loses Function         | .        |             |
| 2 Fans Malfunction           | .        |             |
| "Power Policy"               | .        |             |
| System Isolation Test        | .        |             |
| SEL over night test          | .        |             |
| BMC Remote Media             | .        |             |

-------------------------------------------------------------------------------
#  bbu test    #

##  VGA                          ##
連結到VGA
##  COM1                         ##
COM1 也可以用 mobaXterm 來看 bios 的畫面!!(還可以同步操作)
##  COM2                         ##
COM1 COM2 我一起寫
這裡要測試 COM1 COM2 有讀寫的能力
所以 我們把它融合
概念上 我們使用 COM1寫 COM2 讀 就OK

##  Buzzer Function              ##
##  IPMITOOL                     ##
這裡的測試就是用ipmitool tool

可以使用 筆者是用 我自己寫的[腳本](http://sd20-server.aewin.com/Chin_Chiang/playwright/-/blob/auto/auto_parse_version.sh)
來讀取他的版本號

當然你們也可以用 `ipmitool sdr`

```bash			================start================
function_parse(){
    update_file_name="";
    number_1=$(echo "${catch_bmc_version}"|cut -c 2-4);						#int number_1
    number_2=$(echo "${catch_bmc_version}"|cut -c 5-7);						#int number_2
    number_3=$(echo "${catch_bmc_version}"|cut -c 8-9);                     #int third_number (declare)
    number_4=$(echo "${catch_bmc_version}"|cut -c 11-13);                   #int number_4
    ######int parse_1~4 hex => decimal
    parse_1=$((16#${number_1})); parse_2=$((16#${number_2}));
    parse_3=$((16#${number_3})); parse_4=$((16#${number_4}));
    # echo "${parse_1}   ${parse_2}   ${parse_3}   ${parse_4}  ";  ## dev tr mode
    parse_name=${parse_1}.${parse_2}.$((${parse_4}*100+${parse_3}));    #char *[] parse_name

    printf " right now version : [${parse_name}]\n";
    #need_version=${need_version} $(echo "${catch_version}"|cut -d ' ' -f 3);
    #echo " out : ";
    #echo "${need_version}";											#dev verification
    #echo "${first_number}";											#dev verification
    #echo "${second_number}";											#dev verification
    #echo "${third_number}";											#dev verification
    #echo "${forth_number}";											#dev verification
    ###### exclude the same upload file with current bmc version
    #change_file_limit=$(ls ./UPLOADFILES/ | grep -v "${parse_name}"|wc -l)
    ####### fix bug if update file not only 1
    #if [ ${change_file_limit} == 1 ]
    #then
    ##change_file=$(ls ./tests/uploadFiles/ | grep -v "${parse_name}");	#char *change_file
    #change_file=$(ls ./UPLOADFILES/ | grep -v "${parse_name}");	#char *change_file
    #else
    ##echo -e "===================\n|!!!!!!ERROR!!!!! |\n| you file need   |\n|one is right now |\n|version!		   |";
    #echo -e "==============================\n| One of your files needs to |\n| consisitent with your      |\n| current BMC version        |\n|                            |\n==============================\n| right now version is  :    |\n.      ${parse_name}         "; exit 520;
    #fi
}
```

##  Sensor values are reasonable ##
`ipmitool sdr`
`ipmitool sensor`

##  Log in WebUI                 ##
這個只要確認 BMC -> can WEBUI
##  Remote/Manual Power Conteol  ##
`ipmitool -I lanplus ${ip} powerstatus`
`ipmitool -I lanplus ${ip} power off`
`ipmitool -I lanplus ${ip} power on`
`ipmitool -I lanplus ${ip} power cycle`

##  BMC I2C bus                  ##
`i2cdetect -l`
> 筆者做過的TEST中 在 CB-6102_1.0.14N_2E4C IPMI BBU.xlsx

因為版本的關係  `i2cdetect not found command`
所以需要
`ls /dev/ | grep i2c`
`i2c-test --scan -b 3` 厲害的 allen cheng 大神

##  BMC WDT                      ##
這裡watchdog 原理是要瘋狂下指令
避免OS爆炸 WD就是保持OS的可用性

##  "Updata BMC (WebUI)"         ##
##  "Update BMC (yafufalsh)"     ##
only in OS (have [yafufalsh](./yafuflash.md))
##  KVM                          ##
KVM 可以簡單說 就是類似 遠端的方式
在SD10中 他們還會TEST 鍵盤 滑鼠是否正常
(也因為這個原因 筆者無法放入自動化)
##  SOL                          ##
##  eMMC                         ##
##  VBAT                         ##
##  "Update BIOS (WebUI)"        ##
##  Smart Fan                    ##
##  Store MAC address            ##

[測試目的](https://hackmd.io/@Malo850423/SJDyNqhh3#BBU-%E6%B8%AC%E8%A9%A6-):
看是否能將MAC address寫入EEPROM中，並讀取到EEPROM內address

筆者有[non auto](./bbu_mac_address.md)
筆者沒有把這一個放入到自動化
因為他改完mac address後
bmc的網路會跑掉...

`ipmitool -I raw 0x0c 0x01 0x01 0xc2`
open bmc mac address -> EEPROM function
`ipmitool raw 0x0c 0x01 0x01 0x05 0xx00` `0x08 0x00 0x01 0x00 0x01`

##  LCM                          ##
##  I2C Bus Recovery             ##
##  Slots Verification           ##
##  ipmitool stress test         ##
##  Fan SEL                      ##
##  1 Fna Loses Function         ##
##  2 Fans Malfunction           ##
##  "Power Policy"               ##
`ipmitool chassis status`
##  System Isolation Test        ##
##  SEL over night test          ##
##  BMC Remote Media             ##
