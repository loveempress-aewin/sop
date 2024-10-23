-------------------------------------------------------------------------------
created	:	Mon Oct 14 21:22:07 CST 2024

created	:	Tue Oct 15 17:49:38 CST 2024

date	:	Mon Oct 21 13:55:15 CST 2024

[[project]]
[[1945]]
[[C-enum]]
[[C-uint8_t]]

-------------------------------------------------------------------------------

#  omg == #
一開始被這個搞暈
想說 MALO 仔寫甚麼....
`/mnt/AEWIN/codebase/malo/ast2600evb/packages/common/packages/libAEWIN-src/data/device/fan_closeloop.c`
```C			================start================
    if(!(GPU_info[0].present)){
      printf("================! GPU_info[0].present================\n\n");
    }else{
      printf("if ! else\n\n");
    }
    if(!(GPU_info[1].present)){
        printf("================ GPU_info[1].p================\n\n");
      }else{
      printf("[1] else = =||| \n\n");
    }
```
影片一直可以直接馬....
我可是要去google...
> if(a)		: a 非0 => ture
> if(!a)	: a ==0 => ture
> [ref](https://blog.csdn.net/weixin_44153896/article/details/108217579)
>> 在C語言中，任何非零和非空的值都被視為真[important](https://docs.pingcode.com/ask/304664.html)

以上是基於C的理論 再來需要用 硬體設備的角度來看這個部分
用示波器來看過 - 如果

# define-GPIO-0-PRESENT-PIN #
`/mnt/AEWIN/codebase/malo/ast2600evb/packages/common/packages/libAEWIN-src/data/device/fan_closeloop.c`
```C			================start================
////first find this part
ret = gpio_read_data(GPU_0_PRESENT_PIN, &data);
```
筆者用 vscode 直接 `Ctrl-Alt-left` 點及 `GPU_0_PRESENT_PIN`

會自動jump `/mnt/AEWIN/codebase/malo/ast2600evb/packages/common/packages/libAEWIN-src/data/Include/gpio.h`
```C			================start================
// GPU card present pin         // Malo_Chou 2024-09-30 For GPU card present pin
#define GPU_0_PRESENT_PIN   GPIO_('U', 3)
#define GPU_1_PRESENT_PIN   GPIO_('U', 5)
////[ref](2024-10-04 Malo_GPU Fan 講解  -- 10:19)
```
```C			================start================
#define GPIO_(group, number) ((group - 'A') * 8 + number)
////筆者在這裡會遇到問題 筆者會放一個 gpio table (form john)
////####TODO
```


#  conflic-by-same-GPIO #
####TODO-- peter
一開始遇到的問題是


#  two-gpio-present-pin-0error-1ok #
這裡的問題是
####TODO

# track-code-same-function-call #
```C			================start================
        ret = gpio_read_data(GPU_1_PRESENT_PIN, &data);			// Reading GPU1 is pluged or not
```

```C			================start================
//// /packages/common/packages/libAEWIN-src/data/Include/gpio.h
// GPU card present pin         // Malo_Chou 2024-09-30 For GPU card present pin
#define GPU_0_PRESENT_PIN   GPIO_('U', 3)
#define GPU_1_PRESENT_PIN   GPIO_('U', 5)
```

```C			================start================
| 1                                        | 2 | 3 | 4 |
|------------------------------------------|---|---|---|
| gpio_read_data //fan_sloseloop.c         |   |   |   |
| ret=gpio_fn_r_data(&gpio_info) // gpio.c |   |   |   |
| if( NULL != GPIO_FN[GPIO_FN_R_DATA])     |   |   |   |
|
```

# array-factory #
陣列元素

每個陣列元素都是一個結構體，包含兩個欄位：

+ 函數識別碼：一個常數，用於識別特定的 GPIO 函數。
例如，可能有不同的識別碼來表示設置 GPIO 方向為輸入或輸出，讀取 GPIO 資料等操作。

+ 函數名稱：一個字串，表示函數的名稱。
這個名稱通常是對應於函數識別碼的具體操作名稱，例如 “set_gpio_dir_input” 表示設置 GPIO 方向為輸入。

```
FN_MAP GPIO_FN_MAP[] =
{
    {GPIO_FN_W_DIR_IN,    "set_gpio_dir_input"},
    {GPIO_FN_W_DIR_OUT,   "set_gpio_dir_output"},
    {GPIO_FN_R_DIR,       "get_gpio_dir"},
    {GPIO_FN_W_DATA_LOW,  "set_gpio_data_low"},
    {GPIO_FN_W_DATA_HIGH, "set_gpio_data_high"},
    {GPIO_FN_R_DATA,      "get_gpio_data"}
};
```

## GPU-present-pin-error ##
這個坑真的太大了....我就娓娓來說明
一開始是以為硬體slot 有問題
*因為當時有GPU CARD*
但是就是認不到
但是當我把 `GPU_0` and `GPU_1`
code snip change 就是前面那段code 認不到

### GPU-code-change-location ###
```C			================start================
		GPU_info[0] = gpio_read_data(GPU_0_PRESENT_PIN, &data);
		GPU_info[1] = gpio_read_data(GPU_1_PRESENT_PIN, &data);
        //// Don’t worry, this is the wrong code
```
```C			================start================
    static int gpu_count = 0 ;
    static int ret = 0;		// check if the code correct execute
    //// do while --> 是PE大帝說要用try-catch
    do{
		ret = gpio_read_data(GPU_0_PRESENT_PIN, &data);
		gpu_count++;
		printf("================gpio_0_PRESENT  [ %d ]  count================\n(%d)\n",gpu_count,data); //lovelovequeen_dev
		//printf("\ngpio_0_present_ret : [ %d ] \n\n",ret);												//lovelovequeen_dev
		sleep(3);				//我自己加的時間 --> 但是john 說不好 但是我還是持續用
		if(gpu_count > 15 ) break;	// loveempress -- because i test it's need 8 times get  GPU_0_PRESENT_PIN ####TODO
    }while(0 != ret );
	/* if (0 == data) ? GPU_info[0].present = 1 : GPU_info[0].present = 0; */
    if(0 == data){
        GPU_info[0].present = 0;
    }else{
        GPU_info[0].present = 1;
    }

	data = 1;
    gpu_count = 0;

    do{
        ret = gpio_read_data(GPU_1_PRESENT_PIN, &data);			// Reading GPU1 is pluged or not
        gpu_count++;
        printf("================gpio_1_PRESENT  [ %d ]  count================\n(%d)\n",gpu_count,data); //lovelovequeen_dev
        sleep(3);
        if(gpu_count > 5 ) break;
    }while(0 != ret);
	/* if (0 == data)? GPU_info[1].present = 1 : GPU_info[1].present = 0; */
    if(0 == data){
        GPU_info[1].present = 0;
    }else{
        GPU_info[1].present = 1;
    }
```

### hardware-GPU-present-pin  ###
首先 code 是用上面那個 這裡要說明

`ret` => 全部都是 function return
所以 `ret == 0 ` 代表有

## track-code ##


