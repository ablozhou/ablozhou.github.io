---
author: abloz
comments: true
date: 2013-10-29 10:30:36+00:00
layout: post
link: http://abloz.com/index.php/2013/10/29/kafka-trial/
slug: kafka-trial
title: kafka 试用
wordpress_id: 2255
categories:
- 技术
tags:
- kafka
---

kafka 试用







周海汉/文




2013.10.29







kafka是linkedin 2010年开发的分布式消息订阅发布系统，目前已经开源并贡献给apache，成为apache的顶级项目。kafka用scala开发，以实时处理消息，低IO消耗见长。因此多用于大数据实时处理和离线消息处理。







下面是kafka单机安装试用。







下载最新版本kafka：




[andy@s41 ~]$ wget [https://dist.apache.org/repos/dist/release/kafka/kafka_2.8.0-0.8.0-beta1.tgz](https://dist.apache.org/repos/dist/release/kafka/kafka_2.8.0-0.8.0-beta1.tgz)




解压，mv到kafka目录。







[andy@s41 kafka]$ ./sbt update




[andy@s41 kafka]$ ./sbt package




[andy@s41 kafka]$ ls -l
total 468
drwxrwxr-x  3 andy andy   4096 Sep 26 17:29 bin
drwxrwxr-x  2 andy andy   4096 Sep 26 17:27 config
drwxrwxr-x  5 andy andy   4096 Sep 26 18:10 contrib
drwxrwxr-x  4 andy andy   4096 Sep 26 18:10 core
-rw-rw-r--  1 andy andy    678 Sep 26 17:27 DISCLAIMER
drwxrwxr-x  5 andy andy   4096 Sep 27 10:48 examples
-rw-rw-r--  1 andy andy   4157 Sep 26 17:27 kafka-patch-review.py
drwxrwxr-x  2 andy andy   4096 Sep 26 17:27 lib
-rw-rw-r--  1 andy andy  12932 Sep 26 17:27 LICENSE
-rw-rw-r--  1 andy andy      0 Oct 29 17:38 log-cleaner.log
drwxrwxr-x  2 andy andy   4096 Oct 29 17:50 logs
-rw-rw-r--  1 andy andy    162 Sep 26 17:27 NOTICE
drwxrwxr-x  5 andy andy   4096 Sep 26 18:10 perf
drwxrwxr-x  5 andy andy   4096 Sep 26 17:43 project
-rw-rw-r--  1 andy andy 387643 Sep 26 17:28 rat.out
-rw-rw-r--  1 andy andy   2293 Sep 26 17:27 README.md
-rwxrwxr-x  1 andy andy    890 Sep 26 17:27 sbt
-rw-rw-r--  1 andy andy    900 Sep 26 17:27 sbt.bat
drwxrwxr-x 10 andy andy   4096 Sep 26 17:27 system_test
drwxrwxr-x  5 andy andy   4096 Oct 29 16:56 target







[andy@s41 kafka]$ ./bin/kafka-server-start.sh config/server.properties
Exception in thread "main" java.lang.NoClassDefFoundError: scala/ScalaObject
at java.lang.ClassLoader.defineClass1(Native Method)
at java.lang.ClassLoader.defineClassCond(ClassLoader.java:631)
at java.lang.ClassLoader.defineClass(ClassLoader.java:615)
at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:141)
at java.net.URLClassLoader.defineClass(URLClassLoader.java:283)
at java.net.URLClassLoader.access$000(URLClassLoader.java:58)
at java.net.URLClassLoader$1.run(URLClassLoader.java:197)
at java.security.AccessController.doPrivileged(Native Method)
at java.net.URLClassLoader.findClass(URLClassLoader.java:190)
at java.lang.ClassLoader.loadClass(ClassLoader.java:306)
at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:301)
at java.lang.ClassLoader.loadClass(ClassLoader.java:247)
at java.lang.ClassLoader.defineClass1(Native Method)
at java.lang.ClassLoader.defineClassCond(ClassLoader.java:631)
at java.lang.ClassLoader.defineClass(ClassLoader.java:615)
at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:141)
at java.net.URLClassLoader.defineClass(URLClassLoader.java:283)
at java.net.URLClassLoader.access$000(URLClassLoader.java:58)
at java.net.URLClassLoader$1.run(URLClassLoader.java:197)
at java.security.AccessController.doPrivileged(Native Method)
at java.net.URLClassLoader.findClass(URLClassLoader.java:190)
at java.lang.ClassLoader.loadClass(ClassLoader.java:306)
at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:301)
at java.lang.ClassLoader.loadClass(ClassLoader.java:247)
at kafka.Kafka.main(Kafka.scala)
Caused by: java.lang.ClassNotFoundException: scala.ScalaObject
at java.net.URLClassLoader$1.run(URLClassLoader.java:202)
at java.security.AccessController.doPrivileged(Native Method)
at java.net.URLClassLoader.findClass(URLClassLoader.java:190)
at java.lang.ClassLoader.loadClass(ClassLoader.java:306)
at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:301)
at java.lang.ClassLoader.loadClass(ClassLoader.java:247)
... 25 more
Please build the project using sbt. Documentation is available at [http://kafka.apache.org/](http://kafka.apache.org/)







参考 [http://kafka.apache.org/documentation.html#quickstart](http://kafka.apache.org/documentation.html#quickstart)




还需执行如下的依赖关系：




[andy@s41 kafka]$  ./sbt assembly-package-dependency







如果已有zookeeper，可以不执行下面的语句，没有则执行：




[andy@s41 kafka]$ ./bin/zookeeper-server-start.sh config/zookeeper.properties




 




启动server




[andy@s41 kafka]$ ./bin/kafka-server-start.sh config/server.properties







创建一个话题




[andy@s41 kafka]$ ./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1  --partition 1 --topic test
Created topic "test".







查看话题




[andy@s41 kafka]$ ./bin/kafka-topics.sh --list  --zookeeper localhost:2181
test







订阅话题




[andy@s41 kafka]$ ./bin/kafka-console-consumer.sh --zookeeper  localhost:2181 --topic test




生产话题消息内容：




[andy@s41 kafka]$ ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
hello
这是第二条消息
你好吗？
hello kafka.







此时可以实时看到订阅的消息显示出来




[andy@s41 kafka]$ ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test




hello
这是第二条消息
你好吗？
hello kafka.







或者用如下的命令：




[andy@s41 kafka]$ bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning
This is a message.
这是另一个消息。
这是第三个message. hello kafka.
hello
这是第二条消息
你好吗？
hello kafka.



