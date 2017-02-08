---
author: abloz
comments: true
date: 2010-01-28 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/01/28/virtualbox-problem-with-the-host-exchange-clipboard/
slug: virtualbox-problem-with-the-host-exchange-clipboard
title: virtualbox 与宿主交换剪贴板的问题
wordpress_id: 1032
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou) /文

 

在ubuntu上安装了virtualbox的windows xp，但发现在宿主机拷贝不能粘贴到windows xp. 

 

解决办法：点“设备-安装增强功能”，会下载一个“VBoxGuestAdditions_3.0.8.iso”，约30MB。

将其加载到virtualbox的虚拟光驱，在客户机winxp上安装。装完重启客户机。

 

神奇的事情发生了，不仅可以共享剪贴板，还可以鼠标自由在客户机和宿主机上移动了，而不是原来的必须按左Ctrl解除绑定。virtualbox的winxp就成了ubuntu的一个窗口，使用起来非常方便。

 

另外，原来virtual box客户机移动鼠标有点凝滞，在安装了增强功能后，鼠标也很顺畅了。

 

安装了增强功能，才可以方便的共享文件。我原来是在宿主机设置ftp来共享的，还是有点麻烦。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=b7ce8f6c-11d1-8490-ad3c-534d680741d6)
