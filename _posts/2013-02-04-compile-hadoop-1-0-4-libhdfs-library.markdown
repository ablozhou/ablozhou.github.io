---
author: abloz
comments: true
date: 2013-02-04 11:36:05+00:00
layout: post
link: http://abloz.com/index.php/2013/02/04/compile-hadoop-1-0-4-libhdfs-library/
slug: compile-hadoop-1-0-4-libhdfs-library
title: 编译hadoop 1.0.4的 libhdfs库
wordpress_id: 2116
categories:
- 技术
tags:
- hadoop
- libhdfs
---

周海汉
2013.2.4
[zhouhh@Hadoop48 hadoop-1.0.4]$ echo $JAVA_HOME
/usr/java/jdk1.7.0
[zhouhh@Hadoop48 hadoop-1.0.4]$ uname -a
Linux Hadoop48 2.6.18-348.el5 #1 SMP Tue Jan 8 17:53:53 EST 2013 x86_64 x86_64 x86_64 GNU/Linux
[zhouhh@Hadoop48 hadoop-1.0.4]$ chmod +x src/c++/pipes/configure
[zhouhh@Hadoop48 hadoop-1.0.4]$ chmod +x src/c++/utils/configure
[zhouhh@Hadoop48 hadoop-1.0.4]$ chmod +x src/c++/libhdfs/configure

编译libhdfs
[zhouhh@Hadoop48 hadoop-1.0.4]$ ant compile -Dcompile.c++=true -Dlibhdfs=true

如果此前手动执行过configure，则会报下面的错误
[exec] configure: error: source directory already configured; run "make distclean" there first
执行
make distclean

[zhouhh@Hadoop48 hadoop-1.0.4]$ ant compile -Dcompile.c++=true -Dlibhdfs=true
compile:
     [echo] contrib: gridmix
    [javac] /home/zhouhh/hadoop-1.0.4/src/contrib/build-contrib.xml:185: warning: 'includeantruntime' was not set, defaulting to build.sysclasspath=last; set to false for repeatable builds
    [javac] Compiling 19 source files to /home/zhouhh/hadoop-1.0.4/build/contrib/gridmix/classes
    [javac] /home/zhouhh/hadoop-1.0.4/src/contrib/gridmix/src/java/org/apache/hadoop/mapred/gridmix/Gridmix.java:396: error: type argument ? extends T is not within bounds of type-variable E
    [javac]   private  String getEnumValues(Enum[] e) {
    [javac]                                         ^
    [javac]   where T,E are type-variables:
    [javac]     T extends Object declared in method getEnumValues(Enum[])
    [javac]     E extends Enum declared in class Enum
    [javac] /home/zhouhh/hadoop-1.0.4/src/contrib/gridmix/src/java/org/apache/hadoop/mapred/gridmix/Gridmix.java:399: error: type argument ? extends T is not within bounds of type-variable E
    [javac]     for (Enum v : e) {
    [javac]               ^
    [javac]   where T,E are type-variables:
    [javac]     T extends Object declared in method getEnumValues(Enum[])
    [javac]     E extends Enum declared in class Enum
    [javac] Note: Some input files use unchecked or unsafe operations.
    [javac] Note: Recompile with -Xlint:unchecked for details.
    [javac] 2 errors

BUILD FAILED
/home/zhouhh/hadoop-1.0.4/build.xml:706: The following error occurred while executing this line:
/home/zhouhh/hadoop-1.0.4/src/contrib/build.xml:30: The following error occurred while executing this line:
/home/zhouhh/hadoop-1.0.4/src/contrib/build-contrib.xml:185: Compile failed; see the compiler error output for details.

这是java 7兼容性问题。
见
https://issues.apache.org/jira/browse/Hadoop-8329
https://issues.apache.org/jira/browse/BIGTOP-400

Hadoop-8329提供的patch不能用于hadoop1.0.4
问题出在下面文件的396行。
 hadoop-tools/hadoop-gridmix/src/main/java/org/apache/hadoop/mapred/gridmix/Gridmix.java

我制作了一个patch

[zhouhh@Hadoop48 hadoop-1.0.4]$ cat hadoop-1.0.4.java7.patch
[patch](http://abloz.com/wp-content/uploads/2013/02/patch.txt)

[zhouhh@Hadoop48 hadoop-1.0.4]$ patch -Np0 < hadoop-1.0.4.java7.patch
patching file ./src/contrib/gridmix/src/java/org/apache/hadoop/mapred/gridmix/Gridmix.java

[zhouhh@Hadoop48 hadoop-1.0.4]$ ant compile -Dcompile.c++=true -Dlibhdfs=true
BUILD SUCCESSFUL
Total time: 1 minute 47 seconds

[zhouhh@Hadoop48 hadoop-1.0.4]$ ls build/c++/Linux-amd64-64/lib/
libhadooppipes.a  libhadooputils.a  libhdfs.la  libhdfs.so  libhdfs.so.0  libhdfs.so.0.0.0
