---
author: abloz
comments: true
date: 2011-08-21 08:42:08+00:00
layout: post
link: http://abloz.com/index.php/2011/08/21/eclipse-or-better-under-the-32-bit/
slug: eclipse-or-better-under-the-32-bit
title: eclipse 还是下32位的比较好
wordpress_id: 1350
categories:
- 技术
tags:
- android
- eclipse
- java
- php
---

现在一些笔记本预装的是64位windows 7，但64位的软件到现在也还不是很普及。所以win7为了兼容，在windows目录里包含了所有32位的库，导致该目录庞大无比。不过一些软件为了省麻烦，还是用32位的吧。

比如eclipse，可以用来进行android开发。[最新版3.7](http://www.eclipse.org/downloads/)eclipse提供32位和64位二进制版本下载，212MB。由于系统是64位，就下了个64位版本，但根本用不起来。因为我装的jre是32位的。

错误信息：

Eclipse Error – Failed to load the JNI shared library "C:Program Files (x86)Javajre6binclientjvm.dll"



[![](http://abloz.com/wp-content/uploads/2011/08/eclipse.png)](http://abloz.com/wp-content/uploads/2011/08/eclipse.png)

要么安装64位jre，要么安装32位eclipse。可是64位jre还真不好找。比如这个目录：

[http://www.java.com/en/download/windows_ie-64bit.jsp?locale=en&host=www.java.com](http://www.java.com/en/download/windows_ie-64bit.jsp?locale=en&host=www.java.com) 本来可以下载64位jre。但由于浏览器都是32位的，居然不提供下载链接。

碰到这么多问题，还是用32位的吧。否则别开发的程序也遇到兼容性问题。
