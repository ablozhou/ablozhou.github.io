---
author: abloz
comments: true
date: 2012-05-22 10:22:32+00:00
layout: post
link: http://abloz.com/index.php/2012/05/22/10-minutes-from-scratch-to-build-hadoop-environment-and-test-mapreduce/
slug: 10-minutes-from-scratch-to-build-hadoop-environment-and-test-mapreduce
title: 10分钟从无到有搭建hadoop环境并测试mapreduce
wordpress_id: 1597
categories:
- 技术
tags:
- hadoop
- mapreduce
- single
---

来源：http://abloz.com/2012/05/22/hadoop-installation.html
**目标**：
安装测试本地单机hadoop。
花费时间：10分钟
**前提**：
java环境已经准备好

hadoop有三种运行方式，单机版包括直接本地运行，假多点环境，多点集群环境。本文测试第一种方法，快速部署hadoop应用。

开始：
**下载**
<del>wget http://labs.renren.com/apache-mirror/hadoop/common/hadoop-1.0.3/hadoop-1.0.3.tar.gz</del>(已经失效，最新稳定版1.0.4,谢谢yclimw指出)

wget http://labs.mop.com/apache-mirror/hadoop/common/hadoop-1.0.4/hadoop-1.0.4.tar.gz
60MB大小
解压
tar -zxvf hadoop-1.0.3.tar.gz

配置
[zhouhh@Hadoop48 ~]$ echo $JAVA_HOME
/usr/java/jdk1.7.0

cd hadoop-1.0.3
[zhouhh@Hadoop48 hadoop-1.0.3]$ vi conf/hadoop-env.sh
#将注释去掉，设置JAVA_HOME环境变量
export JAVA_HOME=/usr/java/jdk1.7.0

测试：
[zhouhh@Hadoop46 hadoop-1.0.3]$ ./bin/hadoop
Usage: hadoop [--config confdir] COMMAND
...

执行例子程序中的grep

```
[zhouhh@Hadoop48 hadoop-1.0.3]$ mkdir input
[zhouhh@Hadoop48 hadoop-1.0.3]$ cp conf/* input
[zhouhh@Hadoop48 hadoop-1.0.3]$ ./bin/hadoop jar hadoop-examples-1.0.3.jar grep input output '[a-z.]+'
12/05/22 18:03:32 INFO util.NativeCodeLoader: Loaded the native-hadoop library
12/05/22 18:03:32 WARN snappy.LoadSnappy: Snappy native library not loaded
...
[zhouhh@Hadoop46 hadoop-1.0.3]$ cat output/*
117 value
99 property
91 name
88 description
85 the
77 of
...
```

测试mapreduce 例子wordcount，单词计数：

```
[zhouhh@Hadoop46 hadoop-1.0.3]$ rm -r output
[zhouhh@Hadoop46 hadoop-1.0.3]$ ./bin/hadoop jar hadoop-examples-1.0.3.jar wordcount input output
12/05/22 18:32:54 INFO util.NativeCodeLoader: Loaded the native-hadoop library
12/05/22 18:32:55 INFO input.FileInputFormat: Total input paths to process : 16
...
12/05/22 18:33:47 INFO mapred.JobClient: Map output records=2587
[zhouhh@Hadoop46 hadoop-1.0.3]$
```

可以看到花费将近1分钟计算单词数

```
[zhouhh@Hadoop46 hadoop-1.0.3]$ ls output/
part-r-00000 _SUCCESS

[zhouhh@Hadoop46 hadoop-1.0.3]$ cat output/*
"". 4
"*" 10
"alice,bob 10
"console" 1
"hadoop.root.logger". 1
"jks". 4
...
which 17
who 3
will 8
with 5
worker 1
would 7
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 1
you 1
```

10分钟内完成。
