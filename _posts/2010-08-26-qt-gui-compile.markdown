---
author: abloz
comments: true
date: 2010-08-26 15:11:48+00:00
layout: post
link: http://abloz.com/index.php/2010/08/26/qt-gui-compile/
slug: qt-gui-compile
title: qt gui 编译
wordpress_id: 368
categories:
- 技术
tags:
- boost
- linux
- qt
---

编译别人写的qt gui遇到点问题：




1.找不到mkspecs目录




qt$ make  

make: *** 没有规则可以创建“Makefile”需要的目标“/usr/lib/qt4/mkspecs/linux-g++/qmake.conf”。 停止。  

zhouhh@zhh64:/usr/lib/qt4$ ls  

demos  examples  plugins  

还以为缺什么没装。但qmake都装了的。




解决：




qt$ qmake -project




qt$ qmake




或执行qmake-qt4




此时会重新生成Makefile.而且mkspecs生成到了 /usr/share/qt4/目录下。




qt$ make 即可




2.遇到找不到boost的问题：




首先当然需要先装好boost。




编译遇到：




undefined reference to `boost::system::get_generic_category()'




需在makefile手工添加boost信息：




INCPATH       =-I/usr/include/boost




LIBS          = -lboost_system




如果boost是自己编译的，并指定了安装目录，LIBS里同样需指定目录




再make，过了。



