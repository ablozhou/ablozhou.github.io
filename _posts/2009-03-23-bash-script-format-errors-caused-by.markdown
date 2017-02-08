---
author: abloz
comments: true
date: 2009-03-23 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/03/23/bash-script-format-errors-caused-by/
slug: bash-script-format-errors-caused-by
title: bash 脚本格式引起的错误
wordpress_id: 901
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文

bash脚本其实是格式脚本，并不像C语言那样自由。

比如，对于赋值

[](http://blog.csdn.net/ablo_zhou/archive/2009/03/23/4017714.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/03/23/4017714.aspx#)

  1. [zhouhh@cvttdev ~]$ r=`ls -l test`
  2. [zhouhh@cvttdev ~]$ echo $r
  3. -rwxrwxr-x 1 zhouhh zhouhh 176 03-16 16:35 test
  4. [zhouhh@cvttdev ~]$ ret =`ls -l test`
  5. -bash: ret: command not found
  6. [zhouhh@cvttdev ~]$ ret= `ls -l test`
  7. -bash: -rwxrwxr-x: command not found

[zhouhh@cvttdev ~]$ r=`ls -l test` [zhouhh@cvttdev ~]$ echo $r -rwxrwxr-x 1 zhouhh zhouhh 176 03-16 16:35 test [zhouhh@cvttdev ~]$ ret =`ls -l test` -bash: ret: command not found [zhouhh@cvttdev ~]$ ret= `ls -l test` -bash: -rwxrwxr-x: command not found    

对于C语言，赋值号左右都可以有空格，而在bash脚本中，因为有空格，导致了错误。如果左边有空格，会将变量当成命令执行。如果右边有空格，会将变量赋值为空格。

这容易引起的误会是不知道如何在bash中给变量赋值。其实只要将空格去掉就行了。

 

又如，对于if语句

[](http://blog.csdn.net/ablo_zhou/archive/2009/03/23/4017714.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/03/23/4017714.aspx#)

  1. #!/bin/bash
  2.   3. a="234"
  4. if[ $a=="234"]; then
  5. echo "ok"
  6. fi
  7.   8.   9. [zhouhh@cvttdev ~]$ ./test1
  10. ./test1: line 4: syntax error near unexpected token `then'
  11. ./test1: line 4: `if[ $a=="234"]; then'

#!/bin/bash  a="234" if[ $a=="234"]; then echo "ok" fi   [zhouhh@cvttdev ~]$ ./test1 ./test1: line 4: syntax error near unexpected token `then' ./test1: line 4: `if[ $a=="234"]; then'  

因为if后面没有空格

  
  


![](http://img.zemanta.com/pixy.gif?x-id=ba87e7d5-c894-8b33-80e9-a7f1eb6058a3)
