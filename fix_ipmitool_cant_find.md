-------------------------------------------------------------------------------
created	:	Thu Aug 15 09:47:56 CST 2024

date	:	.

[[ipmitool]] [[modprobe]] [[os]]
[ref](https://serverfault.com/questions/480371/ipmitool-cant-find-dev-ipmi0-or-dev-ipmidev-0)

-------------------------------------------------------------------------------

# ipmitool_remount_ipmitool_kernel #
這個問題是 有一次 我用了更新BMC ~~maybe~~
然後就突然不能用ipmitool
```
Could not open device at /dev/ipmi0 or /dev/ipmi/0 or /dev/ipmidev/0: No such file or directory
Unable to get Chassis Power Status
```

# solution #
> You probably need to load the IPMI kernel modules:

+ directly use commands
```
modprobe ipmi_devintf
modprobe ipmi_si
```
~~I sound very impressive but actually, I'm not. I'm super impressive~~
+ config file
you can add these to `/etc/modules` to have them loaded automatically
(just list the module names):
```
ipmi_devintf
ipmi_si
```

###  add note ###
`modprobe` - Add an remove modules from the Linux Kernel


