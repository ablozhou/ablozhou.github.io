---
author: abloz
comments: true
date: 2012-09-19 07:22:07+00:00
layout: post
link: http://abloz.com/index.php/2012/09/19/the-yarn-hadoop-mapreduce-2-0-compiles/
slug: the-yarn-hadoop-mapreduce-2-0-compiles
title: yarn hadoop mapreduce 2.0 编译
wordpress_id: 1875
categories:
- 技术
tags:
- hadoop
- yarn
- 编译
---

周海汉 /文

2012.9.19


## 
下载



    
    
    [zhouhh@h185 ~]$ wget http://labs.mop.com/apache-mirror/hadoop/chukwa/stable/chukwa-0.4.0.tar.gz
    [zhouhh@h185 ~]$ wget http://labs.mop.com/apache-mirror/hadoop/common/hadoop-2.0.1-alpha/hadoop-2.0.1-alpha.tar.gz
    Length: 82726054 (79M)
    [zhouhh@h185 yarn]$ wget http://labs.mop.com/apache-mirror/hadoop/common/hadoop-2.0.1-alpha/hadoop-2.0.1-alpha-src.tar.gz
    [zhouhh@h185 yarn]$ tar zxvf hadoop-2.0.1-alpha-src.tar.gz





## 环境：


* 类Unix系统
* JDK 1.6 以上
* Maven 3.0 (用于代替ant的编译环境)
* Forrest 0.8 (Apache Forrest是一个平台独立的文档框架。把来自各种不同的输入数据源转换成用一种或多种输出格式(比如HTML,PDF等)来统一显示的发布系统。它基于Apache Cocoon并分离了内容与内容结构,不仅可以生成静态的文档也可以当作一个动态的服务器。如果要生成文档则需要。)
* Findbugs 1.3.9 (Java 语言静态分析工具，用于查找bug。非必须。)
* ProtocolBuffer 2.4.1+ ( MapReduce 和 HDFS 用google protocol buffer来压缩和交换数据)
* Autotools (如果编译 native code需要)
* 第一次编译要用到网络连接 (用于获取所有 Maven 和 Hadoop 依赖库)




## 安装maven




[zhouhh@h185 ~]$ wget http://labs.mop.com/apache-mirror/maven/maven-3/3.0.4/binaries/apache-maven-3.0.4-bin.tar.gz

[zhouhh@h185 ~]$ vi .bashrc
export PATH=$PATH:/home/zhouhh/maven/bin

maven用法：
* Clean : mvn clean
* Compile : mvn compile [-Pnative]
* Run tests : mvn test [-Pnative]
* Create JAR : mvn package
* Run findbugs : mvn compile findbugs:findbugs
* Run checkstyle : mvn compile checkstyle:checkstyle
* Install JAR in M2 cache : mvn install
* Deploy JAR to Maven repo : mvn deploy
* Run clover : mvn test -Pclover [-DcloverLicenseLocation=${user.name}/.clover.license]
* Run Rat : mvn apache-rat:check
* Build javadocs : mvn javadoc:javadoc
* Build distribution : mvn package [-Pdist][-Pdocs][-Psrc][-Pnative][-Dtar]
* Change Hadoop version : mvn versions:set -DnewVersion=NEWVERSION

Build 选项:

* Use -Pnative to compile/bundle native code
* Use -Dsnappy.prefix=(/usr/local) & -Dbundle.snappy=(false) to compile
Snappy JNI bindings and to bundle Snappy SO files
* Use -Pdocs to generate & bundle the documentation in the distribution (using -Pdist)
* Use -Psrc to create a project source TAR.GZ
* Use -Dtar to create a TAR with the distribution (using -Pdist)

[zhouhh@h185 hadoop-2.0.1-alpha-src]$ mvn package -Pdist,native,docs -DskipTests
...
main:
[exec] target/compile-proto.sh: line 17: protoc: command not found




## 安装protobuf




**下载protocol buffer**
[zhouhh@h185 yarn]$ wget http://protobuf.googlecode.com/files/protobuf-2.4.1.tar.bz2
[zhouhh@h185 yarn]$ tar jxvf protobuf-2.4.1.tar.bz2
[zhouhh@h185 protobuf-2.4.1]$ ./configure
[zhouhh@h185 protobuf-2.4.1]$ make
[zhouhh@h185 protobuf-2.4.1]$ sudo make install

[zhouhh@h185 hadoop-2.0.1-alpha-src]$ mvn package -Pdist,native,docs -DskipTests

main:
[exec] protoc: error while loading shared libraries: libprotobuf.so.7: cannot open shared object file: No such file or directory

[zhouhh@h185 local]$ protoc --version
protoc: error while loading shared libraries: libprotobuf.so.7: cannot open shared object file: No such file or directory

[zhouhh@h185 lib]$ ls /usr/local/lib/libprotobuf-lite.so.7
/usr/local/lib/libprotobuf-lite.so.7

[zhouhh@h185 local]$ sudo vi /etc/profile
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
[zhouhh@h185 local]$ source /etc/profile
[zhouhh@h185 local]$ protoc --version
libprotoc 2.4.1




## 错误处理




[zhouhh@h185 hadoop-2.0.1-alpha-src]$ mvn package -Pdist,native,docs -DskipTests
[ERROR] Failed to execute goal org.codehaus.mojo:make-maven-plugin:1.0-beta-1:autoreconf (compile) on project hadoop-common: autoreconf command returned an exit value != 0. Aborting build; see debug output for more information. -> [Help 1]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
[ERROR]
[ERROR] After correcting the problems, you can resume the build with the command
[ERROR] mvn <goals> -rf :hadoop-common
这个是因为编译的时候带了 native 参数，但是没装autotool。




## 安装autotool


[zhouhh@h185 hadoop-2.0.1-alpha-src]$ sudo yum install autoconf automake libtool

[zhouhh@h185 hadoop-2.0.1-alpha-src]$ mvn package -Pdist,native,docs -DskipTests -rf :hadoop-common

[ERROR] Failed to execute goal org.apache.maven.plugins:maven-antrun-plugin:1.6:run (site) on project hadoop-common: An Ant BuildException has occured: Execute failed: java.io.IOException: Cannot run program "${env.FORREST_HOME}/bin/forrest" (in directory "/home/zhouhh/yarn/hadoop-2.0.1-alpha-src/hadoop-common-project/hadoop-common/target/docs-src"): java.io.IOException: error=2, No such file or directory -> [Help 1]

没有安装forrest，没法生成文档。


## apache forrest 安装


[zhouhh@h185 yarn]$ wget http://labs.mop.com/apache-mirror//forrest/apache-forrest-0.9-sources.tar.gz
[zhouhh@h185 yarn]$ wget http://labs.mop.com/apache-mirror//forrest/apache-forrest-0.9-dependencies.tar.gz
解压apache-forrest-0.9-sources.tar.gz

[zhouhh@h185 main]$ pwd
/home/zhouhh/yarn/apache-forrest-0.9/main
[zhouhh@h185 main]$ ./build.sh
./build.sh: line 39: /home/zhouhh/yarn/apache-forrest-0.9/main/../tools/ant/bin/ant: No such file or directory

Could not load definitions from resource net/sf/antcontrib/antlib.xml. It could not be found.
...
BUILD FAILED
/home/zhouhh/yarn/apache-forrest-0.9/main/build.xml:522: /home/zhouhh/yarn/apache-forrest-0.9/tools/jetty not found
...
error: error reading /home/zhouhh/yarn/apache-forrest-0.9/lib/endorsed/xercesImpl-2.9.1.jar; error in opening zip file
解压apache-forrest-0.9-dependencies.tar.gz到forrest目录。tools里面的ant等都是dependencies里面带的。
或者用svn去下载最新的版本svn co http://svn.apache.org/repos/asf/forrest/trunk/

**修改forrest环境变量**
[zhouhh@h185 ~]$ vi .bashrc
export FORREST_HOME=/home/zhouhh/yarn/apache-forrest-0.9
export PATH=$PATH:$FORREST_HOME/bin
[zhouhh@h185 ~]$ source .bashrc




## 继续编译除错


[zhouhh@h185 hadoop-2.0.1-alpha-src]$ mvn package -Pdist,native,docs -DskipTests

[ERROR] Failed to execute goal org.apache.maven.plugins:maven-site-plugin:3.0:site (default) on project hadoop-auth: SiteToolException: IOException: cannot interpolate environment properties: Cannot run program "env": java.io.IOException: error=12, Cannot allocate memory -> [Help 1]
[ERROR] After correcting the problems, you can resume the build with the command
[ERROR] mvn <goals> -rf :hadoop-auth
内存只有2G，不够了，关掉一些程序。

[exec] Exception in thread "main" java.lang.InternalError: Can't connect to X11 window server using '192.168.20.81:0' as the value of the DISPLAY variable.
启动了xwindow
[zhouhh@h185 hadoop-2.0.1-alpha-src]$ mvn package -Pdist,native,docs -DskipTests -rf :hadoop-auth
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-antrun-plugin:1.6:run (site) on project hadoop-common: An Ant BuildException has occured: stylesheet /home/zhouhh/yarn/hadoop-2.0.1-alpha-src/hadoop-common-project/hadoop-common/${env.FINDBUGS_HOME}/src/xsl/default.xsl doesn't exist. -> [Help 1]
findbugs 没安装


## 安装findbugs


http://findbugs.sourceforge.net/downloads.html
[zhouhh@h185 yarn]$ wget http://downloads.sourceforge.net/project/findbugs/findbugs/2.0.1/findbugs-2.0.1-source.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Ffindbugs%2Ffiles%2Ffindbugs%2F2.0.1%2Ffindbugs-2.0.1-source.zip%2Fdownload%3Fuse_mirror%3Dcdnetworks-kr-1%26download%3D&ts=1347957365&use_mirror=cdnetworks-kr-1

[zhouhh@h185 yarn]$ unzip findbugs-2.0.1-source.zip

[zhouhh@h185 yarn]$ cd findbugs-2.0.1
[zhouhh@h185 findbugs-2.0.1]$ ant
BUILD FAILED
/home/zhouhh/yarn/findbugs-2.0.1/build.xml:166: Problem: failed to create task or type native2ascii
Cause: the class org.apache.tools.ant.taskdefs.optional.Native2Ascii was not found.
This looks like one of Ant's optional components.
Action: Check that the appropriate optional JAR exists in
-/usr/share/ant/lib
-/home/zhouhh/.ant/lib
-a directory added on the command line with the -lib argument

ant没安装好，到其他地方将ant的库拷贝到/usr/share/ant/lib。该类在ant-nodeps.jar里面。http://labs.mop.com/apache-mirror//forrest/apache-forrest-0.9-dependencies.tar.gz 里面就含有。
_**redhat和centos自带的ant，在/usr/bin/ant 不能正确编译Findbugs,必须到ant 网站http://ant.apache.org/下载。推荐下载二进制版本。**_




## 重新安装ant




[zhouhh@h185 yarn]$ wget http://mirror.bjtu.edu.cn/apache//ant/binaries/apache-ant-1.8.4-bin.zip
Length: 8043520 (7.7M)

自带ant版本
[zhouhh@h185 findbugs-2.0.1]$ ant -version
Apache Ant version 1.7.1 compiled on September 26 2008

[zhouhh@h185 ~]$ vi .bashrc
export ANT_HOME=/home/zhouhh/yarn/apache-ant-1.8.4
export PATH=$PATH:$ANT_HOME/bin
[zhouhh@h185 ~]$ source .bashrc

新版本ant 1.8.4
[zhouhh@h185 ~]$ ant -version
Apache Ant(TM) version 1.8.4 compiled on May 22 2012

[zhouhh@h185 findbugs-2.0.1]$ ant
Buildfile: /home/zhouhh/yarn/findbugs-2.0.1/build.xml
BUILD SUCCESSFUL

**设置findbugs环境**

[zhouhh@h185 ~]$ vi .bashrc
export FINDBUGS_HOME=/home/zhouhh/yarn/findbugs-2.0.1
export PATH=$PATH:$FINDBUGS_HOME/bin
[zhouhh@h185 ~]$ source .bashrc

[zhouhh@h185 hadoop-2.0.1-alpha-src]$ mvn package -Pdist,native,docs -DskipTests -rf :hadoop-common
[INFO] Apache Hadoop Common .............................. SUCCESS [7:57.297s]
[INFO] Apache Hadoop Common Project ...................... SUCCESS [0.338s]
[INFO] Apache Hadoop HDFS ................................ FAILURE [3:01.064s]

[ERROR] Failed to execute goal org.apache.maven.plugins:maven-antrun-plugin:1.6:run (site) on project hadoop-hdfs: An Ant BuildException has occured: input file /home/zhouhh/yarn/hadoop-2.0.1-alpha-src/hadoop-hdfs-project/hadoop-hdfs/target/findbugsXml.xml does not exist -> [Help 1]

[ERROR] After correcting the problems, you can resume the build with the command
[ERROR] mvn <goals> -rf :hadoop-hdfs



**将native和生成文档的选项去掉，编译ok**

[zhouhh@h185 hadoop-2.0.1-alpha-src]$ mvn package -Pdist -DskipTests -rf :hadoop-hdfs

ok




