---
author: abloz
comments: true
date: 2012-06-14 10:39:14+00:00
layout: post
link: http://abloz.com/index.php/2012/06/14/hive-getting-started-tutorial/
slug: hive-getting-started-tutorial
title: hive 入门教程
wordpress_id: 1693
categories:
- 技术
tags:
- hive
---

http://abloz.com
2012.6.14

**下载**
[zhouhh@Hadoop48 ~]$ wget http://labs.renren.com/apache-mirror/hive/hive-0.9.0/hive-0.9.0.tar.gz

**配置**
[zhouhh@Hadoop48 ~]$ tar zxvf hive-0.9.0.tar.gz
[zhouhh@Hadoop48 ~]$ cd hive-0.9.0
[zhouhh@Hadoop48 hive-0.9.0]$ export HIVE_HOME=`pwd`
[zhouhh@Hadoop48 hive-0.9.0]$ echo $HIVE_HOME
/home/zhouhh/hive-0.9.0

[zhouhh@Hadoop48 ~]$ vi .bashrc

export  HADOOP_HOME=/home/zhouhh/hadoop-1.0.3
export  HADOOP_HOME_WARN_SUPPRESS=1
export HBASE_HOME=/home/zhouhh/hbase-0.94.0
export HIVE_HOME=/home/zhouhh/hive-0.9.0

export PATH=$PATH:/sbin/:$HADOOP_HOME/bin:$HBASE_HOME/bin:$HIVE_HOME/bin

[zhouhh@Hadoop48 ~]$ source .bashrc

源码编译：
$ svn co http://svn.apache.org/repos/asf/hive/trunk hive
  $ cd hive
  $ ant clean package
  $ cd build/dist
  $ ls
  README.txt
  bin/ (all the shell scripts)
  lib/ (required jar files)
  conf/ (configuration files)
  examples/ (sample input and query files)

hdfs的/tmp和/user/hive/warehouse必须创建，并且具有组可写权限。
[zhouhh@Hadoop48 ~]$ hadoop fs -ls /
Found 4 items
drwxr-xr-x   - zhouhh supergroup          0 2012-06-12 19:15 /hbase
drwxr-xr-x   - zhouhh supergroup          0 2012-06-12 12:55 /home
drwxr-xr-x   - zhouhh supergroup          0 2012-06-12 12:54 /tmp
drwxr-xr-x   - zhouhh supergroup          0 2012-06-11 15:40 /user
[zhouhh@Hadoop48 ~]$ hadoop fs -ls /user
Found 1 items
drwxr-xr-x   - zhouhh supergroup          0 2012-06-12 19:04 /user/zhouhh
[zhouhh@Hadoop48 ~]$ hadoop fs -mkdir /user/hive/warehouse
[zhouhh@Hadoop48 ~]$ hadoop fs -chmod g+w /tmp
[zhouhh@Hadoop48 ~]$ hadoop fs -chmod g+w /user/hive/warehouse

[zhouhh@Hadoop48 ~]$ hadoop fs -ls /user/hive/
Found 1 items
drwxrwxr-x   - zhouhh supergroup          0 2012-06-14 17:39 /user/hive/warehouse

[zhouhh@Hadoop48 conf]$ pwd
/home/zhouhh/hive-0.9.0/conf
[zhouhh@Hadoop48 conf]$ ls
hive-default.xml.template  hive-exec-log4j.properties.template
hive-env.sh.template       hive-log4j.properties.template

[zhouhh@Hadoop48 hive-0.9.0]$ ./bin/hive
Exception in thread "main" java.lang.NoClassDefFoundError: org/apache/hadoop/hive/conf/HiveConf

找不到类？
原来，HADOOP_CLASSPATH配置不应该直接覆盖，应将HADOOP_CLASSPATH原来的内容写在前面
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH: ...(其他内容)

**启动使用**
[zhouhh@Hadoop48 hive-0.9.0]$ hive
hive> CREATE TABLE poke(id INT,name STRING);
OK
Time taken: 6.513 seconds
hive> show tables;
OK
poke
Time taken: 0.231 seconds
hive> describe poke;
OK
id      int
name    string
Time taken: 0.039 seconds
hive> alter table poke add columns(other string comment 'this is a new column');
OK
Time taken: 0.237 seconds
hive> describe poke;
OK
id      int
name    string
other   string  this is a new column
Time taken: 0.037 seconds

ALTER TABLE [table name] RENAME TO [other name];
DROP TABLE [table name];

[zhouhh@Hadoop48 files]$ pwd
/home/zhouhh/hive-0.9.0/examples/files
[zhouhh@Hadoop48 files]$ head kv1.txt
57^Aval_57
302^Aval_302
205^Aval_205
149^Aval_149
438^Aval_438
345^Aval_345
129^Aval_129
170^Aval_170
...
数据用Ctrl+a分隔的，打印时分隔符看不见。
hive> load data local inpath './examples/files/kv1.txt' overwrite into table poke;
Copying data from file:/home/zhouhh/hive-0.9.0/examples/files/kv1.txt
Copying file: file:/home/zhouhh/hive-0.9.0/examples/files/kv1.txt
Loading data to table default.poke
Deleted hdfs://Hadoop48:54310/user/hive/warehouse/poke
OK
Time taken: 1.358 seconds
如果是分布式环境，则将命令的local改为hdfs。overwrite 关键字表示覆盖表，会将原来的数据清除。如果没有该关键字，则是追加。
而且，导入数据时不会有数据类型的校验。如果是hdfs，根目录是 hive-default.xml的hive.metastore.warehouse.dir参数指定，建表前应先创建该目录。
hive> select * from poke;
OK
238     val_238 NULL
86      val_86  NULL
311     val_311 NULL
27      val_27  NULL
165     val_165 NULL
...

**参考：**
https://cwiki.apache.org/confluence/display/Hive/GettingStarted
