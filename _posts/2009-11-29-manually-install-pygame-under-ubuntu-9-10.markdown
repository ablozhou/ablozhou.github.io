---
author: abloz
comments: true
date: 2009-11-29 09:19:00+00:00
layout: post
link: http://abloz.com/index.php/2009/11/29/manually-install-pygame-under-ubuntu-9-10/
slug: manually-install-pygame-under-ubuntu-9-10
title: ubuntu 9.10 下手动安装pygame
wordpress_id: 973
categories:
- 技术
---

周海汉 /文  
ablozhou @ gmail.com  
http://blog.csdn.net/ablo_zhou  
2009.11.29

  
pygame.org网站被GFW封锁，大陆不能直接下载。pygame依赖SDL等其他库，都给安装造成一定麻烦。不过，相对于平台无关的强大的使用python语言的游戏开发，这些都不算什么了。

 

1. 简介

pygame 是基于对 SDL库的python 封装，提供python接口。SDL（Simple DirectMedia Layer)  是一个跨平台的游戏开发库，方便游戏开发和移植。目前最新版本SDL1.2.14.  下载地址：http://www.libsdl.org/download-1.2.php. SDL库作者Sam  Lantinga，采用C语言开发。SDL还有perl, erlang, Pango,ruby等语言的封装。  
pygame 作者是Pete Shinners，目前最新稳定版本1.91。

  
  
2. 下载  
pygame 官网http://www.pygame.org，但被变态的GFW屏蔽了。想去官网访问只好学会穿墙。另外有些第三方的下载，看你运气如何了。

或通过apt-get 直接安装。

sudo apt-get install python-pygame

如果是直接下载的，则需要手动配置如下的软件。  
  
3. 安装SDL  
我下载的是pygame-1.9.1release.tar.gz，2MB大小。解压后进入目录执行  
python config.py  
提示  
sh: sdl-config: not found  
sh: smpeg-config: not found  
  
SDL没有安装，执行  
sudo aptitude install libsdl1.2-dev  
下列“新”软件包将被安装。  
libaa1-dev{a} libasound2-dev{a} libaudio-dev{a} libaudiofile-dev{a}   
libcaca-dev{a} libdirectfb-dev{a} libdirectfb-extra{a} libesd0-dev{a}   
libfreetype6-dev{a} libgl1-mesa-dev{a} libglu1-mesa-dev{a} libice-dev{a}   
libjpeg62-dev{a} libncurses5-dev{a} libpng12-dev{a} libpthread-stubs0{a}   
libpthread-stubs0-dev{a} libsdl1.2-dev libslang2-dev{a} libsm-dev{a}   
libsysfs-dev{a} libx11-dev{a} libxau-dev{a} libxcb1-dev{a}   
libxdmcp-dev{a} libxext-dev{a} libxt-dev{a} mesa-common-dev{a}   
x11proto-core-dev{a} x11proto-input-dev{a} x11proto-kb-dev{a}   
x11proto-xext-dev{a} xtrans-dev{a} zlib1g-dev{a}   
大概有10M 会下载安装。  
  
其余源码和其他平台的安装包如rpm可以访问  
http://www.libsdl.org/download-1.2.php  
找到。  
  
4. 安装其他必须软件  
再执行python config.py  
提示  
Hunting dependencies...  
sh: smpeg-config: not found  
WARNING: "smpeg-config" failed!  
SDL : found 1.2.13  
FONT : not found  
IMAGE : not found  
MIXER : not found  
SMPEG : not found  
PNG : not found  
JPEG : not found  
SCRAP : not found  
PORTMIDI: not found  
PORTTIME: not found

 

可以忽略这些组件继续安装，但某些效果无法得到。  
执行如下命令安装缺失组件。

sudo apt-get install libsdl-image1.2-dev libsdl-mixer1.2-dev  libsdl-ttf2.0-dev libsdl-gfx1.2-dev libsdl-net1.2-dev libsdl-sge-dev  libsdl-sound1.2-dev libportmidi-dev libsmpeg-dev  
其中mixer是混音库，sound是声音库，ttf是字体库，gfx,sge,image都是图形处理的。smpeg是播放mpeg电影的。midi是处理midi声音的。  
  
如果python没有安装开发库，也会导致pygame不能安装  
sudo apt-get install python2.6-dev  
根据机器python版本安装相应的开发库。我的python是2.6.4版本，所以安装2.6的开发库。  
还需安装python的numeric库，用于处理向量和数值计算，某些游戏需要。  
sudo apt-get install python-numeric python-numpy python-scipy  
  
5. 安装pygame.再次执行  
sudo ./config.py  
Hunting dependencies...  
SDL : found 1.2.13  
FONT : found  
IMAGE : found  
MIXER : found  
SMPEG : found 0.4.5  
PNG : found  
JPEG : found  
SCRAP : found  
PORTMIDI: found  
PORTTIME: found  
  
执行  
sudo python setup.py  
成功后pygame即安装完毕。如果有问题再根据错误安装相应软件和库。  
  
6.试用pygame  
进入examples,执行  
chmod +x *  
./aliens.py  
会看到一个坦克大战的游戏，可以试试其他游戏。下面是我的pygame游戏画面，可以听到音乐和开炮，爆炸的音效。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091129/Screenshot-Pygame%20Aliens.png)

  
  


![](http://img.zemanta.com/pixy.gif?x-id=ac21247a-c237-8741-b468-d7c7ba7467a2)
