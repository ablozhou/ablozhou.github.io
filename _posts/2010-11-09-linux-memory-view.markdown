---
author: abloz
comments: true
date: 2010-11-09 07:31:09+00:00
layout: post
link: http://abloz.com/index.php/2010/11/09/linux-memory-view/
slug: linux-memory-view
title: linux 内存查看
wordpress_id: 1022
categories:
- 技术
---

linux 内存状态可以用free查看。如下：

    
    
    zhouhh@zhh64:~$ free -m
                 total       used       free     shared    buffers     cached
    Mem:          3961       2285       1676          0        216        671
    -/+ buffers/cache:       1397       2564
    Swap:         4769          0       4769
    
    


各参数含义：

    * total：总物理内存
    * used：已使用内存
    * free：完全未被使用的内存
    * shared：应用程序共享内存
    * buffers：缓存，主要用于目录方面,inode值等
    * cached：缓存，用于已打开的文件
    * -buffers/cache：应用程序使用的内存大小，used减去缓存值
    * +buffers/cache：所有可供应用程序使用的内存大小，free加上缓存值

其中：
    * total = used + free
    * -buffers/cache=used-buffers-cached，这个是应用程序真实使用的内存大小
    * +buffers/cache=free+buffers+cached，这个是服务器真实还可利用的内存大小

free 还可以带-k,-g,分别表示以KB或GB为单位的使用情况。
参考：
http://blog.csdn.net/hbcui1984/archive/2009/12/29/5101265.aspx
