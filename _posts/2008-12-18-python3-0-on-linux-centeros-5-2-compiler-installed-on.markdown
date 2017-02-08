---
author: abloz
comments: true
date: 2008-12-18 02:21:54+00:00
layout: post
link: http://abloz.com/index.php/2008/12/18/python3-0-on-linux-centeros-5-2-compiler-installed-on/
slug: python3-0-on-linux-centeros-5-2-compiler-installed-on
title: python3.0 在linux centerOS 5.2上的编译安装
wordpress_id: 331
categories:
- 技术
tags:
- python3
---

周海汉/文
ablozhou at gmail.com
http://blog.csdn.net/ablo_zhou

首先，到www.python.org去下载最新的3.0版：

    
    
    wget http://www.python.org/ftp/python/3.0/Python-3.0.tgz
    


大小11M

    
    
    tar zxvf Python-3.0.tgz
    



解压后执行

    
    
    $./configure
    


通过

    
    
    $make
    


出这么一个错误：
make: *** [sharedmods] 错误 1

查找网上说是locale的问题:

    
    
    "Python fails
    silently on bad locale" bug:
    http://bugs.python.org/issue2173
    
    $locale
    
    LANG=zh_CN.UTF-8
    LC_COLLATE="zh_CN.GB2312"
    LC_CTYPE="zh_CN.GB2312"
    LC_MESSAGES="zh_CN.GB2312"
    LC_MONETARY="zh_CN.GB2312"
    LC_NUMERIC="zh_CN.GB2312"
    LC_TIME="zh_CN.GB2312"
    LC_ALL=zh_CN.GB2312
    


是LC_CTYPE的值zh_CN.GB2312不是对Python合法的值，

    
    
    $ export LC_ALL=zh_CN.UTF-8
    $ locale
    LANG=zh_CN.UTF-8
    LC_CTYPE="zh_CN.UTF-8"
    LC_NUMERIC="zh_CN.UTF-8"
    LC_TIME="zh_CN.UTF-8"
    LC_ALL=zh_CN.UTF-8
    
    $make
    


总体成功了，但出如下的错误：

    
    
    Failed to find the necessary bits to build these modules:
    _tkinter
    To find the necessary bits, look in setup.py in detect_modules() for the module's name.
    


这是图形库，可以不管。

    
    
    $make install
    ....
    * Note: not installed as 'python'.
    * Use 'make fullinstall' to install as 'python'.
    * However, 'make fullinstall' is discouraged,
    * as it will clobber your Python 2.x installation.
    


安装成功，但没有替换原来的2.x的版本。如果想替换，可以执行"make fullinstall"

执行：

    
    
    $ python3.0
    
    Python 3.0 (r30:67503, Dec 18 2008, 16:31:33)
    [GCC 4.1.2 20071124 (Red Hat 4.1.2-42)] on linux2
    Type "help", "copyright", "credits" or "license" for more information.
    >>>
    
