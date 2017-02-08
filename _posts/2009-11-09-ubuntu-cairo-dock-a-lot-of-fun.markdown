---
author: abloz
comments: true
date: 2009-11-09 08:51:25+00:00
layout: post
link: http://abloz.com/index.php/2009/11/09/ubuntu-cairo-dock-a-lot-of-fun/
slug: ubuntu-cairo-dock-a-lot-of-fun
title: ubuntu很好玩的cairo-dock
wordpress_id: 947
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

09.11.9

windows vista有一些桌面上的小玩意，比如一个钟什么的，挺有意思的。

使用cairo-dock可以做到更酷的效果。通常的底下一排任务栏可以隐藏了，取而代之是一排强大的动态图标。

先秀一下我配置后的效果：

 

![dock](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091109/cairo-dock.png)

 

底下的图标和右上角的钟都是cairo-dock所带的。

 

1.安装前提

必须先安装好3D桌面软件compiz，并测试效果ok。

 

2. 安装cairo-dock

  1. zhouhh@zhhofs:~$ sudo apt-get install cairo-dock
  2. [sudo] password for zhouhh:
  3. 正在读取软件包列表... 完成
  4. 正在分析软件包的依赖关系树
  5. 正在读取状态信息... 完成
  6. 将会安装下列额外的软件包：
  7. cairo-dock-core cairo-dock-data cairo-dock-plug-ins cairo-dock-plug-ins-data
  8. cairo-dock-plug-ins-integration curl libgtkglext1 xdotool
  9. 下列【新】软件包将被安装：
  10. cairo-dock cairo-dock-core cairo-dock-data cairo-dock-plug-ins
  11. cairo-dock-plug-ins-data cairo-dock-plug-ins-integration curl libgtkglext1
  12. xdotool
  13. 共升级了 0 个软件包，新安装了 9 个软件包，要卸载 0 个软件包，有 114 个软件未被升级。
  14. 需要下载 6,174kB 的软件包。
  15. 解压缩后会消耗掉 13.3MB 的额外空间。
  16. 您希望继续执行吗？[Y/n]y

zhouhh@zhhofs:~$ sudo apt-get install cairo-dock [sudo] password for zhouhh:  正在读取软件包列表... 完成 正在分析软件包的依赖关系树        正在读取状态信息... 完成        将会安装下列额外的软件包：  cairo-dock-core cairo-dock-data cairo-dock-plug-ins cairo-dock-plug-ins-data  cairo-dock-plug-ins-integration curl libgtkglext1 xdotool 下列【新】软件包将被安装：  cairo-dock cairo-dock-core cairo-dock-data cairo-dock-plug-ins  cairo-dock-plug-ins-data cairo-dock-plug-ins-integration curl libgtkglext1  xdotool 共升级了 0 个软件包，新安装了 9 个软件包，要卸载 0 个软件包，有 114 个软件未被升级。 需要下载 6,174kB 的软件包。 解压缩后会消耗掉 13.3MB 的额外空间。 您希望继续执行吗？[Y/n]y    

3.运行

在“应用程序->附件”里有cairo-dock(no openGL)或GLX-Dock(cairo-dock with  OpenGL)——后者的图标会3维转动——点击执行，会看到桌面下方多了一排动态按钮，鼠标移上去时图标会放大。在图标上点右键，可以配置和管理主题。 我就是更新了缺省的theme，在配置里从网上获取了评分最高的theme。从下排按钮中拖了一个钟到桌面上。当不是锁定时，按alt+鼠标中键，可以修 改钟的大小。

下排图标都可以完全自定义。

 

4. 开机运行

将cairo-dock加入启动程序中。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=3ff2e35f-e011-80f7-aa4e-bcb3ca887d60)
