---
author: abloz
comments: true
date: 2010-06-10 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/06/10/bash-shell-brace-expansion/
slug: bash-shell-brace-expansion
title: bash shell 大括号扩展
wordpress_id: 1234
categories:
- 技术
---

周海汉 /文

2010.6.10

 

bash shell的扩展，指shell在分析输入命令时的一种将命令展开的操作。 有7种扩展方式。参考一下man bash的扩展页：

[](http://blog.csdn.net/ablo_zhou/archive/2010/06/10/5661730.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2010/06/10/5661730.aspx#)

  1. 扩展(EXPANSION)
  2. 命令行的扩展是在拆分成词之后进行的。有七种类型的扩展： brace expansion(花括号扩展), tilde expan‐
  3. sion(波浪线扩展), parameter and variable expansion(参数和变量扩展), command substi‐
  4. tution(命令替换), arithmetic expansion(算术扩展), word splitting(词的拆分), 和 path‐
  5. name expansion(路径扩展).
  6. 扩展的顺序是：brace expansion, tilde expansion, parameter, variable 和 arith‐
  7. metic expansion 还有 command substitution (按照从左到右的顺序), word splitting,
  8. 最后是 pathname expansion.
  9. 还有一种附加的扩展：process subtitution (进程替换) 只有在支持它 的系统中有效。
  10. 只有 brace expansion, word splitting, 和 pathname expansion
  11. 在扩展前后的词数会发生改变；其他扩展总是将一个词扩展为一个词。 唯一的例外是上面提到的 "$@" 和 "${name[@]}" (参见
  12. PARAMETERS参数)。
  13. Brace Expansion
  14. Brace expansion 是一种可能产生任意字符串的机制。这种机制类似于 pathname expansion,
  15. 但是并不需要存在相应的文件。 花括号扩展的模式是一个可选的 preamble(前导字符),
  16. 后面跟着一系列逗号分隔的字符串，包含在一对花括号中， 再后面是一个可选的 postscript(附言)。
  17. 前导被添加到花括号中的每个字符串前面，附言被附加到每个结果字符串之后， 从左到右进行扩展。
  18. 花括号扩展可以嵌套。扩展字符串的结果没有排序；而是保留了从左到右的顺序。 例如， a{d,c,b}e 扩展为 `ade ace abe'。
  19. 花括号扩展是在任何其他扩展之前进行的，任何对其他扩展有特殊意义的字符 都保留在结果中。它是严格字面上的。 Bash
  20. 不会对扩展的上下文或花括号中的文本做任何语义上的解释。
  21. 正确的花括号扩展必须包含没有引用的左括号和右括号，以及至少一个没有 引用的逗号。任何不正确的表达式都不会被改变。可以用反斜杠来引用 { 或 ,
  22. 来阻止将它们识别为花括号表达式的一部分。 为了避免与参数扩展冲突，字符串 ${ 不被认为有效的组合。
  23. 这种结构通常用来简写字符串的公共前缀远比上例中为长的情况，例如：
  24. mkdir /usr/local/src/bash/{old,new,dist,bugs}
  25. 或者：
  26. chown root /usr/{ucb/{ex,edit},lib/{ex?.?*,how_ex}}
  27. 花括号扩展导致了与历史版本的 sh 的一点不兼容。在左括号或右括号作为词的一部分出现时， sh 不会对它们进行特殊处理，会在输出中保留它们。
  28. Bash 将括号从花括号扩展结果的词中删除。例如，向 sh 输入 file{1,2} 会导致不变的输出。同样的输入在 bash
  29. 进行扩展之后，会输出 file1 file2 . 如果需要同 sh 严格地保持兼容，需要在启动 bash 的时候使用 +B 选项，或者使用
  30. set 命令加上 +B 选项来禁用花括号扩展 (参见下面的 shell 内建命令(SHELL BUILTIN COMMANDS) 章节)。

扩展(EXPANSION)       命令行的扩展是在拆分成词之后进行的。有七种类型的扩展：  brace   expansion(花括号扩展),   tilde   expan‐       sion(波浪线扩展), parameter and variable expansion(参数和变量扩展), command substi‐       tution(命令替换), arithmetic expansion(算术扩展), word splitting(词的拆分), 和 path‐       name expansion(路径扩展).       扩展的顺序是：brace  expansion,  tilde expansion, parameter, variable 和 arith‐       metic expansion 还有 command substitution  (按照从左到右的顺序),  word  splitting,       最后是 pathname expansion.       还有一种
附加的扩展：process subtitution (进程替换) 只有在支持它 的系统中有效。       只有    brace   expansion,   word   splitting,   和   pathname   expansion       在扩展前后的词数会发生改变；其他扩展总是将一个词扩展为一个词。 唯一的例外是上面提到的  "$@"  和  "${name[@]}"  (参见       PARAMETERS参数)。   Brace Expansion       Brace    expansion    是一种可能产生任意字符串的机制。这种机制类似于    pathname    expansion,       但是并不需要存在相应的文件。              花括号扩展的模式是一个可选的              preamble(前导字符),       后面跟着一系列逗号分隔的字符串，包含在一对花括号中，           再后面是一个可选的          postscript(附言)。       前导被添加到花括号中的每个字符串前面，附言被附加到每个结果字符串之后， 从左到右进行扩展。       花括号扩展可以嵌套。扩展字符串的结果没有排序；而是保留了从左到右的顺序。 例如， a{d,c,b}e 扩展为 `ade ace abe'。       花括号扩展是在任何其他扩展之前进行的，任何对其他扩展有特殊意义的字符        都保留在结果中。它是严格字面上的。        Bash       不会对扩展的上下文或花括号中的文本做任何语义上的解释。       正确的花括号扩展必须包含没有引用的左括号和右括号，以及至少一个没有 引用的逗号。任何不正确的表达式都不会被改变。可以用反斜杠来引用 { 或 ,       来阻止将它们识别为花括号表达式的一部分。 为了避免与参数扩展冲突，字符串 ${ 不被认为有效的组合。       这种结构通常用来简写字符串的公共前缀远比上例中为长的情况，例如：              mkdir /usr/local/src/bash/{old,new,dist,bugs}       或者：              chown root /usr/{ucb/{ex,edit},lib/{ex?.?*,how_ex}}       花括号扩展导致了与历史版本的 sh 的一点不兼容。在左括号或右括号作为词的一部分出现时， sh  不会对它们进行特殊处理，会在输出中保留它们。       Bash   将括号从花括号扩展结果的词中删除。例如，向   sh  输入  file{1,2}  会导致不变的输出。同样的输入在  bash       进行扩展之后，会输出 file1 file2 .  如果需要同 sh 严格地保持兼容，需要在启动 bash 的时候使用 +B  选项，或者使用       set 命令加上 +B 选项来禁用花括号扩展 (参见下面的 shell 内建命令(SHELL BUILTIN COMMANDS) 章节)。   

大括号（花括号）扩展方式也有意思。

 

## 示例1：操作多个文件名有共同点的文件

zhouhh@zhh64:~/brace$ ls  
bk  
zhouhh@zhh64:~/brace$ touch file{source,target,info,readme}.txt  
zhouhh@zhh64:~/brace$ ls  
bk fileinfo.txt filereadme.txt filesource.txt filetarget.txt

 

zhouhh@zhh64:~/brace$ echo file{1,2,3,4}.txt  
file1.txt file2.txt file3.txt file4.txt  
zhouhh@zhh64:~/brace$ touch file{1,2,3,4}.txt  
zhouhh@zhh64:~/brace$ ls  
bk file1.txt file2.txt file3.txt file4.txt  


## 示例2：一个命令将几个文件名有规律的文件转移到一个目录

zhouhh@zhh64:~/brace$ ls bk  
zhouhh@zhh64:~/brace$ mv file{1,2,3,4}.txt bk/.  
zhouhh@zhh64:~/brace$ ls bk  
file1.txt file2.txt file3.txt file4.txt  
zhouhh@zhh64:~/brace$

 

## 示例3：备份

 

zhouhh@zhh64:~/brace$ touch mydata.log  
zhouhh@zhh64:~/brace$ vi back.sh  
zhouhh@zhh64:~/brace$ chmod +x back.sh   
zhouhh@zhh64:~/brace$ cat back.sh   
set -x #调试模式  
bkdate=`date +%F` #日期  
cp mydata{,$bkdate}.log #将log备份为带日期格式  
zhouhh@zhh64:~/brace$ ls  
back.sh bk mydata.log  
zhouhh@zhh64:~/brace$ ./back.sh   
+++ date +%F  
++ bkdate=2010-06-10  
++ cp mydata.log mydata2010-06-10.log  
zhouhh@zhh64:~/brace$ ls  
back.sh bk mydata2010-06-10.log mydata.log  


## 示例4 处理多个有规律文件名  


zhouhh@zhh64:~/brace$ echo /var/log/messages.{1..3}  
/var/log/messages.1 /var/log/messages.2 /var/log/messages.3  


zhouhh@zhh64:~/brace$ echo file{a..d}{1..3}.txt  
filea1.txt filea2.txt filea3.txt fileb1.txt fileb2.txt fileb3.txt  filec1.txt filec2.txt filec3.txt filed1.txt filed2.txt filed3.txt

 

## 示例5 for循环

zhouhh@zhh64:~/brace$ for i in {1..9..3}  
> do  
> echo $i  
> done  
1  
4  
7

 

## 参考：

http://www.thegeekstuff.com/2010/06/bash-shell-brace-expansion/#more-4614

  
  


![](http://img.zemanta.com/pixy.gif?x-id=c1cc952e-113f-8bf8-bb1e-cf58ddd689e2)
