---
author: abloz
comments: true
date: 2010-11-23 08:39:15+00:00
layout: post
link: http://abloz.com/index.php/2010/11/23/comparison-libev-and-libevent/
slug: comparison-libev-and-libevent
title: libev和libevent比较
wordpress_id: 1079
categories:
- 技术
---

周海汉 2010.11.23

libev和libevent功能基本相同，名称相近，到底该用哪一个呢？
zhouhh@zhh64:~$ sudo apt-cache search libevent
libevent-dev - Development libraries, header files and docs for libevent
event-rpc-perl - dummy package to install libevent-rpc-perl
libev-dev - static library, header files, and docs for libev
libev-libevent-dev - libevent event loop compatibility wrapper for libev
libev3 - high-performance event loop library modelled after libevent

又有libevent,又有libev，确实挺让人迷惑的。
libevent由于出道早，2000年就出来了。所以应用广泛。而libev 2007年才出来，但号称有后发优势，性能强劲。还修正了libevent的问题。
从资料来看，libevent的更丰富，也有memcached等比较知名软件在使用。而libev需要更多探索。

目录libevent
参考资料：
libevent官网
http://monkey.org/~provos/libevent/

libev性能（有与libevent的比较）：
http://libev.schmorp.de/bench.html
Libev官网：http://software.schmorp.de/pkg/libev.html
Homepage: http://software.schmorp.de/pkg/libev
Mailinglist: libev@lists.schmorp.de
                http://lists.schmorp.de/cgi-bin/mailman/listinfo/libev
Library Documentation: http://pod.tst.eu/http://cvs.schmorp.de/libev/ev.pod

libev和libevent比较中文翻译：
http://blog.csdn.net/heiyeshuwu/archive/2008/09/02/2865201.aspx

Technorati 标签: [libev](http://technorati.com/tag/libev), [libevent](http://technorati.com/tag/libevent), [linux](http://technorati.com/tag/linux)


![](http://img.zemanta.com/pixy.gif?x-id=5feea34d-f0c8-80c0-bf03-12802eb3ceef)
