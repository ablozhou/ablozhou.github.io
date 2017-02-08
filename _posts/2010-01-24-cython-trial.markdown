---
author: abloz
comments: true
date: 2010-01-24 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/01/24/cython-trial/
slug: cython-trial
title: cython 试用
wordpress_id: 1026
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.1.24

 

1.安装

zhouhh@zhouhh-home:~$ cython  
程序“cython”尚未安装。 您可以使用以下命令安装：  
sudo apt-get install cython  
cython: command not found  
zhouhh@zhouhh-home:~$ sudo apt-get install cython

...

2.写测试代码：

zhouhh@zhouhh-home:~$ vi test.pyx

[  
](http://blog.csdn.net/ablo_zhou/archive/2010/01/24/5250766.aspx#)[](http://blog.csdn.net/ablo_zhou/archive/2010/01/24/5250766.aspx#)

  1. def sayhello(char* str):
  2. if str == None:
  3. print 'hello world'
  4. else:
  5. print str

def sayhello(char* str): 	if str == None: 		print 'hello world' 	else: 		print str   

3.编译成C语言

zhouhh@zhouhh-home:~$ cython test.pyx

zhouhh@zhouhh-home:~$ ls test.c  
test.c  
test.c是由cython通过 test.pyx生成的。

 

4. gcc编译成.o文件

直接执行gcc会出错，必须包含python目录。

zhouhh@zhouhh-home:~$ gcc test.c  
  
test.c:4:20: error: Python.h: 没有该文件或目录  
test.c:5:26: error: structmember.h: 没有该文件或目录  
test.c:7:6: error: #error Python headers needed to compile C extensions, please install development version of Python.

...

 

zhouhh@zhouhh-home:~$ gcc -c -fPIC -I/usr/include/python2.6 test.c

-fPIC表示编译成共享库，-I后跟include的路径。

 

5.生成共享库

zhouhh@zhouhh-home:~$ gcc -shared test.o -o test.so

 

6.在python中引用共享库

zhouhh@zhouhh-home:~$ vi test.py

import test  
  
test.sayhello('ni hao')

 

7.执行

zhouhh@zhouhh-home:~$ python test.py  
ni hao

8.疑问：

不知怎么传NULL指针给函数参数。

 

9.参考：

http://www.cython.org/

http://blog.csdn.net/lanphaday/archive/2009/09/17/4561611.aspx

  
  


![](http://img.zemanta.com/pixy.gif?x-id=dab99960-8e0e-8ee9-b86e-a2d2815c0d1e)
