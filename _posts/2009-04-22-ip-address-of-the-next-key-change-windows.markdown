---
author: abloz
comments: true
date: 2009-04-22 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/04/22/ip-address-of-the-next-key-change-windows/
slug: ip-address-of-the-next-key-change-windows
title: windows下一键修改IP地址
wordpress_id: 905
categories:
- 技术
---

#  					 				

				

 					  					  					

笔记本经常带着家里和办公室两头跑，每次需要修改IP地址。有没有方便的办法修改呢？

我同事用lisp写了个脚本，如下：

(when (setq ip (main-args 2))  
(println ip)  
(process (format "netsh interface ip set address "本地连接" static 192.168.11.%s 255.255.255.0 192.168.11.1 1" ip)))  
(process "route add 192.168.29.0 mask 255.255.255.0 192.168.11.60")  
(process "route add 192.168.12.0 mask 255.255.255.0 192.168.11.60")  
(process "route -p add 10.1.1.11 mask 255.255.255.255 192.168.11.254")  
;;(process "net use z: \192.168.0.2root")  
(println "done")  
(exit)

改改可以修改为一个setip_office.bat文件，如下：

  1. netsh interface ip set address "本地连接" static 192.168.11.123 255.255.255.0 192.168.11.1 1
  2. route add -p 192.168.12.0 mask 255.255.255.0 192.168.11.60   

写两个这样的文件放在桌面，在公司执行公司的，在家执行家里的。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=92582603-a1f2-8d19-817b-7c5685096c65)
