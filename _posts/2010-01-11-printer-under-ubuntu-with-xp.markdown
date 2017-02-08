---
author: abloz
comments: true
date: 2010-01-11 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/01/11/printer-under-ubuntu-with-xp/
slug: printer-under-ubuntu-with-xp
title: ubuntu 使用xp下的打印机
wordpress_id: 1016
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.1.11

 

ubuntu要使用window xp下共享的打印机，需先安装samba:

  
sudo aptitude install samba

 

然后，进入“系统-系统管理-打印”，新建打印机。选最下面的“网络打印机”，Windows Printer via SAMBA,  输入IP地址和用户名密码，浏览一下共享的打印机，并选择如hpLaserJ。进入后驱动选一种品牌，如HP。选相应的型号，如HP LaserJet  1300 Series Postscript [en][推荐]。完成。

打印机地址类似： smb://192.168.12.112/hpLaserJ

即可打印。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=1de6e394-386f-8c10-a660-c2fc2516f429)
