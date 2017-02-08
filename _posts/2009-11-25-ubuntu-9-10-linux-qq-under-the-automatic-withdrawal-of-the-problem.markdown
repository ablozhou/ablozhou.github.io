---
author: abloz
comments: true
date: 2009-11-25 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/11/25/ubuntu-9-10-linux-qq-under-the-automatic-withdrawal-of-the-problem/
slug: ubuntu-9-10-linux-qq-under-the-automatic-withdrawal-of-the-problem
title: ubuntu 9.10下linux qq 自动退出的问题
wordpress_id: 955
categories:
- 技术
- 转载
---

升级到ubuntu 2009以后， linux qq经常会自动退出，不清楚什么问题,导致我用了一段时间的web qq

昨天发现是可以处理的，原文在[这里](http://www.lonyer.net/read.php?427)  
修改/usr/bin/qq，添加一个环境变量
    
    export GDK_NATIVE_WINDOWS=true 

修改后：  
#cat /usr/bin/qq
    
    #!/bin/sh export GDK_NATIVE_WINDOWS=true cd /usr/share/tencent/qq/ ./qq 

 

附：[GDK_NATIVE_WINDOWS](http://blogs.gurulabs.com/dax/2009/10/what-gdk-native.html)是什么意思？


```
 

GDK has been rewritten to use ‘client-side windows’. This means that  GDK maintains its own window hierarchy and only uses X windows where it  is necessary or explicitly requested. Some of the benefits of this  change are

* Reduced flicker  
* The ability to do transformed and animated rendering of widgets  
* Easier embedding of GTK+ widgets, e.g. into Clutter scene graphs

Launching an app with GDK_NATIVE_WINDOWS=1 application turns off this feature. This is needed if the application manipulates the windows it  creates using direct X API calls or a mixture of X API and GDK instead  of just going through GDK. When using “client-side windows” all window  manipulation by an application must go through GDK. Adobe needs to  update Acroread to be compatible with this feature. 


```
 

  


  
  


![](http://img.zemanta.com/pixy.gif?x-id=a29fdb29-7ede-869a-9597-cf7aa7427bca)
