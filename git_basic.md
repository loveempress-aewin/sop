-------------------------------------------------------------------------------
created	:	.

date	:	Wed Jan  8 09:19:35 CST 2025

[[git]]
[[basic]]
[look_web](http://sd20-server.aewin.com:3000/SgJLrgSHS-yIw2jycGpl6w?both)
[redir]

-------------------------------------------------------------------------------
# git

## git main function
```
+ **分散式版本庫**
+ git最為出色的是它的**合併追蹤**（merge tracing）
+ git本身關心檔案的整體性是否有改變
    - 多數的版本控制系統如CVS或Subversion系統則在乎檔案內容的差異
+ git是用C語言開發的
+ git自動完成垃圾回收
    + 也可以用命令`git gc --prune` 直接呼叫。
```

---

## git object index 有兩種資料結構：
1. 物件
保存版本庫中所有檔案與版本紀錄
2. 索引
保存當下要進版本庫之前的目錄狀態

---

### git working directory staging area repository 工作區、暫存區與儲存庫


![](https://hackmd.io/_uploads/BJ2OvQCG6.png)

---

![](https://hackmd.io/_uploads/SJBVbtwfp.png)




---

### type of object 物件的類型

再git 中
**物件** 是一種 **"不可變"** 的 (immutable) 檔案類型
無論 blob 物件與 tree 物件，這些都算是物件，
這些物件都會儲存在一個所謂的「物件儲存區」 (object storage) 之中
而這個「物件儲存區」預設就在「儲存庫」的 objects 目錄下

---

## blob tree commit tag
對象資料庫包含4類對象
+ blob
+ tree
+ commit
+ tag

---

![](https://hackmd.io/_uploads/HyOgfFDMp.png)

---

## blob
#### （二進位大型物件） 檔案的 **"內容"**
`git add` => 立刻被寫入成為 blob 物件
檔名則是物件內容的雜湊運算結果
- exclude
    - 檔案時間
    - 原本的檔名或檔案的其他資訊
都會儲存在其他類型的物件裡 (也就是 tree 物件)
Blobs沒有儲存檔名、時間戳或其他後設資料

---

## tree
特定目錄下的所有資訊
+ include
    + 目錄下的檔名
    + 對應的 blob 物件名稱
    + 檔案連結(symbolic link)
    + 其他 tree 物件

---

## commit
對象連結tree對象在一起而成為history

---

## tag
對象是一個容器

所以 git 就是把 content 拿出來 用這樣的方式 找到
> 註: 由於 tree 的概念跟 directory 很像，所以在看國外原文時，working directory 也經常被寫成 working tree

---

# BLOB

---

## blob關於物件
特別的檔案檔案的內容中取出，透過內容產生一組 SHA1 雜湊值
```bash
#{
(master)   130 cat test.txt
     1  V1
     2  0000
     3          1111 (TAB)
     4  0000
     5    123123     (space)
     6  coder spilt 2 => 1. TAB coder     2. space coder
     7  which is you ?
     8
     9  special :
    10
    11
    12  你們應該看不到
#}
```

---


你看出來了嗎? 如果我沒有寫後面的 tab space 你知道嗎? XDDD
還有沒有看到
3 5
10 11 你看得到? XDD

---

```bash
#{
(master)   132 cat -An test.txt
     1  V1$
     2  0000$
     3  ^I1111 (TAB)$
     4  0000$
     5    123123     (space)$
     6  coder spilt 2 => 1. TAB coder     2. space coder$
     7  which is you ?$
     8  $
     9  special :$
    10  ^M$
    11  ^V$
    12  M-dM-=M- M-eM-^@M-^QM-fM-^GM-^IM-hM-)M-2M-gM-^\M-^KM-dM-8M-^MM-eM-^HM-0$
#}
```

---

10 11L 我用特殊方法寫入
所以 在 把它赤裸裸給你看

> 拜託在這個虛假的世界 誰可以那麼赤裸阿? (???

---

#### create manually blob 手動建立 blob 物件
再來我們來點美麗的東西
程式女神說 我們來看看 blob => output 40 checksum hash (by SHA-1 )

```bash
#{
   34 echo "love me " |git hash-object --stdin
1be2a9659f7d9c10ebf8b1fb8f7e79d6d4e723f3

   35 echo "love me 0" |git hash-object --stdin
791bd3d41af9382fe92cd75c23a7e1d026bbabb0

   36 echo " " |git hash-object --stdin
8d1c8b69c3fce7bea45c73efd06983e3c419a92f

   37 echo "" |git hash-object -w --stdin
8b137891791fe96927ad78e64b0aad7bded08bdc
#}
```

---


(`-w` 將物件寫入至物件資料庫 (也就是 目錄內))
`--stdin`

(從 stdin "Standard input 標準輸入" 讀取內容
若不用此 option， 指令預設會從檔案中讀取，
(有點像 linux bash or zsh 的用法  天阿好喜歡 (✿◕‿◕✿) )
EX：git hash-object  <filename\>

底層指令 將資料儲存至 目錄中，並獲得對應的 key （也就是物件名稱，或稱 SHA-1 值）

---

##### when-git-add-and-auto-generator-a-blob

如果`git add `後
就像我前面說的  **[對象資料庫包含4類對象]** 的第一項
有說道 如果你git add 會產生 一個 blob

---

##### 2-commit tree blob add我還是想要說一下 commit tree blob add 的關係
(很像因果關係 我們來看一下 git flow)
到底在亂取甚麼拉XDD

```bash
#{
(master)   174 status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        test.txt

nothing added to commit but untracked files present (use "git add" to track)

(master)   175 git add test.txt

(master)   176 tree .git/objects/
.git/objects/
├── 6a
│   └── 9863a77dfde316266822dae98325c67f888592
├── info
└── pack

4 directories, 1 file

 (master)   177 git commit -m "test.txt"
[master (root-commit) 83627a9] test.txt
 1 file changed, 13 insertions(+)
 create mode 100644 test.txt

 (master)   178 tree .git/objects/
.git/objects/
├── 6a
│   └── 9863a77dfde316266822dae98325c67f888592
├── 83
│   └── 627a919886ecf6c2bf91f034262cb49094f793
├── cc
│   └── 189acf6527f3f1303269f64607b8749d7022b6
├── info
└── pack

6 directories, 3 files
#}
```

---

這裡就是有一個檔案 給他add後 立馬產生 6a9863a77dfde316266822dae98325c67f888592
</br>
然後 前2碼 =>  directory name

---

### 1 tree 第1次看tree-object 物件

這裡我們看一下 commit 後的 tree 與 blob!!
```bash
{#
(master)   179 git cat-file -p master
tree cc189acf6527f3f1303269f64607b8749d7022b6
author love_ferry_queen <lovescv26@gmail.com> 1697778707 +0800
committer love_ferry_queen <lovescv26@gmail.com> 1697778707 +0800

test.txt
#}
```
這裡有沒有發現  我們知道我們最近的 commit
有一個 **tree 物件**
然後如果看tree 裡面有甚麼
很簡單  在一次就好
一樣的指令

---

```bash
{#
(master)   180 git cat-file -p cc189acf6527f3f1303269f64607b8749d7022b6
100644 blob 6a9863a77dfde316266822dae98325c67f888592    test.txt
#}
```
看到了 裡面有一個 blob (✿◕‿◕✿)(✿◕‿◕✿)

---

#### copy same content file 如果我複製1份呢?
```bash
#{
(master)   181 cp test.txt cp_test.txt
'test.txt' -> 'cp_test.txt'

(master)   182 git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        cp_test.txt

nothing added to commit but untracked files present (use "git add" to track)

(master)   184 git add .

(master)   185 status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   cp_test.txt

(master)   186 tree .git/objects/
.git/objects/
├──'6a
│   └── 9863a77dfde316266822dae98325c67f888592          '
├── 83
│   └── 627a919886ecf6c2bf91f034262cb49094f793
├── cc
│   └── 189acf6527f3f1303269f64607b8749d7022b6
├── info
└── pack

6 directories, 3 files}
#}
```
你看這裡 因為我檔案內容一樣 所以!
當你 `git add ` 就不會產生 blob (因為已經有了 (✿◕‿◕✿))

---

```bash
#{
(master)   187 git commit -m "add cp_test.txt"
[master 6d8e535] add cp_test.txt
 1 file changed, 13 insertions(+)
 create mode 100644 cp_test.txt

(master)   188 tree .git/objects/
.git/objects/
├── 6a
│   └── 9863a77dfde316266822dae98325c67f888592
├── 6d
│   └── 8e53513fa4104de7dc22c7b7d572e5be1be885
├── 83
│   └── 627a919886ecf6c2bf91f034262cb49094f793
├── ae
│   └── be03ecfaf763b66eac884d8269f18c0ca3fe8c
├── cc
│   └── 189acf6527f3f1303269f64607b8749d7022b6
├── info
└── pack

8 directories, 5 files}
#}
```

---

所以當你commit 後 就有東西了喔!!!</br>
你看到了嗎?</br>
那我們繼續

---

###  2 tree 第2次看 tree-object 物件
看一下 現在的 tree 物件 (第2次 commit)
```bash
#{
(master)   189 git cat-file -p master
tree aebe03ecfaf763b66eac884d8269f18c0ca3fe8c
parent 83627a919886ecf6c2bf91f034262cb49094f793
author love_ferry_queen <lovescv26@gmail.com> 1697778920 +0800
committer love_ferry_queen <lovescv26@gmail.com> 1697778920 +0800

add cp_test.txt
#}
```

```bash
#{
(master)   190 git cat-file -p aebe03ecfaf763b66eac884d8269f18c0ca3fe8c
100644 blob 6a9863a77dfde316266822dae98325c67f888592    cp_test.txt
100644 blob 6a9863a77dfde316266822dae98325c67f888592    test.txt
#}
```

---

好了 有發現不一樣嗎? 請比較我前面說的這裡很清楚了嗎?
因為 不同的tree物件 裡面就有 不同的blob 物件得到
+ 每一次 commit => 就會有 tree
+ tree => include diff blob or tree

---

![](https://hackmd.io/_uploads/ByvaAYdMa.png)

---

1. index 可變的索引（index、stage或cache）
用於緩衝工作目錄資訊
2. next commit version infomation 下一次提交的版本資訊
不變的、僅追加的對象資料庫。

---

### cat blob 看一下 blob 是甚麼好了

```bash
#{
'(master)   139' cat .git/objects/c0/8440ea75d4df7b6d757b9194262ea02d33b1db
xK¤¤OR0413¤2.NC Pq((h$&¤jr%秤)d¤()¤¤)¤)¤(@¤A*¤¤¤@¤!¤¤¤¤
                                                       ¤¤b¤¤¤R{.¤¤¤¤¤¤+.^.1¤'{<m¤¤¤¤¤¤¤M¤¤t?¤¤¤¤c¤:0¤

'(master)   141' stddikol .git/objects/c0/8440ea75d4df7b6d757b9194262ea02d33b1db
.git/objects/c0/8440ea75d4df7b6d757b9194262ea02d33b1db: zlib compressed data}
#}
```

---

## 1.3 開始 - Git 基礎要點
### 記錄檔案快照，而不是差異
為了講求效率，只要檔案沒有變更，Git 不會再度儲存該檔案</br>

---

### Git 能檢查完整性
機制稱為 SHA-1 雜湊演算法</br>
一個校驗碼是由 40 個 16 進位的字母（0–9 和 a–f）所組成，Git 會根據檔案的內容和資料夾的結構來計算

每個檔案都是用其 *內容的校驗碼來儲存*，而不是使用檔名

---

## git three states
##### 三種狀態
檔案標記為三種主要的狀態：
1. committed(已提交)
存在你的本地端資料庫
2. modified(已修改)
被修改
3. staged(已預存)
將會被存到下次你 **提交**

---


repository .git(預存區及 Git 資料夾)
有時它會稱為索引「index」，但現在更常被稱呼為預存區。
(我都說 暫存區{暫存區域}拉XD)

---

![](https://hackmd.io/_uploads/rJoFVtnGT.png)

---

![](https://hackmd.io/_uploads/BkTx4JYGa.png)


---

#### 30 天精通 Git 版本控管
> 「錯誤的使用方式」比「不會用」還可怕！說穿了，就是你必須先建立一套思維模式(Mindset)

我真的喜歡寫得好的文章 就向這篇... OS 概要的人寫的我看不懂...==
 就像本宮當時 用git自己開發 做錯 還把系統用到炸掉...
~~我可以從coding女神 轉職當 系統炸裂者了....~~
 (╬▔皿▔)╯

---

+ 了解 Git 屬於「分散式版本控管」，每個人都有一份完整的儲存庫(Repository)，所以必須經常合併檔案
+ 使用 Git 的時候，分支與合併是常態，但只要有合併，就會有衝突，要學會如何解決衝突

---

## index 關於索引 07
「索引」曾經出現過很多別名，但其意思都是相同的
+ Index (索引)
+ Cache (快取)
+ Directory cache (目錄快取)
+ Current directory cache (當前目錄快取)
+ Staging area (等待被 commit 的地方)
+ Staged files (等待被 commit 的檔案)
舉個例子來說，指令 `git diff --cached` 就與 `git diff --staged` 是完全同義的。

---

## git status
取得 工作目錄 (working tree) 下的狀態
儲存庫、工作目錄、物件與索引之間的關係，我們用一句話說明這關係：
Git 儲存庫的運作，是將工作目錄裡的變化，透過更新索引的方式，將資料寫入成 Git 物件。

---

## git add
目前「工作目錄」的變更寫入到「索引檔」
如果確定沒有新的file

`git add -u`

則可以僅將「更新」或「刪除」的檔案變更寫入到索引檔

---

## git rm
`git rm filename`
- 更新索引檔
- 工作目錄下的檔案也會一併被刪除

剛開始用git 的時候 我還記得 因為我會一點點 cli
所以當時就很開心的 打下 git rm *
~~系統炸裂者認證...（；´д｀）ゞ~~
OK 然後當時我還 剛git 新手呢
所以...有多 surprise

---

## git commit
index 與目前最新版 => diff</br>
差異部分 => commit 物件

---

## git ls-files
+ 目前commit上 (git的小孩有誰) 的檔案
+ `git add` 更新索引檔後的那些檔案
```bash
(add)    7 $ git ls-files
a.txt
b.txt
c.txt
jp.txt

(add) 6 $ git log
* a5dfaf3 (HEAD -> add)  +c.txt
* 09adb7f jp.txt
* 5d827b0  up => a.txt
* 17b21be up => jp
* 9bd9ec9  up => chi
* 9412f60  +b.txt
* a388399 update a.txt
* bfbfe43 Initial commit (a.txt created)

(add)    8 $ git switch 9412f60
Note: switching to '9412f60'.

((9412f60...))
(add)    9 $ git ls-files
a.txt
b.txt

```

---

# HEAD
對我來說 我覺得
他就像 船的 **錨**
就是 設計網頁 錨點
~~我是海邊那盞一坪的海岸線~~
> HEAD 只會有1個  就像你的影子 你在哪他就在

~~這樣不離不棄真好?~~

---

## branch
分支是給自己一個自己的世界
可以任意修改 就是給你完成後 還是要 **合併**

---

> 就像洛希極限（Roche limit）
>> 任何事物 剛剛好最好 ╰(*°▽°*)╯
>>> 意思是 不要給我無限branch

~~就像是女人的東西很多 所以 不能一直分支下去!!! (???)~~

---

當分支之後 ,
是有人跟你一樣修改到相同檔案的相同一行時
就會引發 **"版本衝突"**
協調出彼此的變更</br>
最後決定要怎樣合併

---

諸如此類的問題非常繁瑣，也因此很多人會盡力避免「分支」的情況發生，以免發生「衝突」。
但如果 開發團隊越來越大，系統功能越來越多
就算你說不要分支 那就可能會被直接蓋掉...
> 那不就是 治標不治本?
所以壓 這個狀態就是一種 </br>
無形的衝突
> 天啊 名字好美 (✿◕‿◕✿)

---

## git branch 建立分支
```bash
#{
git branch [branchname]
EX:
git branch fix-bug
git branch loveme
            ...etc
#}
```

---

## 看all branch
```bash
#{
先看看 你用的分支
git branch

(master)   68 #git branch
  fix-bug
  loveme
* master    <=== U in this branch
#}
```
![](https://hackmd.io/_uploads/ryXPRFwza.png)

---

## delete branch
`git branch -d [branchname]`
這裡我要做兩種
1. 心如止水的       branch
2. 已經動了凡心的   branch

---

##### 心如止水的       branch
```bash
#{
心如止水 branch

(master)   77# branch -d fix-bug
Deleted branch fix-bug (was 44d092e).
#}
```
![](https://hackmd.io/_uploads/H1O2k5PMp.png)

---

```bash
#{
動了凡心的
#echo "lovemehard" > loveme.txt
#git add .
#git commit "+ loveme.txt"
real    0m0.040s
user    0m0.000s
sys     0m0.000s
[loveme 03a9782] +add loveme.txt
 1 file changed, 1 insertion(+)
 create mode 100644 loveme.txt
(master)   79# branch -d loveme
error: The branch 'loveme' is not fully merged.
If you are sure you want to delete it, run 'git branch -D loveme'.
#}
```
![](https://hackmd.io/_uploads/S1gxl9PGp.png)

---

所以你看到了嗎? 他寫得很清楚 meaning:</br>
他說這個 分支沒有 **被 合併** </br>
所以你要合併 OR 你真的要果斷刪掉 就要用 -D
>  程式女神小小提示一下 </br>
> 在git 中 大寫通常是有 **強制性** </br>
> 所以 如果要用大寫 要小心

---


## checkout
checkout 有3大功能
1. 切換分支
`git checkout <branchname>`
2. restory file
`git checkout <filename>`
3. 回到過去的版本 (回到特定的時間點才對)
`git checkout <"SH1 6 code">`

---

## switch working directory
### 工作目錄切換到新的分支
```bash
#{
git checkout [branchname]
git checkout loveme

(master)   69# git checkout loveme
Switched to branch 'loveme'
#}
```

![](https://hackmd.io/_uploads/SkcxGqvz6.png)

---

## git switch [branchname]
##### 但是我比較想用 switch
`git switch loveme`

---

## restore file

---

### git chekcout filename
恢復檔案 也用你 checkout??
(修改錯檔案 來把 找小git幫忙)
`git checkout <filename>`
總要有 Example 吧

```bash
#{
(master)   227$ cat test1.txt
test1

(master)   228$ nano test1.txt

(master)   $ cat test1.txt
test1

I LOVE U!!!
PLZ
LOVE me hard!!!!!
(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)(✿◕‿◕✿)

(master)   $ git checkout test1.txt
Updated 1 path from the index

(master)   $ cat test1.txt
test1

#}
```

---

## git restroe
#### 回朔 也可以用 restore
`git restore <filename>`
不知道有沒有人問我 幹嘛要
我喜歡 功能的明確 </br>
我們舉個例子 用極端一點
假設你會通靈 OR 你用SHA1算出git 的 代表
OR 你是一個很強大的工程師
可以瘋狂寫BUG 完美的寫BUG
怎麼寫都是BUG

---

![](https://hackmd.io/_uploads/Hky5e4CMp.png)

---

![](https://hackmd.io/_uploads/H1dqxEAGp.png)

---

```bash!
git checkout 1949341
```

意義愈多 愈方便 沒錯
但不可否認 同時 也會有 衝突
便利性 與 安全性 穩定性 始終如同 光和影

![](https://hackmd.io/_uploads/r1FKGNRzp.png)

---

## git log
看你commit 的 紀錄

```bash
#{
(master)   5$ git log
commit 9997ae249f6f087845bb0a12925a6be417d6df7f (HEAD -> master)
Merge: 44d092e 03a9782
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Thu Oct 19 17:35:09 2023 +0800

    Merge branch 'loveme'

commit 03a97821f1ae0b7914a9f2508be675c57feedae7 (loveme)
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Thu Oct 19 16:38:30 2023 +0800

    +add loveme.txt

commit 44d092e08b7c4c9cce3cad3b2172f28f4b972497
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Thu Oct 19 15:26:05 2023 +0800

    Revert " +aa1 filei  OK revert 1"

    This reverts commit 20097e211e81b27d66525cdce0b85924371fd2ae.

commit 8fd27ca3f33fc5ab3a301cffd64fa81938dc9ff1
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Thu Oct 19 15:25:32 2023 +0800

    +test2.txt

commit 20097e211e81b27d66525cdce0b85924371fd2ae
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Thu Oct 19 13:07:43 2023 +0800

     +aa1 file
new |
    |
    |
    V(old)
#}
```

---

你不覺得有點難看嗎?
那看看 `git log --oneline`

![](https://hackmd.io/_uploads/B1GjV5vGp.png)

如果很多你要有點美感的話
那就用

---

## beautiful git log
`
git log --decorate --oneline --graph
`
```bash
#{
(master)   11$ git log --all --decorate --oneline --graph
*   9997ae2 (HEAD -> master) Merge branch 'loveme'
|\
| * 03a9782 (loveme) +add loveme.txt
|/
* 44d092e Revert " +aa1 filei  OK revert 1"
* 8fd27ca +test2.txt
* 20097e2  +aa1 file
#}
```

---

## git show
可以看 那次 提交有甚麼詳細內容

```bash
#{
(master)   8$ git show 9997ae2
commit 9997ae249f6f087845bb0a12925a6be417d6df7f (HEAD -> master)
Merge: 44d092e 03a9782
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Thu Oct 19 17:35:09 2023 +0800

    Merge branch 'loveme'

(master)   10$ git show 20097e2
commit 20097e211e81b27d66525cdce0b85924371fd2ae
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Thu Oct 19 13:07:43 2023 +0800

     +aa1 file

diff --git a/aa1.txt b/aa1.txt
new file mode 100644
index 0000000..5244d1c
--- /dev/null
+++ b/aa1.txt
@@ -0,0 +1 @@
+aa1
#}
```

---

## git diff
compare two

---

### git diff 4 type 四種基本的比較方式
1. git diff
2. git diff commit
3. git diff --cached commit
4. git diff commit1 commit2

---

1. 先執行 git log 取得版本資訊 => commit 物件的 id

---

![](https://hackmd.io/_uploads/SJger9vMT.png)

---

所以得到
git diff commit 1 commit2
commit2 (new 比較好)
> git diff commit 1 commit2
>> commit2 (new 比較好)

---

每一個 commit 物件都會包括一個根目錄的 tree 物件
其實比對的是 commit 物件下的那個 tree 物件

---

![](https://hackmd.io/_uploads/H1tUr9df6.png)



---

#### git diff
工作目錄  索引

![](https://hackmd.io/_uploads/BJPWYE0G6.png)

---

![](https://hackmd.io/_uploads/SJ8vkHCfT.png)

---

#### git diff commit
+ 工作目錄
+ 指定 commit 物件裡的那個 tree 物件
最常用的指令是 `git diff HEAD`

---

##### compare git diff vs git diff commit


這裡可以看到  有1個檔案 我修改
1個檔案  git add =>  staging area
1個 給他當牡蠣
所以 我在跟改一次

```bash
#{{{
 (master)    107 $ status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   1.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        math-1.c
        math-2.c

no changes added to commit (use "git add" and/or "git commit -a")
#}}}
```

---

![](https://hackmd.io/_uploads/S1_6mrRG6.png)

---

我特地把

1.txt   (repository)
</br>
math-1.c    (staging area)
</br>
math-2.c            (working directroy)

---

![](https://hackmd.io/_uploads/rkMs0VAMT.png)

他只比 1.txt

---

![](https://hackmd.io/_uploads/SyEpRV0Mp.png)

看到了嗎!!!!
他沒有比 math-2.c (working directory)

---


#### git diff --cached commit

![](https://hackmd.io/_uploads/S1ejXkSCGp.png)

比了 math-1

---

> `git diff --cached == git diff --staged `
>> staged 是 cached 的別名

> `git diff cached == git deff --cached HEAD`


---

![](https://hackmd.io/_uploads/SJ8vkHCfT.png)

---

在上面 都對 起碼 但是卻我女人的直覺就是覺得怪怪的

仔細一想! 不對呀 那 我 git diff --cached 放哪?

---

![](https://hackmd.io/_uploads/HJnhjB0zT.png)


---

當我覺得 我遇到BUG了
腦袋在燃燒 我很開心又痛苦
花了  11min 31 秒
我查到了!!!!!


---

![](https://hackmd.io/_uploads/SkVdDSRG6.png)
[好厲害](https://stackoverflow.com/questions/3686452/what-are-the-differences-between-these-git-diff-commands)

---

V1 but need to fix

![](https://hackmd.io/_uploads/rJHtvBAz6.png)

---

V2 but need to fix

![](https://hackmd.io/_uploads/S1Gdy8AGa.png)


---

V3

![](https://hackmd.io/_uploads/HkVwV2AM6.png)

---

V4

![](https://hackmd.io/_uploads/rJXD83Azp.png)

---

V5

![](https://hackmd.io/_uploads/By1CK2RM6.png)


---

![](https://hackmd.io/_uploads/SkJoBh0zp.png)


---

![](https://hackmd.io/_uploads/B1ATGrRMp.png)

---


### 認識 Git 物件的絕對名稱
每一個版本就代表一個 commit 物件
```bash
#{{{
 (master)    135 $ git log
commit a23ccb412cc369f312850592790e09c9538dc40d (HEAD -> master)
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Mon Oct 23 13:51:39 2023 +0800

    m math.c and + math 3

commit 35da1dddf4c59015509a133d194eae5c7371eb18
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Mon Oct 23 13:50:18 2023 +0800

    + math 1 2

commit 6abb34dadae168074809671c2d89116e2bc4d657
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Mon Oct 23 11:13:39 2023 +0800

     有點亂! 在一次看看
(下面舊的 skip)
#}}}
```

---

## git cat-file
如果我們想看如上圖 commit 物件的內容
`git cat-file -p commit-id`

```bash
#{{{
 (master)    136 $ git cat-file -p a23ccb4
tree 6d3cbca2a94d52e6eb6c3812766ec500e2def7e5
parent 35da1dddf4c59015509a133d194eae5c7371eb18
author love_ferry_queen <lovescv26@gmail.com> 1698040299 +0800
committer love_ferry_queen <lovescv26@gmail.com> 1698040299 +0800

m math.c and + math 3
#}}}
```
and go on

---

`git cat-file -p tree-id`
```bash
#{{{
 (master)    137 $ git cat-file -p 6d3cbca2a9
100644 blob 5d43bb4ea1eaa2267188d615efdf379f453b25ff    add.txt
100644 blob b4a638cfcc1212b1a3037c393737bf8bc56e76d9    add_dy.js
100644 blob 3f75a1ace4a9f82b70ab5572144f2a60deab2122    fix.c
100644 blob f30f90c5954329bf957462093f48974bd254f447    fixbug.c
100644 blob 72efeb66bba0c19c9668bb44af0007a0c38eb04f    hello.c
100644 blob 9f31f6e9010237792fca2ece698e7ec07fdb9e6c    math-1.c
100644 blob 141284d7b2329dc375f7589ca3602cf90f46cf36    math-2.c
100644 blob 9f31f6e9010237792fca2ece698e7ec07fdb9e6c    math-3.c
100644 blob 7454e02198275d147b9dade4813fcec786820404    math.c
100644 blob cdb5f04f10c21998fd7406f7e8ceafd2035d83e2    readme.md
100644 blob a5bce3fd2565d8f458555a0c6f42d0504a848bd5    test1.txt
#}}}
```

---

###### git ref 第 11 天：認識 Git 物件的一般參照與符號參照

參照名稱 (ref) 簡單來說就是 Git 物件的一個「指標」
像  HEAD ~~(代表最新版本)~~(應該說你在哪裡才對 因為最新是時間的概念)
```bash
 156 $ git branch
  add
  fix
* master

 157 $ ls -al .git/refs/heads/
total 3.0K
drwxr-xr-x 1 cxc cxc  0 Oct 23 14:40 ./
drwxr-xr-x 1 cxc cxc  0 Oct 20 16:32 ../
-rw-r--r-- 1 cxc cxc 41 Oct 23 14:33 add
-rw-r--r-- 1 cxc cxc 41 Oct 23 14:40 fix
-rw-r--r-- 1 cxc cxc 41 Oct 23 13:51 master
```
證明~~

---

step 1: swtich a new branch
step 2: edit new file and commit => respository
```bash
#{{{
 (add)    163 $ cat .git/refs/heads/add
fcbb3ccdf5845390111495ba27d6fc8cf8f53150
#}}}
```

---

所以我們就會知道
refs/heads/add == heads/add == add

![](https://hackmd.io/_uploads/r1G5FcPza.png)

---

## about .git/refs/directory
+ 本地分支  :   `.git/refs/heads/`
+ 遠端分支  :   `.git/refs/remotes/`
+ 標籤      :   `.git/refs/tags/`

---

#### git will search in the following order
預設 Git 會**依照以下順序**搜尋適當的參照名稱，只要找到對應的檔案，就會立刻回傳該檔案內容的「物件絕對名稱」

```bash!
.git/<參照簡稱>
.git/refs/<參照簡稱>
.git/refs/tags/<參照簡稱;標籤名稱>
.git/refs/heads/<參照簡稱;本地分支名稱>
.git/refs/remotes/<參照簡稱>
.git/refs/remotes/<參照簡稱;遠端分支名稱>/HEAD
```

---

### symref (符號參照名稱)
+ HEAD
    + 工作目錄 => 分支 => 最新版
    + 執行 git commit 後 => update commit
+ ORIG_HEAD
    + HEAD 這個 commit 物件前一版

---

+ FETCH_HEAD
    + 遠端儲存庫 可能會使用 git fetch 指令取回所有遠端儲存庫的物件。這個 FETCH_HEAD 符號參考則會記錄遠端儲存庫中每個分支的 HEAD (最新版) 的絕對名稱
+ MERGE_HEAD
    + 執行合併 => 「合併來源｣的 commit 物件絕對名稱會被記錄

---

### conclude for ref
參照名稱 (ref) <==> Git 物件的一個"指標"
> 所以你可以把「參照名稱」想像成 Git 物件絕對名稱的別名 (Alias)

---

### ref two part
1. 符號參照
    + 符號參照 => 一般參照
2. 一般參照
    + 一般參照 => 絕對名稱"Git 物件"




---

# git stash
系統開發寫到一半
被要求緊急修正一個現有系統的 Bug 或添加一個功能

---

+ new file
    + untracked files   (尚未列入追蹤)
    + tracked/staged files  (加入索引)
+ modify file / delete file
    + tracked/unstaged files    (尚未加入索引)
    + tracked/unstaged files    (加入索引)

---

#### git stash
##### 暫存版
就是把你用到一半的東西 拿掉 放到 git 的暫存區
git stash 有3種選項
1. `git stash`
A temporary version of [all tracked]() files will be created
2. `git stash -u`
All are created as temporary version
3. `git stash -a`
All file (include changes to **ignored** files)

---

> `git stash` == `git stash save`

對於我來說 我會用 save 的時候 就是用在 你要在暫存 要+上 訊息

---

## git stash list
看全部的暫存 `git stash list`
</br>
那跟我開始吧 一直理論

~~真心會睡著~~
我先建立 new file and modify a file


---

那我們開始吧!!
我們先用 `沒有參數`

![](https://hackmd.io/_uploads/B1PxVlKzp.png)

---

```bash!
$cat add-1.txt
歌えや歌え 心のままに
```

我一開始修改的文字
他給我拿掉了!!(然後放到了)
stash@{0}: WIP on master: d659aee .
然後他沒有拿新檔案

---

再用 `-u`

![](https://hackmd.io/_uploads/SkNASlYG6.png)

他把它刪了!!

---

當然!這樣講 半對而已
他只是把new-1.txt 的檔案
丟到 **暫存區**

## +名稱的暫存

---

### git stash save
```bash
   95 $  git stash save -u " 2.txt "
Saved working directory and index state On master:  2.txt

    72 $  git stash -u "test"
fatal: subcommand wasn't specified; 'push' can't be assumed due to unexpected token 'test'

    73 $ git stash save -u "test"
Saved working directory and index state On master: test

```

![](https://hackmd.io/_uploads/S1EjsqwMp.png)

---

### 存入暫存
我們test一下

```bash
#{{{
    96  git stash list
stash@{0}: On master: 2.txt
stash@{1}: On master: add-1.txt
stash@{2}: WIP on master: d5dae3b Merge branch 'fix1'

    97  echo " 在我觸及不到的遠方 " >> 4.txt

    98  git stash save -u " +4.txt"
Saved working directory and index state On master:  +4.txt
```
```bash
    99  git stash list
stash@{0}: On master: +4.txt
stash@{1}: On master: 2.txt
stash@{2}: On master: add-1.txt
stash@{3}: WIP on master: d5dae3b Merge branch 'fix1'
#}}}
```
看完後 有甚麼感覺嗎?

---

就是 stash 用的方法是


***LIFO***


![](https://hackmd.io/_uploads/rk-6s5wfp.png)

後進先出法(Last in First out,LIFO)

---

### git stash pop or apply 取出 暫存
有 2種
+ pop
    + 刪掉暫存
+ apply
    + 不會刪
我們來看看我準備好的
```bash
    99 $  git stash list
stash@{0}: On master: +4.txt
stash@{1}: On master: 2.txt
stash@{2}: On master: add-1.txt
stash@{3}: WIP on master: d5dae3b Merge branch 'fix1'
```

---

## git stash pop
```bash
#{{{
    90$  git stash pop "stash@{2}"
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   add-1.txt

no changes added to commit (use "git add" and/or "git commit -a")
Dropped stash@{1} (35a2ff00180e0997e7e49a183476a51ad5b56478)

    101$  git stash list
stash@{0}: On master: +4.txt
stash@{1}: On master: 2.txt
stash@{2}: WIP on master: d5dae3b Merge branch 'fix1'
#}}}
```

---


## git stash apply
```bash
#{{{
    101 $  git stash list
stash@{0}: On master: +4.txt
stash@{1}: On master: 2.txt
stash@{2}: WIP on master: d5dae3b Merge branch 'fix1'

    102 $  git stash apply
Already up to date.
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   add-1.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        4.txt

no changes added to commit (use "git add" and/or "git commit -a")
#}}}
    103 $  git stash list
stash@{0}: On master: +4.txt
stash@{1}: On master: 2.txt
stash@{2}: WIP on master: d5dae3b Merge branch 'fix1'

```
所以如果你是用 apply 來拿暫存
那暫存 不會消失喔

---

## git stash drop
`git stash drop "stash@{id}`
delete one


### git stash clear
delete all
`git stash clear`

---

### git config 儲存 Git 選項設定的三個地方
1. 系統層級 (   --system )
    + git config --list --system
2. 使用者層級 ( --global )
    + git config --list --global
3. 儲存區層級 ( --local  )
    + git config --list --local

---

###### 1. 系統層級 ( --system ) (System-level configuration) (設定於整台電腦，適用於本機所有使用者的預設值)
不過不好用...
所以跳過~
~~windows 有時很反人類...~~

###### 2. 使用者層級 ( --global ) (User-level configuration) (設定於目前登入的使用者)
一般來說 我們通常會把 user.name 與 user.email 選項設定在「使用者層級」

###### 3. 儲存區層級 ( --local ) (Repository-level configuration) (設定於工作目錄下的 .git\config 設定檔中)
設定檔預設 `.git\config`

---

#### git config order -- Git 選項設定的套用順序
1. system 先套用系統層級 (優先權最低)
2. global 再套用使用者層級
3. local 再套用儲存區層級 (優先權最高)

---

> 因為他是 **"再套用 "**
>> 所以他寫入設定後 如果 繼續往下寫  就把他蓋掉了
>>> 這就是一種衝突 不對 這是一種選擇  ヾ(≧▽≦*)o

---

## git config option -- 選項設定
+ 取得
```bash
git config --list
git config --list --global
git config --list --local
```

---

+ 設定
```bash
  git config [config_section.config_name] [config_value]

  git config --global user.name "lovemehard"
  git config --local user.email "love@gamil.com"
```

- 刪除
```bash
  git config --unset --global [config_section.config_name]
  git config --unset --local  [config_section.config_name]
```

---

### git alias --設定別名 (Alias)
```bash
  git config --global alias.co   checkout
  git config --global alias.ci   commit
  git config --global alias.st   status
  git config --global alias.sts  "status -s"
  git config --global alias.br   branch
  git config --global alias.re   remote
  git config --global alias.di   diff
  git config --global alias.type "cat-file -t"
  git config --global alias.dump "cat-file -p"
  git config --global alias.lo   "log --oneline"
  git config --global alias.ll "log --pretty=format:'%h %ad | %s%d [%Cgreen%an%Creset]' --graph --date=short"
```

---

### CRLF --自動辨識 CRLF 字元
CRLF 是 一種 CR + LF
~~好像廢話... windows就是很長做這樣的事情...~~
好吧 看表格

system  |   換行    |   named   |   ASCII   |
:---:   |   :---:   |   :---:   | :---:     |
windows |   \r\n    |   CRLF    |0x0D+0x0A  |
LINUX   |   \n      |   LF      |   0x0A    |
MACOS   |   \r      |   CR      |   0x0D    |

---

所以 可以知道   再windows 如果上傳
~~windows 持續反人類設計...~~

那就 把 git的選項開啟
```bash
git config --global core.autocrlf true
```

> \n 換行
</br>
> \r 回車

---

# tag
git 如果我們一直 寫下去 會產生大量的版本
滄海桑田
一定會有一些值得我們紀錄的幾個重要版本

TAG 是一種 Git 物件
前面有說到
Git 物件包含 4 種物件類型

---


+ Tag 物件會儲存在
</br>
`.git/objects/`
(default location)
+ 關聯到另一個 commit 物件
儲存到物件儲存庫中的
> Git 物件都是不變的，只有索引才是變動的

---


## tag have two type
1. 輕量標籤 (lightweight tag)
2. 標示標籤 (annotated tag)

---

### 1. lightweight tag(輕量標籤 )
*輕量標籤*可以說是某個 commit 版本的別名

是一種「相對名稱」

#### lightweight tag use way
##### git tag
(show all tag)
##### git tag [tagname]
(created tag)
##### git tag [tagname] -d
(delete tag)

---

```bash
#{{{
    162  ll .git/refs/tags/
total 0

    163  git tag

    164  ll .git/refs/tags/
total 0

    165  git tag test1

    166  git tag
test1
#}}}
```

這裡可以看到 我有tag了!!
所以也很清楚知道
他帶最新的 commit
我繼續下去了喔

---

```bash
#{{{
    167$  ll .git/refs/tags/
total 1.0K
-rw-r--r-- 1 cxc cxc 41 Oct 24 15:14 test1

    168$  cat .git/refs/tags/test1
02f06e45e56f97158744a11d13234dc12c7ac4ca

    169$  git log -4
commit 02f06e45e56f97158744a11d13234dc12c7ac4ca (HEAD -> master, tag: test1)
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Tue Oct 24 14:30:04 2023 +0800

     diff CRLF

commit f9548f70a66501d753f142ec2af266b89fa894b5
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Tue Oct 24 13:56:19 2023 +0800

     .

commit d5dae3bc0d1e86ee083f660f4ba7a329f0a02525
Merge: 2068e74 e90a855
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Tue Oct 24 10:24:07 2023 +0800

    Merge branch 'fix1'

commit 2068e746886ca8270c9b61e87e8a1f976c24c0c9
Merge: 3c7eaab 8098448
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Tue Oct 24 10:23:54 2023 +0800

    Merge branch 'add1'
#}}}
```
得到了 對吧  ヾ(≧▽≦*)o

---

### 2. annotated tag(標示標籤 )
###### `git tag [tagname] -a -m " 這裡是給你看得懂的文字"`
```bash
    180$  git tag annotated -a -m "annotated"
```
弱弱的說一下 前面的 `git commit -a -m "你的文字"` o(*≧▽≦)ツ┏━┓
`-a` 就是 說 這TAG => 是 annotated

`-m` 就像 commit

---

#### git cat-file -p [tagname]  get content
```bash
#{{{
    205  git cat-file -p test333
tree 41faed7b81a8635853a74dad80e77efe87836839
parent 9d72b431c275235b9ce87f2021e3fdb33fd63fb4
author love_ferry_queen <lovescv26@gmail.com> 1698133693 +0800
committer love_ferry_queen <lovescv26@gmail.com> 1698133693 +0800

 +test-3-test.txt

    206  git cat-file -p annotated
object 9d72b431c275235b9ce87f2021e3fdb33fd63fb4
type commit
tag annotated
tagger love_ferry_queen <lovescv26@gmail.com> 1698133388 +0800

annotated
#}}}
```

---

![](https://hackmd.io/_uploads/r1anAqvfT.png)



---

##### 小進階


![](https://hackmd.io/_uploads/BkOJ1ovza.png)

---

然後我們看看
![](https://hackmd.io/_uploads/BJXgksPfa.png)


---

# git reflog

```
#{{{
(master)    234  git reflog
42120ff (HEAD -> master, tag: test333) HEAD@{0}: reset: moving to 42120ff
02f06e4 (tag: test1, tag: test-test) HEAD@{1}: reset: moving to 02f06e4
41164ac (tag: test_revert) HEAD@{2}: revert: Revert " diff CRLF"
6845aa3 HEAD@{3}: commit: revert.txt
8c3ead9 HEAD@{4}: revert: Revert " ."
42120ff (HEAD -> master, tag: test333) HEAD@{5}: commit: +test-3-test.txt
9d72b43 (tag: annotated) HEAD@{6}: commit: +annotated-tag.txt
02f06e4 (tag: test1, tag: test-test) HEAD@{7}: commit: diff CRLF
f9548f7 HEAD@{8}: commit: .
d5dae3b HEAD@{9}: reset: moving to HEAD
d5dae3b HEAD@{10}: reset: moving to HEAD
d5dae3b HEAD@{11}: reset: moving to HEAD
d5dae3b HEAD@{12}: reset: moving to HEAD
d5dae3b HEAD@{13}: reset: moving to HEAD
d5dae3b HEAD@{14}: reset: moving to HEAD
d5dae3b HEAD@{15}: reset: moving to HEAD
d5dae3b HEAD@{16}: reset: moving to HEAD
d5dae3b HEAD@{17}: merge fix1: Merge made by the 'ort' strategy.
2068e74 HEAD@{18}: merge add1: Merge made by the 'ort' strategy.

(master)    235  echo " 16 " > 16reflog.txt &&up&&commit "+16reflog.txt"
[master 9a31e90] +16reflog.txt
 6 files changed, 2 insertions(+), 12 deletions(-)
 create mode 100644 16reflog.txt
 delete mode 100644 4.txt
 create mode 100644 revert.txt
 delete mode 100644 test-CRLF/linux-nano.txt
 delete mode 100644 test-CRLF/windows-note.txt

(master)    236  git reflog
9a31e90 (HEAD -> master) HEAD@{0}: commit: +16reflog.txt
42120ff (tag: test333) HEAD@{1}: reset: moving to 42120ff
02f06e4 (tag: test1, tag: test-test) HEAD@{2}: reset: moving to 02f06e4
41164ac (tag: test_revert) HEAD@{3}: revert: Revert " diff CRLF"
6845aa3 HEAD@{4}: commit: revert.txt
8c3ead9 HEAD@{5}: revert: Revert " ."
42120ff (tag: test333) HEAD@{6}: commit: +test-3-test.txt
9d72b43 (tag: annotated) HEAD@{7}: commit: +annotated-tag.txt
02f06e4 (tag: test1, tag: test-test) HEAD@{8}: commit: diff CRLF
f9548f7 HEAD@{9}: commit: .
d5dae3b HEAD@{10}: reset: moving to HEAD
d5dae3b HEAD@{11}: reset: moving to HEAD
d5dae3b HEAD@{12}: reset: moving to HEAD
d5dae3b HEAD@{13}: reset: moving to HEAD
#}}}
```

---

#### 紀錄版本變更的原則
改了 `ref`(參照內容)
才引發的 `log`(紀錄)

這些會更改 reflog
```
+ commit
+ checkout
+ pull
+ push
+ merge
+ reset
+ clone
+ branch
+ rebase
+ stash
```

---

## git reflog -- 顯示 reflog 的詳細版本記錄
`git reflog` 取出版本歷史紀錄的摘要資訊
`git log -g`

---

## git config for history time -- 設定歷史紀錄的過期時間
永遠不想刪除
```
git config --global gc.reflogExpire "never"
git config --global gc.reflogExpireUnreachable "never"
```
if 7day
```bash
git config --global gc.reflogExpire "7 days"
git config --global gc.reflogExpireUnreachable "7 days"
```

---

### 針對特定分支設定
master 分支只保留 14 天期
develop 分支可以保留完整記錄
```bash
git config --local gc.master.reflogExpire "14 days"
git config --local gc.master.reflogExpireUnreachable "14 days"

git config --local gc.develop.reflogExpire "never"
git config --local gc.develop.reflogExpireUnreachable "never"
```
在.git/config file
```git
[gc "master"]
	reflogExpire = 14 days
	reflogExpireUnreachable = 14 days
[gc "develop"]
	reflogExpire = never
	reflogExpireUnreachable = never
```

---


#### clearn reflog -- 清除歷史紀錄
清除所有歷史紀錄
`git reflog expire --expire=now --all`
重新整理或清除那些找不到、無法追蹤的版本
`git gc`

---

# git rebase vs merge
[](https://blog.git-init.com/differences-between-git-merge-and-rebase-and-why-you-should-care/)
rebase "reapplies commits on top of another base branch”,
whereas merge "joins two or more development histories together”
+ In other words
    + while merge preserves history as it happened
    +  rebase rewrites it

---

1. merge
git 預設會以 fast-forward 的模式進行 他會在
+ ff 模式下 產生 一個 commit
    + default
+ + no-fast-forward 的模式，會長出小耳朵

---

2. rebase
Rebase 是 “Re-” 與 “Base” 的複合字，這裡的 “Base” 代表「基礎版本」的意思
表示你想要重新修改特定分支的「基礎版本」，把另外一個分支的變更，當成我這個分支的基礎。
+ .
    + function : 融合版本 \ (有些網站的不清楚叫法 合併版本)
    + function : 修改歷史 commit 紀錄

---

## basic concepts about "merge"
有意的合併(git merge)
無意的合併(git pull) (通常我都不用這個....XD )
突然想到 revert 也是呢 Ψ(￣∀￣)Ψ


---

### git merge --no-ff

```bash
#{{{
(master)    46 $ git switch add
Switched to branch 'add'

(add)    47 $ echo " delete branch " > delete_branch.txt

(add)    48 $ git add . &&commit " + delete_branch.txt"
[add e174aed]  + delete_branch.txt
 1 file changed, 1 insertion(+)
 create mode 100644 delete_branch.txt

(add)    49 $ git switch master
Switched to branch 'master'

(master)    50 $ git merge --no-ff add
Merge made by the 'ort' strategy.
 delete_branch.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 delete_branch.txt

#}}}
```

---

![](https://hackmd.io/_uploads/B1Nwecwfp.png)
但是我真心推薦 用 `git merge --no-ff`
![](https://hackmd.io/_uploads/SkBd-5vza.png)
看出來了嗎???

---

在開發中可以直接知道
你是甚麼來合併的
因為人類的記憶裡很不好...
別說我 我的記憶能力也不好....ORZ

> 但是到後來 我看了其他人寫的文章
> 我發現 應該是 要合併時
> 你要給他多一個 commit 嗎?
> 意思是 當你覺得這個 commit 如果不是那麼 重要 就用 -ff
> 如果是 需要給日後 track  就用 --no-ff

---

### conflicted merger
體驗一場「衝突的合併」

```bash
#{{{
'
(love)    69 $'cat -n 1.txt
     1  1
     2  in love branch

(love)    70 $ git add .&&commit " m->1.txt +love.txt"
[love 2e14993]  m->1.txt +love.txt
 2 files changed, 2 insertions(+)
 create mode 100644 love.txt

(love)    71 $ git switch master
Switched to branch 'master'
#}}}
```
記得 69 的地方 這是(love)69 的高潮點
我們先埋下伏筆

---

![](https://hackmd.io/_uploads/HJeyxiPzT.png)

往master 出發
聰明的你們一定會知道我要幹嘛對吧!?
我在master 也修改 1.txt  file



---

```bash
#{{{

(master)    73 $ cat -n 1.txt
     1  1
     2  master branch

(master)    74 $ git add . &&commit "master 故意要與你作對 怎模樣?  本宮是皇后!!!"
git add . &&commit "master 故意要與你作對 怎模樣?  本宮是皇后cat -n 1.txt!"
[master cc666af] master 故意要與你作對 怎模樣?  本宮是皇后cat -n 1.txt!
 1 file changed, 1 insertion(+)
#}}}
```

![](https://hackmd.io/_uploads/rJWegjPM6.png)

---

各位大大 精彩絕倫的時刻來了!!!!
就像 正宮 要打小三 巴掌的高光時刻!!
o(*≧▽≦)ツ┏━┓  *

```bash
#{{{
(master)    75 $ git merge love
Auto-merging 1.txt
CONFLICT (content): Merge conflict in 1.txt
Automatic merge failed; fix conflicts and then commit the result.
```
```bash
(master|MERGING)    76 $ git diff
diff --cc 1.txt
index f532436,7dd35b4..0000000
--- a/1.txt
+++ b/1.txt
@@@ -1,2 -1,2 +1,6 @@@
  1
#++<<<<<<< HEAD
 +master branch
++=======
+ in love branch
++>>>>>>> love

(master|MERGING)    77 $ code 1.txt

(master|MERGING)    78 $ git status
On branch master
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Changes to be committed:
        new file:   love.txt

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   1.txt


(master|MERGING)    79 $ git add .&&commit " merge conflic 1.txt file "
[master 1eabbb2]  merge conflic 1.txt file
#}}}
```
---

這是比較當你完成一個合併後
我的master 與 love 分支
file 還是不同
git 就是這麼神奇!!

---

![](https://hackmd.io/_uploads/rJnZgovMa.png)

---

### mutiple file merge
```bash
(master)    40 $ git switch m2
error: Your local changes to the following files would be overwritten by checkout:
        1.txt
        hello.c
        love.txt
Please commit your changes or stash them before you switch branches.
Aborting
```
你看 如果你要切換 branch
如果有改動就不能切換
這裡我上圖
![](../pic/pic-20231025/4-git-merge-mulfile-0.png)

---

這是我看所有更改的file
把它集合在一起 o(\*≧▽≦)ツ┏━┓
當然 給你們看我修改 3 files
![](https://hackmd.io/_uploads/r15reiPz6.png)

---

```bash
(master)    186 $ git merge --no-ff m2
Auto-merging 1.txt
CONFLICT (content): Merge conflict in 1.txt
Auto-merging hello.c
CONFLICT (content): Merge conflict in hello.c
Auto-merging love.txt
CONFLICT (content): Merge conflict in love.txt
Automatic merge failed; fix conflicts and then commit the result.
```

其實 你看看你看看
他都有說 你哪些file have diff
其實 用 `git status `
就可以看出

---



![](https://hackmd.io/_uploads/Sk9DgiDMa.png)

---

因為 當你 merge 後  如果遇到衝突
git 會自動幫你 把conflic
修改到 file 中
甚麼意思呢?
意思就是 看圖八


---

![](https://hackmd.io/_uploads/ByjtliDzp.png)

當然你也可以用

---

##### git ls-files -u
`git ls-files -u`
```git
    -z                    separate paths with the NUL character
    -t                    identify the file status with tags
    -v                    use lowercase letters for 'assume unchanged' files
    -f                    use lowercase letters for 'fsmonitor clean' files
    -c, --cached          show cached files in the output (default)
    -d, --deleted         show deleted files in the output
    -m, --modified        show modified files in the output
    -u, --unmerged        show unmerged files in the output
    ....etc
```
所以可以看出來 -u 是沒有被 合併的 file

---

```bash
(master|MERGING)    189 $ git ls-files -u
100644 c5b66cd9495b4f8aa9390e7afd077709adec84ce 1       1.txt
100644 c1450dcfccd1e02cd2c2ac2b1a6673cae27d2ca9 2       1.txt
100644 cb1975c38a516024ed2b577aa70ccc9b5649183f 3       1.txt
100644 0e775d5f768fec326d754ba3aa59cdfda6eac30a 1       hello.c
100644 d0089ddceae404d57863c05943dbd3c3ad801489 2       hello.c
100644 37a5c67265f4fb4fe35f00caa73e5a6d3fcf30b0 3       hello.c
100644 881af8eb38b793900450b103bb67cf935d3a68e1 1       love.txt
100644 5bc9086c3ec87d90c521c73d3a11d0aa32af91ac 2       love.txt
100644 4630a8b98c73628aec77cb01dfc18d8afdd3f327 3       love.txt
```

如果這時候你用 `git diff ` 少的東西還好
檔案1多 ....你會發現 天啊
~~你們這些一起開發的人
真的是謝謝耶 (大誤  ??) (∪.∪ )...zzz~~
所以 一開始的出現的訊息 就很好了

---

當然你可以用 GUI (sourcetree)來幫你完成就是了
> 就是不同工具 不同用法~~

---

#### EX1 by web
![](https://hackmd.io/_uploads/SJdpgiPfT.png)

---

Looking at the example above, we see that the developers Ada and Satoshi initially created two topic branches (feature-1 and feature-2), stemming from the same commit (C1) on the master branch. Ada then completed feature-1 by merging it into master (creating merge commit C4). Satoshi now has two options to integrate Ada’s changes into his branch feature-2 — merge or rebase.

Ada 他是用 merge 的方式
Satoshi 他想要合併 Ada 的

---

他就有兩個選項
+ `merge`
+ `rebase`

> 小小補充一下 你看 左邊的時間線 與
> 右邊物件的箭頭 (他指回去 ) 代表 git
> 只做 修改的part 其他的 就是關聯

所以 當他用 merge 後

---

![](https://hackmd.io/_uploads/H1eyWowzp.png)


 it’s time to look at the same example but from a rebase perspective
來吧 環境要一樣 才能比較

---


## git rebase
如果這時我是用 rebase

[](https://hackmd.io/_uploads/r1r8SjDz6.gif)
![](https://hackmd.io/_uploads/HyYLrivGa.gif)


---

## conclude git rebase vs merge
+ rebase
    + 關注點是開發的過程
        - 沒有合併操作
        + 複製 加工 貼上 的概念
+ merge
    + 關注點是 歷史紀錄
        + 兩個分支 合併

---

# git reset
reset 通常在 給我們的感覺是 重置
一種  好像 聖經般 大洪水 把世界重置 的感覺XD
但是呢 在 git 中 reset  像是 goto
一種 好喔 我們去旅行的概念 XDDDD

一手  世界毀滅 一手 輕鬆休閒
其實 都一樣的呢~~~ ༼ つ ◕_◕ ༽つ

---

### Recover accidentally deleted branches (救回 誤刪的分支)
1. step1  use `git reflog`
2. step2  `git branch [branch-name] <SHA1>`

我一樣準備好前置動作

```bash
(master)    52 $ git branch add -d
Deleted branch add (was e174aed).

(master)    54 $ git reflog
4239125 (HEAD -> master) HEAD@{0}: merge add: Merge made by the 'ort' strategy.
f8fc3d9 HEAD@{1}: checkout: moving from add to master
e174aed HEAD@{2}: commit: + delete_branch.txt
f8fc3d9 HEAD@{3}: checkout: moving from master to add
f8fc3d9 HEAD@{4}: commit (initial): 0000

(master)    55 $ git branch add f8fc3d9

(master)    56 $ git branch
  add
* master
```

![](https://hackmd.io/_uploads/HyV3kiwza.png)


---

## 復原意外地變更
用 `HEAD@{1} ` 這個特殊的「參考名稱」
```bash
git reset "HEAD@{1}" --hard
```

---

### the basic principle for commit
###### h6-- 版本控管的基本原則
+ 小功能修改就建立版本，這樣才容易追蹤變更
+ 有邏輯、有順序的修正功能

```bash
#{{{
(master)    236 $ git log
commit 98524e00f4a7abb1fae4640a06025c47f8c9993a (HEAD -> master)
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 15:55:46 2023 +0800

     + c.txt

commit 9fd0d0172f7d19be71c34e7c682bc1045493b5be
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 15:55:45 2023 +0800

     + b.txt

commit a3883996e03ad89d2c16008b86a2b91030f6e119
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 15:55:45 2023 +0800

    update a.txt

commit bfbfe4368582ea45405467a38c20b63b01be0613
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 15:55:45 2023 +0800

    Initial commit (a.txt created)
#}}}
```

![](https://hackmd.io/_uploads/BkInvowGp.png)

---

![](https://hackmd.io/_uploads/BkGpwowMa.png)

---

版本現在
```bash
[ bfbfe4 ]  =>  [ a38839 ]  => [ 9fd0d0 ] => [ 98524e ]
```

---

BUT!!!! 現在 你發現 你的 98524e 不小心
寫錯BUG 又不小心 commit
怎麼半?!
簡單!

---

## git reset

```bash
git reset master^
```
如果你要兩次

```bash
git reset master^^
```
但如果你要13次呢?

git reset master^^^^^^^^^^^^^
不可能吧...=3=

---

所以就會變成

```bash
git reset master~13
```

##### Git 物件的相對名稱
###### 相對名稱的表示法
+ ~
    + +數字 `main~3` `HEAD~5` `~3`
        + 回去幾個
+ ^
    + +數字  `^2` `^3!=^^^`
        +選paret (選會哪個) (merge 才有 => 很多分支就很好玩)
`git reset master ~2^3^^^~5`

---
原本要給你們看的說 可是一開始的我用錯QQ
被習慣害死的我....ORZ
```
  (master)    39 $ git reset master^3
fatal: ambiguous argument 'master^3': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

錯誤的我....{{{(>_<)}}}
```



---

![](https://hackmd.io/_uploads/ryFXjb2Ma.png)

---

![](https://hackmd.io/_uploads/B1f4oW2fa.png)

---

![](https://hackmd.io/_uploads/r1jVjZ3M6.png)

---

我後來發現 如果是 你如果merge  2個以上的新files
那他就會用 --no-ff的方式
如果你 很完美的 都改道不同的檔案 也一樣 會用
--no-ff (當然 第一個 他還是會用 fast forward )

---


### 但是 reset 我還是會用版本號來用....
`git log --oneline` 得到你要回去的版本
再把 6碼 複製
`git reset "SH1 6code"`

### git reset --hard 如果你要果斷全部回去
```bash
git reset --hard
```

---

### git reset Usually 3  types are used
+ --soft
+ --mixed(default)
+ --hard

type    | working directroy |   staging area    |
:---    |   :---:           |   :---:           |
soft    |   (V) intact      |   (V) intact      |
mixed   |   (V) intact      |   (X) change      |
hard    |   (X) change      |   (X) change      |

---



## git reset --hard HEAD^
![](https://hackmd.io/_uploads/BksLvj_fa.png)
`git reset --hard HEAD^`
至於為什麼時 hard
可以看回去我寫過的
> 在CMD => ^ 是特殊字元 所以 要變成 git reset --hard "HEAD^"

## git reset --hard ORIG_HEAD (restore back one step)
你不小心 用到
`git reset --hard HEAD^`
然後你想回去? 當然可以

`git reset --hard ORIG_HEAD`

```bash
#{{{
(master)    240 $ git reset --hard ORIG_HEAD
HEAD is now at 98524e0  + c.txt

(master)    241 $ dir
total 3.0K
-rw-r--r-- 1 cxc cxc 2 Oct 25 15:55 a.txt
-rw-r--r-- 1 cxc cxc 2 Oct 25 15:55 b.txt
-rw-r--r-- 1 cxc cxc 2 Oct 25 16:19 c.txt

(master)    242 $ git reflog
98524e0 (HEAD -> master) HEAD@{0}: reset: moving to ORIG_HEAD
9fd0d01 HEAD@{1}: reset: moving to HEAD^
98524e0 (HEAD -> master) HEAD@{2}: commit: + c.txt
9fd0d01 HEAD@{3}: commit: + b.txt
a388399 HEAD@{4}: commit: update a.txt
bfbfe43 HEAD@{5}: commit (initial): Initial commit (a.txt created)

(master)    243 $ git log
commit 98524e00f4a7abb1fae4640a06025c47f8c9993a (HEAD -> master)
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 15:55:46 2023 +0800

     + c.txt

commit 9fd0d0172f7d19be71c34e7c682bc1045493b5be
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 15:55:45 2023 +0800

     + b.txt

commit a3883996e03ad89d2c16008b86a2b91030f6e119
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 15:55:45 2023 +0800

    update a.txt

commit bfbfe4368582ea45405467a38c20b63b01be0613
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 15:55:45 2023 +0800

    Initial commit (a.txt created)
#}}}
```

---

### git commit --amend
重新提交一次最後一個版本 (即 HEAD 版本)
不小心執行了 git commit 動作
+ 忘了加有些檔案
+ 紀錄訊息寫錯

---

來看看他們的LOG

![](https://hackmd.io/_uploads/Sy3POsDzT.png)

---

```bash
#{{{
(master)    11 $ git reflog
66d855b (HEAD -> master) HEAD@{0}: commit (amend): +d.txt
c5c3bfe HEAD@{1}: commit: +d.txt
cc7bb70 HEAD@{2}: reset: moving to cc7bb70
6bf3daa HEAD@{3}: commit (amend): +d.txt
5bce709 HEAD@{4}: commit: +d.txt
cc7bb70 HEAD@{5}: commit (amend): OKOK
c352ea0 HEAD@{6}: commit: 分明只是尋常能耐
9fd0d01 HEAD@{7}: reset: moving to HEAD^
98524e0 HEAD@{8}: reset: moving to ORIG_HEAD
9fd0d01 HEAD@{9}: reset: moving to HEAD^
98524e0 HEAD@{10}: commit: + c.txt
9fd0d01 HEAD@{11}: commit: + b.txt
a388399 HEAD@{12}: commit: update a.txt
bfbfe43 HEAD@{13}: commit (initial): Initial commit (a.txt created)
#}}}
```

---

# git revert

他跟`git reset `很像
但是不同的是
她會多一個 commit
所以如果你要回到過去 最好是用這個
再回推版本就好
因為這樣好看雅...


---

```bash
#{{{
(master)    29 $ git show 9bd9ec
commit 9bd9ec95db07478ae9bfa46d584b060c65e94060
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 17:03:17 2023 +0800

     up => chi

diff --git a/a.txt b/a.txt
index d00491f..cb6bdbb 100644
--- a/a.txt
+++ b/a.txt
@@ -1 +1 @@
-1
+ 行書潦草，換了小楷

(master)    30 $ git show 17b21b
commit 17b21be67a3377b1383658a520260d28d280f7fd (HEAD -> master)
Author: love_ferry_queen <lovescv26@gmail.com>
Date:   Wed Oct 25 17:03:58 2023 +0800

    up => jp

diff --git a/a.txt b/a.txt
index cb6bdbb..1d81cc3 100644
--- a/a.txt
+++ b/a.txt
@@ -1 +1 @@
- 行書潦草，換了小楷
+ そこに君は居なくとも
#}}}
```


![](https://hackmd.io/_uploads/r12Ltjvfa.png)

---

```bash
(master)    32 $ git revert 9bd9ec
Auto-merging a.txt
CONFLICT (content): Merge conflict in a.txt
error: could not revert 9bd9ec9...  up => chi
hint: After resolving the conflicts, mark them with
hint: "git add/rm <pathspec>", then run
hint: "git revert --continue".
hint: You can instead skip this commit with "git revert --skip".
hint: To abort and get back to the state before "git revert",
hint: run "git revert --abort".

(master|REVERTING)    33 $ cat a.txt
<<<<<<< HEAD
 そこに君は居なくとも
=======
1
>>>>>>> parent of 9bd9ec9 ( up => chi)
```

沒想到我竟然用到 衝突態 ORZ好把這樣也給你們知道 revert 就是用merge 的方式
> 真是美麗的錯誤壓 (●ˇ∀ˇ●)

---

git revert 時，預設若執行成功，會直接建立一個 commit 版本

## git revert -n
就是 不會立馬 commit

後續完成後你可以用兩個 options
+ continue
    + commit
+ abort
    + all discord

---

> 如果你用了 `-n`
>> 你好了 不要給我用 git commit..
>>> git revert continue

---

後來真的了解後 我才懂 你們還是要搞懂
reset switch checkout revert
應該說 你要用甚麼樣子的方式給妳共同開發
的團隊看

---

# git cherry-pick
這是給我們挑選的操作

---

```bash
(add)    52 $ echo "私は特に「アドベンチャー 」" > jp.txt

(add)    53 $ git add .&&commit "jp.txt"
[add 09adb7f] jp.txt
 1 file changed, 1 insertion(+)
 create mode 100644 jp.txt
#
```

---

![](https://hackmd.io/_uploads/SJ8bW5nz6.png)

---

#####  git and github
![](https://hackmd.io/_uploads/B1gcpbtnzp.png)

---

# THE END
