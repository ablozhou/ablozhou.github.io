---
author: abloz
comments: true
date: 2012-07-26 03:42:33+00:00
layout: post
link: http://abloz.com/index.php/2012/07/26/to-hdfs-the-use-distcp-parallel-copy/
slug: to-hdfs-the-use-distcp-parallel-copy
title: 用distcp进行hdfs的并行复制
wordpress_id: 1781
categories:
- 技术
tags:
- distcp
- hadoop
---

from http://abloz.com
date:2012.7.26
author:ablozhou#gmail.com

我另一篇文章提到了《[HBase复制备份数据](http://abloz.com/2012/06/19/hbase-copy-the-backup-data.html)》，可以通过CopyTable来复制表。对于HDFS的数据，可以通过distcp来进行复制和备份。
distcp 是Hadoop一个有用的分布式复制程序，可以从Hadoop复制大量数据，也可以将大量数据复制到Hadoop中。典型应用是两个Hadoop系统间复制数据。


    
    
    [zhoulei@Hadoop46 ~]$ hadoop fs -ls /user/zhoulei/log
    
    Found 1 items
    -rw-r--r--   3 zhoulei supergroup       3793 2012-07-24 18:39 /user/zhoulei/log/award.log
    


将Hadoop46上的一个Hadoop系统上的award.log复制到Hadoop48上另一个Hadoop系统
Hadoop48上没有zhouhh下没有log目录

    
    
    [zhouhh@Hadoop48 ~]$ hadoop distcp hdfs://Hadoop46:9200/user/zhoulei/log hdfs://Hadoop48:54310/user/zhouhh
    [zhouhh@Hadoop48 ~]$ fs -ls hdfs://Hadoop48:54310/user/zhouhh/log
    Found 1 items
    -rw-r--r--   3 zhouhh supergroup       3793 2012-07-26 11:09 /user/zhouhh/log/award.log
    


复制成功。这指令将源的log目录复制到目标的zhouhh目录下。如果目标目录不存在，会新建。
可以指定多个源，并且源路径必须是绝对路径。
默认情况下distcp会跳过存在的文件，可以加-overwrite参数覆盖，也可以用-update参数来仅同步有更新的文件。
如果目标文件已经存在，可以这样更新，但路径应该完全对应。

    
    
    [zhouhh@Hadoop48 ~]$ hadoop distcp -update hdfs://Hadoop46:9200/user/zhoulei/log hdfs://Hadoop48:54310/user/zhouhh/log
    


注意目标路径加了“log”。

distcp是通过map任务完成的。可以通过-m参数指定多少个map。每个map复制大致相等的数据量。所以需要权衡考虑任务构建开销和map的数目，节点的数目，数据量的大小。最好每个map不小于256MB数据，而每个节点(或tasktracker)不多于20个map任务。

distcp 的hdfs协议版本必须一致，否则复制会失败。如果版本不一致，可以采用基于只读HTTP协议的HFTP文件系统并从源读取数据。必须在目标集群上运行作业。


    
    
    [zhouhh@Hadoop48 ~]$ hadoop distcp  hftp://Hadoop46:50070/user/zhoulei/log hdfs://Hadoop48:54310/user/zhouhh/log
    


50070是hftp的默认端口，通过dfs.http.address指定。

**参考：**
http://hadoop.apache.org/common/docs/r0.19.2/cn/distcp.html
