---
author: abloz
comments: true
date: 2009-12-25 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/25/evolution-and-outlook-of-the-chinese-attachment-compatibility/
slug: evolution-and-outlook-of-the-chinese-attachment-compatibility
title: evolution 与 outlook 的中文附件兼容问题
wordpress_id: 1003
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2009.12.25 圣诞快乐！

 

在linux下工作，需与同事交换邮件。我使用的邮件客户端是ubuntu自带的evolution,  同事使用各种邮件客户端的都有。有outlook, outlook express, foxmail, dreammail.  但都遇到一个典型问题，就是我发送的中文文件名的附件，要么附件不能显示，要么显示了文件名和后缀不对，要么后缀不对，不能直接打开。

 

后面发现早已有人[提交了bug](https://bugs.launchpad.net/ubuntu/+source/evolution-data-server/+bug/205999) ，并且去年已经fix，evolution 较新的版本其实可以做到兼容outlook，只是没有缺省兼容。

我的evolution版本：

zhouhh@zhhofs:~$ evolution --version  
GNOME evolution 2.28.1

 

修改配置：在“编辑->首选项，编写器首选项页，将兼容outlook/gmail方式编码文件名选上，即可解决问题。如图：

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091225/Screenshot-Evolution%20%E9%A6%96%E9%80%89%E9%A1%B9.png)

  
  


![](http://img.zemanta.com/pixy.gif?x-id=1b72594d-9fe3-8cd1-a342-4b0360b6bc9d)
