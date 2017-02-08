---
author: abloz
comments: true
date: 2012-06-11 11:46:26+00:00
layout: post
link: http://abloz.com/index.php/2012/06/11/the-hadoop-of-the-classnotfoundexception/
slug: the-hadoop-of-the-classnotfoundexception
title: hadoop 中的 ClassNotFoundException
wordpress_id: 1690
categories:
- 技术
tags:
- hadoop
- hbase
---

在执行hbase或mapreduce的程序时，有时会遇到ClassNotFoundException。如果jar包里的MANIFEST.MF没有指定Main-Class,就会遇到这一问题。但如果指定无误，还是会遇到这样的问题。

有人的建议是将所有用到的jar包都打进要执行的jar包里。这是一种解决方法。但即使将jar包全打进了新的jar文件，还是会遇到该问题。如我在执行hbase的IndexBuilder这个例子时，遇到如下问题：

    
    12/06/11 18:23:32 INFO mapred.JobClient: Task Id : attempt_201206111811_0001_m_000002_1, Status : FAILED
    java.lang.RuntimeException: java.lang.ClassNotFoundException: org.apache.hadoop.hbase.mapreduce.MultiTableOutputFormat
            at org.apache.hadoop.conf.Configuration.getClass(Configuration.java:867)
            at org.apache.hadoop.mapreduce.JobContext.getOutputFormatClass(JobContext.java:235)
            at org.apache.hadoop.mapred.Task.initialize(Task.java:513)
            at org.apache.hadoop.mapred.MapTask.run(MapTask.java:353)
            at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
            at java.security.AccessController.doPrivileged(Native Method)
            at javax.security.auth.Subject.doAs(Subject.java:415)
            at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1121)
            at org.apache.hadoop.mapred.Child.main(Child.java:249)
    Caused by: java.lang.ClassNotFoundException: org.apache.hadoop.hbase.mapreduce.MultiTableOutputFormat
            at java.net.URLClassLoader$1.run(URLClassLoader.java:366)
            at java.net.URLClassLoader$1.run(URLClassLoader.java:355)
            at java.security.AccessController.doPrivileged(Native Method)
            at java.net.URLClassLoader.findClass(URLClassLoader.java:354)
            at java.lang.ClassLoader.loadClass(ClassLoader.java:423)
            at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:308)
            at java.lang.ClassLoader.loadClass(ClassLoader.java:356)
            at java.lang.Class.forName0(Native Method)
            at java.lang.Class.forName(Class.java:264)
            at org.apache.hadoop.conf.Configuration.getClassByName(Configuration.java:820)
            at org.apache.hadoop.conf.Configuration.getClass(Configuration.java:865)
            ... 8 more


org.apache.hadoop.hbase.mapreduce.MultiTableOutputFormat是包含在hbase-0.94.0.jar里的。我打的jar包里确认有该jar文件，还是找不到。[http://wiki.apache.org/hadoop/Hbase/MapReduce](http://wiki.apache.org/hadoop/Hbase/MapReduce) 和[http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/mapreduce/package-summary.html](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/mapreduce/package-summary.html) 的HBase, MapReduce and the CLASSPATH

中提到，MapReduce的Job部署到群集中，并不缺省就能访问hbase配置目录和HBase下的类。解决办法：

1. 将hbase下的配置文件hbase-site.xml拷贝到hadoop的conf目录下，将hbase下的lib文件，拷贝到hadoop下的lib文件。并将变动应用到集群的每一台机器。

2. 编辑$HADOOP_HOME/conf下的hadoop-env.sh文件，将相关文件和目录加到`HADOOP_CLASSPATH中。但这有一个问题，就是会污染hadoop的执行环境。如果不在意的话，倒是可以这么用。但可能会有较大副作用。尤其是当环境出问题的时候。`

    
    HADOOP_CLASSPATH=${HBASE_HOME}/hbase-0.94.0.jar:`${HBASE_HOME}/bin/hbase classpath`


注意将hbase-0.94.jar放在其他库的前面。

3.在hbase 0.90版以后，可以只在本地环境修改CLASSPATH变量，不会对其他环境产生不良影响。

[zhouhh@Hadoop48 ~]$ HADOOP_CLASSPATH=`${HBASE_HOME}/bin/hbase classpath`  ${HADOOP_HOME}/bin/hadoop jar  multitb.jar cars.csv




