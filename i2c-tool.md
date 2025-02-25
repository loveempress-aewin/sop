-------------------------------------------------------------------------------
created	:	Mon Feb 10 10:16:21 CST 2025

date	:	.

-------------------------------------------------------------------------------
[ref](https://b8807053.pixnet.net/blog/post/347698301)
| [[i2c]] | [[basic]] |

-------------------------------------------------------------------------------
i2c-tools是一套OpenSource，透過這個tools我們可以透過i2c 介面與 IC 去作溝通

我們可以到下面的網站去抓整包的SourceCode 然後再透過你的toolchain去編譯出你板子
上可以使用的工具 而編譯的方式我這邊就不贅述 我們這篇著重在tool如何使用

`i2cdetect i2cdump i2cset`

i2cdetect  ===> 會列出 i2c的 Bus上所有的Device
i2cdump   ===> 會列出 Device上所有的 Register值
i2cset       ===> 可寫入到某個 Bus上的某個 Device上的 Register值

筆者這裡使用

```bash			================start================
i2cdetect -l

i2c-0   i2c             Synopsys DesignWare I2C adapter         I2C adapter
i2c-1   i2c             Synopsys DesignWare I2C adapter         I2C adapter
i2c-2   smbus           SMBus PIIX4 adapter port 0 at 0b00      SMBus adapter
i2c-3   smbus           SMBus PIIX4 adapter port 2 at 0b00      SMBus adapter
i2c-4   smbus           SMBus PIIX4 adapter port 1 at 0b20      SMBus adapter
i2c-5   i2c             AST i2c bit bus                         I2C adapter
```
從上圖我們可以知道，這台設備上總共有 0 ~ 5 個 I2C Bus

 i2cdetect 來確認 Bus上有哪些 Device
```bash			================start================
 i2cdetect -r -y 1    ####列出 Bus 1上的所有Device
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --
10: 10 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- 54 -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- 6c 6d -- --
70: -- -- -- -- -- -- -- --
```
```bash			================start================
i2cdetect -r -y 4
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         08 09 0a 0b 0c 0d 0e 0f
10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
70: 70 71 72 73 74 75 76 77
```
> i2cdetect -r -y 1 -> 1 可以從i2cdetect -l 看出來 i2c-1 的PART

```bash			================start================
i2cdetect -y 1
Warning: Can't use SMBus Quick Write command, will skip some addresses
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:
10:
20:
30: -- -- -- -- -- -- -- --
40:
50: -- -- -- -- 54 -- -- -- -- -- -- -- -- -- -- --
60:
```
 i2cdump 查詢設備內所有暫存器
```bash			================start================
i2cdump -y 5 0x30
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f    .???????????????
10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f    ????????????????
20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f     !"#$%&'()*+,-./
30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f    0123456789:;<=>?
40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f    @ABCDEFGHIJKLMNO
50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f    PQRSTUVWXYZ[\]^_
60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f    `abcdefghijklmno
70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f    pqrstuvwxyz{|}~?
80: 80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f    ????????????????
90: 90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f    ????????????????
a0: a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af    ????????????????
b0: b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf    ????????????????
c0: c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf    ????????????????
d0: d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df    ????????????????
e0: e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef    ????????????????
f0: f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff    ???????????????.
```
```bash			================start================
i2cdump -y 5 0x37
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 7e 3d 3c e8 f1 02 25 a8 a3 e9 24 5d 5f e4 cf 04    ~=<???%???$]_???
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
```

`i2cset -y 1 0x50 0x36 0x05  ===> 寫入 Bus1 的 Device 0x50的 0x36 Register值 寫入 0x05`
這個筆者付現不出來...
```bash			================stqrat================
i2cset -f -y 5 0x30 0x00 ff
Error: Data value invalid!
Usage: i2cset [-f] [-y] [-m MASK] [-r] [-a] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]
  I2CBUS is an integer or an I2C bus name
  ADDRESS is an integer (0x08 - 0x77, or 0x00 - 0x7f if -a is given)
  MODE is one of:
    c (byte, no value)
    b (byte data, default)
    w (word data)
    i (I2C block data)
    s (SMBus block data)
    Append p for SMBus PEC
```
`i2cget  -y 1 0x50 0x12`
