---
author: abloz
comments: true
date: 2013-02-18 07:53:36+00:00
layout: post
link: http://abloz.com/index.php/2013/02/18/compile-under-windows-flume-1-3-1/
slug: compile-under-windows-flume-1-3-1
title: windows 下编译flume 1.3.1
wordpress_id: 2123
categories:
- 技术
tags:
- flume
- windows
---

周海汉/文
2013.2.18 http://abloz.com

windows下flume 1.0以上没有官方版本，但一些系统需要收集windows下程序和服务的日志。可以自己编译windows下版本。

**编译所需环境：**
1.maven 3.x
http://mirror.bit.edu.cn/apache/maven/maven-3/3.0.4/binaries/apache-maven-3.0.4-bin.zip
2.java sdk 1.6 以上
我的java安装在D:Program FilesJavajdk1.6.0_24。
可以到oracle下载：http://www.oracle.com/technetwork/java/javase/downloads/index.html
3.git
可以安装msysgit,下载地址：https://code.google.com/p/msysgit/downloads/list?q=full+installer+official+git
4.解压工具，如winrar，haozip
5.编辑工具ultraedit,用于编辑conf文件

**环境变量修改**
右键点桌面上“我的电脑”，“属性”，进入“控制面板系统和安全系统”
点“高级系统设置”，设置“环境变量”
JAVA_HOME设为"D:Program FilesJavajdk1.6.0_24"
M2_HOME设为D:apache-maven-3.0.4-bin
M2 为 "%M2_HOME%bin
MAVEN_OPTS 为 "-XX:MaxPermSize=1024M"
PATH里添加D:apache-maven-3.0.4-binbin;%JAVA_HOME%bin;

测试
cmd里输入mvn，git,java,看是否有相应输出。

**编译flume**
下载源文件：
http://www.apache.org/dyn/closer.cgi/flume/1.3.1/apache-flume-1.3.1-src.tar.gz
解压到D:apache-flume-1.3.1-src
D:apache-flume-1.3.1-src>mvn clean
D:apache-flume-1.3.1-src>mvn package -DskipTests
...
[INFO] Apache Flume ...................................... SUCCESS [32:00.307s]
[INFO] Flume NG SDK ...................................... SUCCESS [1:06.691s]
[INFO] Flume NG Configuration ............................ SUCCESS [2.331s]
[INFO] Flume NG Core ..................................... SUCCESS [7.444s]
[INFO] Flume NG Sinks .................................... SUCCESS [1.146s]
[INFO] Flume NG HDFS Sink ................................ SUCCESS [4.112s]
[INFO] Flume NG IRC Sink ................................. SUCCESS [1.800s]
[INFO] Flume NG HBase Sink ............................... SUCCESS [4.246s]
[INFO] Flume NG ElasticSearch Sink ....................... SUCCESS [3.510s]
[INFO] Flume Sources ..................................... SUCCESS [1.093s]
[INFO] Flume Scribe Source ............................... SUCCESS [2.744s]
[INFO] Flume NG Channels ................................. SUCCESS [1.132s]
[INFO] Flume NG JDBC channel ............................. SUCCESS [2.943s]
[INFO] Flume NG Node ..................................... SUCCESS [3.817s]
[INFO] Flume NG file-based channel ....................... SUCCESS [7.614s]
[INFO] Flume NG file backed Memory channel ............... SUCCESS [4.066s]
[INFO] Flume legacy Sources .............................. SUCCESS [2.347s]
[INFO] Flume legacy Avro source .......................... SUCCESS [4.311s]
[INFO] Flume legacy Thrift Source ........................ SUCCESS [6.173s]
[INFO] Flume NG Clients .................................. SUCCESS [2.050s]
[INFO] Flume NG Log4j Appender ........................... SUCCESS [4.352s]
[INFO] Flume NG distribution ............................. SUCCESS [48.551s]
[INFO] Flume NG Integration Tests ........................ SUCCESS [3.277s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 35:06.425s
[INFO] Finished at: Mon Feb 18 12:03:59 CST 2013
[INFO] Final Memory: 140M/247M
[INFO] ------------------------------------------------------------------------

编译成功后，查看
D:apache-flume-1.3.1-srcflume-ng-disttarget
apache-flume-1.3.1-bin.tar.gz
apache-flume-1.3.1-src.tar.gz

**测试flume**
解压apache-flume-1.3.1-bin.tar.gz到D:apache-flume-1.3.1-bin

修改log4j
D:apache-flume-1.3.1-binconflog4j.properties
将
#flume.root.logger=DEBUG,console
flume.root.logger=INFO,LOGFILE
改为
flume.root.logger=DEBUG,console
#flume.root.logger=INFO,LOGFILE

新建一个testconsole.conf文件，用console做输出
syslog-agent.sources = Syslog
syslog-agent.channels = MemoryChannel-1
syslog-agent.sinks = Console

syslog-agent.sources.Syslog.type = syslogTcp
syslog-agent.sources.Syslog.port = 5140

syslog-agent.sources.Syslog.channels = MemoryChannel-1
syslog-agent.sinks.Console.channel = MemoryChannel-1

syslog-agent.sinks.Console.type = logger
syslog-agent.channels.MemoryChannel-1.type = memory

保存到D:apache-flume-1.3.1-binconf目录下
执行flume agent
linux下类似
bin/flume-ng agent -n syslog-agent -f conf/syslog-agent.cnf
windows下有点不一样，-Xmx最少可以到20m。
D:apache-flume-1.3.1-bin> "D:Program FilesJavajdk1.6.0_24binjava.exe" -Xmx50m -Dlog4j.configuration=file:///D:apache-flume-1.3.1-binconflog4j.properties -cp "D:apache-flume-1.3.1-binlib*" org.apache.flume.node.Application -f D:apache-flume-1.3.1-binconftestconsole.conf -n syslog-agent

可以看到输出：
...
2013-02-18 15:44:58,370 (conf-file-poller-0) [DEBUG - org.apache.flume.conf.file
.AbstractFileConfigurationProvider$FileWatcherRunnable.run(AbstractFileConfigura
tionProvider.java:188)] Checking file:D:apache-flume-1.3.1-binconftestconsole
.conf for changes

到另一台linux机器下往windows 5140端口发syslog消息:
[zhouhh@Hadoop48 trunk]$ echo "<13>zhh write a syslog message from zhh" > /tmp/foo
[zhouhh@Hadoop48 trunk]$ nc -v 192.168.20.81 5140 < /tmp/foo
Connection to 192.168.20.81 5140 port [tcp/*] succeeded!
其中20.81是我刚运行了flume的windows机器。
这时，在windows命令行看到：
2013-02-18 15:48:08,922 (SinkRunner-PollingRunner-DefaultSinkProcessor) [INFO -
org.apache.flume.sink.LoggerSink.process(LoggerSink.java:70)] Event: { headers:{
Severity=5, Facility=1} body: 7A 68 68 20 77 72 69 74 65 20 61 20 73 79 73 6C zh
h write a sysl }
已经收到syslog消息。

**参考：**
下面这两篇博文是clouder公司flume的开发者Alex发的。我编译测试主要参考他的博文，一次通过。
http://mapredit.blogspot.com/2012/07/run-flume-13x-on-windows.html?showComment=1361158732748#c3717966993715817903
http://mapredit.blogspot.de/2012/03/flumeng-evolution.html
