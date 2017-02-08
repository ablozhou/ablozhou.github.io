---
author: abloz
comments: true
date: 2013-02-01 04:29:17+00:00
layout: post
link: http://abloz.com/index.php/2013/02/01/perform-a-mapreduce-the-script-hadoop-streaming/
slug: perform-a-mapreduce-the-script-hadoop-streaming
title: 用hadoop streaming 来执行mapreduce的脚本
wordpress_id: 2106
categories:
- 技术
tags:
- hadoop
- streaming
---

周海汉/文

2013.2.1

http://abloz.com

tom white的《hadoop the_definitive_guide 3nd edition》附录C里面讲到用streaming方式来处理气象的原始数据。由于气象原始数据是小文件压缩成的gz2文件，需要将文件解压，合并成一个大文件，再按年份压缩存放。这样便于后续的mapreduce处理。

white用的是streaming执行bash脚本 load_ncdc_map.sh。该脚本将NLineInputFormat格式的文本文件作为输入，内容是一个个存放在S3中的气象数据。解压，合并，上传到hadoop。


    
    
    #!/usr/bin/env bash
    # NLineInputFormat gives a single line: key is offset, value is S3 URI
    read offset s3file
    # Retrieve file from S3 to local disk
    echo "reporter:status:Retrieving $s3file" >&2
    $HADOOP_INSTALL/bin/hadoop fs -get $s3file .
    # Un-bzip and un-tar the local file
    target=`basename $s3file .tar.bz2`
    mkdir -p $target
    echo "reporter:status:Un-tarring $s3file to $target" >&2
    tar jxf `basename $s3file` -C $target
    # Un-gzip each station file and concat into one file
    echo "reporter:status:Un-gzipping $target" >&2
    for file in $target/*/*
    do
    gunzip -c $file >> $target.all
    echo "reporter:status:Processed $file" >&2
    done
    # Put gzipped version into HDFS
    echo "reporter:status:Gzipping $target and putting in HDFS" >&2
    gzip -c $target.all | $HADOOP_INSTALL/bin/hadoop fs -put - gz/$target.gz
    


执行方式：

    
    
    % hadoop jar $HADOOP_INSTALL/contrib/streaming/hadoop-*-streaming.jar 
    -D mapred.reduce.tasks=0 
    -D mapred.map.tasks.speculative.execution=false 
    -D mapred.task.timeout=12000000 
    -input ncdc_files.txt 
    -inputformat org.apache.hadoop.mapred.lib.NLineInputFormat 
    -output output 
    -mapper load_ncdc_map.sh 
    -file load_ncdc_map.sh
    


其中ncdc_files.txt格式：

    
    
    s3n://hadoopbook/ncdc/raw/isd-1901.tar.bz2
    s3n://hadoopbook/ncdc/raw/isd-1902.tar.bz2
    ...
    




可见streaming方式的mapreduce十分强大，可以执行脚本和第三方可执行程序，读取输入文件后标准输入作为可执行文件输入，可执行文件的输出作为标准输出。

仿其原理，我们可以做一个bash脚本来统计或排序大文件。

要统计排序的文本：README.txt

    
    
    [zhouhh@Hadoop48 ~]$ ls -l README.txt
    -rw-r--r-- 1 zhouhh zhouhh 1399 Feb 1 10:53 README.txt
    
    [zhouhh@Hadoop48 ~]$ wc README.txt
    34 182 1399 README.txt
    [zhouhh@Hadoop48 ~]$ hadoop fs -ls
    Found 3 items
    -rw-r--r-- 2 zhouhh supergroup 9358 2013-01-10 17:52 /user/zhouhh/fsimage
    drwxr-xr-x - zhouhh supergroup 0 2013-02-01 10:30 /user/zhouhh/gz
    -rw-r--r-- 2 zhouhh supergroup 65 2012-09-26 14:10 /user/zhouhh/test中文.txt
    [zhouhh@Hadoop48 ~]$ hadoop fs -put README.txt .
    [zhouhh@Hadoop48 ~]$ hadoop fs -ls
    Found 4 items
    -rw-r--r-- 2 zhouhh supergroup 1399 2013-02-01 10:56 /user/zhouhh/README.txt
    -rw-r--r-- 2 zhouhh supergroup 9358 2013-01-10 17:52 /user/zhouhh/fsimage
    drwxr-xr-x - zhouhh supergroup 0 2013-02-01 10:30 /user/zhouhh/gz
    -rw-r--r-- 2 zhouhh supergroup 65 2012-09-26 14:10 /user/zhouhh/test中文.txt
    [zhouhh@Hadoop48 ~]$ hadoop fs -ls README.txt
    Found 1 items
    -rw-r--r-- 2 zhouhh supergroup 1399 2013-02-01 10:56 /user/zhouhh/README.txt
    


排序：

    
    
    [zhouhh@Hadoop48 ~]$ hadoop jar $HADOOP_INSTALL/contrib/streaming/hadoop-streaming-*.jar -input README.txt -output wordcount1 -mapper /bin/cat -reducer /bin/sort
    [zhouhh@Hadoop48 ~]$ hadoop fs -ls wordcount/part*
    Found 1 items
    -rw-r--r-- 2 zhouhh supergroup 1433 2013-02-01 11:20 /user/zhouhh/wordcount/part-00000
    




统计行数，字数

    
    
    [zhouhh@Hadoop48 ~]$ hadoop jar $HADOOP_INSTALL/contrib/streaming/hadoop-streaming-*.jar -input README.txt -output wordcount1 -mapper /bin/cat -reducer /usr/bin/wc
    
    [zhouhh@Hadoop48 ~]$ hadoop fs -cat wordcount1/p*
    34 182 1433
    



这里可以发现一个问题，streaming会给输入文件的换行0a增加09字节(tab)，变成090a，所以统计文件的字节数会是原文件字节数+行数，并且文件内容也改变了。
该问题导致sort后文件改变。用diff比较每行都多了一个09(tab)字节。

原理：
mapper和reducer都是可执行文件，它们从标准输入读入数据（一行一行读）， 并把计算结果发给标准输出。Streaming工具会创建一个Map/Reduce作业， 并把它发送给合适的集群，同时监视这个作业的整个执行过程。

如果一个可执行文件被用于mapper，则在mapper初始化时， 每一个mapper任务会把这个可执行文件作为一个单独的进程启动。 mapper任务运行时，它把输入切分成行并把每一行提供给可执行文件进程的标准输入。 同时，mapper收集可执行文件进程标准输出的内容，并把收到的每一行内容转化成key/value对，作为mapper的输出。 默认情况下，一行中第一个tab之前的部分作为key，之后的（不包括tab）作为value。 如果没有tab，整行作为key值，value值为null。这可以定制。

如果一个可执行文件被用于reducer，每个reducer任务会把这个可执行文件作为一个单独的进程启动。 Reducer任务运行时，它把输入切分成行并把每一行提供给可执行文件进程的标准输入。 同时，reducer收集可执行文件进程标准输出的内容，并把每一行内容转化成key/value对，作为reducer的输出。 默认情况下，一行中第一个tab之前的部分作为key，之后的（不包括tab）作为value。这可以定制。

对于需要复制到集群其他机器的文件，用-file filename 指定。

这是Map/Reduce框架和streaming mapper/reducer之间的基本通信协议。

我们可以看到，原文件和streaming后的文件不同：

part of the two file of hex code:
sort README.txt  :

源文件：

    
    
    0000000: 0a0a 0a0a 0a0a 0a61 6c67 6f72 6974 686d  .......algorithm
    0000010: 732e 2020 5468 6520 666f 726d 2061 6e64  s.  The form and
    0000020: 206d 616e 6e65 7220 6f66 2074 6869 7320   manner of this
    0000030: 4170 6163 6865 2053 6f66 7477 6172 6520  Apache Software
    0000040: 466f 756e 6461 7469 6f6e 0a61 6e64 206f  Foundation.and o
    0000050: 7572 2077 696b 692c 2061 743a 0a62 7920  ur wiki, at:.by
    0000060: 6d6f 7274 6261 792e 6f72 672e 0a63 6865  mortbay.org..che
    0000070: 636b 2079 6f75 7220 636f 756e 7472 7927  ck your country'
    


streaming README.txt and reduce sort:

    
    
    0000000: 090a 090a 090a 090a 090a 090a 090a 616c  ..............al
    0000010: 676f 7269 7468 6d73 2e20 2054 6865 2066  gorithms.  The f
    0000020: 6f72 6d20 616e 6420 6d61 6e6e 6572 206f  orm and manner o
    0000030: 6620 7468 6973 2041 7061 6368 6520 536f  f this Apache So
    0000040: 6674 7761 7265 2046 6f75 6e64 6174 696f  ftware Foundatio
    0000050: 6e09 0a61 6e64 206f 7572 2077 696b 692c  n..and our wiki,
    
    


这是因为streaming将每一行当成key+tab+value,而value为空。
参考：
http://hadoop.apache.org/docs/r0.19.2/cn/streaming.html
