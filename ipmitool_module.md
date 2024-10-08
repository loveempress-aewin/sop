-------------------------------------------------------------------------------
created	:	Thu Aug 29 09:36:58 CST 2024
date	:	.

-------------------------------------------------------------------------------
#  ipmitool  #
[ref](https://segmentfault.com/a/1190000021396481)

load `ipmi_devinft`  &&  `ipmitool_si`
will generate -> `/dev/ipmi0`

this is this auto use command
```
$ ipmitool bmc reset cold            #Reset BMC/DRAC to default
$ ipmitool –I open bmc info          #check BMC info
$ ipmitool sel                       #check SEL log
$ ipmitool sel list                  #list SEL log
$ ipmitool raw 0x34 0x11             #Check which node you are in [For Dell Cloud edge]
$ ipmitool lan set 1 ipsrc static    #Set BMC/DRAC static IP
$ ipmitool lan set 1 ipaddr          #Set BMC/DRAC IP Address
$ ipmitool lan set 1 netmask         #Set BMC/DRAC Subnet Mask
$ ipmitool lan set 1 defgw ipaddr    #Set BMC/DRAC Default Gateway
$ ipmitool lan set 1 defgw macaddr 00:0e:0c:aa:8e:13    #Set BMC/DRAC Default Gateway mac address
$ ipmitool lan set 1 arp respond on        #Enable arp
$ ipmitool lan set 1 auth ADMIN MD5        #Enable auth
$ ipmitool lan set 1 access on             #allow access
$ ipmitool user set name 2 admin           #create admin
$ ipmitool user set password 2             #set password
$ ipmitool channel setaccess 1 2 link=on ipmi=on callin=on privilege=2        #set user access permission
$ ipmitool user enable 2                   #Enable user
$ ipmitool channel getaccess 1 2           #set channel
$ ipmitool raw 0x30 0x24 2                 #Change the NIC settings to dedicated
$ ipmitool raw 0x30 0x24 0                 #Change the NIC settings to shared
$ ipmitool raw 0x30 0x25                   #Check the NIC settings[Output of 00 means shared and 02 means dedicated]
$ ipmitool mc reset warm                   #Restart the BMC/DRAC
$ ipmitool -I open sensor                  #read sensor data
$ ipmitool sunoem fan speed 100            #set fan speed
```

[my command](./bmc_command)

