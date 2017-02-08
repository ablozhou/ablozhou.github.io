---
author: abloz
comments: true
date: 2013-01-25 03:30:08+00:00
layout: post
link: http://abloz.com/index.php/2013/01/25/flume-agent-the-rewrite-of-problems-of-the-tail-source-with-vim/
slug: flume-agent-the-rewrite-of-problems-of-the-tail-source-with-vim
title: flume agent tail source用vim编辑后全文重写的问题
wordpress_id: 2091
categories:
- 技术
tags:
- flume
- tail
- vim
---

周海汉
2013.1.25
http://abloz.com

在flume master中配置agent的configure如下：

    
    
     config ag1 tail("/home/zhouhh/cars.csv",startFromEnd=true) |agentSink("hadoop48",35853);
     config co1 collectorSource( 35853 )|[collectorSink( "hdfs://hadoop48:54310/user/flume/%y%m/%d","%{host}-",5000,raw),collectorSink( "hdfs://hadoop48:54310/user/flume/%y%m","%{host}-",10000,raw)];


但是发现，如果重启agent，则agent会重新读取tail

    
    
     [zhouhh@Hadoop46 ~]$ flume-daemon.sh stop node -n ag1
     stopping node
     [zhouhh@Hadoop46 ~]$ flume-daemon.sh start node -n ag1
     starting node, logging to /home/zhouhh/flume-distribution-0.9.4/logs/flume-zhouhh-node-Hadoop46.out



    
    [zhouhh@Hadoop46 ~]$ hadoop fs -ls /user/flume/1301
     -rw-r--r-- 2 zhouhh supergroup 261 2013-01-25 11:16 /user/flume/1301/Hadoop46-20130125-111627296+0800.2334041655608560.00000021
     -rw-r--r-- 2 zhouhh supergroup 261 2013-01-25 11:17 /user/flume/1301/Hadoop46-20130125-111738299+0800.2334112657728560.00000021



    
    这两个文件内容一样。
     再重启，又增加一个。
     [zhouhh@Hadoop46 ~]$ flume-daemon.sh stop node -n ag1
     stopping node
     [zhouhh@Hadoop46 ~]$ flume-daemon.sh start node -n ag1
     starting node, logging to /home/zhouhh/flume-distribution-0.9.4/logs/flume-zhouhh-node-Hadoop46.out
     [zhouhh@Hadoop46 ~]$ hadoop fs -ls /user/flume/1301
     -rw-r--r-- 2 zhouhh supergroup 261 2013-01-25 11:16 /user/flume/1301/Hadoop46-20130125-111627296+0800.2334041655608560.00000021
     -rw-r--r-- 2 zhouhh supergroup 261 2013-01-25 11:17 /user/flume/1301/Hadoop46-20130125-111738299+0800.2334112657728560.00000021
     -rw-r--r-- 2 zhouhh supergroup 261 2013-01-25 11:19 /user/flume/1301/Hadoop46-20130125-111929858+0800.2334224217328560.00000021


另外，如果用重定向符>>往文件追加内容，则系统会添加新内容。而如果用vim编辑后关闭文件，则flume也会重新发送整个文件。
这是因为vim编辑文件是在临时文件中编辑的，编辑完，将源文件删除，用临时文件替换原文件内容。这导致inode变化。所以agent只好重新发送整个文件。这些都可能导致日志操作时的问题。

flume 的tail 类似于unix系统tail -F, -F参数是在文件被用其他文件替换后重新读取的。但因为inode改变，无法确认追加，只能重新全部读取。

    
    
     [zhouhh@Hadoop46 ~]$ tail --follow=name cards
     haha,1,2
     2013.1.23.18:52:59 haha,3,4
     asdf
     hello,
     what heppen?
     haha
     tail: `cards' has been replaced; following end of new file //此处在另一个console中用vim编辑了该文件。
     haha,1,2
     2013.1.23.18:52:59 haha,3,4
     asdf
     hello,
     what heppen?
     haha
     i love it!


这种方式方便日志文件的滚动命名，但需要注意可能引入的问题。



**参考：**
[tail -f 不起作用了？ http://geeklu.com/2010/06/continuous-monitor-tail-fails/](http://geeklu.com/2010/06/continuous-monitor-tail-fails/)
