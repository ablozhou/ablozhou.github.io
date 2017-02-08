---
author: abloz
comments: true
date: 2013-08-20 06:32:30+00:00
layout: post
link: http://abloz.com/index.php/2013/08/20/sqoop-1-99-installation-and-configuration/
slug: sqoop-1-99-installation-and-configuration
title: sqoop 1.99 安装配置
wordpress_id: 2204
categories:
- 技术
tags:
- sqoop
---

周海汉/文 2013.8.20
http://abloz.com

摘要：
1. sqoop 1.99的安装配置
2. client使用
3. 从HBase，Hive导数据到mysql

版本
sqoop-1.99.2-bin-hadoop100

Sqoop是Hadoop系统数据和RDBMS互导数据的工具。1.99新版的一个包里包含两个部分：客户端和服务器端。必须在集群中安装好一个节点的服务器端。所有客户端和该服务器端相连。服务器端作为mapreduce的client，所以Hadoop必须和Sqoop服务器端装在一起。客户端则不限。这种设计让导数据更灵活。原1.44版则没有区分服务器端和客户端。


服务器端安装

1.确认本机有hadoop
hadoop fs -ls

由于hadoop的主版本1.xx和2.xx不兼容，所以sqoop的二进制版本也是分100和200的。如我在hadoop 1.1.2中使用sqoop-1.99.2-bin-hadoop100来进行配套。
解压
 tar zxvf sqoop-1.99.2-bin-hadoop100.tar.gz
cd sqoop-1.99.2-bin-hadoop100

2. 安装依赖库和组件

./bin/addtowar.sh -hadoop-auto

[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ ./bin/addtowar.sh -hadoop-auto

Non of expected directories with Hadoop exists

Usage  : addtowar.sh 
Options: -hadoop-auto Try to guess hadoop version and path
          -hadoop-version HADOOP_VERSION Specify used version
          -hadoop-path HADOOP_PATHS Where to find hadoop jars (multiple paths with Hadoop jars separated by ':')
          -jars JARS_PATH Special jars that should be added (multiple JAR paths separated by ':')
          -war SQOOP_WAR Target Sqoop war file where all jars should be ingested

由于我的hadoop没有安装到系统路径，所以需修改配置文件。
[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ vi ./bin/addtowar.sh
 hadoopPossiblePaths="/home/hadoop/hadoop-1.1.2 /usr/lib/hadoop /usr/lib/hadoop-mapreduce/ /usr/lib/hadoop-yarn/ /usr/lib/hadoop-hdfs"

[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ ./bin/addtowar.sh -hadoop-auto
./bin/addtowar.sh: line 126: [: missing `]'
Hadoop version: 1.1.2
Hadoop path: /home/hadoop/hadoop-1.1.2
Extra jars:

Injecting following Hadoop JARs

/home/hadoop/hadoop-1.1.2/hadoop-core-1.1.2.jar
/home/hadoop/hadoop-1.1.2/lib/jackson-core-asl-1.8.8.jar
/home/hadoop/hadoop-1.1.2/lib/jackson-mapper-asl-1.8.8.jar
/home/hadoop/hadoop-1.1.2/lib/commons-configuration-1.6.jar
/home/hadoop/hadoop-1.1.2/lib/commons-logging-api-1.0.4.jar
/home/hadoop/hadoop-1.1.2/lib/slf4j-api-1.4.3.jar
/home/hadoop/hadoop-1.1.2/lib/slf4j-log4j12-1.4.3.jar

Backing up original WAR file to ./bin/../server/webapps/sqoop.war_2013-08-20_09:36:01.263437795

New Sqoop WAR file with added 'Hadoop JARs' at ./bin/../server/webapps/sqoop.war

脚本126行]有个空格问题，但不影响结果。改后：
[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ vi ./bin/addtowar.sh
[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ ./bin/addtowar.sh -hadoop-auto
Hadoop version: 1.1.2
Hadoop path: /home/hadoop/hadoop-1.1.2
Extra jars:

Specified Sqoop WAR './bin/../server/webapps/sqoop.war' already contains Hadoop JAR files

也可以指定,-hadoop-version指定版本，-hadoop-path 指定目录。如果各部分安装在多个目录，则用:分隔。
如：
hadoop 1.0
./bin/addtowar.sh -hadoop-version 1.0 -hadoop-path /usr/lib/hadoop-common:/usr/lib/hadoop-hdfs:/usr/lib/hadoop-mpred

hadoop 2.0
./bin/addtowar.sh -hadoop-version 2.0 -hadoop-path /usr/lib/hadoop-common:/usr/lib/hadoop-hdfs:/usr/lib/hadoop-yarn

也可以用addtowar.sh的-jars参数来绑定其他的jar文件。
绑定jdbc mysql库：
由于不同协议，sqoop没有自带mysql jdbc库，需下载，并绑定：
http://dev.mysql.com/downloads/mirror.php?id=13597
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.0.8.tar.gz/from/http://cdn.mysql.com/

注意下载的是tar.gz, 里面有源码和jar包。只需解压后使用jar包即可。

[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ ./bin/addtowar.sh -jars /home/hadoop/hive-0.11.0/lib/mysql-connector-java-5.0.8-bin.jar
Hadoop version:
Hadoop path:
Extra jars: /home/hadoop/hive-0.11.0/lib/mysql-connector-java-5.0.8-bin.jar

Injecting following additional JARs

/home/hadoop/hive-0.11.0/lib/mysql-connector-java-5.0.8-bin.jar


Backing up original WAR file to ./bin/../server/webapps/sqoop.war_2013-08-20_09:49:32.401896012

New Sqoop WAR file with added 'JARs' at ./bin/../server/webapps/sqoop.war

3.配置sqoop服务器
server/conf 里面存放服务器的配置文件。包括tomcat等配置。但缺省配置PropertiesConfigurationProvider足够用。如需修改，编辑sqoop_bootstrap.properties的sqoop.config.provider即可。
[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ cd server/conf
[hadoop@hs11 conf]$ ls
catalina.policy  catalina.properties  context.xml  logging.properties  server.xml  sqoop_bootstrap.properties  sqoop.properties  tomcat-users.xml  web.xml
[hadoop@hs11 conf]$ cat sqoop_bootstrap.properties
sqoop.config.provider=org.apache.sqoop.core.PropertiesConfigurationProvider

sqoop.properties包含其他的一些修改。可能需要微调，以适应环境需要。
#org.apache.sqoop.submission.engine.mapreduce.configuration.directory=/etc/hadoop/conf/
org.apache.sqoop.submission.engine.mapreduce.configuration.directory=/home/hadoop/hadoop-1.1.2/conf/

4. 启动和停止服务器
./bin/sqoop.sh server start

[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ ./bin/sqoop.sh server start
Sqoop home directory: /home/hadoop/sqoop-1.99.2-bin-hadoop100...
Using CATALINA_BASE:   /home/hadoop/sqoop-1.99.2-bin-hadoop100/server
Using CATALINA_HOME:   /home/hadoop/sqoop-1.99.2-bin-hadoop100/server
Using CATALINA_TMPDIR: /home/hadoop/sqoop-1.99.2-bin-hadoop100/server/temp
Using JRE_HOME:        /usr/java/jdk1.6.0_45
Using CLASSPATH:       /home/hadoop/sqoop-1.99.2-bin-hadoop100/server/bin/bootstrap.jar

[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ ./bin/sqoop.sh server stop
Sqoop home directory: /home/hadoop/sqoop-1.99.2-bin-hadoop100...
Using CATALINA_BASE:   /home/hadoop/sqoop-1.99.2-bin-hadoop100/server
Using CATALINA_HOME:   /home/hadoop/sqoop-1.99.2-bin-hadoop100/server
Using CATALINA_TMPDIR: /home/hadoop/sqoop-1.99.2-bin-hadoop100/server/temp
Using JRE_HOME:        /usr/java/jdk1.6.0_45
Using CLASSPATH:       /home/hadoop/sqoop-1.99.2-bin-hadoop100/server/bin/bootstrap.jar

5.客户端安装
客户端无需配置，只需将下载版本解压即可。
[hadoop@hs11 sqoop-1.99.2-bin-hadoop100]$ ./bin/sqoop.sh client
Sqoop home directory: /home/hadoop/sqoop-1.99.2-bin-hadoop100...
Aug 20, 2013 10:07:54 AM java.util.prefs.FileSystemPreferences$2 run
INFO: Created user preferences directory.
Sqoop Shell: Type 'help' or 'h' for help.

sqoop:000>
或执行sqoop脚本：
sqoop.sh client /path/to/your/script.sqoop

具体使用在下一篇详述。
6.参考：
http://sqoop.apache.org/docs/1.99.2/Installation.html
http://sqoop.apache.org/docs/1.99.2/Sqoop5MinutesDemo.html
http://sqoop.apache.org/docs/1.99.2/CommandLineClient.html

