---
author: abloz
comments: true
date: 2010-03-31 07:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/31/upgrade-ubuntu-kernel-virtualbox-can-not-be-used/
slug: upgrade-ubuntu-kernel-virtualbox-can-not-be-used
title: 升级ubuntu内核，virtualbox不能用了
wordpress_id: 1189
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

 

今天遇到一件奇怪的事情，编译升级完一个内核模块，重启系统后，导致virtualbox虚拟机电脑起不来，弹出对话框提示如下：

 

[view plain](http://blog.csdn.net/ablo_zhou/archive/2010/03/31/5437384.aspx#)[copy to clipboard](http://blog.csdn.net/ablo_zhou/archive/2010/03/31/5437384.aspx#)[print](http://blog.csdn.net/ablo_zhou/archive/2010/03/31/5437384.aspx#)[?](http://blog.csdn.net/ablo_zhou/archive/2010/03/31/5437384.aspx#)

  1. 不能为虚拟电脑 win7 打开一个新任务.
  2. Virtual machine 'win7' has terminated unexpectedly during startup.
  3.   4. 返回 代码:
  5. NS_ERROR_FAILURE (0x80004005)
  6. 组件:
  7. Machine
  8. 界面:
  9. IMachine {540dcfda-3df2-49c6-88fa-033a28c2ff85

不能为虚拟电脑 win7 打开一个新任务. Virtual machine 'win7' has terminated unexpectedly during startup.  返回 代码: NS_ERROR_FAILURE (0x80004005) 组件: Machine 界面: IMachine {540dcfda-3df2-49c6-88fa-033a28c2ff85    

网上有人说升级内核会遇到此问题，给出的建议是

sudo /etc/init.d/vboxdrv setup

可是我的版本ubuntu9.10没有这个文件。

zhouhh@zhh64:/etc/init.d$ sudo find / -name "vboxdrv"  
/dev/vboxdrv  
/var/lib/dkms/vboxdrv  
/sys/devices/virtual/misc/vboxdrv  
/sys/bus/platform/drivers/vboxdrv  
/sys/class/misc/vboxdrv  
/sys/module/vboxdrv

 

/etc/init.d里面只有：

zhouhh@zhh64:/etc/init.d$ ls v*  
virtualbox-ose

  
试一下：

zhouhh@zhh64:/etc/init.d$ sudo ./virtualbox-ose setup  
Usage: ./virtualbox-ose {start|stop|stop_vms|restart|force-reload|status}  
zhouhh@zhh64:/etc/init.d$ sudo ./virtualbox-ose force-reload  
* Stopping VirtualBox kernel modules [ OK ]   
* Starting VirtualBox kernel modules

* Disabling the hardware performance counter framework [ OK ]

此时，终于可以看到启动界面，但还是不能进入windows，总是进入修复模式就重启。

 

没办法，新建一个虚拟电脑，但硬盘指向我原来的winxp.vdi，结果顺利启动了系统。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=750f2395-56dc-81f1-b5ef-27f4fbf7587e)
