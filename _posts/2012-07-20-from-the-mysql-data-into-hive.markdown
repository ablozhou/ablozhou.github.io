---
author: abloz
comments: true
date: 2012-07-20 08:10:17+00:00
layout: post
link: http://abloz.com/index.php/2012/07/20/from-the-mysql-data-into-hive/
slug: from-the-mysql-data-into-hive
title: 从mysql将数据导入hive
wordpress_id: 1779
categories:
- 技术
tags:
- hive
- import
- mysql
---

http://abloz.com
author:周海汉
date:2012.7.20
下面是从mysql将数据导入hive的实例。
--hive-import 表示导入到hive，--create-hive-table表示创建hive表。--hive-table指定hive的表名。


    
    [zhouhh@Hadoop46 ~]$ sqoop import --connect jdbc:mysql://Hadoop48/toplists --verbose -m 1 --username root --hive-overwrite --direct --table award --hive-import --create-hive-table --hive-table mysql_award --fields-terminated-by 't' --lines-terminated-by 'n' --append
    
    12/07/20 16:02:23 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
    12/07/20 16:02:23 INFO tool.CodeGenTool: Beginning code generation
    12/07/20 16:02:23 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `award` AS t LIMIT 1
    12/07/20 16:02:24 INFO orm.CompilationManager: HADOOP_HOME is /home/zhouhh/hadoop-1.0.0/libexec/..
    注: /tmp/sqoop-zhouhh/compile/2fe3efbc94924ad6391b948ef8f8254f/award.java使用或覆盖了已过时的 API。
    注: 有关详细信息, 请使用 -Xlint:deprecation 重新编译。
    12/07/20 16:02:25 ERROR orm.CompilationManager: Could not rename /tmp/sqoop-zhouhh/compile/2fe3efbc94924ad6391b948ef8f8254f/award.java to /home/zhouhh/./award.java
    12/07/20 16:02:25 INFO orm.CompilationManager: Writing jar file: /tmp/sqoop-zhouhh/compile/2fe3efbc94924ad6391b948ef8f8254f/award.jar
    12/07/20 16:02:25 INFO manager.DirectMySQLManager: Beginning mysqldump fast path import
    12/07/20 16:02:25 INFO mapreduce.ImportJobBase: Beginning import of award
    12/07/20 16:02:27 INFO mapred.JobClient: Running job: job_201207191159_0322
    12/07/20 16:02:28 INFO mapred.JobClient:  map 0% reduce 0%
    12/07/20 16:02:41 INFO mapred.JobClient:  map 100% reduce 0%
    12/07/20 16:02:46 INFO mapred.JobClient: Job complete: job_201207191159_0322
    12/07/20 16:02:46 INFO mapred.JobClient: Counters: 18
    12/07/20 16:02:46 INFO mapred.JobClient:   Job Counters
    12/07/20 16:02:46 INFO mapred.JobClient:     SLOTS_MILLIS_MAPS=12849
    12/07/20 16:02:46 INFO mapred.JobClient:     Total time spent by all reduces waiting after reserving slots (ms)=0
    12/07/20 16:02:46 INFO mapred.JobClient:     Total time spent by all maps waiting after reserving slots (ms)=0
    12/07/20 16:02:46 INFO mapred.JobClient:     Launched map tasks=1
    12/07/20 16:02:46 INFO mapred.JobClient:     SLOTS_MILLIS_REDUCES=0
    12/07/20 16:02:46 INFO mapred.JobClient:   File Output Format Counters
    12/07/20 16:02:46 INFO mapred.JobClient:     Bytes Written=208
    12/07/20 16:02:46 INFO mapred.JobClient:   FileSystemCounters
    12/07/20 16:02:46 INFO mapred.JobClient:     HDFS_BYTES_READ=87
    12/07/20 16:02:46 INFO mapred.JobClient:     FILE_BYTES_WRITTEN=30543
    12/07/20 16:02:46 INFO mapred.JobClient:     HDFS_BYTES_WRITTEN=208
    12/07/20 16:02:46 INFO mapred.JobClient:   File Input Format Counters
    12/07/20 16:02:46 INFO mapred.JobClient:     Bytes Read=0
    12/07/20 16:02:46 INFO mapred.JobClient:   Map-Reduce Framework
    12/07/20 16:02:46 INFO mapred.JobClient:     Map input records=1
    12/07/20 16:02:46 INFO mapred.JobClient:     Physical memory (bytes) snapshot=78295040
    12/07/20 16:02:46 INFO mapred.JobClient:     Spilled Records=0
    12/07/20 16:02:46 INFO mapred.JobClient:     CPU time spent (ms)=440
    12/07/20 16:02:46 INFO mapred.JobClient:     Total committed heap usage (bytes)=56623104
    12/07/20 16:02:46 INFO mapred.JobClient:     Virtual memory (bytes) snapshot=901132288
    12/07/20 16:02:46 INFO mapred.JobClient:     Map output records=44
    12/07/20 16:02:46 INFO mapred.JobClient:     SPLIT_RAW_BYTES=87
    12/07/20 16:02:46 INFO mapreduce.ImportJobBase: Transferred 208 bytes in 20.349 seconds (10.2216 bytes/sec)
    12/07/20 16:02:46 INFO mapreduce.ImportJobBase: Retrieved 44 records.
    12/07/20 16:02:46 INFO util.AppendUtils: Creating missing output directory - award
    12/07/20 16:02:46 INFO hive.HiveImport: Removing temporary files from import process: award/_logs
    12/07/20 16:02:46 INFO hive.HiveImport: Loading uploaded data into Hive
    12/07/20 16:02:46 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `award` AS t LIMIT 1
    12/07/20 16:02:48 INFO hive.HiveImport: WARNING: org.apache.hadoop.metrics.jvm.EventCounter is deprecated. Please use org.apache.hadoop.log.metrics.EventCounter in all the log4j.properties files.
    12/07/20 16:02:48 INFO hive.HiveImport: Logging initialized using configuration in jar:file:/home/zhouhh/hive-0.8.1/lib/hive-common-0.8.1.jar!/hive-log4j.properties
    12/07/20 16:02:48 INFO hive.HiveImport: Hive history file=/home/zhouhh/hive-0.8.1/logs/hive_job_log_zhouhh_201207201602_1448253330.txt
    12/07/20 16:02:53 INFO hive.HiveImport: OK
    12/07/20 16:02:53 INFO hive.HiveImport: Time taken: 4.322 seconds
    12/07/20 16:02:53 INFO hive.HiveImport: Loading data to table default.mysql_award
    12/07/20 16:02:53 INFO hive.HiveImport: Deleted hdfs://Hadoop46:9200/user/hive/warehouse/mysql_award
    12/07/20 16:02:53 INFO hive.HiveImport: OK
    12/07/20 16:02:53 INFO hive.HiveImport: Time taken: 0.28 seconds
    12/07/20 16:02:53 INFO hive.HiveImport: Hive import complete.
    


到hive中查询，已经成功导入数据

    
    
    hive> select * from mysql_award;
    OK
    2012-04-27 06:55:00:402713629   5947    433203828       2       4027102 402713629       1001    NULL    715878221 杀破天A ios
    2012-04-27 06:55:00:406788559   778     433203930       19      4017780 406788559       1001    1       13835155880       亲牛牛旦旦      android
    Time taken: 0.368 seconds
    hive>


由于基于utf8，所以没有遇到乱码问题。
