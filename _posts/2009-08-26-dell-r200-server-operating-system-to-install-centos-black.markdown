---
author: abloz
comments: true
date: 2009-08-26 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/08/26/dell-r200-server-operating-system-to-install-centos-black/
slug: dell-r200-server-operating-system-to-install-centos-black
title: Dell R200 服务器安装Centos操作系统黑屏
wordpress_id: 927
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文 09.8.26

服务器安装有时会遇到一些问题。我让一位刚毕业的硕士去安装一台Dell R200服务器，装CentOS 5.2. 他根据说明顺利安装完了，安装过程没有报任何错误。可就是起不来。一启动完udev就黑屏。于是我又和他一起重装，把过程记录一下，也许对后来者有用。

 

Dell服务器说明书说的是安装操作系统前需用其自带光盘启动，选“DELL(TM) SYSTEMS BUILD AND UPDATE UTILITY ”，一步一步，最后提示放入操作系统盘再放入。否则会导致SATA驱动不支持，找不到硬盘的问题。

使用Dell自带的“DELL(TM) SYSTEMS BUILD AND UPDATE UTILITY 1.0.3”光盘，可以预先进行配置，光盘分区。但缺省只支持如下的操作系统：

* Microsoft(R) Windows(R) 2000 Server (SP4)   
* Microsoft Windows Server(R) 2003, SBS (SP2, R2)   
* Microsoft Windows Server 2003 x86, x86_64 Edition SP2 and SP2 R2  
* Microsoft Windows Server 2008 Standard and Enterprise Editions (x86)  
and (x86_64)  
* Red Hat Enterprise Linux (version 4) for x86  
* Red Hat Enterprise Linux (version 4) for x86_64  
* Red Hat Enterprise Linux (version 5) for x86  
* Red Hat Enterprise Linux (version 5) for x86_64  
* SUSE (R) Linux Enterprise Server version 9, (SP4) x86_64  
* SUSE Linux Enterprise Server version 10 x86_64  
* VMware ESX 3.5

 

选了Red Hat Enterprise Linux (version 5) for x86，系统几分钟后会提示放入RHEL5操作系统安装盘。

这时放入CentOS5.2的安装盘，提示是不是RHEL5安装盘，直接弹出。

 

如果想安装支持列表之外的操作系统，可能会遇到SATA驱动的问题，导致找不到硬盘。我们安装SUSE 10 professional时就碰到光驱和硬盘都找不到的问题。用下面的驱动也不好使。最后只好去下了个企业版来安装。

查到网上一个资料，对早一点版本的CentOS，需下载一个sata驱动：

 

[](http://blog.csdn.net/ablo_zhou/archive/2009/08/26/4485382.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/08/26/4485382.aspx#)

  1. “下载地址：
  2. http://www.hellophp.cn/wp-content/uploads/2008/08/ata_piix-2001dell-manykernels-ddimg
  3. 将 这个驱动放入U盘中，然后插到服务器上，用CENTOS5光盘启动，在选择安装模式时输入linux dd，然后它会自动加载U盘，然后问你哪个盘里面有 驱动程序，选择sda，即你的U盘，然后选择那个驱动程序，加载完成后它还会继续问你要加载驱动，这时候选择NO，然后安装程序就会象平常一样开始正常的 安装系统了。
  4.   5. source from：http://www.diybl.com/course/6_system/linux/Linuxjs/2008810/135436.html
  6.   7. ”

“下 载地址： http://www.hellophp.cn/wp-content/uploads/2008/08/ata_piix-2001dell- manykernels-ddimg 将这个驱动放入U盘中，然后插到服务器上，用CENTOS5光盘启动，在选择安装模式时输入linux  dd，然后它会自动加载U盘，然后问你哪个盘里面有驱动程序，选择sda，即你的U盘，然后选择那个驱动程序，加载完成后它还会继续问你要加载驱动，这时 候选择NO，然后安装程序就会象平常一样开始正常的安装系统了。  source  from：http://www.diybl.com/course/6_system/linux/Linuxjs/2008810 /135436.html  ”    

我们安装CentOS5.2 没有碰到找不到光驱和硬盘的问题，直接用Centos安装即可。安装一切顺利，但重启后遇到udev 加载完毕后立即黑屏的问题。这时用ALT+CTRL+F2切换都不能响应。

因为我们安装时选的图形安装，缺省启动是图形界面。据网上有人说ATI的显卡Linux下支持是有问题的。而R200就是ATI显卡。这时可以将缺省启动修改为3，字符界面。

但问题时系统没有启动完就黑屏，根本启动不了。用启动盘启动，到需要next时ALT+CTRL+F2，里面/etc的配置不是要安装的系统的配置。需要mount新安装的硬盘。

#fdisk -l

/dev/sda1 .... dell support

/dev/sda2 linux

/dev/sda3 linux LVM

 

#mkdir /mnt/os

#mount /dev/sda3 /mnt/os

error 

提示文件系统有问题或非法的文件。

因为/dev/sda3 是linux LVM,逻辑卷，不能挂载。而vgscan,vgchange这些命令都没有。

 

这时，用到我上篇转载的《Linux 系统的单用户模式、修复模式、跨控制台登录在系统修复中的运用》，用恢复模式进入系统，自动将/dev/sda3 挂载到了/mnt/sysimage 

#cd /mnt/sysimage

#vi etc/inittab

将id:5:default:

改为id:3:default:

#vi etc/X11/xorg.conf

看到里面的配置项少，可能有问题。

#chroot /mnt/sysimage

#exit

重启后，直接进入了字符界面。  
不会是黑屏了，解决了基本问题。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=6dc40183-689b-891d-9b5c-6fa38af2ab0b)
