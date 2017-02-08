---
author: abloz
comments: true
date: 2008-03-31 01:54:06+00:00
layout: post
link: http://abloz.com/index.php/2008/03/31/python-handle-packet-loss-with-the-number-of-log/
slug: python-handle-packet-loss-with-the-number-of-log
title: 用python 处理丢包log的数字
wordpress_id: 281
categories:
- 技术
tags:
- python
---

先用bash脚本排序，然后用python脚本找出丢失的数字。当然，也可以完全在python脚本中完成。
#!/usr/bin/python
# filename:findlost.py
# author: zhouhh
# http://blog.csdn.net/ablo_zhou
# email:ablozhou@gmail.com
# date:2008.3.31
# Find out what number is lost from a file

import os

infilename = raw_input("in file name [rawpack]:");
outfilename = raw_input("out file name [outfile]:");

if infilename =="" :
        infilename="rawpack";

if outfilename =="" :
        outfilename="outfile";

cmd = ("sort.sh",infilename,outfilename)
os.system(' '.join(cmd))

f = open(outfilename);

i=0
pkid = 0
count = 0
while True :
        line = f.readline()
        if len(line) == 0:
                f.close()
                break

        pkid = int(line)
        if pkid>i:
                print "lost package ",i
                i+=1
                count +=1
        i+=1
print "================================="
print "total package num is",pkid,",lost package count:",count


执行结果：
$ ./findlost.py
in file name [rawpack]:
out file name [outfile]:
./sort.sh,rawpack,outfile
lost package  1707
lost package  2126
lost package  2139
lost package  2278
lost package  2280
lost package  2475
lost package  2763
lost package  3014
lost package  3072
lost package  3165
lost package  3271
=================================
total package num is 3778 ,lost package count: 11

