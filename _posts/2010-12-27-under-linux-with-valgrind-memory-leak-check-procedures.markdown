---
author: abloz
comments: true
date: 2010-12-27 06:17:53+00:00
layout: post
link: http://abloz.com/index.php/2010/12/27/under-linux-with-valgrind-memory-leak-check-procedures/
slug: under-linux-with-valgrind-memory-leak-check-procedures
title: linux下用valgrind检查程序内存泄漏
wordpress_id: 1118
categories:
- 技术
tags:
- linux
- valgrind
- 内存泄漏
---

http://abloz.com
2010.12.27

**问题提出：**
如果一个较复杂的程序，有内存泄漏，如何检测？
在windows下，VC本身带有内存泄漏的检查，程序结束时输出窗口会提示有多少memory leaks. linux下有什么办法呢？

**1.发现内存泄漏，可以用top或ps。**



```
zhouhh@zhh64:~/smscore$ top | grep firefox
```



会持续打印firefox的内存占用状况，可以重定向到文件中。
**2.静态检测**
用splint, PC-LINT,IBM的 BEAM（IBM Checking Tool for Bugs Errors and Mistakes）等。在本文略过。
**3.动态检测**
有IBM的rational purify，开源的valgrind. 本文主要介绍valgrind。
Valgrind 现在提供多个工具，其中最重要的是 Memcheck，Cachegrind，Massif 和 Callgrind。Valgrind 是在 Linux 系统下开发应用程序时用于调试内存问题的工具。它尤其擅长发现内存管理的问题，它可以检查程序运行时的内存泄漏问题。其中的 memecheck 工具可以用来寻找 c、c++ 程序中内存管理的错误。可以检查出下列几种内存操作上的错误：

    * 读写已经释放的内存
    * 读写内存块越界（从前或者从后）
    * 使用还未初始化的变量
    * 将无意义的参数传递给系统调用
    * 内存泄漏
valgrind网址：http://valgrind.org/。到现在为止最新版：3.60,支持ubuntu 10.10.对centos 5.2可以直接编译安装使用，ubuntu中遇到一些问题。
**3.1下载**




```
zhouhh@zhh64:~/valgrind$ wget http://valgrind.org/downloads/valgrind-3.6.0.tar.bz2
```




我开始用较老的版本，configure时遇到glibc版本太新的问题。
zhouhh@zhh64:~/valgrind/valgrind-3.4.1$ ./configure
...
checking the GLIBC_VERSION version... unsupported version
configure: error: Valgrind requires glibc version 2.2 - 2.10

我的系统环境：



```
zhouhh@zhh64:~$ uname -a
Linux zhh64 2.6.35-24-generic #42-Ubuntu SMP Thu Dec 2 02:41:37 UTC 2010 x86_64 GNU/Linux
zhouhh@zhh64:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=10.10
DISTRIB_CODENAME=maverick
DISTRIB_DESCRIPTION="Ubuntu 10.10"
zhouhh@zhh64:~$ ls -l /lib/libc.so.6
lrwxrwxrwx 1 root root 14 2010-11-22 09:58 /lib/libc.so.6 -> libc-2.12.1.so

zhouhh@zhh64:~$ ls /lib/libc*
/lib/libc-2.12.1.so
zhouhh@zhh64:~$ /lib/libc.so.6
GNU C Library (Ubuntu EGLIBC 2.12.1-0ubuntu10) stable release version 2.12.1, by Roland McGrath et al.

zhouhh@zhh64:~$ gcc -v
Using built-in specs.
Target: x86_64-linux-gnu
gcc version 4.4.5 (Ubuntu/Linaro 4.4.4-14ubuntu5)
```



下载完成后，解压tar xvf valgrind-3.6.0.tar.bz2,然后configure,编译安装，都没有问题。



```
zhouhh@zhh64:~/valgrind/valgrind-3.6.0$ ./configure
zhouhh@zhh64:~/valgrind/valgrind-3.6.0$ make
zhouhh@zhh64:~/valgrind/valgrind-3.6.0$ sudo make install
```


**3.2执行检测**

zhouhh@zhh64:~/test$ valgrind --leak-check=yes ./bin/myprog
valgrind:  Fatal error at startup: a function redirection
valgrind:  which is mandatory for this platform-tool combination
valgrind:  cannot be set up.  Details of the redirection are:
valgrind:
valgrind:  A must-be-redirected function
valgrind:  whose name matches the pattern:      strlen
valgrind:  in an object with soname matching:   ld-linux-x86-64.so.2
valgrind:  was not found whilst processing
valgrind:  symbols from the object with soname: ld-linux-x86-64.so.2
valgrind:
valgrind:  Possible fixes: (1, short term): install glibc's debuginfo
valgrind:  package on this machine.  (2, longer term): ask the packagers
valgrind:  for your Linux distribution to please in future ship a non-
valgrind:  stripped ld.so (or whatever the dynamic linker .so is called)
valgrind:  that exports the above-named function using the standard
valgrind:  calling conventions for this platform.
valgrind:
valgrind:  Cannot continue -- exiting now.  Sorry.

发现程序中使用了strlen，valgrind就直接退出了。原因是glibc没有debuginfo.
安装glibc的debug info:
**zhouhh@zhh64:~$ sudo apt-cache search libc6-dbg
libc6-dbg - Embedded GNU C Library: detached debugging symbols
libc6-dbg-armel-cross - Embedded GNU C Library: detached debugging symbols (for cross-compiling)
zhouhh@zhh64:~$ sudo apt-get install libc6-dbg**
再执行，程序结束时，就会有内存泄漏的提示了。

**4.测试**
vi testmem.c

    
    
    #include <stdlib.h>
    
    void f(void)
    {
        int* x = malloc(10 * sizeof(int));
        x[10] = 0;        // problem 1: heap block overrun
    }                    // problem 2: memory leak -- x not freed
    
    int main(void)
    {
        f();
        return 0;
    }
    


编译：



```
zhouhh@zhh64:~/test$ gcc -g -O0 -o testmem testmem.c
```



执行：




```
zhouhh@zhh64:~/test$ valgrind --leak-check=yes testmem
valgrind: testmem: command not found
zhouhh@zhh64:~/test$ valgrind --leak-check=yes ./testmem
==14783== Memcheck, a memory error detector
==14783== Copyright (C) 2002-2010, and GNU GPL'd, by Julian Seward et al.
==14783== Using Valgrind-3.6.0 and LibVEX; rerun with -h for copyright info
==14783== Command: ./testmem
==14783==
==14783== Invalid write of size 4
==14783==    at 0x400512: f (testmem.c:6)
==14783==    by 0x400522: main (testmem.c:11)
==14783==  Address 0x51b1068 is 0 bytes after a block of size 40 alloc'd
==14783==    at 0x4C2827C: malloc (vg_replace_malloc.c:236)
==14783==    by 0x400505: f (testmem.c:5)
==14783==    by 0x400522: main (testmem.c:11)
==14783==
==14783==
==14783== HEAP SUMMARY:
==14783==     in use at exit: 40 bytes in 1 blocks
==14783==   total heap usage: 1 allocs, 0 frees, 40 bytes allocated
==14783==
==14783== 40 bytes in 1 blocks are definitely lost in loss record 1 of 1
==14783==    at 0x4C2827C: malloc (vg_replace_malloc.c:236)
==14783==    by 0x400505: f (testmem.c:5)
==14783==    by 0x400522: main (testmem.c:11)
==14783==
==14783== LEAK SUMMARY:
==14783==    definitely lost: 40 bytes in 1 blocks
==14783==    indirectly lost: 0 bytes in 0 blocks
==14783==      possibly lost: 0 bytes in 0 blocks
==14783==    still reachable: 0 bytes in 0 blocks
==14783==         suppressed: 0 bytes in 0 blocks
==14783==
==14783== For counts of detected and suppressed errors, rerun with: -v
==14783== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 2 from 2)
```


可以看到，40 bytes in 1 blocks are definitely lost in loss record 1 of 1
by 0x400505: f (testmem.c:5)
所以testmem.c第5行有40byte的泄漏。
查看源码，int* x = malloc(10 * sizeof(int));分配的内存没有释放。

其中，--leak-check=yes表示检测内存。
如果程序原来执行命令是



```
myprog var1 var2
```



则用valgrind检测的执行命令是



```
valgrind --leak-check=yes myprog var1 var2
```


程序gcc的编译选项必须带-g, 最好带-O0，表示没有优化，方便定位问题。

**5.参考**
http://valgrind.org/docs/manual/quick-start.html
http://www.ibm.com/developerworks/cn/linux/l-cn-memleak/index.html
http://fafeng.blogbus.com/logs/7525571.html
