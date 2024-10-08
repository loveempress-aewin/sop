-------------------------------------------------------------------------------
created	:	Wed Aug 14 11:18:41 CST 2024
date	:	.

-------------------------------------------------------------------------------
[ipmitool sensor change](https://www.truenas.com/community/resources/how-to-change-ipmi-sensor-thresholds-using-ipmitool.35/)

#  change the  threshold   #
`ipmitool sensor thresh "CPU0 Temp." upper 45 50 55`

```bash                +start
root 11:17:06 ~/queen_tools -->ipmitool sensor thresh "CPU0 Temp." upper 45 50 55
Locating sensor record 'CPU0 Temp.'...
Setting sensor "CPU0 Temp." Upper Non-Critical threshold to 45.000
Setting sensor "CPU0 Temp." Upper Critical threshold to 50.000
Setting sensor "CPU0 Temp." Upper Non-Recoverable threshold to 55.000
Error setting threshold: Command illegal for specified sensor or record type
```

```bash                +start
root 11:01:20 ~/queen_tools -->ipmitool sensor thresh "CPU0 Temp" upper 45 50 55
Locating sensor record 'CPU0 Temp'...
Sensor data record not found!
```


