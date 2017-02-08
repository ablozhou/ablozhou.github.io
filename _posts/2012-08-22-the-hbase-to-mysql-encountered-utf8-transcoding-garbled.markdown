---
author: abloz
comments: true
date: 2012-08-22 07:41:27+00:00
layout: post
link: http://abloz.com/index.php/2012/08/22/the-hbase-to-mysql-encountered-utf8-transcoding-garbled/
slug: the-hbase-to-mysql-encountered-utf8-transcoding-garbled
title: hbase到mysql遇到的utf8转码的乱码问题
wordpress_id: 1810
categories:
- 技术
tags:
- hbase
- mysql
- utf8
---

author:周海汉
2012.8.22



# 1.从应用到HBase的乱码问题


应用通过thrift将用户信息提交到hbase。应用字符是GB18030的，需转成UTF8. 用户输入的昵称很多火星文。Windows下用官网提供的iconv库来进行。官网windows 库地址：http://gnuwin32.sourceforge.net/packages/libiconv.htm。但该库是1.9.2版本，2004年提供出来的，已经严重滞后于现有Unicode版本，大量火星文繁体等转成Utf8失败。所以该库不可用。

libiconv的官网是http://www.gnu.org/software/libiconv/。通过http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz 下载最新libiconv，但没有windows版本。windows下需要通过源码和cygwin等环境编译成libiconv.la库。codeproject上有人做了windows的编译版本：http://www.codeproject.com/Articles/302012/How-to-Build-libiconv-with-Microsoft-Visual-Studio，可以生成libiconv.lib库。但是该库还是有问题。

libiconv 1.14版本的问题，不是转换时报错，而是转成utf8时一些字符会转成四个字节。如Unicode Private Use Areas (PUA)区的 U+E815 - U+E864, 我们遇到一个字符，U+E817 ,UTF8对应'xeexa0x97',但windows下通过libiconv 1.14时居然被转成了“xF0xA0x82x89”，这四个字节无法被转成UTF8字符，在插入mysql时，Java直接报IO Exception. 目前怀疑还是最新库在windows下的编译方式有问题。

由于hbase向mysql提交时，是成批提交。数据量有数十万，所以经过比较繁琐定位，才找到这一特殊字符产生问题。

**解决方式：**
下载最后一个windows支持nmake编译的版本 http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.11.1.tar.gz，编译出lib和dll库。



# 2. 从hbase存入mysql乱码


由于hbase里面字符串都采用bytes的方式存放，所以需转到Java string。Java中new String方法，通过bytes转成String，需指定bytes的编码，否则可能会变成乱码，因为String的编码缺省受系统影响。s=new String(bytes,"UTF-8"),指定编码。

**编译iconv 1.11方法参考：**
http://hi.baidu.com/deanlee1987/item/34269fd4ead5ea876cce3f79
http://demon.tw/software/compile-iconv-in-windows.html

**unicode官方网站：**
http://www.unicode.org/
unicode和utf8编码映射查询
http://www.utf8-chartable.de
