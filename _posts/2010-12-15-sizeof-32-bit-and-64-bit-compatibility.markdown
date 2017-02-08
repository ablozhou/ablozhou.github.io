---
author: abloz
comments: true
date: 2010-12-15 03:00:46+00:00
layout: post
link: http://abloz.com/index.php/2010/12/15/sizeof-32-bit-and-64-bit-compatibility/
slug: sizeof-32-bit-and-64-bit-compatibility
title: sizeof的32位和64位兼容问题
wordpress_id: 1107
categories:
- 技术
tags:
- printf
- size_t
- sizeof
---

周海汉 2010.12.15
http://abloz.com

**问题：**
linux下编写一个普通的打印语句：
printf("sizeof int is %d", sizeof(int));
编译时会得到如下的warning：
warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘long unsigned int’
源码：

    
    
    //////////////////////////////////////////
    //author 	zhouhh
    //date 		2010.12.15
    //notes     testsizeof.c
    //history
    //http://abloz.com copyright( 2010 ) allright reserved!
    /////////////////////////////////////////
    
    #include <stdio.h>
    
    void main()
    {
        printf("sizeof int=%d",sizeof(int));
    }
    


zhouhh@zhh64:~/test$ gcc -o ts testsizeof.c
testsizeof.c: In function ‘main’:
testsizeof.c:13: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘long unsigned int’

**问题原因**
这是因为我的系统是64位的，sizeof返回的size_t类型定义为long unsigned int.
zhouhh@zhh64:~/test$ uname -a
Linux zhh64 2.6.35-24-generic #42-Ubuntu SMP Thu Dec 2 02:41:37 UTC 2010 x86_64 GNU/Linux

而对32位系统，不会产生该warning。因为32为的size_t类型是unsigned int.
那如果程序需要在32和64位系统保持兼容性，不希望产生该warning，如何处理呢？

**问题解决**
1.强制转换size_t为unsigned int. 这种方式可以去掉warning，但有截断，只能是权宜之计。
2.原来printf已经为该兼容性定义了新的格式字符z。
修改源代码：

    
    
      1 //////////////////////////////////////////
      2 //author    zhouhh
      3 //date      2010.12.15
      4 //notes     testsizeof.c
      5 //web       http://abloz.com
      6 //copyright( 2010 ) allright reserved!
      7 /////////////////////////////////////////
      8
      9 #include <stdio.h>
     10
     11 void main()
     12 {
     13     printf("sizeof int=%zu",sizeof(int));
     14 }
    


再编译，32位和64位系统都不会有warning。
zhouhh@zhh64:~/test$ gcc -o ts testsizeof.c
zhouhh@zhh64:~/test$ ./ts
sizeof int=4

**深究：**
printf 为长度的兼容性定义了一系列的格式化字符：
man 3 printf:

    
    
    The length modifier
           Here, "integer conversion" stands for d, i, o, u, x, or X conversion.
    
           hh     A following integer conversion corresponds to a signed  char  or
                  unsigned  char argument, or a following n conversion corresponds
                  to a pointer to a signed char argument.
    
           h      A following integer conversion corresponds to  a  short  int  or
                  unsigned  short int argument, or a following n conversion corre‐
                  sponds to a pointer to a short int argument.
    
           l      (ell) A following integer conversion corresponds to a  long  int
                  or  unsigned long int argument, or a following n conversion cor‐
                  responds to a pointer to a long int argument, or a  following  c
                  conversion  corresponds  to  a wint_t argument, or a following s
                  conversion corresponds to a pointer to wchar_t argument.
    
           ll     (ell-ell).  A following integer conversion corresponds to a long
                  long  int  or  unsigned long long int argument, or a following n
                  conversion corresponds to a pointer to a long long int argument.
    
           L      A following a, A, e, E, f, F, g, or G conversion corresponds  to
                  a long double argument.  (C99 allows %LF, but SUSv2 does not.)
           q      ("quad".  4.4BSD  and  Linux libc5 only.  Don't use.)  This is a
                  synonym for ll.
    
           j      A following integer conversion corresponds  to  an  intmax_t  or
                  uintmax_t argument.
    
           z      A  following  integer  conversion  corresponds  to  a  size_t or
                  ssize_t argument.  (Linux libc5 has Z with this meaning.   Don't
                  use it.)
    
           t      A  following integer conversion corresponds to a ptrdiff_t argu‐
                  ment.
    
    


可以看到z 是专门针对size_t和ssize_t打印的。遇到类似问题可以到上面找一找。
