---
author: abloz
comments: true
date: 2009-12-17 06:25:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/17/the-python-vim-syntax-highlighting/
slug: the-python-vim-syntax-highlighting
title: vim 的python 语法高亮
wordpress_id: 989
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

 

vim支持大部分文件格式的语法高亮，而且可以自定义。不过缺省的python语法高亮感觉太少，修改一下。

 

1.修改语法高亮文件

/usr/share/vim/vim72/syntax/python.vim

 

将"  let python_highlight_all = 1

前面的引号去掉，可支持内置函数，数字，空格，异常的语法高亮。

 

2. 将self加进

syn keyword pythonBuiltin reversed sorted sum self

这一行最后。

 

3. 将标点符号加进高亮

在HiLink定义前加入一行：

syn match pythonOper "=|+|-|*|{|}|[|]|(|)|.|,"

在尾巴上加入：

HiLink pythonOper Operator " SpecialKey

 

这时，python语法基本比较鲜艳了。

 

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091217/Screenshot-syntax.py%20%28%7E%29%20-%20GVIM-1.png)

 

#!/bin/env python   
# coding=utf8    
# author:周海汉   
# 2009.12.17   
  
import os  
  
**def** myfunc **(** self **,** args**)** :  
self **.** args**=** args  
  
**class** myclass :  
**def** __init__ **(** self **)** :  
self **.** func**=** myfunc  
  
**def** listdir **(** self **)** :  
self **.** func**(** self **,** self **.** args**)**   
**print** os**.** listdir**(** self **.** args**)**   
  
**if** __name__**==** '__main__ ':  
o **=** myclass**()**   
myfunc**(** o**,** '. '**)**   
o**.** listdir**()**

  
  


![](http://img.zemanta.com/pixy.gif?x-id=81ba8a22-1f3c-8a82-94a2-93790033bfb2)
