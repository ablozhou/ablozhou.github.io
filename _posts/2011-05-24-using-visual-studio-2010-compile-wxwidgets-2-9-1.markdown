---
author: abloz
comments: true
date: 2011-05-24 10:28:31+00:00
layout: post
link: http://abloz.com/index.php/2011/05/24/using-visual-studio-2010-compile-wxwidgets-2-9-1/
slug: using-visual-studio-2010-compile-wxwidgets-2-9-1
title: 用visual studio 2010编译wxWidgets 2.9.1
wordpress_id: 1273
categories:
- 技术
tags:
- wxwidgets
---

2011.5.24 abloz.com

wxWidgets 是跨平台的基于GTK+的C++ 开源库。有点类似于windows平台的MFC。支持Windows,OSX,Linux和Unix的32位和64位结构。同时还支持一些移动平台如windows mobile, iPhone SDK和嵌入式GTK+。如果对C++不熟，wxWidgets库同时还支持python,perl,Ruby和其他的语言的封装。WxWidgets生成的程序，会让程序外观和本地平台一样。

wxWidgets最新版本 2.9.1. [点此下载](http://wxwidgets.org/downloads/)（http://wxwidgets.org/downloads/）。

Windows 提供了一个安装exe的程序。我将其安装到D:wxWidgets-2.9.1.

wxWidgets目前缺省还不支持vs2010，需要转换一下工程文件。

**1. 设置环境**

vs2010的include环境，只能影响项目。如果要设置全局的include目录，需到系统的Path中设置。

Win7 右键点桌面的“计算机”->属性，高级系统设置，环境变量。双击系统变量下的Path，变量值增加：

;D:wxWidgets-2.9.1include;D:wxWidgets-2.9.1includemsvc

如果不设环境变量会出现如下的错误：

```
fatal error C1083: Cannot open include file: ‘wx/setup.h’: No such file or directory d:wxwidgets-2.9.1includewxplatform.h
```

**2.用vs2010编译**

进入D:wxWidgets-2.9.1buildmsw，里面有

wx.dsw

wx_dll.dsw

wx_vc7.sln

wx_vc8.sln

wx_vc9.sln

如果直接将wx_vc9.sln 复制重命名为wx_vc10.sln，再用vc10打开，编译可能会遇到如下的错误：

```



1>  正在创建“vc_mswudauiaui.unsuccessfulbuild”，因为已指定“AlwaysCreate”。




1>C:Program FilesMSBuildMicrosoft.Cppv4.0Microsoft.CppCommon.targets(151,5): error MSB6001: “cmd.exe”的命令行开关无效。路径的形式不合法。




1>




1>生成失败。


1>  正在创建“vc_mswudauiaui.unsuccessfulbuild”，因为已指定“AlwaysCreate”。1>C:Program FilesMSBuildMicrosoft.Cppv4.0Microsoft.CppCommon.targets(151,5): error MSB6001: “cmd.exe”的命令行开关无效。路径的形式不合法。1>1>生成失败。
```

因此，应该先用VC6的工程文件wx.dsw 和wx_dll.dsw来转为wx.sln, wx_dll.sln，再进行编译。

然后再用wx_vs10.sln编译就不会有问题了。

**3.用命令行编译**

进入** Visual Studio 命令提示(2010)，**切换到

D:wxWidgets-2.9.1buildmsw>

nmake -f makefile.vc

创建库的DLL。

nmake -f makefile.vc RUNTIME_LIBS=static BUILD=release

创建静态release库。

动态库开关是RUNTIME_LIBS=dynamic

进入samples,同样执行

nmake -f makefile.vc

编译例子。

对64位系统，用如下的命令。

如AMD64

nmake -f makefile.vc TARGET_CPU=AMD64

对Intel的Itanium

nmake -f makefile.vc TARGET_CPU=IA64

**4.参考**

官网**：**[http://wxwidgets.org/](http://wxwidgets.org/)

wiki：[http://wiki.wxwidgets.org/Microsoft_Visual_C++_Guide](http://wiki.wxwidgets.org/Microsoft_Visual_C++_Guide)

安装包自带文档：**docsmswinstall.txt**
