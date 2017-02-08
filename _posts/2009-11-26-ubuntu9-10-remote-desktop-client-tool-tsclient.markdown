---
author: abloz
comments: true
date: 2009-11-26 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/11/26/ubuntu9-10-remote-desktop-client-tool-tsclient/
slug: ubuntu9-10-remote-desktop-client-tool-tsclient
title: ubuntu9.10 的远程桌面客户端工具tsclient
wordpress_id: 956
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

09.11.26

 

_需求来源，linux对windows远程桌面进行管理，操作服务器数据库和网站等。_

linux  下有时候也需要对windows服务器进行管理，访问windows的远程桌面。这可以用rdesktop。而tsclient可以通过rdesktop 对windows远程桌面进行访问，不过需要windows 打开终端服务。tsclient除了支持rdesktop(支持Microsoft  Windows RDP，RDPv5远程桌面协议）,还支持vnc xdmcp(xnest),wfica.

 

1.安装

  
apt-get install tsclient

  
2.远程控制windows

tsclient支持rdesktop(支持Microsoft Windows RDP，RDPv5远程桌面协议）,vnc xdmcp(xnest),wfica.

是个不错的客户端。

 

需先安装rdesktop，才能支持RDP协议。rdesktop是命令行程序，tsclient利用其对windows进行远程桌面连接：

apt-get install rdesktop

 

2.1 登录windows

 

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091126/Screenshot-%E7%BB%88%E7%AB%AF%E6%9C%8D%E5%8A%A1%E5%AE%A2%E6%88%B7%E7%AB%AF.png)

22.40这台服务器是windows 2003，远程桌面端口设置为60066. 对MS windows 远程桌面，协议选RDP 或 RDP v5.

点连接后进入。

![tsclient](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091126/60066%20-%20%E7%BB%88%E7%AB%AF%E6%9C%8D%E5%8A%A1%E5%AE%A2%E6%88%B7%E7%AB%AF%27.png)

 

2.2 与本地文件共享

配置本地资源

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091126/Screenshot-%E7%BB%88%E7%AB%AF%E6%9C%8D%E5%8A%A1%E5%AE%A2%E6%88%B7%E7%AB%AF-1.png)

选中“添加我的本地磁盘到远程计算机”，点连接。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091126/Screenshot-3.png)

可以看到 其他栏的本地磁盘。点击进入即开始访问本地磁盘，可以和windows互相拷贝，省去配置ftp或samba等磁盘共享方式：

![share](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091126/60066%20-%20%E7%BB%88%E7%AB%AF%E6%9C%8D%E5%8A%A1%E5%AE%A2%E6%88%B7%E7%AB%AF%27-1.png)

  

3. 使用VNC 协议

在安装了 rdesktop软件后，tsclient支持RDP协议，但VNC和XDMCP,ICA仍然是灰的。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091126/Screenshot-%E7%BB%88%E7%AB%AF%E6%9C%8D%E5%8A%A1%E5%AE%A2%E6%88%B7%E7%AB%AF-2.png)

要支持vncviewer，需安装相应软件：

sudo apt-get install xtightvncviewer 

 

安装完毕，协议里vnc 变黑，选择该协议

服务器地址22.31是linux，并且配置了vnc服务器。 冒号后1标示第1个显示端口。

由于vncserver每个用户均可启动多个，所以用户用:1,:2等来标示不同的显示端口。连接时需指定连到哪个显示端口。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091126/Screenshot-%E7%BB%88%E7%AB%AF%E6%9C%8D%E5%8A%A1%E5%AE%A2%E6%88%B7%E7%AB%AF-3.png)

点连接，输入该显示端口的密码：

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091126/Screenshot-passwd-1.png)

进入vncviewer，操控远程linux桌面（如果windows 安装了vncserver也可以控制）

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091126/Screenshot-4.png)

 

4. 使用XDMCP

 

参考：

 
    
    Linux下远程管理Windows服务器(上) ： http://server.it168.com/server/2007-10-16/200710161443031.shtml

  
  


![](http://img.zemanta.com/pixy.gif?x-id=b4e1ce9c-583a-8a9b-9d85-fe7b12f6fb33)
