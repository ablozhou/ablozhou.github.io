---
author: abloz
comments: true
date: 2010-11-12 02:30:20+00:00
layout: post
link: http://abloz.com/index.php/2010/11/12/the-discussion-makefile/
slug: the-discussion-makefile
title: Makefile小议
wordpress_id: 1062
categories:
- 技术
tags:
- make
- makefile
---

周海汉/文 http://abloz.com
2010.11.12

Makefile一般用于项目的编译。源文件较多，需要指定编译规则。make 工具如 GNU make、System V make 和 Berkeley make 是用来组织应用程序编译过程的基本工具，但是每个 make 工具之间又有所不同。本文基于GNU make，在ubuntu 10.10上测试。

**1.Makefile 基本规则**

    
    target: dependencies
    	instructions


注意instructions前必须有一个TAB，空格或无TAB会导致错误。如果dependencies有变化，则执行instructions.但dependencies和instructions都不是必须的。Makefile的第一个target会首先被执行。而不是因为它的名字叫default或all。

**2.用Makefile执行命令**
用makefile执行bash命令ls -l

`zhouhh@zhh64:~/test$ cat Makefile
default:
ls -l
zhouhh@zhh64:~/test$ make
ls -l
总计 112
-rwxr-xr-x 1 zhouhh zhouhh 8503 2010-10-21 11:32 a.out`

执行for循环
`zhouhh@zhh64:~$ cat Makefile
ALLDIRS="test Public"
default:
for i in $(ALLDIRS) ; 
do ls $$i ;
done;
zhouhh@zhh64:~$ make
for i in "test Public" ; 
do ls $i ;
done;
Public:
...
test:
...`
其中$$表示传递给shell一个$. 分号加反斜杠表示续行。

**3.Makefile的变量**
变量执行顺序，由高到低：

1. 命令行变量设置
2. 父 make 进程的 makefile 中的变量设置
3. 本 make 进程的 makefile 中的变量设置
4. 环境变量
Makefile自带：
* $< —— 用来构建目标所使用的源文件
* $* —— 目标名中基本的部分（不包含扩展名或目录）
* $@ —— 目标的完整名
自带变量测试：

`zhouhh@zhh64:~/test$ cat Makefile
all: test.c
@echo "Beginning build at:"
@date
@echo "--------"
@echo checkfile:$<
@echo short: $*
@echo target :$@
zhouhh@zhh64:~/test$ make
Beginning build at:
2010年 11月 12日 星期五 10:23:40 CST
--------
checkfile:test.c
short:
target :all`
其中命令前的@用于隐藏命令本身。

**4.vim中对不存在Makefile的单个测试文件进行make**
vim编完程序，如果有Makefile，可直接执行make，这样错误会定位到源码的行。有时简单测试的单个文件，也可以用命令来指定make规则
`:set makeprg=gcc -g -lpthread -o epthrd epthrd.c`
其中命令中空格用转义，否则会当成两个命令。

http://www.ibm.com/developerworks/cn/linux/l-debugmake.html
