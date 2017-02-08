---
author: abloz
comments: true
date: 2009-11-08 08:49:54+00:00
layout: post
link: http://abloz.com/index.php/2009/11/08/were-using-the-3d-desktop-ubuntu/
slug: were-using-the-3d-desktop-ubuntu
title: 用上了ubuntu的3D 桌面
wordpress_id: 943
categories:
- 技术
---

#  					 				

				

 					  					  					

ubuntu 9.10 执行安装：

 

sudo apt-get install compizconfig-settings-manager

zhouhh@zhhofs:~$ sudo apt-get install compizconfig-settings-manager  
[sudo] password for zhouhh:   
正在读取软件包列表... 完成  
正在分析软件包的依赖关系树   
正在读取状态信息... 完成   
将会安装下列额外的软件包：  
python-compizconfig  
下列【新】软件包将被安装：  
compizconfig-settings-manager python-compizconfig  
共升级了 0 个软件包，新安装了 2 个软件包，要卸载 0 个软件包，有 114 个软件未被升级。  
需要下载 676kB 的软件包。  
解压缩后会消耗掉 4,329kB 的额外空间。  
您希望继续执行吗？[Y/n]y  
获取：1 http://mirrors.sohu.com karmic/universe python-compizconfig 0.8.2-0ubuntu1 [37.9kB]  
获取：2 http://mirrors.sohu.com karmic/universe compizconfig-settings-manager 0.8.2-0ubuntu1 [638kB]  
下载 676kB，耗时 11 秒 (59.5kB/s)   
选中了曾被取消选择的软件包 python-compizconfig。  
(正在读取数据库 ... 系统当前总共安装有 124032 个文件和目录。)  
正在解压缩 python-compizconfig (从 .../python-compizconfig_0.8.2-0ubuntu1_i386.deb) ...  
选中了曾被取消选择的软件包 compizconfig-settings-manager。  
正在解压缩 compizconfig-settings-manager (从 .../compizconfig-settings-manager_0.8.2-0ubuntu1_all.deb) ...  
正在处理用于 desktop-file-utils 的触发器...  
正在处理用于 hicolor-icon-theme 的触发器...  
正在设置 python-compizconfig (0.8.2-0ubuntu1) ...  
正在设置 compizconfig-settings-manager (0.8.2-0ubuntu1) ...  


成功后，就可以玩3D 桌面了。

 

在“系统->首选项->CompizConfig配置管理器"中，可以配各种效果。

将3D窗口，桌面立方体，旋转立方体选中，震颤窗口选中，将环形切换或轮转切换条选中，并配置下一个窗口为alt-tab。

 

在“系统->首选项->外观”里选“视觉效果”标签，选中“扩展（X）“即可。

 

在右下角工作区点右键，选首选项，将列设为4.

 

拖动窗口看到波动效果，用鼠标中键按下拖动可以看到3维的桌面，用alt-tab可以看到3维的窗口切换，ctrl-alt+上下左右方向键看到退后对桌面。

 

ubuntu我没有专门安装显卡驱动，在IBM T40和一台组装机上安装3D桌面均成功。

 

但3D 桌面直接抓图不太方便，如下是我的3D桌面效果。

 

3D切换窗口：

![切换](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091109/Screenshot-1.png)

 

3D桌面![3d桌面](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091109/Screenshot-2.png)

 

参考：[3d桌面完全教程](http://forum.ubuntu.org.cn/viewtopic.php?f=94&t=140531)

  


  
  


![](http://img.zemanta.com/pixy.gif?x-id=7d239347-3a36-850f-95aa-1896bad66a44)
