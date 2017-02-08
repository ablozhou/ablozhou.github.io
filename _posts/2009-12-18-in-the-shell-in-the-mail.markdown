---
author: abloz
comments: true
date: 2009-12-18 06:25:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/18/in-the-shell-in-the-mail/
slug: in-the-shell-in-the-mail
title: 在shell中发邮件
wordpress_id: 991
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2009.12.18

 

一个服务程序，需要知道它的运行情况，将探测报告定期发送给运维人员，对错误要立即告警。在任何一台能上网的linux机器，需要能部署发送邮件。

 

写脚本探测程序和系统运行情况基本完成，现在需要告警和定期发送邮件。采用exim4程序

 

sudo apt-get install mailutils

 

安装完毕，输入命令 mail xxx@zhouhh.org

title: test

test

^D

结果在mail 收件箱中收到一封错误邮件

_Mailing to remote domains not supported_

需要配置为域外发送，执行命令：

sudo dpkg-reconfigure exim4-config

看到exim一个图形设置界面，按提示一步一步设置。缺省的是仅在本地投递信件，改为直接通过smtp发送或接受邮件。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091218/%20%7E.png)

点确定进入下一步。根据提示配置完毕，即可发送邮件：

mail zhouhh@xxx.com

title:hello

测试邮件

^D

 

发送成功到外面的邮箱。由于是内网地址，无法接受邮件，也无须关心。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=273159f9-5d29-8fdb-b89c-e646b48872aa)
