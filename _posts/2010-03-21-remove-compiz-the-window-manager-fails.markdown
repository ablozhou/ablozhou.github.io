---
author: abloz
comments: true
date: 2010-03-21 06:47:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/21/remove-compiz-the-window-manager-fails/
slug: remove-compiz-the-window-manager-fails
title: 删除compiz之后，窗口管理器失败
wordpress_id: 1172
categories:
- 技术
---

周海汉 /文

2010.3.21

ubuntu缺省安装了compiz. 我将compiz删光了，结果启动系统后，没有window manager了。窗口打开后没有边框，不能移动，不能切换，甚至不能获取鼠标点击的焦点。

搜了搜，发现这是个bug，https://bugs.launchpad.net/ubuntu/+source/gnome-session/+bug/132772

据说debian的脚本没有问题。删除compiz后，可以自动用metacity来代替，而ubuntu9.10有问题。

临时解决办法：

在shell里执行：

metacity --replace

最终解决办法：

1.安装fusion-icon，可以切换window manager

http://tombuntu.com/index.php/2007/08/26/compiz-fusion-tray-icon/

2.想偷懒，将compiz再装上

3.从debian去下载/usr/bin/gnome-wm

没有试过。ubuntu该脚本在删除compiz后，还执行compiz，所以导致执行失败。牛人可以自己修改调试该脚本，将compiz替换为metacity

3.自己配置metacity自启动[Desktop Entry]

cd ~/.config/autostart

vi metacity.desktop

输入：

Encoding=UTF-8
Version=2.28.0
Type=Application
Name=metacity
Comment=metacity
Exec=metacity
StartupNotify=false
Terminal=false
Hidden=false

或者在“系统”-“首选项”-“启动应用程序”里，添加上metacity.  
  


![](http://img.zemanta.com/pixy.gif?x-id=f8404ffd-dcc1-8029-b1f5-c8a7fc904acc)
