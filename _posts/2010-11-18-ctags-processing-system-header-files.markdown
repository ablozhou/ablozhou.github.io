---
author: abloz
comments: true
date: 2010-11-18 06:35:36+00:00
layout: post
link: http://abloz.com/index.php/2010/11/18/ctags-processing-system-header-files/
slug: ctags-processing-system-header-files
title: ctags 处理系统头文件
wordpress_id: 1071
categories:
- 技术
tags:
- ctags
- linux
- vim
---

周海汉 2010.11.16
http://abloz.com

**问题提出：**

```
vim编写程序时，不能跳转到系统头文件定义，不能自动完成自己编写结构成员。需要解决。
```

ctags 在使用vim编程和浏览代码是非常有用。可以用CTRL+]和CTRL+t 来回跳转关键字。
先生成自己工作目录的tags。最简单粗暴用法：

    
    $cd yourwork
    $ctags -R *


这样会生成一个tags文件。
不过，这种有个问题，成员变量没有包含在里面。所以自动完成对象的成员时没有提示。
解决办法：

    
    $ctags -R --fields=+iaS --extra=+q *


--fields=[+|-]flags
--fields指定tags的可用扩展域（extension fields），以包含到tags入口。
i:继承信息Inheritance information
a：类成员的访问控制信息 Access (or export) of class members
S： 常规签名信息，如原型或参数表 Signature of routine(e.g. prototype or parameter list)
--extra=[+|-]flags
指定是否包含某种扩展信息到tags入口。
q：包含类成员信息（如c++,java,Eiffel)。
但就算是C 语言的结构，也需要这两个参数设置才能获取成员信息。

这样就能自动完成结构和类的成员了。

但是，对于系统的函数，还是没有跳转。如socket定义，inetaddr_in这样的结构没有自动变量完成。
最简单做法：

    
    $ctags --fields=+iaS --extra=+q -R -f ~/.vim/systags /usr/include /usr/local/include


然后在.vimrc里设置

    
    set tags+=~/.vim/systags


这样虽然基本能跳转到系统函数定义，一个问题是某些系统函数并没有加入到systags里。
如/usr/incluce/socket.h的socket系列函数,memset等很多关键函数都没有到tag里：

    
    extern int listen (int __fd, int __n) __THROW;


这是因为 __THROW的宏定义让ctags不再认为该系列函数是函数。
同理，如memcpy系列函数：
如/usr/include/string.h的

    
    extern int strcmp (__const char *__s1, __const char *__s2)
         __THROW __attribute_pure__ __nonnull ((1, 2));


还有attribute_pure ，nonull等属性，都需要忽略。如果需要#if 0里面的定义，可以--if0=yes来忽略 #if 0这样的定义。

    
    $ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q -R -f ~/.vim/systags /usr/include /usr/local/include


这样.vim/systags里面是全的，但内容过多。一个函数定义的跳转，会有几十个候选。这时我们可以简化一下，将-R去掉，自己指定目录：

    
    $ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q  -f ~/.vim/systags /usr/include/* /usr/include/sys/* /usr/include/bits/*  /usr/include/netinet/* /usr/include/arpa/* /usr/include/mysql/*


还可以包含一些自己编程需要的路径。注意后面加*号。
这样生成的系统tags就少多了。不会有太多不相干的定义。

**参考：**
http://hi.baidu.com/%B2%BB%D5%FD%D6%B1%B5%C4%C8%CB/blog/item/7f55080382c5a9e708fa93bf.html
