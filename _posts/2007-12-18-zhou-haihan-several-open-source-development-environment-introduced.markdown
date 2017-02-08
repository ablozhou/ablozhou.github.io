---
author: abloz
comments: true
date: 2007-12-18 09:47:42+00:00
layout: post
link: http://abloz.com/index.php/2007/12/18/zhou-haihan-several-open-source-development-environment-introduced/
slug: zhou-haihan-several-open-source-development-environment-introduced
title: 周海汉:几款开源开发环境介绍
wordpress_id: 259
categories:
- 技术
tags:
- code blocks
- 开发
- 开源
---

# 




[周 海汉](http://blog.csdn.net/ablo_zhou)/文
ablozhou at gmail.com
2007.12.18

摘要:
本文介绍几款开源的开发工具,包括UML建模工具starUML,Windows下编译跨平台的Linux代码的工具集MinGW和跨平台集成开发环境 codeblocks.




### 
1. UML 建模工具：starUML。


这是韩国人 Minkyu  Lee(李珉奎)负责开发的UML建模工具。用C++编写，只能在windows下使用，中文支持不好，据说bug比较多。但它支持了C++,C#,  java等建模后的代码生成。可以作为商业UML建模工具rose，together的替代品。StarUML（http:  //www.staruml.com）的前身是Plastic，从1996年开始开发。1998年开始，Plastic转变为UML建模工具。2005年  改名为StarUML，最新版本StarUML  5.0已经是一款功能全面的产品，支持UML2.0，支持MDA，Java、C++、C#转换，MS-Office集成，XMI，模式等。  sourceforge 地址：http://staruml.sourceforge.net/en/


## 


[![](https://sourceforge.net/dbimage.php?id=48455)](https://sourceforge.net/dbimage.php?id=48455)


## 
2.  Windows下利用GNU编译的工具集：MinGW


MinGW（"Minimalistic GNU for  Windows"）。该工具集可以在windows下编译linux下开源软件，并生成.dll,.exe等windows本地可执行文件。相对  CygWin等重量级环境，MinGW是比较轻量级和适用的。MinGW支持C，C++，Fortran77等的编译。MinGW包含了轻量级的可自由使  用和分发的windows平台相关的头文件和库以及GNU工具集，不必依赖于第三方C语言头。

MinGW使用了windows  API和库来build  windows程序，所以其生成的可执行程序发布版不必遵循GPL，除非使用了GPL的库。MinGW包含了gcc，binutils（linker，汇  编），gdb，mingw-runtime，win32 API，mingw32-make，mingw-utils。

如，VC可以生成makefile，在命令行下用nmake -f  makefile.vc来编译。但对gcc的makefile，nmake是不能编译的。这时候可以用MinGW，在命令行下用mingw32-make  -f makefile.gcc来生成*.o中间文件和.dll,.lib,.exe可执行文件。下载地址：[Sourceforge's MinGW ](http://sourceforge.net/projects/mingw/) 或[MinGW's website](http://www.mingw.org/download.shtml).


## 
3. C++集成开发环境codeblocks。


Code::Blocks 是一款跨平台的C++集成开发环境，可以在linux和windows下运行。采用C++编写，基于  wxWidgets和MinGW，可用于编写跨平台的程序和界面。相比eclipse，它的效率更高，比同样基于wxWidgets对Dev-C++强  大。而且eclipse采用java编写，关注的焦点也是java编程，c++开发者一般不太接受。其功能比同样是linux集成开发环境的  KDevloper强大很多。


## 







### 亮点:





	
  * **开源**！ GPL2， 无隐藏花费。

	
  * **跨平台。** 使用wxWidgets，可在Linux 和  Windows  上运行。wxWidgets是著名的跨平台界面库。其最大特点是生成系统本地界面。不像QT之类生成的界面，在windows下很多人不习惯。 

	
  * **采用GNU C++开发。** 不需要解释性语言和商业库，性能高。 

	
  * **两种展示**：独立发布，MinGW捆绑 

	
  * **通过插件支持扩展。**





### 编译相关特点:





	
  * **支持多种编译器**:


	
    * GCC (MingW / Linux GCC)

	
    * MSVC++

	
    * Digital Mars

	
    * Borland C++ 5.5

	
    * Open Watcom




	
  * **直接编译或采用makefile**

	
  * **预定义工程模板，如ActiveX，console**

	
  * **支持自定义模板**

	
  * **项目文件采用xml格式**

	
  * **工程支持多目标**

	
  * **支持工作区**

	
  * **可导入VC的工程文件和工作区（不支持汇编和工程依赖）**


	
  * **导入 Dev-C++  工程文件，Dev-C++是基于wxWidgets的集成开发环境**

	
  * **集成 GDB** 调试 




### 界面特征:





	
  * **语法高亮，可自定义和扩展**

	
  * **代码目录**

	
  * **可停靠的界面**

	
  * **自动完成代码的插件**

	
  * **类浏览器**

	
  * 智能缩进


	
  * 一键切换c/cpp和.h头文件


	
  * **打开文件列表，以快速切换**

	
  * **自定义外部工具**

	
  * **To-do list 管理，区分用户**







网址：http://www.codeblocks.org/
虽然没有vs2005好用，但作为一款开源的c++开发工具，弥补了linux下C++集成开发环境的不足。下面是其ubuntu下的抓图:




[![](http://abloz.com/wp-content/uploads/2010/07/Screenshot-main.c-test-CodeBlocks-8.02-300x220.png)](http://abloz.com/wp-content/uploads/2010/07/Screenshot-main.c-test-CodeBlocks-8.02.png)
