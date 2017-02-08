---
author: abloz
comments: true
date: 2013-01-21 06:58:45+00:00
layout: post
link: http://abloz.com/index.php/2013/01/21/the-flume-log-collection-single-node/
slug: the-flume-log-collection-single-node
title: flume 日志收集单节点
wordpress_id: 2078
categories:
- 技术
tags:
- flume
- hadoop
---

周海汉 2013.1.21

flume 是 cloudera公司研发的日志收集系统，采用3层结构：1. agent层，用于直接收集日志;2.connect 层，用于接受日志; 3. 数据存储层，用于保存日志。由一到多个master管理1和2层节点。

本文采用单节点试用flume日志处理。




## **下载**


flume下载页面

[https://github.com/cloudera/flume/downloads](https://github.com/cloudera/flume/downloads)

flume windows最新版(2013.1.21)

[http://cloud.github.com/downloads/cloudera/flume/flume-node-0.9.4.exe](http://cloud.github.com/downloads/cloudera/flume/flume-node-0.9.4.exe)

fulume linux 最新版下载地址

[http://cloud.github.com/downloads/cloudera/flume/flume-distribution-0.9.4-bin.tar.gz](http://cloud.github.com/downloads/cloudera/flume/flume-distribution-0.9.4-bin.tar.gz)

本实验在linux上进行


## **flume 单节点使用示例**


flume号称水道，其设计思路是水源(source)和水槽(sink)都是可以人意组合的。这样在汇集水的过程是非常灵活的。每一个逻辑节点由事件生产(source)和事件消费(sink)组成。从源拉取数据，从sink推走。单节点缺省sink是console。单节点源采用dump的方式。命令行 flume dump source

常用source源：



	
  * **console**

	
  * 标准输入控制台

	
  * **text("filename")**

	
  * 单文本文件源，一行一事件

	
  * **tail("filename")**

	
  * 和 Unix 的tail -F 类似。一行一事件。一直打开等待数据，会跟踪文件切换。

	
  * **multitail("file1"[,** "file2"[, …]])

	
  * 同 tail 源类似，但可以跟踪多文件。

	
  * **asciisynth(msg_count,msg_size)**

	
  * 一个源，用于产生msg_count 个msg_size大小的随机消息，转成可打印 ASCII字符。

	
  * **syslogUdp(port)**

	
  * UDP 端口上的 Syslog，和syslog兼容。

	
  * **syslogTcp(port)**

	
  * TCP 端口上的 Syslog，和syslog-ng兼容。




    
    <strong></strong>
    [zhouhh@Hadoop48 ~]$ flume dump console
    你好
    Hadoop48 [INFO Mon Jan 21 11:37:52 CST 2013] ??
    haha
    Hadoop48 [INFO Mon Jan 21 11:37:56 CST 2013] haha
    hello
    Hadoop48 [INFO Mon Jan 21 11:37:59 CST 2013] hello
    this is a test
    Hadoop48 [INFO Mon Jan 21 11:38:07 CST 2013] this is a test



    
    [zhouhh@Hadoop48 ~]$ flume dump 'text("/etc/services")'
    ...
    Hadoop48 [INFO Mon Jan 21 10:57:15 CST 2013] iqobjectt48619/udpttt# iqobject
    Hadoop48 [INFO Mon Jan 21 10:57:15 CST 2013] # Local services
    2013-01-21 10:57:15,498 [logicalNode dump-9] INFO debug.TextFileSource: File /etc/services closed
    2013-01-21 10:57:15,498 [logicalNode dump-9] INFO debug.ConsoleEventSink: ConsoleEventSink( debug ) closed



    
    [zhouhh@Hadoop48 ~]$ flume dump 'tail("testfile")'



    
    [zhouhh@Hadoop48 ~]$ echo hello world >> testfile
    [zhouhh@Hadoop48 ~]$ echo 你好 >> testfile


输出

    
    [zhouhh@Hadoop48 ~]$ flume dump 'tail("testfile")'
    ...
    Hadoop48 [INFO Mon Jan 21 10:55:39 CST 2013] { tailSrcFile : (long)8387236824819002469 (string) 'testfile' (double)4.914663849160389E252 } hello world
    Hadoop48 [INFO Mon Jan 21 10:56:07 CST 2013] { tailSrcFile : (long)8387236824819002469 (string) 'testfile' (double)4.914663849160389E252 } u4F60u597D



    
    [zhouhh@Hadoop48 ~]$ flume dump 'multitail("test1", "test2")'



    
    [zhouhh@Hadoop48 ~]$ echo Hello world test1! >> test1
    [zhouhh@Hadoop48 ~]$ echo Hello world test2! >> test2



    
    输出



    
    [zhouhh@Hadoop48 ~]$ flume dump 'multitail("test1", "test2")'



    
    ...
    Hadoop48 [INFO Mon Jan 21 10:59:51 CST 2013] { tailSrcFile : test1 } Hello world test1!
    Hadoop48 [INFO Mon Jan 21 11:00:00 CST 2013] { tailSrcFile : test2 } Hello world test2!




tail 缺省分隔符是n,并且n不包含在事件中。tail 支持自定义分隔符，还可指定分隔符是包含在前一事件(prev)，后一事件(next),还是不包含在事件中(exclude).

    
    两个及以上n换行
    tail("file", delim="nn+", delimMode="exclude")
    用</a>做分隔符，并且做为前一事件结尾。
    tail("file", delim="</a>", delimMode="prev")
    用"ndddd"正则表达式做分隔符，并且做为后一事件的开头。用于分析stack dump日志。如年开头四位数字。
    tail("file", delim="\n\d\d\d\d", delimMode="next")


**获取2行3个随机字符日志**

    
    [zhouhh@Hadoop48 ~]$ flume dump 'asciisynth(2,3)'
    Hadoop48 [INFO Mon Jan 21 11:12:36 CST 2013] :,J
    Hadoop48 [INFO Mon Jan 21 11:12:36 CST 2013] o


**用udp或tcp接受syslog格式日志**

    
    [zhouhh@Hadoop48 ~]$ flume dump 'syslogUdp(5140)'


发送消息到5140端口

    
    [zhouhh@Hadoop48 ~]$ echo "hello " | nc -u hadoop48 5140
    [zhouhh@Hadoop48 ~]$ flume dump 'syslogUdp(5140)'
    2013-01-21 11:15:10,587 [logicalNode dump-9] WARN syslog.SyslogUdpSource: 1 rejected packets. packet: java.net.DatagramPacket@75037619
    com.cloudera.flume.handlers.text.EventExtractException: Failed to extract syslog wire entry
     at com.cloudera.flume.handlers.syslog.SyslogWireExtractor.extract(SyslogWireExtractor.java:178)
     at com.cloudera.flume.handlers.syslog.SyslogWireExtractor.extractEvent(SyslogWireExtractor.java:89)
     at com.cloudera.flume.handlers.syslog.SyslogUdpSource.next(SyslogUdpSource.java:88)
     at com.cloudera.flume.core.connector.DirectDriver$PumperThread.run(DirectDriver.java:105)
    
    这是因为发送的消息没有wireformat数据
    [zhouhh@Hadoop48 ~]$ echo "<37>hello " | nc -u hadoop48 5140
    [zhouhh@Hadoop48 ~]$ flume dump 'syslogUdp(5140)'
    ...
    Hadoop48 [INFO Mon Jan 21 11:24:02 CST 2013] { syslogfacility : 4 } { syslogseverity : 5 } hello


<37>用于指定log分类和log级别

**接受tcp数据**

    
    [zhouhh@Hadoop48 ~]$ flume dump 'syslogTcp(5140)'



    
    [zhouhh@Hadoop48 ~]$ echo "<37>hello via syslog" | nc -t localhost 5140



    
    显示结果
    [zhouhh@Hadoop48 ~]$ flume dump 'syslogTcp(5140)'
    ...
    Hadoop48 [INFO Mon Jan 21 11:33:01 CST 2013] { syslogfacility : 4 } { syslogseverity : 5 } hello via syslog





## 参考


[http://archive.cloudera.com/cdh/3/flume/UserGuide/index.html](http://archive.cloudera.com/cdh/3/flume/UserGuide/index.html)
