-------------------------------------------------------------------------------
created	:	Fri Jan 17 13:51:35 CST 2025

date	:	.

-------------------------------------------------------------------------------
| [[virtualbox]] | [[apt]] |

-------------------------------------------------------------------------------

mtd-utils:i386
: Unable to locate package python-numpy

```bash			================start================
root@bmc:~# at libncurses5:i386 python-numpy doxygen python-apt dmsetup python-svn
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Package python-apt is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source
However the following packages replace it:
  python3-apt python-apt-common python-apt-doc python3-apt-dbg:i386 python3-apt:i386 python3-apt-dbg

E: Unable to locate package python-numpy
E: Package 'python-apt' has no installation candidate
E: Unable to locate package python-svn
```
E: Unable to locate package python-numpy

```bash			================start================
root@bmc:~# at python-apt
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Package python-apt is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source
However the following packages replace it:
  python-apt-doc python3-apt-dbg:i386 python3-apt:i386 python3-apt-dbg python3-apt python-apt-common

E: Package 'python-apt' has no installation candidate
```
```bash			================start================
root@bmc:~# at python-svn
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package python-svn
```

-------------------------------------------------------------------------------

# detail #
Certainly! Let's break down the command curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - step by step:

curl -sL https://deb.nodesource.com/setup_10.x:

curl: This is a command-line tool used to transfer data from or to a server.
-sL: These are options for curl.
-s: Silent mode. This option makes curl operate in silent mode, meaning it won't show progress or error messages.
-L: Follow redirects. This option tells curl to follow any HTTP redirects until it reaches the final destination.
https://deb.nodesource.com/setup_10.x: This is the URL from which curl will fetch the script. The script is designed to set up the NodeSource repository for Node.js version 10.x on your system.
| (pipe):

The pipe symbol takes the output of the command on its left (curl -sL https://deb.nodesource.com/setup_10.x) and passes it as input to the command on its right (sudo bash -).
sudo bash -:

sudo: This command allows you to run commands with superuser (root) privileges.
bash -: This tells the bash shell to read commands from standard input (which, in this case, is the script fetched by curl).
In summary, this command fetches a script from the NodeSource repository and runs it with superuser privileges. The script sets up the NodeSource repository on your system, allowing you to install Node.js version 10.x using your package manager.

Do you need help with anything else? 💗💗

# curl-nodes #
```bash			================start================
TO AVOID THIS WAIT MIGRATE THE SCRIPT
Continuing in 60 seconds (press Ctrl-C to abort) ...


## Installing the NodeSource Node.js 10.x repo...


## Populating apt-get cache...

+ apt-get update
Hit:1 http://tw.archive.ubuntu.com/ubuntu jammy InRelease
Get:2 http://tw.archive.ubuntu.com/ubuntu jammy-updates InRelease [128 kB]
Get:3 http://tw.archive.ubuntu.com/ubuntu jammy-backports InRelease [127 kB]
Get:4 http://security.ubuntu.com/ubuntu jammy-security InRelease [129 kB]
Get:5 http://tw.archive.ubuntu.com/ubuntu jammy-updates/main amd64 DEP-11 Metadata [103 kB]
Get:6 http://tw.archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 DEP-11 Metadata [212 B]
Get:7 http://tw.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 DEP-11 Metadata [356 kB]
Get:8 http://tw.archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 DEP-11 Metadata [940 B]
Get:9 http://tw.archive.ubuntu.com/ubuntu jammy-backports/main amd64 DEP-11 Metadata [7,012 B]
Get:10 http://tw.archive.ubuntu.com/ubuntu jammy-backports/restricted amd64 DEP-11 Metadata [212 B]
Get:11 http://tw.archive.ubuntu.com/ubuntu jammy-backports/universe amd64 DEP-11 Metadata [17.7 kB]
Get:12 http://tw.archive.ubuntu.com/ubuntu jammy-backports/multiverse amd64 DEP-11 Metadata [212 B]
Fetched 869 kB in 2s (511 kB/s)
Reading package lists... Done

## Confirming "jammy" is supported...

+ curl -sLf -o /dev/null 'https://deb.nodesource.com/node_10.x/dists/jammy/Release'

## Your distribution, identified as "jammy", is not currently supported, please contact NodeSource at https://github.com/nodesource/distributions/issues if you think this is incorrect or would like your distribution to be considered for support
```
