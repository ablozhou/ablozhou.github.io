---
author: abloz
comments: true
date: 2012-06-15 03:31:01+00:00
layout: post
link: http://abloz.com/index.php/2012/06/15/hive-execution-hbase-create-the-table-can-not-find-protobuf/
slug: hive-execution-hbase-create-the-table-can-not-find-protobuf
title: hive 执行hbase创建表时找不到protobuf
wordpress_id: 1695
categories:
- 技术
tags:
- hbase
- hive
---

hadoop:1.0.3
hive:0.9.0
hbase:0.94.0

protobuf:$HBASE_HOME/lib/protobuf-java-2.4.0a.jar

可以看到，0.9.0的hive里面自带的hbase的jar是0.92版本的。

[zhouhh@Hadoop48 ~]$ hive --auxpath $HIVE_HOME/lib/hive-hbase-handler-0.9.0.jar,$HIVE_HOME/lib/hbase-0.92.0.jar,$HIVE_HOME/lib/zookeeper-3.3.4.jar,$HIVE_HOME/lib/guava-r09.jar,$HBASE_HOME/lib/protobuf-java-2.4.0a.jar
hive> CREATE TABLE hbase_table_1(key int, value string)
    > STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
    > WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,cf1:val")
    > TBLPROPERTIES ("hbase.table.name" = "xyz");
java.lang.NoClassDefFoundError: com/google/protobuf/Message
        at org.apache.hadoop.hbase.io.HbaseObjectWritable.(HbaseObjectWritable.java
...
Caused by: java.lang.ClassNotFoundException: com.google.protobuf.Message
解决办法：
将$HBASE_HOME/lib/protobuf-java-2.4.0a.jar 拷贝到 $HIVE_HOME/lib/.

[zhouhh@Hadoop48 ~]$ cp /home/zhouhh/hbase-0.94.0/lib/protobuf-java-2.4.0a.jar $HIVE_HOME/lib/.

hive> CREATE TABLE hbase_table_1(key int, value string)
    > STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
    > WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,cf1:val")
    > TBLPROPERTIES ("hbase.table.name" = "xyz");
OK
Time taken: 10.492 seconds


hbase(main):002:0> list 'xyz'
TABLE
xyz
1 row(s) in 0.0640 seconds

