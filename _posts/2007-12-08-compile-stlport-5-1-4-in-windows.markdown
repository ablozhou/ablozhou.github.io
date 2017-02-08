---
author: abloz
comments: true
date: 2007-12-08 08:34:04+00:00
layout: post
link: http://abloz.com/index.php/2007/12/08/compile-stlport-5-1-4-in-windows/
slug: compile-stlport-5-1-4-in-windows
title: 在windows下编译 stlport 5.1.4
wordpress_id: 252
categories:
- 技术
tags:
- stlport
- vc6
---

# 




[周海汉](http://blog.csdn.net/ablo_zhou) /文
转载注明出处

stlport是对C++标准模板库的一个实现，遵循INTERNATIONAL STANDARD ISO/IEC 14882:1998(E)  和最新的ISO/IEC  14882:2003(E)标准。它的一个好处，就是提供了跨平台和跨编译器的实现。另外它还有一个易于使用的“安全模式”可以检测容器和迭代器的不正确 用法。对于通用的功能也进行了优化。它的源代码比微软的实现也易于阅读。

但是stlport没有提供vc6和vc8的编译项目文件，而是提供了相应的各编译器的make  file。这给windows下编译增加了一定困难。必须在命令行下用nmake来进行编译，以生成相应的lib文件。编译过程可以参考 doc/README.msvc这个文件。这里以vc6编译为例。

首先，用命令行进到stlport的解压目录的buildlib目录，执行：





![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)configure -c msvc6





执行完毕，会提示用nmake /fmsvc.mak来编译。执行：
<table cellpadding="1" cellspacing="1" border="1" width="500" >
<tbody >
<tr >

<td >E:cvsvodthirdpartySTLport-5.1.4buildlib>nmake  /fmsvc.mak

Microsoft (R) Program Maintenance Utility   Version  7.00.8882
Copyright (C) Microsoft Corp 1988-2000. All rights  reserved.

cl /nologo /W4 /GX /GR /Zm800  /MD /Zi /O2   /DWIN32 /D_WINDOWS /DNDEBUG
/I../../stlport  /c  /Foobjvc6shareddll_main.o /Fdobjvc6sharedstlport.5.1.
pdb  ../../srcdll_main.cpp
dll_main.cpp
D:Program FilesMicrosoft  Platform SDK for Windows Server 2003 R2Include.win
base.h(1576) :  error C2733: second C linkage of overloaded function 'Interlocked
Increment'  not allowed
D:Program FilesMicrosoft Platform SDK for  Windows Server 2003 R2Inclu
de.winbase.h(1574) : see declaration  of 'InterlockedIncrement'
D:Program FilesMicrosoft Platform SDK for  Windows Server 2003 R2Include.win
base.h(1583) : error C2733:  second C linkage of overloaded function 'Interlocked
Decrement' not  allowed
D:Program FilesMicrosoft Platform SDK for Windows  Server 2003 R2Inclu
de.winbase.h(1581) : see declaration of  'InterlockedDecrement'
D:Program FilesMicrosoft Platform SDK for  Windows Server 2003 R2Include.win
base.h(1591) : error C2733:  second C linkage of overloaded function 'Interlocked
Exchange' not  allowed
D:Program FilesMicrosoft Platform SDK for Windows  Server 2003 R2Inclu
de.winbase.h(1588) : see declaration of  'InterlockedExchange'
NMAKE : fatal error U1077: 'cl' : return code  '0x2'
Stop.
</td>
</tr>
</tbody>
</table>
这是因为安装了plaform  SDK引起的错误。这需要修改源码了。找到stlportstlconfiguser_config.h，打开，找到

#define _STLP_NEW_PLATFORM_SDK 1，将其注释去掉。修改后如下：





/**//*
* boris : this setting is here as we cannot detect precense of new Platform SDK automatically
* If you are using new PSDK with VC++ 6.0 or lower,
* please define this to get correct prototypes for InterlockedXXX functions
*/
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)#define _STLP_NEW_PLATFORM_SDK 1
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)





再执行nmake /fmsvc.mak，就会通过了。
接着执行nmake /fmsvc.mak  install，会将相应的lib文件拷贝到bin目录。

如果找不到nmake，则需要安装环境变量。找到VC6安装目录，用命令行进入其VC98/Bin，执行vcvars32.bat，即可得到相应环 境变量。


