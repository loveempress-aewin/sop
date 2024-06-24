---
created	:	Mon Jun 24 13:40:30 CST 2024
date	:	.

-------------------------------------------------------------------------------

# I2C bus recovery #
這個原理是我們要測試
SMbus **可能**幾萬次後 有機率發生
訊號被  blocked 住 ( 通長是 32ms )後 bmc發現 這個太久
就會執行 I2C bus recovery

我們BMC可不可以做到 I2C bus recovery的function
> SMbus 可能會發生device 被LOW住(我們都會稱為拉住)

> BMC basic : BMC normal status --> high (這樣device 才能溝通)

也因為這樣 所以 stroke 大大他們設計了一個設備
*搞破壞*的設備 (不管你BMC 是不是有在溝通 他都會把device 拉住)
當BMC看到你的訊號被blocked住32ms後
就會釋放掉他 **等於reset**

# how to do #

## equipment ##
1. 這裡可以用的是 big power (我們通常有兩種 power)
2. 有一個線是 brian 的 涂 做的接線 (brian's al dupont lines)
3. OT004   破壞設備
![3](./pic/I2C_bus_recovery_de.jpg)

> PSU 只有一個 I2C 通常都會接BMC上的 I2C0

> BMC 上會有很多的I2C (依照 chip)


#### brian's al dupont lines  ####
![2](./pic/I2C_bus_recovery_brianlove.jpg)

至於接法 要看電路圖
我依照 6102的例子來寫

會有4個(因為要讓 BMC 被stroke 設備來 執行 所以 要知道 SDA CLK GND VCC **這個是 I2C的基礎喔!!!**)
![connect_de](./pic/I2C_bus_recovery_connect.jpg)

這裡我是依照 brian's al dupont lines 的紅色來看(反正不是CLK 就是 SDA)

# result #
-------------------------------------------------------------------------------
在 OT004 中 你會看到 LED 指示燈
[OT004 detail](https://hackmd.io/@Josh-cpld/rk804uz2F)

## OT004 ##
有三種行為
+ 閃爍綠燈 --(nowork)
+ 恆亮橘燈 --(keep low)
+ 閃爍橘燈 --(done)


都接好後 把BMC 打開

當一開始 OT004 --> 閃爍綠燈

然後OT004 會拉住 I2C --> 恆亮橘燈

I2C recovery function success --> 閃爍橘燈

我測試 很快 所以都會直接拉住 --> I2C recovery function success