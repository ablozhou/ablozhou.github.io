---
author: abloz
comments: true
date: 2013-10-17 08:30:45+00:00
layout: post
link: http://abloz.com/index.php/2013/10/17/compile-hadoop-2-2-0/
slug: compile-hadoop-2-2-0
title: 编译 hadoop 2.2.0
wordpress_id: 2242
categories:
- 技术
tags:
- hadoop
- yarn
---

周海汉 /文

2013.10.17

Hadoop 2.2 是 Hadoop 2 即yarn的第一个稳定版。并且解决单点问题。





## maven安装




[andy@s41 ~]$ wget [http://mirrors.cnnic.cn/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz](http://mirrors.cnnic.cn/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz)




解压后放到/usr/local目录下。







增加国内maven 开源中国镜像




[andy@s41 ~]$ sudo vi /usr/local/apache-maven-3.1.1/conf/settings.xml






    
      <mirror>
    <id>nexus-osc</id>
    <mirrorOf>*</mirrorOf>
    <name>Nexus osc</name>
    <url>http://maven.oschina.net/content/groups/public/</url>
    </mirror>










## 下载安装hadoop2.2







[andy@s41 ~]$ wget http://mirrors.cnnic.cn/apache/hadoop/common/stable2/hadoop-2.2.0-src.tar.gz







[andy@s41 ~]$ cd hadoop-2.2.0-src
[andy@s41 hadoop-2.2.0-src]$







## 编译




[andy@s41 hadoop-2.2.0-src]$ mvn clean install -DskipTests




[INFO] --- hadoop-maven-plugins:2.2.0:protoc (compile-protoc) @ hadoop-common ---
[WARNING] [protoc, --version] failed: java.io.IOException: Cannot run program "protoc": java.io.IOException: error=2, No such file or directory







[ERROR] Failed to execute goal org.apache.hadoop:hadoop-maven-plugins:2.2.0:protoc (compile-protoc) on project hadoop-common: org.apache.maven.plugin.MojoExecutionException: 'protoc --version' did not return a version -> [Help 1]







## 安装编译protobuf




[andy@s41 ~]$ wget [https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2](https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2)




[andy@s41 ~]$ tar jxvf protobuf-2.5.0.tar.bz2




[andy@s41 protobuf-2.5.0]$ ./configure




[andy@s41 protobuf-2.5.0]$ make




[andy@s41 protobuf-2.5.0]$ protoc --version
protoc: error while loading shared libraries: libprotobuf.so.8: cannot open shared object file: No such file or directory




[root@s41 protobuf-2.5.0]# ls /usr/local/lib
libhiredis.a        libltdl.a     libltdl.so.3.1.0    libprotobuf-lite.la        libprotobuf.so        libprotoc.la        liby.a
libhiredis.so       libltdl.la    libprotobuf.a       libprotobuf-lite.so        libprotobuf.so.8      libprotoc.so        pkgconfig
libhiredis.so.0     libltdl.so    libprotobuf.la      libprotobuf-lite.so.8      libprotobuf.so.8.0.0  libprotoc.so.8
libhiredis.so.0.10  libltdl.so.3  libprotobuf-lite.a  libprotobuf-lite.so.8.0.0  libprotoc.a           libprotoc.so.8.0.0







[root@s41 protobuf-2.5.0]# vi /etc/ld.so.conf




include /usr/local/lib







[andy@s41 protobuf-2.5.0]$ protoc --version
libprotoc 2.5.0







[andy@s41 hadoop-2.2.0-src]$ mvn install -DskipTests






[INFO] Apache Hadoop Main ................................ SUCCESS [0.947s]
[INFO] Apache Hadoop Project POM ......................... SUCCESS [0.294s]
[INFO] Apache Hadoop Annotations ......................... SUCCESS [0.474s]
[INFO] Apache Hadoop Project Dist POM .................... SUCCESS [0.287s]
[INFO] Apache Hadoop Assemblies .......................... SUCCESS [0.106s]
[INFO] Apache Hadoop Maven Plugins ....................... SUCCESS [0.937s]
[INFO] Apache Hadoop Auth ................................ SUCCESS [0.248s]
[INFO] Apache Hadoop Auth Examples ....................... SUCCESS [0.318s]
[INFO] Apache Hadoop Common .............................. SUCCESS [17.582s]
[INFO] Apache Hadoop NFS ................................. SUCCESS [1.364s]
[INFO] Apache Hadoop Common Project ...................... SUCCESS [0.016s]
[INFO] Apache Hadoop HDFS ................................ SUCCESS [39.854s]
[INFO] Apache Hadoop HttpFS .............................. SUCCESS [1.544s]
[INFO] Apache Hadoop HDFS BookKeeper Journal ............. SUCCESS [1.494s]
[INFO] Apache Hadoop HDFS-NFS ............................ SUCCESS [0.189s]
[INFO] Apache Hadoop HDFS Project ........................ SUCCESS [0.017s]
[INFO] hadoop-yarn ....................................... SUCCESS [5.859s]
[INFO] hadoop-yarn-api ................................... SUCCESS [2.837s]
[INFO] hadoop-yarn-common ................................ SUCCESS [1.263s]
[INFO] hadoop-yarn-server ................................ SUCCESS [0.045s]
[INFO] hadoop-yarn-server-common ......................... SUCCESS [0.458s]
[INFO] hadoop-yarn-server-nodemanager .................... SUCCESS [0.776s]
[INFO] hadoop-yarn-server-web-proxy ...................... SUCCESS [0.192s]
[INFO] hadoop-yarn-server-resourcemanager ................ SUCCESS [0.952s]
[INFO] hadoop-yarn-server-tests .......................... SUCCESS [0.150s]
[INFO] hadoop-yarn-client ................................ SUCCESS [0.239s]
[INFO] hadoop-yarn-applications .......................... SUCCESS [0.032s]
[INFO] hadoop-yarn-applications-distributedshell ......... SUCCESS [0.155s]
[INFO] hadoop-mapreduce-client ........................... SUCCESS [0.028s]
[INFO] hadoop-mapreduce-client-core ...................... SUCCESS [1.472s]
[INFO] hadoop-yarn-applications-unmanaged-am-launcher .... SUCCESS [0.124s]
[INFO] hadoop-yarn-site .................................. SUCCESS [0.047s]
[INFO] hadoop-yarn-project ............................... SUCCESS [1.431s]
[INFO] hadoop-mapreduce-client-common .................... SUCCESS [1.460s]
[INFO] hadoop-mapreduce-client-shuffle ................... SUCCESS [0.140s]
[INFO] hadoop-mapreduce-client-app ....................... SUCCESS [0.718s]
[INFO] hadoop-mapreduce-client-hs ........................ SUCCESS [0.320s]
[INFO] hadoop-mapreduce-client-jobclient ................. SUCCESS [1.065s]
[INFO] hadoop-mapreduce-client-hs-plugins ................ SUCCESS [0.104s]
[INFO] Apache Hadoop MapReduce Examples .................. SUCCESS [0.292s]
[INFO] hadoop-mapreduce .................................. SUCCESS [0.035s]
[INFO] Apache Hadoop MapReduce Streaming ................. SUCCESS [0.243s]
[INFO] Apache Hadoop Distributed Copy .................... SUCCESS [31.506s]
[INFO] Apache Hadoop Archives ............................ SUCCESS [0.138s]
[INFO] Apache Hadoop Rumen ............................... SUCCESS [0.296s]
[INFO] Apache Hadoop Gridmix ............................. SUCCESS [0.330s]
[INFO] Apache Hadoop Data Join ........................... SUCCESS [0.132s]
[INFO] Apache Hadoop Extras .............................. SUCCESS [0.182s]
[INFO] Apache Hadoop Pipes ............................... SUCCESS [0.011s]
[INFO] Apache Hadoop Tools Dist .......................... SUCCESS [0.185s]
[INFO] Apache Hadoop Tools ............................... SUCCESS [0.011s]
[INFO] Apache Hadoop Distribution ........................ SUCCESS [0.043s]
[INFO] Apache Hadoop Client .............................. SUCCESS [0.106s]
[INFO] Apache Hadoop Mini-Cluster ........................ SUCCESS [0.054s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 2:00.410s
[INFO] Finished at: Thu Oct 17 15:26:18 CST 2013
[INFO] Final Memory: 95M/1548M








