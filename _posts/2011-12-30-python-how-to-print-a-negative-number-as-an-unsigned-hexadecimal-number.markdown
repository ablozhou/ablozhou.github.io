---
author: abloz
comments: true
date: 2011-12-30 09:18:29+00:00
layout: post
link: http://abloz.com/index.php/2011/12/30/python-how-to-print-a-negative-number-as-an-unsigned-hexadecimal-number/
slug: python-how-to-print-a-negative-number-as-an-unsigned-hexadecimal-number
title: python 如何 打印负数为16进制 无符号数？
wordpress_id: 1481
categories:
- 技术
tags:
- hex
- python
- 负数
---

如，想将-1打印成0xffffffff，结果是：

    
    >>> a=-1
    >>> hex(a)
    '-0x1'
    >>> print "%u"%a
    -1
    >>> print "%x"%a
    -1
    >>> print hex(a)
    -0x1




没有办法将其打印成0xffffffff。打印和转化办法，可以定义hex2函数进行转换：




    
    >>> print hex(a&0xffffffff)
    0xffffffffL
    >>> b=-2
    >>> print "0x%08x"%(b&0xffffffff)
    0xfffffffe
    
    >>> def hex2(a):
    ...     return a>0 and hex(a) or hex(a&0xffffffff)
    ...
    >>> hex2(a)
    '0xffffffffL'
    >>> hex2(234)
    '0xea'
    >>> hex2(b)
    '0xfffffffeL'
