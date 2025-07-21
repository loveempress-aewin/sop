-------------------------------------------------------------------------------
created	:
2025-04-30_11:02:15
Wed Apr 30 11:02:15 CST 2025

date	:

-------------------------------------------------------------------------------
| [[bmc]] | [[nmap]] | [[ping]] |

-------------------------------------------------------------------------------

# use name to open arp #
```bash ====sss================================================================
nmap 192.168.199.15
Starting Nmap 7.80 ( https://nmap.org ) at 2025-04-30 10:57 CST
Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn
Nmap done: 1 IP address (0 hosts up) scanned in 6.17 seconds
```
因為知道是BMC的網路 所以 就直接把她打開
```bash ====sss================================================================
root 10:58:17 ~ --> ipmitool lan set 1  arp respond on
Enabling BMC-generated ARP responses
```
有了NMAP真的很好用呢
```bash ====sss================================================================
 nmap 192.168.199.15
Starting Nmap 7.80 ( https://nmap.org ) at 2025-04-30 10:58 CST
Nmap scan report for 192.168.199.15
Host is up (0.73s latency).
Not shown: 998 closed ports
PORT    STATE    SERVICE
80/tcp  filtered http
443/tcp open     https

Nmap done: 1 IP address (1 host up) scanned in 3.39 seconds
```

