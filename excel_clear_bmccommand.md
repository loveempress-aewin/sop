ipmitool user list
ipmitool channel setaccess 1 2 callin=on ipmi=on link=on privilege=4

ipmitool mc info
ipmitool lan print 1
ipmitool sensor
ipmitool sdr type fan

ipmitool type temp

ipmitool sdr | grep PSU

```bash ====sss================================================================
#### auto_sd10_latter_part.sh
ipmitool sel -v  info
ipmitool event 1
```

```bash ====sss================================================================
####auto_function_elist.sh
ipmitool sel elist
ipmitool sel elist |wc -l
```

```bash ====sss================================================================
#### auto_get_version.sh
ipmitool raw 0x1e 0x01 0x0 ## get bmc version
```

```bash ====sss================================================================
ipmitool sdr #### auto_
```

use AMZ tool

```bash ====sss================================================================
/mnt/d/WEB_auto/auto_bbu_privious_half.sh:sdr=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sdr);
/mnt/d/WEB_auto/auto_bbu_privious_half.sh:vbat=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sdr|grep -i VBAT);
/mnt/d/WEB_auto/auto_bbu_privious_half.sh:fan=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sdr type fan)
/mnt/d/WEB_auto/auto_bbu_watchdog.sh:    watchdog=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 mc watchdog get);
/mnt/d/WEB_auto/auto_bbu_watchdog.sh:    ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 raw 0x06 0x24 0x04 0x03 0x01 0x10 0x64 0x00;
/mnt/d/WEB_auto/auto_bbu_watchdog.sh:    watchdog_reset=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 mc watchdog reset);
/mnt/d/WEB_auto/auto_function_elist.sh:    sel_elist=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel elist);
/mnt/d/WEB_auto/auto_function_elist.sh:        sel_elist_count=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel elist|wc -l);
/mnt/d/WEB_auto/auto_get_version.sh:catch_version=$(ipmitool -I lanplus -H "${global_ip}" -U admin -P 11111111 raw 0x1e 0x01 0x00);
/mnt/d/WEB_auto/auto_over_night.sh:    ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 event 1;
/mnt/d/WEB_auto/auto_parse_version.sh:        echo "| didn't ipmitool|"
/mnt/d/WEB_auto/auto_parse_version.sh:    catch_bmc_version=$(ipmitool -I lanplus -H ${global_ip} -U admin -P 11111111 raw 0x1e 0x01 0x00);
/mnt/d/WEB_auto/auto_sd10_first_half.sh:mc_info=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 mc info);
/mnt/d/WEB_auto/auto_sd10_first_half.sh:lan_print=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 lan print 1);
/mnt/d/WEB_auto/auto_sd10_first_half.sh:sensor=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sensor);
/mnt/d/WEB_auto/auto_sd10_first_half.sh:sdr_fan=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sdr type fan);
/mnt/d/WEB_auto/auto_sd10_first_half.sh:sdr_temp=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sdr type temp);
/mnt/d/WEB_auto/auto_sd10_first_half.sh:sdr_voltage=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sdr type voltage);
/mnt/d/WEB_auto/auto_sd10_first_half.sh:sdr_PSU=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sdr|grep PSU);
/mnt/d/WEB_auto/auto_sd10_latter_part.sh:    sel_clear_0=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel clear);
/mnt/d/WEB_auto/auto_sd10_latter_part.sh:sel_v=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel -v info);
/mnt/d/WEB_auto/auto_sd10_latter_part.sh:event_manually=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 event 1);
/mnt/d/WEB_auto/auto_sd10_userlist.sh:user_list_0=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 user list)
/mnt/d/WEB_auto/auto_sd10_userlist.sh:    ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 channel setaccess 1 2 callin=on ipmi=on link=on privilege=4
/mnt/d/WEB_auto/auto_sd10_userlist.sh:    user_list_1=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 user list);
/mnt/d/WEB_auto/auto_set_time.sh:    get_time=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel time get);
/mnt/d/WEB_auto/auto_set_time.sh:    bmc_month=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel time get|cut -d ' ' -f 1|cut -d '/' -f 1);
/mnt/d/WEB_auto/auto_set_time.sh:    bmc_date=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel time get|cut -d ' ' -f 1|cut -d '/' -f 2);
/mnt/d/WEB_auto/auto_set_time.sh:    bmc_hour=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel time get|cut -d ' ' -f 2|cut -d ':' -f 1);
/mnt/d/WEB_auto/auto_update_bmc.sh:    $(ipmitool -I lanplus -H ${global_ip} -U admin -P 11111111 raw 0x1e 0x01 0x00 >> log.txt);
```




```bash ====sss================================================================
/mnt/d/WEB_auto/auto_bbu_privious_half.sh:# version=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 raw 0x1e 0x01 0x00);
/mnt/d/WEB_auto/auto_bbu_privious_half.sh:##fan=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel elist|grep -i fan);
/mnt/d/WEB_auto/auto_bbu_watchdog.sh:        # sel_elist=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel elist);
/mnt/d/WEB_auto/auto_get_version.sh:# catch_version=$(ipmitool -I lanplus -H "${global_ip}" -U admin -P 11111111 raw 0x1e 0x01 0x00);
/mnt/d/WEB_auto/auto_sd10_first_half.sh:### `ipmitool sdr` bbu havae it
/mnt/d/WEB_auto/auto_sd10_latter_part.sh:#     sel_elist=$(ipmitool -I lanplus -H${global_ip} -Uadmin -P11111111 sel elist);
/mnt/d/WEB_auto/auto_test.sh:### TODO:check ipmitool can use
/mnt/d/WEB_auto/auto_test.sh:# catch_version=$(ipmitool -I lanplus -H "${ip}" -U admin -P 11111111 raw 0x1e 0x01 0x00);
/mnt/d/WEB_auto/auto_test.sh:#     $(ipmitool -I lanplus -H ${global_ip} -U admin -P 11111111 raw 0x1e 0x01 0x00 >> log.txt);
/mnt/d/WEB_auto/auto_update_bmc.sh:### TODO:check ipmitool can use
/mnt/d/WEB_auto/auto_update_bmc.sh:# catch_version=$(ipmitool -I lanplus -H "${ip}" -U admin -P 11111111 raw 0x1e 0x01 0x00);
```

this is conclude

```bash ====sss================================================================
ipmitool sdr
ipmitool sdr | grep VBAT
ipmitool sdr type fan
ipmitool mc watchdog get
ipmitool raw 0x06 0x24 0x04 0x03 0x01 0x10 0x64 0x00  ## watchdog
ipmitool mc watchdog reset
ipmitool sel elist
ipmitool sel elist | wc -l
ipmitool raw 0x1e 0x01 0x00
ipmitool event 1
ipmitool mc info
ipmitool lan print 1
ipmitool sensor
ipmitool sel -v info
ipmitool sdr type fan
ipmitool sdr type temp
ipmitool sdr type voltage
ipmitool sdr |grep PSU
ipmitool user list 1 ##?
ipmitool channel setaccess 1 2 callin=on ipmio=on link=on privilege=4
```

## catch the excel ##
```bash ====sss================================================================
# 1-Flash_Image
ipmitool lan print 1
ipmitool lan print 1

#### 2-BIOS
ipmitool lan print 1

#### 3-OS
ipmitool mc info
ipmitool lan print 1
ipmitool user list 1

#### 4,5-WEbUI_part1
ipmitool sdr
ipmitool sel clear

#### 6-Sensor Page
ipmitool sdr
ipmitool sensor
ipmitool sdr list    #ipmitool sdr
ipmitool sdr type fan
ipmitool sdr type temp
ipmitool sdr type voltage
ipmitool sdr | grep PSU
ipmitool sdr | grep -i fan

#### 7-Log and report page
#### sensor_event.jpg (download web)
ipmitool sel clear

####7_SEL
ipmitool sel elist
ipmitool sel info
ipmitool sel save sel_log$(date +%i).txt
ipmitool sel clear && ipmitool sel elist

#### execute a command to overload the logs and verify the output to detemine correctness.
#### run a command to generate excessive logs, then inspect the results for accuracy.

```

7_SEL need to use bash script!
```bash ====sss================================================================
#### 8-Setting
#### timedatectl in OS
```

