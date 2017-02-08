---
author: abloz
comments: true
date: 2012-06-19 06:50:50+00:00
layout: post
link: http://abloz.com/index.php/2012/06/19/hbase-copy-the-backup-data/
slug: hbase-copy-the-backup-data
title: hbase 复制备份数据
wordpress_id: 1709
categories:
- 技术
tags:
- backup
- hbase
---



[hbase官方文档中文版的14.7节](http://abloz.com/hbase/book.html#ops.backup)，讲了如何备份恢复hbase数据库。有好几种方法。现在我想从另一个集群将某个表转移到新的集群Hadoop46，47，48中，采用copytable方法。
需要先在目标集群中创建相应的表，否则会报org.apache.hadoop.hbase.TableNotFoundException: Cannot find row in .META. for table: award, row=award,,99999999999999。
创建表：
hbase(main):002:0> create 'award','info'
然后执行copyTable如下：

    
    
    [zhou@Hadoop48 hbase-0.92.0]$ bin/hbase org.apache.hadoop.hbase.mapreduce.CopyTable --peer.adr=Hadoop48,Hadoop47,Hadoop46:2181:/hbase award
    


其中peer.adr前是两个短杠“-”,直接复制可能会变成一个中文的“——”，则需要修改正确。
在目标系统读award表：
hbase(main):009:0> scan 'award',LIMIT=>5

