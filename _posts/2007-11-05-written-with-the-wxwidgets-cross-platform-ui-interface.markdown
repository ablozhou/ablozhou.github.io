---
author: abloz
comments: true
date: 2007-11-05 07:11:00+00:00
layout: post
link: http://abloz.com/index.php/2007/11/05/written-with-the-wxwidgets-cross-platform-ui-interface/
slug: written-with-the-wxwidgets-cross-platform-ui-interface
title: 用wxWidgets写跨平台UI界面
wordpress_id: 237
categories:
- 技术
tags:
- ui
- wxwidgets
- 跨平台
---

一般写跨平台的UI，都是用QT。但QT的界面在不同的平台下显示都像Linux的。因此，Windows用户用起来不是很习惯。另一个是开源的 QT使用是有限制的。而wxWidgets同QT类似，可以实现跨平台UI。同样，也是开源，而且完全免费，不受限。最大的好处，就是wxWidgets 的图形表现和相关平台是一致的。Windows下就像Windows程序，Linux下像Linux程序，Mac OS下像Mac OS X程序。

wxWidgets使用一套代码，就可以实现Win32，Mac OS  X，GTK+，X11，Motif，Wince和更多的平台界面。而且还支持C++,C#/.net,  Perl,Python等多种语言。由于使用本地平台的组件，而不是模拟出来，所以它能够和本地平台表现完全一致。wxWidgets是开源，免费，可扩 展，成熟的库。

可以到[http://www.wxwidgets.org/](http://www.wxwidgets.org/) 下 载该库。最新版2.8.6。下一版为3.0版。

下面是使用wxWidgets编写的程序windows下的截图。

![symLab](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/symlab.png)
