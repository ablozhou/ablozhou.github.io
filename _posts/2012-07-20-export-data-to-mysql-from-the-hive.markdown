---
author: abloz
comments: true
date: 2012-07-20 06:38:17+00:00
layout: post
link: http://abloz.com/index.php/2012/07/20/export-data-to-mysql-from-the-hive/
slug: export-data-to-mysql-from-the-hive
title: 从hive将数据导出到mysql
wordpress_id: 1768
categories:
- 技术
tags:
- export
- hive
- mysql
- sqoop
---

http://abloz.com

2012.7.20

author:周海汉


在上一篇文章《[用sqoop进行mysql和hdfs系统间的数据互导](http://abloz.com/2012/07/19/data-between-the-mysql-and-hdfs-system-of-mutual-conductance-using-sqoop.html)》中，提到sqoop可以让RDBMS和HDFS之间互导数据，并且也支持从mysql中导入到HBase，但从HBase直接导入mysql则不是直接支持，而是间接支持。要么将HBase导出到HDFS平面文件，要么将其导出到Hive中，再导出到mysql。本篇讲从hive中导出到mysql。
从hive将数据导出到mysql


## 一、创建mysql表



    
    mysql> create table award (rowkey varchar(255), productid int, matchid varchar(255), rank varchar(255), tourneyid varchar(255), userid bigint, gameid int, gold int, loginid varchar(255), nick varchar(255), plat varchar(255));
    Query OK, 0 rows affected (0.01 sec)




## 二、尝试用hive作为外部数据库连接hbase，导入mysql



    
    hive> CREATE EXTERNAL TABLE hive_award(key string, productid int,matchid string, rank string, tourneyid string, userid bigint,gameid int,gold int,loginid string,nick string,plat string) STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler' WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,info:MPID,info:MatchID,info:Rank,info:TourneyID,info:UserId,info:gameID,info:gold,info:loginId,info:nickName,info:platform") TBLPROPERTIES("hbase.table.name" = "award");



    
    hive> desc hive_award;
    key string from deserializer
    productid int from deserializer
    matchid string from deserializer
    rank string from deserializer
    tourneyid string from deserializer
    userid bigint from deserializer
    gameid int from deserializer
    gold int from deserializer
    loginid string from deserializer
    nick string from deserializer
    plat string from deserializer
    [zhouhh@Hadoop46 ~]$ hadoop fs -ls /user/hive/warehouse/
    Found 3 items
    drwxr-xr-x - zhouhh supergroup 0 2012-07-16 14:08 /user/hive/warehouse/hive_award
    drwxr-xr-x - zhouhh supergroup 0 2012-07-16 14:30 /user/hive/warehouse/nnnon
    drwxr-xr-x - zhouhh supergroup 0 2012-07-16 13:53 /user/hive/warehouse/test222



    
    [zhouhh@Hadoop46 ~]$ sqoop export --connect jdbc:mysql://Hadoop48/toplists -m 1 --table award --export-dir /user/hive/warehouse/hive_award --input-fields-terminated-by '\001'
    12/07/19 16:13:06 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.



    
    12/07/19 16:13:06 INFO tool.CodeGenTool: Beginning code generation
    12/07/19 16:13:06 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `award` AS t LIMIT 1
    12/07/19 16:13:06 INFO orm.CompilationManager: HADOOP_HOME is /home/zhouhh/hadoop-1.0.0/libexec/..
    注: /tmp/sqoop-zhouhh/compile/4366149f0b6dd311c5b622594744fbb0/award.java使用或覆盖了已过时的 API。
    注: 有关详细信息, 请使用 -Xlint:deprecation 重新编译。
    12/07/19 16:13:08 INFO orm.CompilationManager: Writing jar file: /tmp/sqoop-zhouhh/compile/4366149f0b6dd311c5b622594744fbb0/award.jar
    12/07/19 16:13:08 INFO mapreduce.ExportJobBase: Beginning export of award
    12/07/19 16:13:09 WARN mapreduce.ExportJobBase: Input path hdfs://Hadoop46:9200/user/hive/warehouse/hive_award contains no files
    12/07/19 16:13:11 INFO input.FileInputFormat: Total input paths to process : 0
    12/07/19 16:13:11 INFO input.FileInputFormat: Total input paths to process : 0
    12/07/19 16:13:13 INFO mapred.JobClient: Running job: job_201207191159_0059
    12/07/19 16:13:14 INFO mapred.JobClient: map 0% reduce 0%
    12/07/19 16:13:26 INFO mapred.JobClient: Job complete: job_201207191159_0059
    12/07/19 16:13:26 INFO mapred.JobClient: Counters: 4
    12/07/19 16:13:26 INFO mapred.JobClient: Job Counters
    12/07/19 16:13:26 INFO mapred.JobClient: SLOTS_MILLIS_MAPS=7993
    12/07/19 16:13:26 INFO mapred.JobClient: Total time spent by all reduces waiting after reserving slots (ms)=0
    12/07/19 16:13:26 INFO mapred.JobClient: Total time spent by all maps waiting after reserving slots (ms)=0
    12/07/19 16:13:26 INFO mapred.JobClient: SLOTS_MILLIS_REDUCES=0
    12/07/19 16:13:26 INFO mapreduce.ExportJobBase: Transferred 0 bytes in 16.9678 seconds (0 bytes/sec)
    12/07/19 16:13:26 INFO mapreduce.ExportJobBase: Exported 0 records.



    
    直接导外部表不成功，Input path hdfs://Hadoop46:9200/user/hive/warehouse/hive_award contains no files




## 三、hive中创建连结hbase的表，在hive中的插入会引起hbase的数据改变：



    
    CREATE TABLE hive_award_data(key string,productid int,matchid string,rank string,
    tourneyid string,userid bigint,gameid int,
    gold int,loginid string,nick string,plat string)
    STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
    WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,info:MPID,info:MatchID,info:Rank,info:TourneyID,info:UserId,info:gameID,info:gold,info:loginId,info:nickName,info:platform") TBLPROPERTIES("hbase.table.name" = "award_test");
    hive> insert overwrite table hive_award_data select * from hive_award limit 2;
    hbase(main):014:0> scan 'award_test'
    ROW COLUMN+CELL
     2012-04-27 06:55:00:402713629 column=info:MPID, timestamp=1342754799918, value=5947
     2012-04-27 06:55:00:402713629 column=info:MatchID, timestamp=1342754799918, value=433203828
     2012-04-27 06:55:00:402713629 column=info:Rank, timestamp=1342754799918, value=2
     2012-04-27 06:55:00:402713629 column=info:TourneyID, timestamp=1342754799918, value=4027102
     2012-04-27 06:55:00:402713629 column=info:UserId, timestamp=1342754799918, value=402713629
     2012-04-27 06:55:00:402713629 column=info:gameID, timestamp=1342754799918, value=1001
     2012-04-27 06:55:00:402713629 column=info:loginId, timestamp=1342754799918, value=715878221
     2012-04-27 06:55:00:402713629 column=info:nickName, timestamp=1342754799918, value=xxx
     2012-04-27 06:55:00:402713629 column=info:platform, timestamp=1342754799918, value=ios
     2012-04-27 06:55:00:402713629 column=info:userid, timestamp=1342754445451, value=402713629
     2012-04-27 06:55:00:406788559 column=info:MPID, timestamp=1342754799918, value=778
     2012-04-27 06:55:00:406788559 column=info:MatchID, timestamp=1342754799918, value=433203930
     2012-04-27 06:55:00:406788559 column=info:Rank, timestamp=1342754799918, value=19
     2012-04-27 06:55:00:406788559 column=info:TourneyID, timestamp=1342754799918, value=4017780
     2012-04-27 06:55:00:406788559 column=info:UserId, timestamp=1342754799918, value=406788559
     2012-04-27 06:55:00:406788559 column=info:gameID, timestamp=1342754799918, value=1001
     2012-04-27 06:55:00:406788559 column=info:gold, timestamp=1342754799918, value=1
     2012-04-27 06:55:00:406788559 column=info:loginId, timestamp=1342754799918, value=13835155880
     2012-04-27 06:55:00:406788559 column=info:nickName, timestamp=1342754799918, value=xxx
     2012-04-27 06:55:00:406788559 column=info:platform, timestamp=1342754799918, value=android
    2 row(s) in 0.0280 seconds
    [zhouhh@Hadoop46 ~]$ sqoop export --connect jdbc:mysql://Hadoop48/toplists -m 1 --table award --export-dir /user/hive/warehouse/hive_award_data --input-fields-terminated-by '\001'
    12/07/20 11:32:01 WARN mapreduce.ExportJobBase: Input path hdfs://Hadoop46:9200/user/hive/warehouse/hive_award_data contains no files


创建连接HBase的表，还是不能导入。


## 四、创建Hive表，将HBase外部表的数据导入



    
    hive> CREATE TABLE hive_myaward(key string,productid int,matchid string,rank string,tourneyid string,userid bigint,gameid int,gold int,loginid string,nick string,plat string);
    hive> insert overwrite table hive_myaward select * from hive_award limit 2;



    
    hive> select * from hive_myaward;
    OK
    2012-04-27 06:55:00:402713629 5947 433203828 2 4027102 402713629 1001 NULL 715878221 杀破天A ios
    2012-04-27 06:55:00:406788559 778 433203930 19 4017780 406788559 1001 1 13835155880 亲牛牛旦旦 android
    Time taken: 2.257 seconds
    [zhouhh@Hadoop46 ~]$ sqoop export --connect jdbc:mysql://Hadoop48/toplists -m 1 --table award --export-dir /user/hive/warehouse/hive_myaward --input-fields-terminated-by '\001'
    java.io.IOException: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Access denied for user ''@'Hadoop48' to database 'toplists'


权限问题，再授权一下

    
    
    mysql> GRANT ALL PRIVILEGES ON *.* TO ''@'Hadoop48';
    Query OK, 0 rows affected (0.03 sec)
    mysql> GRANT ALL PRIVILEGES ON *.* TO ''@'localhost';
    Query OK, 0 rows affected (0.00 sec)




## 五、解决Hive中遇到的空值NULL的问题：



    
    [zhouhh@Hadoop46 ~]$ sqoop export --connect jdbc:mysql://Hadoop48/toplists -m 1 --table award --export-dir /user/hive/warehouse/hive_myaward --input-fields-terminated-by '\001'
    ...
    12/07/20 11:49:25 INFO mapred.JobClient: map 0% reduce 0%
    12/07/20 11:49:37 INFO mapred.JobClient: Task Id : attempt_201207191159_0227_m_000000_0, Status : FAILED
    java.lang.NumberFormatException: For input string: "N"
     at java.lang.NumberFormatException.forInputString(NumberFormatException.java:65)


N是什么东西呢？

    
    [zhouhh@Hadoop46 ~]$ hadoop fs -cat /user/hive/warehouse/hive_myaward/000000_0
    2012-04-27 06:55:00:4027136295947433203828240271024027136291001N715878221杀破天Aios
    2012-04-27 06:55:00:4067885597784332039301940177804067885591001113835155880亲牛牛旦旦android



    
    hive> select * from hive_myaward;
    OK
    2012-04-27 06:55:00:402713629 5947 433203828 2 4027102 402713629 1001 NULL 715878221 杀破天A ios
    2012-04-27 06:55:00:406788559 778 433203930 19 4017780 406788559 1001 1 13835155880 亲牛牛旦旦 android
    Time taken: 2.257 seconds


由于Hive的NULL用N来表示，字段用\1来分割，换行用n来换行，所以需增加相应的指示,注意转义字符：
见：https://issues.cloudera.org/browse/SQOOP-188

    
    [zhouhh@Hadoop46 ~]$ sqoop export --connect jdbc:mysql://Hadoop48/toplists -m 1 --table award --export-dir /user/hive/warehouse/hive_myaward/000000_0 --input-null-string "\\N" --input-null-non-string "\\N" --input-fields-terminated-by "\01" --input-lines-terminated-by "\n"



    
    12/07/20 12:53:56 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
    12/07/20 12:53:56 INFO tool.CodeGenTool: Beginning code generation
    12/07/20 12:53:56 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `award` AS t LIMIT 1
    12/07/20 12:53:56 INFO orm.CompilationManager: HADOOP_HOME is /home/zhouhh/hadoop-1.0.0/libexec/..
    注: /tmp/sqoop-zhouhh/compile/4427d3db678bb145c995073e0924dc0b/award.java使用或覆盖了已过时的 API。
    注: 有关详细信息, 请使用 -Xlint:deprecation 重新编译。
    12/07/20 12:53:57 ERROR orm.CompilationManager: Could not rename /tmp/sqoop-zhouhh/compile/4427d3db678bb145c995073e0924dc0b/award.java to /home/zhouhh/./award.java
    12/07/20 12:53:57 INFO orm.CompilationManager: Writing jar file: /tmp/sqoop-zhouhh/compile/4427d3db678bb145c995073e0924dc0b/award.jar
    12/07/20 12:53:57 INFO mapreduce.ExportJobBase: Beginning export of award
    12/07/20 12:53:58 INFO input.FileInputFormat: Total input paths to process : 1
    12/07/20 12:53:58 INFO input.FileInputFormat: Total input paths to process : 1
    12/07/20 12:53:58 INFO mapred.JobClient: Running job: job_201207191159_0232
    12/07/20 12:53:59 INFO mapred.JobClient: map 0% reduce 0%
    12/07/20 12:54:12 INFO mapred.JobClient: map 100% reduce 0%
    12/07/20 12:54:17 INFO mapred.JobClient: Job complete: job_201207191159_0232
    12/07/20 12:54:17 INFO mapred.JobClient: Counters: 18
    12/07/20 12:54:17 INFO mapred.JobClient: Job Counters
    12/07/20 12:54:17 INFO mapred.JobClient: SLOTS_MILLIS_MAPS=12114
    12/07/20 12:54:17 INFO mapred.JobClient: Total time spent by all reduces waiting after reserving slots (ms)=0
    12/07/20 12:54:17 INFO mapred.JobClient: Total time spent by all maps waiting after reserving slots (ms)=0
    12/07/20 12:54:17 INFO mapred.JobClient: Rack-local map tasks=1
    12/07/20 12:54:17 INFO mapred.JobClient: Launched map tasks=1
    12/07/20 12:54:17 INFO mapred.JobClient: SLOTS_MILLIS_REDUCES=0
    12/07/20 12:54:17 INFO mapred.JobClient: File Output Format Counters
    12/07/20 12:54:17 INFO mapred.JobClient: Bytes Written=0
    12/07/20 12:54:17 INFO mapred.JobClient: FileSystemCounters
    12/07/20 12:54:17 INFO mapred.JobClient: HDFS_BYTES_READ=335
    12/07/20 12:54:17 INFO mapred.JobClient: FILE_BYTES_WRITTEN=30172
    12/07/20 12:54:17 INFO mapred.JobClient: File Input Format Counters
    12/07/20 12:54:17 INFO mapred.JobClient: Bytes Read=0
    12/07/20 12:54:17 INFO mapred.JobClient: Map-Reduce Framework
    12/07/20 12:54:17 INFO mapred.JobClient: Map input records=2
    12/07/20 12:54:17 INFO mapred.JobClient: Physical memory (bytes) snapshot=78696448
    12/07/20 12:54:17 INFO mapred.JobClient: Spilled Records=0
    12/07/20 12:54:17 INFO mapred.JobClient: CPU time spent (ms)=390
    12/07/20 12:54:17 INFO mapred.JobClient: Total committed heap usage (bytes)=56623104
    12/07/20 12:54:17 INFO mapred.JobClient: Virtual memory (bytes) snapshot=891781120
    12/07/20 12:54:17 INFO mapred.JobClient: Map output records=2
    12/07/20 12:54:17 INFO mapred.JobClient: SPLIT_RAW_BYTES=123
    12/07/20 12:54:17 INFO mapreduce.ExportJobBase: Transferred 335 bytes in 19.6631 seconds (17.037 bytes/sec)
    12/07/20 12:54:17 INFO mapreduce.ExportJobBase: Exported 2 records.


导出到mysql成功

    
    mysql> use toplists;
    Reading table information for completion of table and column names
    You can turn off this feature to get a quicker startup with -A



    
    Database changed
    mysql> select * from award;
    +-------------------------------+-----------+-----------+------+-----------+-----------+--------+------+-------------+-------+---------+
    | rowkey | productid | matchid | rank | tourneyid | userid | gameid | gold | loginid | nick | plat |
    +-------------------------------+-----------+-----------+------+-----------+-----------+--------+------+-------------+-------+---------+
    | 2012-04-27 06:55:00:402713629 | 5947 | 433203828 | 2 | 4027102 | 402713629 | 1001 | NULL | 715878221 | ???A | ios |
    | 2012-04-27 06:55:00:406788559 | 778 | 433203930 | 19 | 4017780 | 406788559 | 1001 | 1 | 13835155880 | ????? | android |
    +-------------------------------+-----------+-----------+------+-----------+-----------+--------+------+-------------+-------+---------+
    2 rows in set (0.00 sec)


虽然mysql中有了数据，不过，导入的却是乱码
在《[Hive导出到Mysql中中文乱码的问题](http://abloz.com/2012/07/20/hive-exported-to-the-chinese-garbled-in-mysql.html)》这篇文章中继续解决。
