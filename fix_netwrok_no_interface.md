-------------------------------------------------------------------------------
created	:	Mon Mar 17 15:45:22 CST 2025

date	:	.

-------------------------------------------------------------------------------
[ref](https://www.freedomwolf.cc/2019/10/network_by_systemd/)
| [[linux]]     | [[bash]]  | [[network]] | [[systemd-network]] | [[NetworkManager]] |
| [[systemctl]] | [[dmesg]] | [[lspic]]   |                     |                    |

-------------------------------------------------------------------------------

# sudden disappearance of the network  #

筆者這裡要做 1930的TEST

當時換過一個PSU後 網路就直接不見....

然後我就用 leon 的場測OS 就可以連到

這時候的故事就展開了....

這我們花費了  3 days

才找到問題....

這裡當時只有拿取到 local network
```bash ====sss================================================================
root 15:41:55 ~ --> ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
```
其實這裡就可以判斷了

當時我們還以為是 `NetworkManager` and `systemd-networkd` conflic

所以就有一些列 的奇怪指令

後來我們就在
```bash ====sss================================================================
root 16:00:11 ~ -->dmesg|g -i net
[    0.430800] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.446529] audit: initializing netlink subsys (disabled)
[    2.026850] NetLabel: Initializing
[    2.030520] NetLabel:  domain hash size = 128
[    2.034518] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    2.038551] NetLabel:  unlabeled traffic allowed by default
[    2.332487] NET: Registered PF_INET protocol family
[    2.406880] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.412550] NET: Registered PF_XDP protocol family
[    6.351101] drop_monitor: Initializing network drop monitor service
[    6.357785] NET: Registered PF_INET6 protocol family
[    6.380277] NET: Registered PF_PACKET protocol family
[   32.091804] systemd[1]: Configuration file /run/systemd/system/netplan-ovs-cleanup.service is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[   32.722772] systemd[1]: Listening on Network Service Netlink Socket.
[   46.851529] WangXun Gigabit PCI Express Network Driver - version 1.2.6
[   47.020626] ngbe 0000:43:00.0 eth0: WangXun(R) Gigabit Network Connection
[   47.184706] ngbe 0000:43:00.1 eth1: WangXun(R) Gigabit Network Connection
[   47.348734] ngbe 0000:43:00.2 eth2: WangXun(R) Gigabit Network Connection
[   47.512677] ngbe 0000:43:00.3 eth3: WangXun(R) Gigabit Network Connection
[   47.676464] ngbe 0000:44:00.0 eth4: WangXun(R) Gigabit Network Connection
[   47.834556] ngbe 0000:44:00.1 eth5: WangXun(R) Gigabit Network Connection
[   50.044440] audit: type=1400 audit(1742197075.337:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=804 comm="apparmor_parser"
[   50.044448] audit: type=1400 audit(1742197075.337:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=804 comm="apparmor_parser"
[   95.335071] IPv6: ADDRCONF(NETDEV_CHANGE): enp68s0f1: link becomes ready
[   96.798835] IPv6: ADDRCONF(NETDEV_CHANGE): enp68s0f0: link becomes ready
```
```bash ====sss================================================================
root 15:59:53 ~ --> lspci -vvv | g -i net
43:00.0 Ethernet controller: Beijing Wangxun Technology Co., Ltd. WX1860A4 Gigabit Ethernet Controller (rev 01)
        Subsystem: Beijing Wangxun Technology Co., Ltd. Qual-Port Ethernet Network Adaptor SF400T
43:00.1 Ethernet controller: Beijing Wangxun Technology Co., Ltd. WX1860A4 Gigabit Ethernet Controller (rev 01)
        Subsystem: Beijing Wangxun Technology Co., Ltd. Qual-Port Ethernet Network Adaptor SF400T
43:00.2 Ethernet controller: Beijing Wangxun Technology Co., Ltd. WX1860A4 Gigabit Ethernet Controller (rev 01)
        Subsystem: Beijing Wangxun Technology Co., Ltd. Qual-Port Ethernet Network Adaptor SF400T
43:00.3 Ethernet controller: Beijing Wangxun Technology Co., Ltd. WX1860A4 Gigabit Ethernet Controller (rev 01)
        Subsystem: Beijing Wangxun Technology Co., Ltd. Qual-Port Ethernet Network Adaptor SF400T
44:00.0 Ethernet controller: Beijing Wangxun Technology Co., Ltd. WX1860A2 Gigabit Ethernet Controller (rev 01)
        Subsystem: Beijing Wangxun Technology Co., Ltd. Dual-Port Ethernet Network Adaptor SF200T (NCSI)
44:00.1 Ethernet controller: Beijing Wangxun Technology Co., Ltd. WX1860A2 Gigabit Ethernet Controller (rev 01)
        Subsystem: Beijing Wangxun Technology Co., Ltd. Dual-Port Ethernet Network Adaptor SF200T (NCSI)
```
我們就是由 lspci 的這裡看到 Beijing 的網路

就是到又是中國魔改的物件...

其實上面的 ip a的時候 就有出現 抓不到interface

就是到我們需要重啟驅動(他們中國寫的...)

```bash ====sss================================================================


root 16:09:51 /ngbe-1.2.6/src -->make install&&make
```

等他跑完 斷AC ~~怎麼感覺筆者寫過這個~~

```bash ====sss================================================================
root 16:14:40 /ngbe-1.2.6/src --> ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp67s0f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether c0:33:da:00:0c:07 brd ff:ff:ff:ff:ff:ff
3: enp67s0f1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether c0:33:da:00:0c:08 brd ff:ff:ff:ff:ff:ff
4: enp67s0f2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether c0:33:da:00:0c:09 brd ff:ff:ff:ff:ff:ff
5: enp67s0f3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether c0:33:da:00:0c:0a brd ff:ff:ff:ff:ff:ff
6: enp68s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether c0:33:da:00:0c:05 brd ff:ff:ff:ff:ff:ff
    inet 192.168.120.25/24 brd 192.168.120.255 scope global dynamic enp68s0f0
       valid_lft 26624sec preferred_lft 26624sec
    inet6 fe80::c233:daff:fe00:c05/64 scope link
       valid_lft forever preferred_lft forever
7: enp68s0f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether c0:33:da:00:0c:06 brd ff:ff:ff:ff:ff:ff
    inet 192.168.199.11/24 brd 192.168.199.255 scope global dynamic enp68s0f1
       valid_lft 743sec preferred_lft 743sec
    inet6 fe80::c233:daff:fe00:c06/64 scope link
       valid_lft forever preferred_lft forever
```
這個才正確!!!! 終於
