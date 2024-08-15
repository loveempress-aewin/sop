-------------------------------------------------------------------------------
created	:	Wed Jul 31 14:00:20 CST 2024
date	:	.
aliases: [80poort]

-------------------------------------------------------------------------------
# metadata  #
auto	:	love-queen
[[80port]]

-------------------------------------------------------------------------------
#  OT005   #
file:`\\192.168.101.240\sd00軟體研發處\SD20SW二部\04_Project\80 port card\OT005 eSPI_LPC debug card user manual_20221012.docx`
file:`\\192.168.101.240\sd00軟體研發處\內部共用區\04-Develop Tool\OT005 eSPI_LPC debug card user manual_20221012.docx`
OT005 can support both
+ old LPC (low ping count)
  + 80 debug port LPC
  + 2-3
+ new eSPI
  + new 80/82 port debug port ESPI
  + 1-2
```
              J1 ┌──────────────┐
ESPI_IO1/LAD1────│ 1         2  │
─────────────────│ 3         4  │
─────────────────│ 5         6  │
─────────────────│ 7         8  │
ESPI CLK/LCLK────│ 9         10 │
─────────────────│ 11           │
─────────────────│ 13        14 │───────┐VCC3_HDR_P14
─────────────────└──────────────┘       │
                                J3      │
                               ┌───┐    │
                               │ 1 │────┘
                3VCC───────────│ 2 │
                               │ 3 │─────3VBS
                               └───┘
(1-2) : NEW define 80/82 debug port ESPI
(2-3) : OLD define 80    debug port LPC
```

we can select by J3 jumper.


