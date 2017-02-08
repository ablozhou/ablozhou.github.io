---
author: abloz
comments: true
date: 2007-07-20 07:05:38+00:00
layout: post
link: http://abloz.com/index.php/2007/07/20/vc6-compile-and-link-the-two-headaches/
slug: vc6-compile-and-link-the-two-headaches
title: VC6编译和链接的两个头疼问题
wordpress_id: 233
categories:
- 技术
tags:
- vc6
- 编译
- 链接
---

# 




[周海汉](http://blog.csdn.net/ablo_zhou) /文

为了清空，将debug目录删了。结果编译时出如下错误：

fatal error C1083: Cannot open precompiled header file:  'Debug/xxx.pch':

No such file or directory

怎么搞都不行。

归结为同样问题的错误：

fatal error C1010: unexpected end of file while looking for  precompiled

header directive

原来，xxx.pch是预编译头文件生成的文件。在project-settings里面，选中编译的项目和c/c++页，在下拉框选 precompiled headers, 下面有四个选项。

1.不使用预编译头；
2.自动使用预编译头；
3.从头文件创建预编译头，指定头文件；
4.使用预编译头文件 stdafx.h

如果预编译头文件是stdafx.h,那么其他的文件都选4. 而stdafx.cpp选3，并且头文件选stdafx.h

出现第一个编译错误问题时，只需要把stdafx.cpp重编译一下，预编译的xxx.pch就生成了。而出现第二个编译问题时，需要把 stdafx.h包含在文件的最开始。

链接错误：

使用了静态库，有时出下面的错误：

LIBCD.lib(crt0dat.obj) : error LNK2005: __cinit already defined in  libcmt.lib(crt0dat.obj)
LIBCD.lib(crt0dat.obj) : error LNK2005: _exit  already defined in libcmt.lib(crt0dat.obj)
LIBCD.lib(crt0dat.obj) :  error LNK2005: __exit already defined in libcmt.lib(crt0dat.obj)

这是库和可执行程序使用了不同的库所引起的冲突。在主程序中的project-settings的link页，下拉框选input项，

在Ignore Librarys中增加：
libc.lib,msvcrt.lib,mfc42.lib

若是debug版，则应为：
libcd.lib,msvcrtd.lib,mfc42d.lib。

这时就可以编译通过了。

类似问题：
error LNK2001: unresolved external symbol __afxForceEXCLUDE

这是因为选了ignore all default libraries引起的，去掉就可以了。


