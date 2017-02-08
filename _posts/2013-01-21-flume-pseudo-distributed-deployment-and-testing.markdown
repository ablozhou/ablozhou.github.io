---
author: abloz
comments: true
date: 2013-01-21 09:58:26+00:00
layout: post
link: http://abloz.com/index.php/2013/01/21/flume-pseudo-distributed-deployment-and-testing/
slug: flume-pseudo-distributed-deployment-and-testing
title: flume伪分布式部署和测试
wordpress_id: 2083
categories:
- 技术
tags:
- flume
---

周海汉 2013.1.21

http://abloz.com

前一篇《[flume日志收集单节点](http://abloz.com/2013/01/21/the-flume-log-collection-single-node.html)》，讲了怎么安装flume，对单节点模式进行了测试。本篇讲flume伪分布式部署和测试

flume包括3种节点，一种是agent，一种是collector，一种是master。master用于管理agent和collector。agent和collector是完全一样的，都是从source拉数据，往sink 推数据。所以其不同完全是管理者赋予的。即agent部署在日志源节点。collector接受多个agent的sink作为源，再写到数据层，通常是hdfs或文件系统，供后续分析。
==========
**1. 修改flume-conf.xml**,将flume.master.servers的value有localhost改为hostname。本步非必须，但为方便起见还是改为hostname省事，方便远程访问。
[zhouhh@Hadoop48 conf]$ vi flume-conf.xml
<property>
<name>flume.master.servers</name>
<value>hadoop48</value>
<description>A comma-separated list of hostnames, one for each
machine in the Flume Master.
</description>
</property>

**2.启动**
[zhouhh@Hadoop48 ~]$ flume master

浏览http://hadoop48:35871/
Flume Master

Version: 0.9.4, r8d0aa4be4ee50bb664cb0d1624e5634f46d7b62a
Compiled: Mon Jun 20 14:48:23 PDT 2011 by jon
ServerID: 0

Servers hadoop48

Node status

logical node physical node host name status version last seen delta (s) last seen
Node configuration

Node Version Flow ID Source Sink Translated Version Translated Source Translated Sink
Physical/Logical Node mapping

physical node logical node

Command history

id State command line message

什么都是空的。

启动一个节点
[zhouhh@Hadoop48 ~]$ flume node_nowatch

浏览http://hadoop48:35871/
Flume Master
Version: 0.9.4, r8d0aa4be4ee50bb664cb0d1624e5634f46d7b62a
Compiled: Mon Jun 20 14:48:23 PDT 2011 by jon
ServerID: 0

Servers hadoop48

Node status

logical node physical node host name status version last seen delta (s) last seen
Hadoop48 Hadoop48 Hadoop48 IDLE none 4 Mon Jan 21 11:47:48 CST 2013
Node configuration

Node Version Flow ID Source Sink Translated Version Translated Source Translated Sink
Physical/Logical Node mapping

physical node logical node
Hadoop48 Hadoop48
Command history

id State command line message

可以看到用hostname做缺省节点名的节点hadoop48

**3.启动一个connect co1和一个agent ag1**,名字根据自己喜好起。-n参数表示后跟名字。
[zhouhh@Hadoop48 ~]$ flume node_nowatch -n co1
[zhouhh@Hadoop48 ~]$ flume node_nowatch -n ag1
2013-01-21 16:32:47,511 [main] WARN mortbay.log: failed SelectChannelConnector@0.0.0.0:35862: java.net.BindException: Address already in use
2013-01-21 16:32:47,512 [main] WARN mortbay.log: failed Server@7f2315e5: java.net.BindException: Address already in use
2013-01-21 16:32:47,512 [main] WARN util.InternalHttpServer: Caught exception during HTTP server start.
java.net.BindException: Address already in use

因为在一台机器机器启动，所以后一个node启动时会报端口35862被占用的警告，该端口是通过浏览器查看node信息的。忽略不管。

浏览http://hadoop48:35871/flumemaster.jsp
Node status

logical node physical node host name status version last seen delta (s) last seen
ag1 ag1 Hadoop48 IDLE none 0 Mon Jan 21 16:41:39 CST 2013
co1 co1 Hadoop48 IDLE none 4 Mon Jan 21 16:41:35 CST 2013



**4.执行命令**

在浏览器配置页执行命令http://hadoop48:35871/flumeconfig.jsp
Configure multiple nodes:
填写如下命令，提交。再回到master页面看命令执行是否成功。

    
    
    ag1 : console | agentSink("localhost",35853) ;
    co1 : collectorSource(35853) | console ;


这是对两个节点同时提交命令。前一个命令表示agent ag1的source是console，sink是agentSink,往 localhost的35853端口写数据。
后一个命令表示source是collectorSource(35853)，即从35853端口接受数据，sink是控制台。中间用管道符|隔开。
其格式为：

    
    
    nodename1: source1 | sink1;
    nodename2: source2 | sink2;
    ...




下一个命令agent ag1的源是从tcp端口5140接受数据，sink写到localhost的35853端口。collector co1将从源localhost的35853端口收集到的数据写到临时文件夹file:///tmp/flume/collected，并采用syslog的格式。

    
    
    ag1 : syslogTcp(5140) | agentSink("localhost",35853) ;
    co1 : collectorSource(35853) | collectorSink("file:///tmp/flume/collected", "syslog");


下一个命令agent ag1的源是从tcp端口5140接受数据，sink写到localhost的35853端口。collector co1将从源localhost的35853端口收集到的数据写到hdfs文件夹hdfs://hadoop48:54310/user/flume/，并采用syslog的格式。但hdfs里面保存的数据缺省格式是json的。

    
    
    ag1 : syslogTcp(5140) | agentSink("localhost",35853);
    co1 : collectorSource(35853) | collectorSink("hdfs://hadoop48:54310/user/flume/","syslog");


我们测试最后一种，写hdfs。



**5.写hdfs**
写之前查看一下hdfs文件系统：
[zhouhh@Hadoop48 conf]$ hadoop fs -ls hdfs://hadoop48:54310/user
Found 1 items
drwxr-xr-x - zhouhh supergroup 0 2013-01-10 17:52 /user/zhouhh

到http://hadoop48:35871/flumeconfig.jsp执行命令。

到http://hadoop48:35871/flumemaster.jsp的Command history查看命令执行结果，看看state是不是SUCCEEDED

id State command line message
9 SUCCEEDED multiconfig [ag1 : syslogTcp(5140) | agentSink("localhost",35853) ; co1 : collectorSource(35853) | collectorSink("hdfs://hadoop48:54310/user/flume/","syslog");]

往agent监听的tcp端口5140写syslog兼容的日志数据。<37>的意思是日志分类和log级别。
[zhouhh@Hadoop48 ~]$ echo "<37>hello zhouhh syslog" | nc -t localhost 5140

查看hdfs文件系统：
[zhouhh@Hadoop48 ~]$ hadoop fs -ls /user
Found 2 items
drwxr-xr-x - zhouhh supergroup 0 2013-01-21 16:52 /user/flume
drwxr-xr-x - zhouhh supergroup 0 2013-01-10 17:52 /user/zhouhh

目录创建成功。
检查文件：
[zhouhh@Hadoop48 ~]$ hadoop fs -ls /user/flume
Found 1 items
-rw-r--r-- 2 zhouhh supergroup 725 2013-01-21 16:52 /user/flume/syslog20130121-165237236+0800.2008611595205560.00000022
[zhouhh@Hadoop48 ~]$ hadoop fs -cat /user/flume/syslog20130121-165237236+0800.2008611595205560.00000022
{"body":"hello zhouhh syslog","timestamp":1358758047593,"pri":"INFO","nanos":2008301952329560,"host":"Hadoop48","fields":{"AckTag":"20130121-164721805+0800.2008296164296560.00000020","syslogfacility":"u0004","AckType":"msg","AckChecksum":"u0000u0000u0000u0000>i??","syslogseverity":"u0005","rolltag":"20130121-165237236+0800.2008611595205560.00000022"}}

可以看到json格式的hdfs文件的body，正是我发送的hello zhouhh syslog.syslogfacility 是4，syslogseverity是5. 即<37>表示的意思。
伪分布式flume测试成功。



**6.参考**

[http://archive.cloudera.com/cdh/3/flume/UserGuide/index.html](http://archive.cloudera.com/cdh/3/flume/UserGuide/index.html)
