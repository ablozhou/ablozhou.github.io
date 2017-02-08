---
author: abloz
comments: true
date: 2012-07-04 10:19:51+00:00
layout: post
link: http://abloz.com/index.php/2012/07/04/hbase-shell-timestamp-into-readable-format/
slug: hbase-shell-timestamp-into-readable-format
title: hbase shell中timestamp转为可读格式
wordpress_id: 1755
categories:
- 技术
tags:
- hbase shell
---

http://abloz.com
date:2012.7.4

将hbase shell的timestamp转为可读。下面的示例将-ROOT-表的列info:serverstartcode的timestamp和value转成可读格式。

    
    
    hbase(main):001:0> scan '-ROOT-'
    ROW                        COLUMN+CELL
     .META.,,1                 column=info:regioninfo, timestamp=1340249081981, value={NAME => '.META.,,
                               1', STARTKEY => '', ENDKEY => '', ENCODED => 1028785192,}
     .META.,,1                 column=info:server, timestamp=1341304672637, value=Hadoop46:60020
     .META.,,1                 column=info:serverstartcode, timestamp=1341304672637, value=1341301228326
     .META.,,1                 column=info:v, timestamp=1340249081981, value=x00x00
    1 row(s) in 1.3230 seconds
    
    hbase(main):002:0> import java.util.Date
    => Java::JavaUtil::Date
    hbase(main):003:0> Date.new(1341304672637).toString()
    => "Tue Jul 03 16:37:52 CST 2012"
    hbase(main):004:0> Date.new(1341301228326).toString()
    => "Tue Jul 03 15:40:28 CST 2012"
    
    



在shell中，如果有可读日期，能否转成long类型呢？


    
    
    hbase(main):005:0> import java.text.SimpleDateFormat
    => Java::JavaText::SimpleDateFormat
    hbase(main):006:0> import java.text.ParsePosition
    => Java::JavaText::ParsePosition
    
    hbase(main):015:0> SimpleDateFormat.new("yy/MM/dd").parse("12/07/03",ParsePosition.new(0)).getTime()
    => 1341244800000
    


参考
http://abloz.com/hbase/book.html
