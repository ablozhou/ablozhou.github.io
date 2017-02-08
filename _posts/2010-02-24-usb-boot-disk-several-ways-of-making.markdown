---
author: abloz
comments: true
date: 2010-02-24 06:05:12+00:00
layout: post
link: http://abloz.com/index.php/2010/02/24/usb-boot-disk-several-ways-of-making/
slug: usb-boot-disk-several-ways-of-making
title: usb 启动盘制作的几种办法
wordpress_id: 1151
categories:
- 技术
---

# 







## [周海汉](http://blog.csdn.net/ablo_zhou) /文


2010.2.24

[http://blog.csdn.net/ablo_zhou](http://blog.csdn.net/ablo_zhou)

USB启动盘越来越流行了。因为一些轻便的笔记本，根本就没有光驱。带U盘比带光盘还是方便一点。

本文关注windows启动盘的制作，以windows 7 iso为例。首先，准备一个win7.iso，是win7的安装盘镜像。该镜像可以在微软的[在线 store](http://store.microsoft.com/home.aspx)买到。另外，准备一个不低于4G的空U盘，格式化为FAT32。

以下是一些可行的办法。但USB的安装盘还是可能会有莫名其妙的错误。需要多尝试。


## 1.使用Windows 7 USB/DVD Download Tool


这个号称是傻瓜工具，但我试用时发现并不那么好用。

相关信息：[http://store.microsoft.com/Help/ISO-Tool](http://store.microsoft.com/Help/ISO-Tool)

下载页面：[http://images2.store.microsoft.com/prod/clustera/framework/w7udt/1.0/en-us/Windows7-USB-DVD-tool.exe](http://images2.store.microsoft.com/prod/clustera/framework/w7udt/1.0/en-us/Windows7-USB-DVD-tool.exe)

安装usb tool时，提示缺Image Mastering API v2.0 (IMAPIv2.0) for Windows XP (KB932716)，中文名

Windows XP 的映像控制 API v2.0 (IMAPIv2.0) (KB932716)。下载页面：[http://www.microsoft.com/downloads/details.aspx?FamilyID=b5f726f1-4ace-455d-bad7-abc4dd2f147b&displayLang=zh-cn](http://www.microsoft.com/downloads/details.aspx?FamilyID=b5f726f1-4ace-455d-bad7-abc4dd2f147b&displayLang=zh-cn)

不过需要正版验证。

可能还需要.net 2.0 以上的framework.下载：[http://www.microsoft.com/downloads/details.aspx?FamilyID=0856EACB-4362-4B0D-8EDD-AAB15C5E04F5&displaylang=en](http://www.microsoft.com/downloads/details.aspx?FamilyID=0856EACB-4362-4B0D-8EDD-AAB15C5E04F5&displaylang=en)

但我在使用Windows 7 USB/DVD Download Tool 时，报错：

the selected file is not a valid iso file windows 7 usb，please select a valid ISO file and try again。

因为我的是直接拷的win7.iso。据成功的反应，如果是购买的微软的iso则拷贝到U盘和DVD都没有问题。

很多人遇到此问题，有人提出了解决办法，[在这里](http://www.withinwindows.com/2009/11/01/use-the-windows-7-usbdvd-download-tool-with-custom-isos/)（英文）。他提供了一个[工具](http://withinwindows.com/files/isoavdpcopy/isoavdpcopy_0.1.zip)。直接在cmd下面执行isoavdpcopy iso_file.

也有人用如下的方法创建win7 usb tool兼容的iso：

oscdimg -lWindows_7 -u2 -bC:DVD_DataBootetfsboot.com C:DVD_Data C:Win7.iso

说明：[http://technet.microsoft.com/en-us/library/cc749036%28WS.10%29.aspx](http://technet.microsoft.com/en-us/library/cc749036%28WS.10%29.aspx)


## 2. 使用ms-diskpart


假如U盘为F：

先将U盘格式化为NTFS。

要将U盘格式为NTFS，必须在U盘的属性的策略里，将其改为“为提高性能而优化”

FORMAT F: /FS NTFS

DISKPART
LIST DISK
SELECT DISK x (x是上一个命令的#编号）

SELECT PARTITION 1
ACTIVE
EXIT

但我使用时，发现list disk没有U盘。

C:>DISKPART

Microsoft DiskPart 版本 5.1.3565

版权所有 (C) 1999-2003 Microsoft Corporation.
位于计算机: ZHOU-HAI-HAN

DISKPART> list disk

  磁盘 ###  状态      大小     可用     动态  Gpt
  --------  ----------  -------  -------  ---  ---
  磁盘 0    联机           233 GB      0 B

DISKPART> select disk 0

磁盘 0 现在是所选磁盘。

DISKPART>

解决办法：

用Lexar Bootit工具将U盘改为固定硬盘(fix disk)。

再将win7.iso用daemon等虚拟光驱挂载，如挂在Z：盘

z:

CD BOOT
BOOTSECT /NT60 F:

XCOPY Z: F: /S/E


## 3.ultraiso


用ultraiso premium 9.3.3以上版本打开win7.iso

从启动菜单点“写入硬盘映像”，硬盘选中U盘。（Bootable” 与 “Write Disk Image”.）


## 4.poweriso(完全版)


打开菜单“文件”，“属性”，check UDF，点Ok。保存即可。


## 5.  使用7-zip


USB格式化为fat32

用7-zip将win7.iso解压到USB盘，即可启动。


## 6.ubuntu (or ubuntu live cd)


1. sudo fdisk -l （U盘：/dev/sdb (盘), /dev/sdb1 (分区)）
2. sudo dd if=/dev/zero of=/dev/sdb/ bs=1M count=1
3. sudo blockdev --rereadpt /dev/sdb
4. usb-creator-gtk

在图形界面选好win7.iso或dvd，生成U盘启动盘。


## 7.将usb盘烧成usb-cdrom,usb-hdd


下载芯片精灵，查看U盘芯片，记下vid，pid

下载相应的芯片的usb量产工具，设置相应参数，指定win7.iso量产。

这个看似比较有前途，不过目前我没有成功。

网上有相应图文教程。

以上的方法，我只有部分验证，只提供一下思路。每一个人的情况不一样，不打包票成功。






![](http://img.zemanta.com/pixy.gif?x-id=31253185-5354-8ade-9027-d9cc1e396ace)
