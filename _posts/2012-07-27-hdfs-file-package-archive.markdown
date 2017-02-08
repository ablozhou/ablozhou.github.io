---
author: abloz
comments: true
date: 2012-07-27 07:39:05+00:00
layout: post
link: http://abloz.com/index.php/2012/07/27/hdfs-file-package-archive/
slug: hdfs-file-package-archive
title: hdfs 文件打包存档
wordpress_id: 1788
categories:
- 技术
tags:
- archive
- hadoop
---


打包存档命令：
[zhouhh@Hadoop48 ~]$ hadoop archive
archive -archiveName NAME -p  * 

在父目录后面可以跟若干子目录，也可以不跟，直接打全部父目录。
如：

    
    
    hadoop archive -archiveName foo.har -p /user/hadoop dir1/dir2 dir3 /user/zoo/
    


表示dir1/dir2和dir3都是/user/hadoop子目录，选择父目录下的部分目录打包。

**实践**：
要打包的目录：

    
    
    [zhouhh@Hadoop48 ~]$ hadoop fs -lsr output1
    drwxr-xr-x - zhouhh supergroup 0 2012-06-04 11:05 /user/zhouhh/output1/_logs
    drwxr-xr-x - zhouhh supergroup 0 2012-06-04 11:05 /user/zhouhh/output1/_logs/history
    -rw-r--r-- 3 zhouhh supergroup 16856 2012-06-04 11:05 /user/zhouhh/output1/_logs/history/job_201205231824_0007_1338779151666_zhouhh_wordcount.py+%281%2F1%29
    -rw-r--r-- 3 zhouhh supergroup 22357 2012-06-04 11:05 /user/zhouhh/output1/_logs/history/job_201205231824_0007_conf.xml
    



打包

    
    
    [zhouhh@Hadoop48 ~]$ hadoop archive -archiveName output1.har  -p /user/zhouhh/output1  /user/zhouhh/
    [zhouhh@Hadoop48 ~]$ hadoop fs -lsr output1.har
    -rw-r--r--   3 zhouhh supergroup          0 2012-07-27 15:30 /user/zhouhh/output1.har/_SUCCESS
    -rw-r--r--   5 zhouhh supergroup        555 2012-07-27 15:30 /user/zhouhh/output1.har/_index
    -rw-r--r--   5 zhouhh supergroup         23 2012-07-27 15:30 /user/zhouhh/output1.har/_masterindex
    -rw-r--r--   3 zhouhh supergroup      39213 2012-07-27 15:30 /user/zhouhh/output1.har/part-0
    


已经打包成功。
查看包内文件：

    
    
    
    [zhouhh@Hadoop48 ~]$ hadoop fs -lsr har:///user/zhouhh/output1.har
    drwxr-xr-x   - zhouhh supergroup          0 2012-06-04 11:05 /user/zhouhh/output1.har/_logs
    drwxr-xr-x   - zhouhh supergroup          0 2012-06-04 11:05 /user/zhouhh/output1.har/_logs/history
    -rw-r--r--   3 zhouhh supergroup      22357 2012-06-04 11:05 /user/zhouhh/output1.har/_logs/history/job_201205231824_0007_conf.xml
    -rw-r--r--   3 zhouhh supergroup      16856 2012-06-04 11:05 /user/zhouhh/output1.har/_logs/history/job_201205231824_0007_1338779151666_zhouhh_wordcount.py+%281%2F1%29
    


或：

    
    
    
    [zhouhh@Hadoop48 ~]$ hadoop fs -lsr har://hdfs-Hadoop48:54310/user/zhouhh/output1.har
    drwxr-xr-x   - zhouhh supergroup          0 2012-06-04 11:05 /user/zhouhh/output1.har/_logs
    drwxr-xr-x   - zhouhh supergroup          0 2012-06-04 11:05 /user/zhouhh/output1.har/_logs/history
    -rw-r--r--   3 zhouhh supergroup      22357 2012-06-04 11:05 /user/zhouhh/output1.har/_logs/history/job_201205231824_0007_conf.xml
    -rw-r--r--   3 zhouhh supergroup      16856 2012-06-04 11:05 /user/zhouhh/output1.har/_logs/history/job_201205231824_0007_1338779151666_zhouhh_wordcount.py+%281%2F1%29
    


其中54310是我Hadoop 在core-site.xml配置的hdfs的端口。
删除

    
    
    [zhouhh@Hadoop48 ~]$ hadoop fs -rmr output1.har
    Deleted hdfs://Hadoop48:54310/user/zhouhh/output1.har
    
    
