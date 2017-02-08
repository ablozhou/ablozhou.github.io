---
author: abloz
comments: true
date: 2010-01-25 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/01/25/virtualbox-windows-operating-system-installation-problems/
slug: virtualbox-windows-operating-system-installation-problems
title: virtualbox 安装windows操作系统遇到的问题
wordpress_id: 1028
categories:
- 技术
---

#  					 				

				

 					  					  					  

1.安装windows7 的oem 版，结果在信息检查时报错：找不到DVD光驱的驱动。但安装文件就是从光驱读出来的。想从光驱拷贝内容到虚拟机硬盘，结果报错，拷贝失败。

 

2.安装ghost的xp，先用paragon partition manager分区为C,D两个盘，进入winpe,  安装ghost时提示“未发现作用分区，请恢复镜像后激活第一分区”。不管，直接安装。安装完毕重启，报 "int18 boot  failure"，这是没有启动硬盘的错误。

 

3.进入winpe，看到有个7.8M的主分区，而C盘，D盘都是逻辑分区。将C 盘用ppm设为主分区，并设为活动分区，启动问题解决。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=b4b46ddf-1d29-8981-aad2-7567f4017431)
