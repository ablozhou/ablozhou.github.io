---
author: abloz
comments: true
date: 2010-05-19 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/05/19/compile-ffmpeg-ubuntu-10-04/
slug: compile-ffmpeg-ubuntu-10-04
title: ubuntu 10.04 编译ffmpeg
wordpress_id: 1226
categories:
- 技术
---

周海汉 /文

2010.5.19

 

==========

1.预备：

==========

sudo apt-get install build-essential libxvidcore4-dev libfaad-dev libfaac-dev libmp3lame-dev subversion

E: 无法找到软件包 libxvidcore4-dev

但在ubuntu 9.10中该库是存在的。

后面发现ubuntu 报的[bug](https://bugs.launchpad.net/ubuntu/+source/xvidcore/+bug/500044) ，该文件名改成了libxvidcore-dev

 

zhouhh@zhh64:~/ffmpeg$ sudo apt-get install libxvidcore-dev  
正在读取软件包列表... 完成  
正在分析软件包的依赖关系树   
正在读取状态信息... 完成   
下列【新】软件包将被安装：  
libxvidcore-dev

 

==========

2.下载ffmpeg

==========

 	 	 	 	 	<!-- 		@page { margin: 2cm } 		P { margin-bottom: 0.21cm } 	-->

zhouhh@zhh64:~$ svn checkout svn://svn.ffmpeg.org/ffmpeg/trunk ffmpeg

 

========

3.编译

========

 	 	 	 	 	<!-- 		@page { margin: 2cm } 		P { margin-bottom: 0.21cm } 	-->

编译安装：

zhouhh@zhh64:~$ cd ffmpeg/

zhouhh@zhh64:~/ffmpeg$ ./configure --enable-gpl --enable-libmp3lame --enable-libxvid --enable-libfaac --enable-nonfree  
zhouhh@zhh64:~/ffmpeg$ make

zhouhh@zhh64:~/ffmpeg$ sudo make install

  
  


![](http://img.zemanta.com/pixy.gif?x-id=672100ca-990f-8a2c-8618-2b3d55c77fa8)
