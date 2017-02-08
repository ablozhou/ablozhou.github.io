---
author: abloz
comments: true
date: 2012-06-25 03:34:37+00:00
layout: post
link: http://abloz.com/index.php/2012/06/25/python-simulation-hadoop-map-the-reduce-process/
slug: python-simulation-hadoop-map-the-reduce-process
title: 用python模拟hadoop的map reduce过程
wordpress_id: 1713
categories:
- 技术
tags:
- hadoop
- map
- python
- reduce
---

用python简单模拟hadoop的map reduce过程，便于对hadoop工作机制进行理解。

简单来说，map reduce过程是：  
给出一个(key,value)的列表list1，分析完后得到另一个想要的(key,value)列表  
list1(k1,v1)->**map** ->list2(k2,v2)->**sort,combine,shuffle**->list3(k3,list(v3))->**reduce**-> list4(k4,v4)

在此用python代码模拟整个过程，但因为没有分布式，省去combine和shuffle过程。实现字数统计功能。  
程序可以在没有hadoop的python环境中执行，包含如下几个文件：  
mymapred.py mymap.py mysort.py myreduce.py test.txt

## 1.主程序：
    
    [zhouhh@Hadoop48 hadoop-1.0.3]$ cat mymapred.py
    #!/bin/env python
    # author zhouhh
    # http://abloz.com
    # date:2012.6.25
    
    #$ cat test.txt
    #a b c d
    #a b c d
    #aa bb cc dd
    #ee ff gg hh
    #foo foo quux labs foo bar quux
    
    import sys
    
    filename = 'test.txt'
    
    if len(sys.argv) == 2:
        filename= sys.argv[1]
    
    
    lines = open(filename,'r').readlines()
    for line in lines:
        print line.strip()
    

## 2.map程序
    
    [zhouhh@Hadoop48 hadoop-1.0.3]$ cat mymap.py
    #!/bin/env python
    # author zhouhh
    # http://abloz.com
    # date:2012.6.25
    import sys
    def mapword(w):
        print "%st%d"%(w,1)
    for line in sys.stdin:
        line = line.strip()
    
        words = line.split()
        m = map(mapword,words)
    

## 3.排序
    
    [zhouhh@Hadoop48 hadoop-1.0.3]$ cat mysort.py
    #!/bin/env python
    # author zhouhh
    # http://abloz.com
    # date:2012.6.25
    
    import sys
    def mapword(w):
        print "%st%d"%(w,1)
    m = []
    for line in sys.stdin:
        line = line.strip()
    
        word,count = line.split('t')
        m.append((word,count))
    m = sorted(m)
    for i in m:
        print "%st%s"%i
    

## 4.reduce
    
    [zhouhh@Hadoop48 hadoop-1.0.3]$ cat myreduce.py
    #!/usr/bin/env python
    # author zhouhh
    # http://abloz.com
    # date:2012.6.25
    import sys
    
    current_word = None
    current_count = 0
    word = None
    
    for line in sys.stdin:
        line = line.strip()
    
        word, count = line.split('t', 1)
    
        try:
            count = int(count)
        except ValueError:
            continue
    
        if current_word == word:
            current_count += count
        else:
            if current_word:
                print '%st%s' % (current_word, current_count)
            current_count = count
            current_word = word
    
    if current_word == word:
        print '%st%s' % (current_word, current_count)
    
    

## 5.测试文件，可以自己指定。
    
    [zhouhh@Hadoop48 hadoop-1.0.3]$ ./mymapred.py test.txt<br></br>a b c d<br></br>a b c d<br></br>aa bb cc dd<br></br>ee ff gg hh<br></br>foo foo quux labs foo bar quux

## 6.执行：
    
    [zhouhh@Hadoop48 hadoop-1.0.3]$ ./mymapred.py test.txt | ./mymap.py | ./mysort.py | ./myreduce.py<br></br>a       2<br></br>aa      1<br></br>b       2<br></br>bar     1<br></br>bb      1<br></br>c       2<br></br>cc      1<br></br>d       2<br></br>dd      1<br></br>ee      1<br></br>ff      1<br></br>foo     3<br></br>gg      1<br></br>hh      1<br></br>labs    1<br></br>quux    2

## 7.分步执行：
    
    [zhouhh@Hadoop48 hadoop-1.0.3]$ ./mymapred.py test.txt<br></br>a b c d<br></br>a b c d<br></br>aa bb cc dd<br></br>ee ff gg hh<br></br>foo foo quux labs foo bar quux

执行map

  

    
    [zhouhh@Hadoop48 hadoop-1.0.3]$ ./mymapred.py test.txt | ./mymap.py<br></br>a       1<br></br>b       1<br></br>c       1<br></br>d       1<br></br>a       1<br></br>b       1<br></br>c       1<br></br>d       1<br></br>aa      1<br></br>bb      1<br></br>cc      1<br></br>dd      1<br></br>ee      1<br></br>ff      1<br></br>gg      1<br></br>hh      1<br></br>foo     1<br></br>foo     1<br></br>quux    1<br></br>labs    1<br></br>foo     1<br></br>bar     1<br></br>quux    1

执行排序

  

    
    [zhouhh@Hadoop48 hadoop-1.0.3]$ ./mymapred.py test.txt | ./mymap.py | ./mysort.py<br></br>a       1<br></br>a       1<br></br>aa      1<br></br>b       1<br></br>b       1<br></br>bar     1<br></br>bb      1<br></br>c       1<br></br>c       1<br></br>cc      1<br></br>d       1<br></br>d       1<br></br>dd      1<br></br>ee      1<br></br>ff      1<br></br>foo     1<br></br>foo     1<br></br>foo     1<br></br>gg      1<br></br>hh      1<br></br>labs    1<br></br>quux    1<br></br>quux    1

最后执行reduce

[zhouhh@Hadoop48 hadoop-1.0.3]$ ./mymapred.py test.txt | ./mymap.py | ./mysort.py | ./myreduce.py
