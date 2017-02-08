---
author: abloz
comments: true
date: 2013-02-19 10:32:10+00:00
layout: post
link: http://abloz.com/index.php/2013/02/19/flume-ng-output-according-to-the-source-file-name-to-the-hdfs-file-name/
slug: flume-ng-output-according-to-the-source-file-name-to-the-hdfs-file-name
title: flume-ng如何根据源文件名输出到HDFS文件名
wordpress_id: 2126
categories:
- 技术
tags:
- flume-ng
---

周海汉/文
2013.2.19
http://abloz.com

flume-ng如何根据源文件名输出到HDFS文件名

需求：源中不同的文件，格式和内容不一样，希望采集到hdfs中后，能有对应的文件名，方便后续分析。

flume-ng可以自定义header，所以可以通过header来传递一些变量。而旧版的flume则可能不得不通过逻辑节点来部署不同的端口来曲线完成一些变量约定。
自定义header的方法，至少有5种。
**1.**编辑一个header文件，每一行用key=value的形式。在执行flume客户端时用--headerFile header指定header文件。
**2.**interceptors的static类型可以指定key，value，随header传递。
**3.**编程实现，在header里面添加相应的key/value
如果自己实现Interceptor，可以做类似的动作：
public class LogFormatInterceptor implements Interceptor {
Map headers = event.getHeaders();
                     headers.put( "host", hostname );
参考：http://blog.csdn.net/rjhym/article/details/8450728
**4.**flume已有的，如时间。见http://flume.apache.org/FlumeUserGuide.html#hdfs-sink
**5.**采用json，header里面可以指定
configure文件：
# Describe/configure the source
a1.sources.r1.type =  org.apache.flume.source.http.HTTPSource
a1.sources.r1.port = 9000
#a1.sources.r1.handler = org.apache.flume.http.JSONHandler

# Describe the sink
a1.sinks.k1.type = hdfs
a1.sinks.k1.hdfs.path = /user/uri/events/%{field1}
a1.sinks.k1.hdfs.filePrefix = events-

curl -X POST -d '[{  "headers" : {           "timestamp" : "434324343", "host" :"random_host.example.com", "field1" : "val1"            },  "body" : "random_body"  }]' localhost:9000

本文采用1,2,4 这三种方案，来实现hdfs文件的自定义和可传输。
[zhouhh@Hadoop48 flume1.3.1]$ cat header
host=ha48
filename=game.log

[zhouhh@Hadoop48 flume1.3.1]$ cat conf/testhdfs.conf
syslog-agent.sources = Syslog gamelog
syslog-agent.channels = MemoryChannel-1
syslog-agent.sinks = HDFS-LAB

#syslog-agent.sources.Syslog.type = syslogTcp
syslog-agent.sources.Syslog.type = avro
syslog-agent.sources.Syslog.port = 5140
syslog-agent.sources.Syslog.bind= 0.0.0.0
syslog-agent.sources.Syslog.host= hadoop48
syslog-agent.sources.Syslog.interceptors = i1 i2 i3
syslog-agent.sources.Syslog.interceptors.i1.type = org.apache.flume.interceptor.HostInterceptor$Builder
syslog-agent.sources.Syslog.interceptors.i1.preserveExisting = false
syslog-agent.sources.Syslog.interceptors.i1.hostHeader = hostname
syslog-agent.sources.Syslog.interceptors.i2.type = org.apache.flume.interceptor.TimestampInterceptor$Builder
syslog-agent.sources.Syslog.interceptors.i3.type = static
syslog-agent.sources.Syslog.interceptors.i3.key = datacenter
syslog-agent.sources.Syslog.interceptors.i3.value = NEW_YORK
syslog-agent.sources.Syslog.channels = MemoryChannel-1

syslog-agent.sources.gamelog.type = syslogTcp
syslog-agent.sources.gamelog.port = 5150

syslog-agent.sources.gamelog.channels = MemoryChannel-1

syslog-agent.sinks.HDFS-LAB.channel = MemoryChannel-1

syslog-agent.sinks.HDFS-LAB.type = hdfs

syslog-agent.sinks.HDFS-LAB.hdfs.path = hdfs://Hadoop48:54310/flume/%{host}
#syslog-agent.sinks.HDFS-LAB.hdfs.filePrefix = Syslog.%{host}
syslog-agent.sinks.HDFS-LAB.hdfs.filePrefix = %{filename}.%{host}.%Y-%m-%d
syslog-agent.sinks.HDFS-LAB.hdfs.rollInterval = 60
#syslog-agent.sinks.HDFS-LAB.hdfs.fileType = SequenceFile
syslog-agent.sinks.HDFS-LAB.hdfs.fileType = DataStream
#syslog-agent.sinks.HDFS-LAB.hdfs.file.writeFormat= Text
syslog-agent.channels.MemoryChannel-1.type = memory

[zhouhh@Hadoop48 flume1.3.1]$ flume-ng agent -n syslog-agent  -f testhdfs.conf
...
13/02/19 18:06:50 INFO hdfs.BucketWriter: Renaming hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410603.tmp to hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410603
13/02/19 18:06:50 INFO hdfs.BucketWriter: Creating hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410604.tmp
13/02/19 18:06:50 INFO hdfs.BucketWriter: Renaming hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410604.tmp to hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410604
13/02/19 18:06:50 INFO hdfs.BucketWriter: Creating hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410605.tmp
13/02/19 18:06:50 INFO hdfs.BucketWriter: Renaming hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410605.tmp to hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410605
13/02/19 18:06:50 INFO hdfs.BucketWriter: Creating hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410606.tmp
13/02/19 18:07:50 INFO hdfs.BucketWriter: Renaming hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410606.tmp to hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410606


[zhouhh@Hadoop48 flume1.3.1]$ fs -cat hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.2013-02-19.1361268410606
gdm:x:42:42::/var/gdm:/sbin/nologin
sabayon:x:86:86:Sabayon user:/home/sabayon:/sbin/nologin
hbase:x:500:500::/home/hbase:/bin/bash
zhh:x:501:501::/home/zhh:/bin/bash

[zhouhh@Hadoop48 flume1.3.1]$ vi conf/testhdfs.conf
syslog-agent.sinks.HDFS-LAB.hdfs.filePrefix = %{filename}.%{host}.%{datacenter}.%Y-%m-%d

文件名：
[zhouhh@Hadoop48 flume1.3.1]$ flume-ng agent -n syslog-agent  -f testhdfs.conf
...
13/02/19 18:12:13 INFO hdfs.BucketWriter: Renaming hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.NEW_YORK.2013-02-19.1361268733012.tmp to hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.NEW_YORK.2013-02-19.1361268733012
13/02/19 18:12:13 INFO hdfs.BucketWriter: Creating hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.NEW_YORK.2013-02-19.1361268733013.tmp
13/02/19 18:12:13 INFO hdfs.BucketWriter: Renaming hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.NEW_YORK.2013-02-19.1361268733013.tmp to hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.NEW_YORK.2013-02-19.1361268733013
13/02/19 18:12:13 INFO hdfs.BucketWriter: Creating hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.NEW_YORK.2013-02-19.1361268733014.tmp
13/02/19 18:12:13 INFO hdfs.BucketWriter: Renaming hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.NEW_YORK.2013-02-19.1361268733014.tmp to hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.NEW_YORK.2013-02-19.1361268733014
13/02/19 18:12:13 INFO hdfs.BucketWriter: Creating hdfs://Hadoop48:54310/flume/ha48/game.log.ha48.NEW_YORK.2013-02-19.1361268733015.tmp

这就实现了可以定制来源的hdfs输出文件名。
