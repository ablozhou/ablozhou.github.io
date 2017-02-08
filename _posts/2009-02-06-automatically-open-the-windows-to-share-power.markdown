---
author: abloz
comments: true
date: 2009-02-06 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/02/06/automatically-open-the-windows-to-share-power/
slug: automatically-open-the-windows-to-share-power
title: 开机自动打开windows共享
wordpress_id: 889
categories:
- 技术
---

打印机放在windows共享中，但需要输入密码。因此缺省的打印机是不能用的。

解决办法：将共享的命令放入Print.bat文件里，再将该文件快捷方式放入windows的启动。就不用每次打印前辛苦输入[\xx.xx.xx.xx](file:///) 再输入用户名密码了。

 

假如要访问的文件共享在192.168.1.20 ,用户名是share，密码是share123，将下面的指令放入print.bat

  
net use [\192.168.1.20](file:///) "share123" /user:"share"

 

关于net 命令的用法：

 

net use ipipc$ " " /user:" " 建立IPC空链接 

net use ipipc$ "密码" /user:"用户名" 建立IPC非空链接 

net use h: ipc$ "密码" /user:"用户名" 直接登陆后映射对方C：到本地为H: 

net use h: ipc$ 登陆后映射对方C：到本地为H: 

net use ipipc$ /del 删除IPC链接 

net use h: /del 删除映射对方到本地的为H:的映射 

net user 用户名　密码　/add 建立用户 

net user guest /active:yes 激活guest用户 

net user 查看有哪些用户 

net user 帐户名 查看帐户的属性 

net localgroup administrators 用户名 /add 把“用户”添加到管理员中使其具有管理员权限,注意：administrator后加s用复数 

net start 查看开启了哪些服务 

net start 服务名　 开启服务；(如:net start telnet， net start schedule) 

net stop 服务名 停止某服务 

net time 目标ip 查看对方时间 

net time 目标ip /set 设置本地计算机时间与“目标IP”主机的时间同步,加上参数/yes可取消确认信息 

net view 查看本地局域网内开启了哪些共享 

net view ip 查看对方局域网内开启了哪些共享 

net config 显示系统网络设置 

net logoff 断开连接的共享 

net pause 服务名 暂停某服务 

net send ip "文本信息" 向对方发信息 

net ver 局域网内正在使用的网络连接类型和信息 

net share 查看本地开启的共享 

net share ipc$ 开启ipc$共享 

net share ipc$ /del 删除ipc$共享 

net share c$ /del 删除C：共享 

net user guest 12345 用guest用户登陆后用将密码改为12345 

net password 密码 更改系统登陆密码 

  
  


![](http://img.zemanta.com/pixy.gif?x-id=738c753f-c7b2-8c15-9597-a02bbda367d8)
