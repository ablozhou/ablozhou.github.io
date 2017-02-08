---
author: abloz
comments: true
date: 2007-07-03 02:02:09+00:00
layout: post
link: http://abloz.com/index.php/2007/07/03/telnet-client-to-use-the-mainstream-and-more-difficult/
slug: telnet-client-to-use-the-mainstream-and-more-difficult
title: 主流远程登录客户端使用难点和比较
wordpress_id: 219
categories:
- 技术
tags:
- linux
- pietty
- putty
- securecrt
- ssh
- ssh secure shell
- vnc client
- xmanager
---

本文可以免费自由使用，但不得去掉作者信息。
作者: [ablo](http://blog.csdn.net/ablo_zhou/archive/2007/07/03/blog.csdn.net/ablo_zhou)
主 页：http://blog.csdn.net/ablo_zhou
Email:ablozhou at gmail.com
日 期：2007.7.3，2010.7.22有修改补充

搞Linux开发维护的，经常用到远程登录客户端。Windows下比较著名的产品有SecureCRT，SSH  Secure    Shell，Xmanager，PuTTY/PieTTY，vnc client。linux下就很方便了，自带ssh客户端，scp命令直接可以用。上传下载都很简单。本文对windows下这些远程登录软件进行比较评价，偏重于解决字体和乱码问题，并介绍这些客户端的文件上传下载能力。VNC client以后专文介绍。

本人比较偏向于Linux带彩色的文 本终端，黑底彩字，而且字体要比较肥厚，可以长时间操作。我觉得VC6.0编辑窗口的缺省的字体，就非常舒服。而这些软件缺省的界面，往往是白底黑字，字 型黑瘦，有的没有彩色输出，在现在分辨率越来越高的显示器下效果不好，长时间使用眼睛非常疲劳。有的缺省配置不支持中文，所以也是本文关注重点。而对 Xmanager，则重点在于如何能够在远程使用XWindows。


## 1.PieTTY


Putty是英国人开发的非常小巧 的终端，PieTTY是台湾人林弘德（Hung-Te Lin,  piaip）在PuTTY基础上开发的，增加了对亚洲语言的支持，所以使用PieTTY对中文支持是挺不错的。PieTTY是一款免费软件，非常小巧，才 300多K，对中文支持也非常好。其最新版是2005年6月14日发布的0.3.27,可以到http://ntu.csie.org/~piaip /pietty/ 下载。
美化和解决中文乱码问题的配置：在登录时去掉English  UI的选项，进去后是繁体中文菜单。在“选项”->字型菜单，设置字体为新宋体，粗体，小四。在汉字繁简转换选中将繁体转为简体。将“字源编码”选 为Unicode-UTF8。在服务器端查看一下locale，如果不是zh_CN.UTF8，则在.bashrc中编辑输入export  LANG=zh_CN.UTF8。重新登入，就能看见和输入中文。

上传文件，将文件直接拖到pietty的窗口，在弹出对话框输入用户名密码和路径，即可上传。但没有直接下载文件的能力。需用scp从linux下载文件到windows。

对于远程xwindow操作，pietty/putty也有x转发能力。只是windows下需安装Xwindow服务器，如X-Win32,还有Exceed等。
![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/pietty.PNG)


## 2.SSH  Secure Shell


该软件是共享软件，对个人用户免费。我没有找到很好解决中文乱码问题的方法。没有地方可以设置终端输出的字符编码。自 带一个文件传输windows程序，方便使用。在没有中文的环境下还是不错的。
设置：Edit->Settings, Global  Settings->Appearance,设置Font为Terminal  12,设置Colors的Foreground为white，Background为black，选中ANSI  color复选框。即可看到比较舒服的界面。
文件传输，可以在Windows菜单下选new file transfer或new file  transfer in current directory，即可进入文件传输窗口。
![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/secureShell.PNG)


## 3.SecureCRT


SecureCRT  最新版本是5.5, 该软件是商业软件。在5.0以前对中文支持很不好，不能输入中文，拷贝中文也出现乱码。最新版支持Windows  Vista，多个Session同时连接，对中文支持也好了很多。尽管输出的配置中文还是只能配UTF8。
美化和中文支持配置：菜单 Options->Session  options,在Terminal项，Emulation的Terminal选Linux，在Appearance项，Color scheme  选Taditional,Fonts里面选 Terminal 14,黑体，Character选UTF-8.  在服务端，同样修改.bashrc,加入export LANG=zh_CN.UTF8，再进入就能看见和输入中文了。![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/secureCRT.PNG)
文 件传输：菜单  Transfer里面有文本，Xmodem和Zmodem。文本传输可以传输文本文件。而Xmodem支持单个文件的传输。Zmodem支持多个文件的传 输。在Session Options的对话框，可以配置Xmodem和Zmodem在本地的上传和下载的文件夹。
在终端中输入rz，将本地多个 文件传入服务器。输入 sz 跟文件名，将文件传入本地。支持通配符。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/secureCRTup.PNG)


## 4.Xmanager


Xmanager是韩国Netsarang公司开发的一款非常优秀的远程登录软件，支持 Xwindows，即可以远程使用图形桌面。该软件是商业软件，最新版V2.1。具有相同功能的软件有X-Win32,最新版本V8，还有Exceed 等，都是商业或共享软件。

![xbrowser](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/xmanager1.PNG)
Xmanager  有两个可以远程使用X桌面的程序，一个XBrowser（XDMCP），一个是Xstart。前者在操作系统配置正确的情况下，可以全面控制桌面。后者倾 向于运行单个程序。Xbrowser  可以自动发现远程机器，跟Windows网上邻居一样，双击计算机图标即可登录，而且对中文支持非常好，速度也很快，不需要配置。
![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/xbrowser.PNG)
安 全连接通道：由于XDMCP是通过UDP连的，所以不能建立安全连接。如果有这个需要，可以通过XStart建一个SSH的连接，Execution  Command 选Xterm（Linux），其命令行为/usr/X11R6/bin/xterm -ls -display $DISPLAY,  选run。连接成功后，对KDE，运行**startkde**,对 gnome，运行**gnome-session**，即启动 Xwindows，注意，不是startX命令。

在私网内部使用远程登录Xwindows：因为使用Xwindows，必须要往本机发送 信息。所以不能直接使用Xbrowser。  要想通过XDMCP使用SSH通道连接，就比较繁琐。首先，要启动Xshell，新建一个Session，Protocol选SSH，输入用户名，密码。 点Setup按钮，在弹出对话框中选Tunneling页，新建一个TCP/IP forwarding，点Add按钮，在Forwarding  Rule中，Type选Incoming，Listen Port输入6020，目标Destination  host选localhost，Destination port同样选6020，OK。全部确定，保存。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/Image00000.jpg)

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/Image00001.jpg)再 进入Xbrowser，Tools菜单，Options，新建地址中输入目标地址，加入到列表中。确定后，看到一个图标在Xbrowser内，将其 save  as一个新的，在新的图标上点右键，选属性，设置Proxy选项，Host输入0.0.0.0，端口输入6020.再选Xserver页，在 Display Number中，去掉复选的自动分配显示号，在输入框中输入20.  输入20是因为上面配置Proxy时的端口是6020，取后面三位作为显示数。如果Proxy端口是6230，则显示数输入230.
确定保存后， 双击该图标，即可在私网中通过SSH通道使用Xwindow了。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/Image00002.jpg)

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/Image00003.jpg)
