-------------------------------------------------------------------------------
created	:	Fri Jun 28 16:53:45 CST 2024
date	:	.

-------------------------------------------------------------------------------

# bios WEBUI #
when upload finished
```
###bmc console
[  475.000030] aspeed-smc 1e630000.spi: bus_width 2, Using 50 MHz SPI frequency
[  475.008074] aspeed-smc 1e630000.spi: mx25l25635e (32768 Kbytes)
[  475.014761] aspeed-smc 1e630000.spi: CE0 window [ 0x30000000 - 0x32000000 ] 32MB
[  475.023048] aspeed-smc 1e630000.spi: CE1 window [ 0x32000000 - 0x32000000 ] 0MB (disabled)
[  475.032295] aspeed-smc 1e630000.spi: read control register: [203c0641]
```

progressing
```
#### bmc console
[1577 : 2456 INFO]Skipping the erase block 0

[1577 : 2456 INFO]Skipping the erase block 1

[1577 : 2456 INFO]Flashing the erase block 2

[1577 : 2456 INFO]Flashing the erase block 3

[1577 : 2456 INFO]Skipping the erase block 4

[1577 : 2456 INFO]Skipping the erase block 5

[1577 : 2456 INFO]Skipping the erase block 6

[1577 : 2456 INFO]Skipping the erase block 7

[1577 : 2456 INFO]Flashing the erase block 8

[1577 : 2456 INFO]Flashing the erase block 9

[1577 : 2456 INFO]Skipping the erase block 10

[1577 : 2456 INFO]Skipping the erase block 11

[1577 : 2456 INFO]Skipping the erase block 12

[1577 : 2456 INFO]Skipping the erase block 13

[1577 : 2456 INFO]Skipping the erase block 14

[1577 : 2456 INFO]Skipping the erase block 15

[1577 : 2456 INFO]Skipping the erase block 16
...
....
[1577 : 2456 INFO]Skipping the erase block 509

[1577 : 2456 INFO]Skipping the erase block 510

[1577 : 2456 INFO]Skipping the erase block 511

[1577 : 2456 INFO]Bios START update done FlashOffset 0: SizeToWrite 33554432

[1577 : 1587 INFO]IPMI Session established successfully

[1577 : 1587 INFO]IPMI Session established successfully

[  650.878836] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: request() failed for pin 12
[  650.888036] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: pin-12 (1e780000.gpio:12) status -1
[207 : 253 CRITICAL][gpioifc.c:200]set 12 gpio/value 0x1

POWER CYCLE CHASSIS
[207 : 253 CRITICAL][Storage/SELDevice/SEL.c:1877]Error in getting TLS data 207

[  650.916128] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: request() failed for pin 12
[  650.924728] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: pin-12 (1e780000.gpio:12) status -1
[1593 : 1603 CRITICAL][gpioifc.c:200]set 12 gpio/value 0x1

[207 : 253 CRITICAL][Storage/SELDevice/SEL.c:1877]Error in getting TLS data 207

POWER OFF CHASSIS

```


