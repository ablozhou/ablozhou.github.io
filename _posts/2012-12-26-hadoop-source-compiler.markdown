---
author: abloz
comments: true
date: 2012-12-26 03:26:24+00:00
layout: post
link: http://abloz.com/index.php/2012/12/26/hadoop-source-compiler/
slug: hadoop-source-compiler
title: hadoop 源码编译
wordpress_id: 2027
categories:
- 技术
tags:
- build
- hadoop
---

周海汉
2012.12.26
http://abloz.com

以前写过一篇《[yarn hadoop mapreduce 2.0 编译](http://abloz.com/2012/09/19/the-yarn-hadoop-mapreduce-2-0-compiles.html)》，环境准备和那一篇一样。
本篇直接从svn下载最新源码，进行编译。

**下载源码：**
从subversion库check out：
[zhouhh@Hadoop48 hsrc]$ svn co http://svn.apache.org/repos/asf/hadoop/common/trunk


[zhouhh@Hadoop48 hsrc]$ cd trunk/
[zhouhh@Hadoop48 trunk]$ ls
BUILDING.txt  hadoop-assemblies  hadoop-common-project  hadoop-hdfs-project       hadoop-minicluster  hadoop-project-dist  hadoop-yarn-project
dev-support   hadoop-client      hadoop-dist            hadoop-mapreduce-project  hadoop-project      hadoop-tools         pom.xml

**Maven 主要模块:**

  hadoop                            (Main Hadoop project)
         - hadoop-project           (Parent POM for all Hadoop Maven modules.             )
                                    (All plugins & dependencies versions are defined here.)
         - hadoop-project-dist      (Parent POM for modules that generate distributions.)
         - hadoop-annotations       (Generates the Hadoop doclet used to generated the Javadocs)
         - hadoop-assemblies        (Maven assemblies used by the different modules)
         - hadoop-common-project    (Hadoop Common)
         - hadoop-hdfs-project      (Hadoop HDFS)
         - hadoop-mapreduce-project (Hadoop MapReduce)
         - hadoop-tools             (Hadoop tools like Streaming, Distcp, etc.)
         - hadoop-dist              (Hadoop distribution assembler)

**编译：**

[zhouhh@Hadoop48 trunk]$ mvn compile -DskipTest
...
[INFO] Reactor Summary:
[INFO]
[INFO] Apache Hadoop Main ................................ SUCCESS [0.605s]
[INFO] Apache Hadoop Project POM ......................... SUCCESS [0.558s]
[INFO] Apache Hadoop Annotations ......................... SUCCESS [0.288s]
[INFO] Apache Hadoop Project Dist POM .................... SUCCESS [0.094s]
[INFO] Apache Hadoop Assemblies .......................... SUCCESS [0.088s]
[INFO] Apache Hadoop Auth ................................ SUCCESS [0.152s]
[INFO] Apache Hadoop Auth Examples ....................... SUCCESS [0.093s]
[INFO] Apache Hadoop Common .............................. SUCCESS [5.188s]
[INFO] Apache Hadoop Common Project ...................... SUCCESS [0.049s]
[INFO] Apache Hadoop HDFS ................................ SUCCESS [12.065s]
[INFO] Apache Hadoop HttpFS .............................. SUCCESS [0.194s]
[INFO] Apache Hadoop HDFS BookKeeper Journal ............. SUCCESS [0.616s]
[INFO] Apache Hadoop HDFS Project ........................ SUCCESS [0.029s]
[INFO] hadoop-yarn ....................................... SUCCESS [0.157s]
[INFO] hadoop-yarn-api ................................... SUCCESS [2.951s]
[INFO] hadoop-yarn-common ................................ SUCCESS [0.752s]
[INFO] hadoop-yarn-server ................................ SUCCESS [0.124s]
[INFO] hadoop-yarn-server-common ......................... SUCCESS [0.736s]
[INFO] hadoop-yarn-server-nodemanager .................... SUCCESS [0.592s]
[INFO] hadoop-yarn-server-web-proxy ...................... SUCCESS [0.123s]
[INFO] hadoop-yarn-server-resourcemanager ................ SUCCESS [0.200s]
[INFO] hadoop-yarn-server-tests .......................... SUCCESS [0.149s]
[INFO] hadoop-yarn-client ................................ SUCCESS [0.119s]
[INFO] hadoop-yarn-applications .......................... SUCCESS [0.090s]
[INFO] hadoop-yarn-applications-distributedshell ......... SUCCESS [0.167s]
[INFO] hadoop-mapreduce-client ........................... SUCCESS [0.049s]
[INFO] hadoop-mapreduce-client-core ...................... SUCCESS [1.103s]
[INFO] hadoop-yarn-applications-unmanaged-am-launcher .... SUCCESS [0.142s]
[INFO] hadoop-yarn-site .................................. SUCCESS [0.082s]
[INFO] hadoop-yarn-project ............................... SUCCESS [0.075s]
[INFO] hadoop-mapreduce-client-common .................... SUCCESS [1.202s]
[INFO] hadoop-mapreduce-client-shuffle ................... SUCCESS [0.066s]
[INFO] hadoop-mapreduce-client-app ....................... SUCCESS [0.109s]
[INFO] hadoop-mapreduce-client-hs ........................ SUCCESS [0.123s]
[INFO] hadoop-mapreduce-client-jobclient ................. SUCCESS [0.114s]
[INFO] hadoop-mapreduce-client-hs-plugins ................ SUCCESS [0.084s]
[INFO] Apache Hadoop MapReduce Examples .................. SUCCESS [0.130s]
[INFO] hadoop-mapreduce .................................. SUCCESS [0.060s]
[INFO] Apache Hadoop MapReduce Streaming ................. SUCCESS [0.071s]
[INFO] Apache Hadoop Distributed Copy .................... SUCCESS [0.069s]
[INFO] Apache Hadoop Archives ............................ SUCCESS [0.061s]
[INFO] Apache Hadoop Rumen ............................... SUCCESS [0.135s]
[INFO] Apache Hadoop Gridmix ............................. SUCCESS [0.082s]
[INFO] Apache Hadoop Data Join ........................... SUCCESS [0.070s]
[INFO] Apache Hadoop Extras .............................. SUCCESS [0.192s]
[INFO] Apache Hadoop Pipes ............................... SUCCESS [0.019s]
[INFO] Apache Hadoop Tools Dist .......................... SUCCESS [0.057s]
[INFO] Apache Hadoop Tools ............................... SUCCESS [0.018s]
[INFO] Apache Hadoop Distribution ........................ SUCCESS [0.047s]
[INFO] Apache Hadoop Client .............................. SUCCESS [0.047s]
[INFO] Apache Hadoop Mini-Cluster ........................ SUCCESS [0.053s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 32.093s
[INFO] Finished at: Wed Dec 26 11:00:10 CST 2012
[INFO] Final Memory: 60M/769M

**打包命令：**
创建二进制分发版，不带native code和文档：
[zhouhh@Hadoop48 trunk]$ mvn package -Pdist -DskipTests -Dtar
创建二进制分发版，带native code和文档：
[zhouhh@Hadoop48 trunk]$ mvn package -Pdist,native,docs -DskipTests -Dtar
创建源码分发版
[zhouhh@Hadoop48 trunk]$ mvn package -Psrc -DskipTests
创建二进制带源码分发版，带native code和文档：
[zhouhh@Hadoop48 trunk]$ mvn package -Pdist,native,docs,src -DskipTests -Dtar
创建本地版web页面，放在/tmp/hadoop-site
[zhouhh@Hadoop48 trunk]$ mvn clean site; mvn site:stage -DstagingDirectory=/tmp/hadoop-site

**参考**
http://svn.apache.org/repos/asf/hadoop/common/trunk/BUILDING.txt
