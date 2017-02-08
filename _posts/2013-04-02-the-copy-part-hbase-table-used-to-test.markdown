---
author: abloz
comments: true
date: 2013-04-02 10:53:32+00:00
layout: post
link: http://abloz.com/index.php/2013/04/02/the-copy-part-hbase-table-used-to-test/
slug: the-copy-part-hbase-table-used-to-test
title: 复制部分HBase表用于测试
wordpress_id: 2175
categories:
- 技术
tags:
- hbase
---

周海汉/文

2013.4.2










可以将日期'08/08/16 20:56:29'从hbase log 转换成一个 timestamp, 操作如下:

    
                        hbase(main):021:0> import java.text.SimpleDateFormat
                        hbase(main):022:0> import java.text.ParsePosition
                        hbase(main):023:0> SimpleDateFormat.new("yy/MM/dd HH:mm:ss").parse("08/08/16 20:56:29", ParsePosition.new(0)).getTime() => 1218920189000




也可以逆过来操作。

    
                        hbase(main):021:0> import java.util.Date
                        hbase(main):022:0> Date.new(1218920189000).toString() => "Sat Aug 16 20:56:29 UTC 2008"












    
    $ bin/hbase org.apache.hadoop.hbase.mapreduce.CopyTable [--starttime=X] [--endtime=Y] [--new.name=NEW] [--peer.adr=ADR] tablename










hbase(main):001:0> import java.text.SimpleDateFormat
=> Java::JavaText::SimpleDateFormat
hbase(main):002:0> import java.text.ParsePosition
=> Java::JavaText::ParsePosition

hbase(main):004:0> SimpleDateFormat.new("yyyy/MM/dd HH:mm:ss").parse("2013/03/28 00:00:00", ParsePosition.new(0)).getTime()
=> 1364400000000
hbase(main):005:0> SimpleDateFormat.new("yyyy/MM/dd HH:mm:ss").parse("2013/03/28 00:00:10", ParsePosition.new(0)).getTime()
=> 1364400010000







[hbase@h46 sh]$ hbase org.apache.hadoop.hbase.mapreduce.CopyTable
Usage: CopyTable [general options] [--starttime=X] [--endtime=Y] [--new.name=NEW] [--peer.adr=ADR] <tablename>







导出部分数据到另一个表myolc,需先创建该表，也可以指定另一个集群：



    
    --peer.adr=server1,server2,server3:2181:/hbase




[hbase@h46 hbase]$ hbase org.apache.hadoop.hbase.mapreduce.CopyTable --starttime=1364400000000 --endtime=1364400010000 --new.name=myolc online_count









导出实用工具可以将表的内容输出成HDFS的序列化文件，如下调用：

    
    $ bin/hbase org.apache.hadoop.hbase.mapreduce.Export <tablename> <outputdir> [<versions> [<starttime> [<endtime>]]]










导出2000秒数据




[hbase@h46 hbase]$ hbase org.apache.hadoop.hbase.mapreduce.Export online_count onlinecount 1 1364400000000 1364402000000




[hbase@h46 hbase]$ hadoop fs -ls /user/hbase/onlinecount
Found 3 items
-rw-r--r--   3 hbase supergroup          0 2013-04-01 15:56 /user/hbase/onlinecount/_SUCCESS
drwxr-xr-x   - hbase supergroup          0 2013-04-01 15:55 /user/hbase/onlinecount/_logs
-rw-r--r--   3 hbase supergroup        451 2013-04-01 15:56 /user/hbase/onlinecount/part-m-00000









导入实用工具可以加载导出的数据回到HBase，如下调用：

    
    $ bin/hbase org.apache.hadoop.hbase.mapreduce.Import <tablename> <inputdir>







[zhouhh@Hadoop48 ~]$ hadoop fs -put olc onlinecount




[zhouhh@Hadoop48 ~]$ hbase shell




hbase(main):001:0> create 'online_count','info'







 [zhouhh@Hadoop48 ~]$ hbase org.apache.hadoop.hbase.mapreduce.Import online_count onlinecount





















