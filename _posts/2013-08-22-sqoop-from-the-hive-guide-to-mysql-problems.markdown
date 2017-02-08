---
author: abloz
comments: true
date: 2013-08-22 11:44:34+00:00
layout: post
link: http://abloz.com/index.php/2013/08/22/sqoop-from-the-hive-guide-to-mysql-problems/
slug: sqoop-from-the-hive-guide-to-mysql-problems
title: sqoop 从 hive 导到mysql遇到的问题
wordpress_id: 2207
categories:
- 技术
tags:
- hive
- mysql
- sqoop
---

周海汉/文 2013.8.22










## 环境




hive 版本hive-0.11.0




sqoop 版本 sqoop-1.4.4.bin__hadoop-1.0.0







从hive导到mysql







mysql 表：






mysql> desc cps_activation;

+------------+-------------+------+-----+---------+----------------+
| Field | Type | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+----------------+
| id | int(11) | NO | PRI | NULL | auto_increment |
| day | date | NO | MUL | NULL | |
| pkgname | varchar(50) | YES | | NULL | |
| cid | varchar(50) | YES | | NULL | |
| pid | varchar(50) | YES | | NULL | |
| activation | int(11) | YES | | NULL | |
+------------+-------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)



hive表

hive> desc active;
OK
id int None
day string None
pkgname string None
cid string None
pid string None
activation int None






## 测试链接成功




[hadoop@hs11 ~]sqoop list-databases --connect jdbc:mysql://localhost:3306/ --username root --password admin
Warning: /usr/lib/hcatalog does not exist! HCatalog jobs will fail.
Please set $HCAT_HOME to the root of your HCatalog installation.
13/08/20 16:42:26 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
13/08/20 16:42:26 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
information_schema
easyhadoop
mysql
test
[hadoop@hs11 ~]$ sqoop list-databases --connect jdbc:mysql://localhost:3306/test --username root --password admin
Warning: /usr/lib/hcatalog does not exist! HCatalog jobs will fail.
Please set $HCAT_HOME to the root of your HCatalog installation.
13/08/20 16:42:40 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
13/08/20 16:42:40 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
information_schema
easyhadoop
mysql
test
[hadoop@hs11 ~]$ sqoop list-tables --connect jdbc:mysql://localhost:3306/test --username root --password admin
Warning: /usr/lib/hcatalog does not exist! HCatalog jobs will fail.
Please set $HCAT_HOME to the root of your HCatalog installation.
13/08/20 16:42:54 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
13/08/20 16:42:54 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
active





[hadoop@hs11 ~]$  sqoop create-hive-table --connect jdbc:mysql://localhost:3306/test --table active --username root --password admin --hive-table test
Warning: /usr/lib/hcatalog does not exist! HCatalog jobs will fail.
Please set $HCAT_HOME to the root of your HCatalog installation.
13/08/20 16:57:04 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
13/08/20 16:57:04 INFO tool.BaseSqoopTool: Using Hive-specific delimiters for output. You can override
13/08/20 16:57:04 INFO tool.BaseSqoopTool: delimiters with --fields-terminated-by, etc.
13/08/20 16:57:04 WARN tool.BaseSqoopTool: It seems that you've specified at least one of following:
13/08/20 16:57:04 WARN tool.BaseSqoopTool:      --hive-home
13/08/20 16:57:04 WARN tool.BaseSqoopTool:      --hive-overwrite
13/08/20 16:57:04 WARN tool.BaseSqoopTool:      --create-hive-table
13/08/20 16:57:04 WARN tool.BaseSqoopTool:      --hive-table
13/08/20 16:57:04 WARN tool.BaseSqoopTool:      --hive-partition-key
13/08/20 16:57:04 WARN tool.BaseSqoopTool:      --hive-partition-value
13/08/20 16:57:04 WARN tool.BaseSqoopTool:      --map-column-hive
13/08/20 16:57:04 WARN tool.BaseSqoopTool: Without specifying parameter --hive-import. Please note that
13/08/20 16:57:04 WARN tool.BaseSqoopTool: those arguments will not be used in this session. Either
13/08/20 16:57:04 WARN tool.BaseSqoopTool: specify --hive-import to apply them correctly or remove them
13/08/20 16:57:04 WARN tool.BaseSqoopTool: from command line to remove this warning.
13/08/20 16:57:04 INFO tool.BaseSqoopTool: Please note that --hive-home, --hive-partition-key,
13/08/20 16:57:04 INFO tool.BaseSqoopTool:       hive-partition-value and --map-column-hive options are
13/08/20 16:57:04 INFO tool.BaseSqoopTool:       are also valid for HCatalog imports and exports
13/08/20 16:57:04 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
13/08/20 16:57:05 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `active` AS t LIMIT 1
13/08/20 16:57:05 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `active` AS t LIMIT 1
13/08/20 16:57:05 WARN hive.TableDefWriter: Column day had to be cast to a less precise type in Hive
13/08/20 16:57:05 INFO hive.HiveImport: Loading uploaded data into Hive










## 1、拒绝连接


[hadoop@hs11 ~]$ sqoop export --connect jdbc:mysql://localhost/test --username root  --password admin --table test --export-dir /user/hive/warehouse/actmp
Warning: /usr/lib/hcatalog does not exist! HCatalog jobs will fail.
Please set $HCAT_HOME to the root of your HCatalog installation.
13/08/21 09:14:07 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
13/08/21 09:14:07 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
13/08/21 09:14:07 INFO tool.CodeGenTool: Beginning code generation
13/08/21 09:14:07 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `test` AS t LIMIT 1
13/08/21 09:14:07 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `test` AS t LIMIT 1
13/08/21 09:14:07 INFO orm.CompilationManager: HADOOP_MAPRED_HOME is /home/hadoop/hadoop-1.1.2
Note: /tmp/sqoop-hadoop/compile/0b5cae714a00b3940fb793c3694408ac/test.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
13/08/21 09:14:08 INFO orm.CompilationManager: Writing jar file: /tmp/sqoop-hadoop/compile/0b5cae714a00b3940fb793c3694408ac/test.jar
13/08/21 09:14:08 INFO mapreduce.ExportJobBase: Beginning export of test
13/08/21 09:14:09 INFO input.FileInputFormat: Total input paths to process : 1
13/08/21 09:14:09 INFO input.FileInputFormat: Total input paths to process : 1
13/08/21 09:14:09 INFO util.NativeCodeLoader: Loaded the native-hadoop library
13/08/21 09:14:09 WARN snappy.LoadSnappy: Snappy native library not loaded
13/08/21 09:14:10 INFO mapred.JobClient: Running job: job_201307251523_0059
13/08/21 09:14:11 INFO mapred.JobClient:  map 0% reduce 0%
13/08/21 09:14:20 INFO mapred.JobClient: Task Id : attempt_201307251523_0059_m_000000_0, Status : FAILED
java.io.IOException: com.mysql.jdbc.CommunicationsException: Communications link failure due to underlying exception:

** BEGIN NESTED EXCEPTION **

java.net.ConnectException
MESSAGE: Connection refused

STACKTRACE:

java.net.ConnectException: Connection refused
at java.net.PlainSocketImpl.socketConnect(Native Method)
at java.net.PlainSocketImpl.doConnect(PlainSocketImpl.java:351)
at java.net.PlainSocketImpl.connectToAddress(PlainSocketImpl.java:213)
at java.net.PlainSocketImpl.connect(PlainSocketImpl.java:200)
at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:366)
at java.net.Socket.connect(Socket.java:529)
at java.net.Socket.connect(Socket.java:478)
at java.net.Socket.<init>(Socket.java:375)
at java.net.Socket.<init>(Socket.java:218)
at com.mysql.jdbc.StandardSocketFactory.connect(StandardSocketFactory.java:256)
at com.mysql.jdbc.MysqlIO.<init>(MysqlIO.java:271)
at com.mysql.jdbc.Connection.createNewIO(Connection.java:2771)
at com.mysql.jdbc.Connection.<init>(Connection.java:1555)
at com.mysql.jdbc.NonRegisteringDriver.connect(NonRegisteringDriver.java:285)
at java.sql.DriverManager.getConnection(DriverManager.java:582)
at java.sql.DriverManager.getConnection(DriverManager.java:185)
at org.apache.sqoop.mapreduce.db.DBConfiguration.getConnection(DBConfiguration.java:294)
at org.apache.sqoop.mapreduce.AsyncSqlRecordWriter.<init>(AsyncSqlRecordWriter.java:76)
at org.apache.sqoop.mapreduce.ExportOutputFormat$ExportRecordWriter.<init>(ExportOutputFormat.java:95)
at org.apache.sqoop.mapreduce.ExportOutputFormat.getRecordWriter(ExportOutputFormat.java:77)
at org.apache.hadoop.mapred.MapTask$NewDirectOutputCollector.<init>(MapTask.java:628)
at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:753)
at org.apache.hadoop.mapred.MapTask.run(MapTask.java:370)
at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
at java.security.AccessController.doPrivileged(Native Method)
at javax.security.auth.Subject.doAs(Subject.java:396)
at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1149)
at org.apache.hadoop.mapred.Child.main(Child.java:249)


** END NESTED EXCEPTION **



Last packet sent to the server was 1 ms ago.
at org.apache.sqoop.mapreduce.ExportOutputFormat.getRecordWriter(ExportOutputFormat.java:79)
at org.apache.hadoop.mapred.MapTask$NewDirectOutputCollector.<init>(MapTask.java:628)
at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:753)
at org.apache.hadoop.mapred.MapTask.run(MapTask.java:370)
at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
at java.security.AccessController.doPrivileged(Native Method)
at javax.security.auth.Subject.doAs(Subject.java:396)
at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1149)
at org.apache.hadoop.mapred.Child.main(Child.java:249)
Caused by: com.mysql.jdbc.CommunicationsException: Communications link failure due to underlying exception:

** BEGIN NESTED EXCEPTION **

java.net.ConnectException
MESSAGE: Connection refused







mysql 用户权限问题







 mysql> show grants;




mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY PASSWORD '*4ACFE3202A5FF5CF467898FC58AAB1D615029441' WITH GRANT OPTION;
mysql> FLUSH PRIVILEGES;
mysql> create table test (mkey varchar(30),pkg varchar(50),cid varchar(20),pid varchar(50),count int,primary key(mkey,pkg,cid,pid) );




alter ignore table cps_activation add unique index_day_pkgname_cid_pid (`day`,`pkgname`,`cid`,`pid`);
Query OK, 0 rows affected (0.03 sec)







## 2. 表不存在







===========




[hadoop@hs11 ~]$ sqoop export --connect jdbc:mysql://10.10.20.11/test --username root  --password admin --table test --export-dir /user/hive/warehouse/actmp
Warning: /usr/lib/hcatalog does not exist! HCatalog jobs will fail.
Please set $HCAT_HOME to the root of your HCatalog installation.
13/08/21 09:16:26 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
13/08/21 09:16:26 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
13/08/21 09:16:26 INFO tool.CodeGenTool: Beginning code generation
13/08/21 09:16:27 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `test` AS t LIMIT 1
13/08/21 09:16:27 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `test` AS t LIMIT 1
13/08/21 09:16:27 INFO orm.CompilationManager: HADOOP_MAPRED_HOME is /home/hadoop/hadoop-1.1.2
Note: /tmp/sqoop-hadoop/compile/74d18a91ec141f2feb777dc698bf7eb4/test.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
13/08/21 09:16:28 INFO orm.CompilationManager: Writing jar file: /tmp/sqoop-hadoop/compile/74d18a91ec141f2feb777dc698bf7eb4/test.jar
13/08/21 09:16:28 INFO mapreduce.ExportJobBase: Beginning export of test
13/08/21 09:16:29 INFO input.FileInputFormat: Total input paths to process : 1
13/08/21 09:16:29 INFO input.FileInputFormat: Total input paths to process : 1
13/08/21 09:16:29 INFO util.NativeCodeLoader: Loaded the native-hadoop library
13/08/21 09:16:29 WARN snappy.LoadSnappy: Snappy native library not loaded
13/08/21 09:16:29 INFO mapred.JobClient: Running job: job_201307251523_0060
13/08/21 09:16:30 INFO mapred.JobClient:  map 0% reduce 0%
13/08/21 09:16:38 INFO mapred.JobClient: Task Id : attempt_201307251523_0060_m_000000_0, Status : FAILED
java.io.IOException: Can't export data, please check task tracker logs
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:112)
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:39)
at org.apache.hadoop.mapreduce.Mapper.run(Mapper.java:144)
at org.apache.sqoop.mapreduce.AutoProgressMapper.run(AutoProgressMapper.java:64)
at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:764)
at org.apache.hadoop.mapred.MapTask.run(MapTask.java:370)
at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
at java.security.AccessController.doPrivileged(Native Method)
at javax.security.auth.Subject.doAs(Subject.java:396)
at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1149)
at org.apache.hadoop.mapred.Child.main(Child.java:249)
Caused by: java.util.NoSuchElementException
at java.util.AbstractList$Itr.next(AbstractList.java:350)
at test.__loadFromFields(test.java:252)
at test.parse(test.java:201)
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:83)
... 10 more







导出数据到MySQL，当然数据库表要先存在，否则会报错




此错误的原因为sqoop解析文件的字段与MySql数据库的表的字段对应不上造成的。因此需要在执行的时候给sqoop增加参数，告诉sqoop文件的分隔符，使它能够正确的解析文件字段。hive默认的字段分隔符为'\01'




===========







## 3. null字段填充符需指定




没有指定null字段分隔符，导致错位。




[hadoop@hs11 ~]$ sqoop export --connect jdbc:mysql://10.10.20.11/test --username root  --password admin --table test --export-dir /user/hive/warehouse/actmp --input-fields-tminated-by '\01'
Warning: /usr/lib/hcatalog does not exist! HCatalog jobs will fail.
Please set $HCAT_HOME to the root of your HCatalog installation.
13/08/21 09:21:07 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
13/08/21 09:21:07 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
13/08/21 09:21:07 INFO tool.CodeGenTool: Beginning code generation
13/08/21 09:21:07 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `test` AS t LIMIT 1
13/08/21 09:21:07 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `test` AS t LIMIT 1
13/08/21 09:21:07 INFO orm.CompilationManager: HADOOP_MAPRED_HOME is /home/hadoop/hadoop-1.1.2
Note: /tmp/sqoop-hadoop/compile/04d183c9e534cdb8d735e1bdc4be3deb/test.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
13/08/21 09:21:08 INFO orm.CompilationManager: Writing jar file: /tmp/sqoop-hadoop/compile/04d183c9e534cdb8d735e1bdc4be3deb/test.jar
13/08/21 09:21:08 INFO mapreduce.ExportJobBase: Beginning export of test
13/08/21 09:21:09 INFO input.FileInputFormat: Total input paths to process : 1
13/08/21 09:21:09 INFO input.FileInputFormat: Total input paths to process : 1
13/08/21 09:21:09 INFO util.NativeCodeLoader: Loaded the native-hadoop library
13/08/21 09:21:09 WARN snappy.LoadSnappy: Snappy native library not loaded
13/08/21 09:21:10 INFO mapred.JobClient: Running job: job_201307251523_0061
13/08/21 09:21:11 INFO mapred.JobClient:  map 0% reduce 0%
13/08/21 09:21:17 INFO mapred.JobClient:  map 25% reduce 0%
13/08/21 09:21:19 INFO mapred.JobClient:  map 50% reduce 0%
13/08/21 09:21:21 INFO mapred.JobClient: Task Id : attempt_201307251523_0061_m_000001_0, Status : FAILED
java.io.IOException: Can't export data, please check task tracker logs
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:112)
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:39)
at org.apache.hadoop.mapreduce.Mapper.run(Mapper.java:144)
at org.apache.sqoop.mapreduce.AutoProgressMapper.run(AutoProgressMapper.java:64)
at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:764)
at org.apache.hadoop.mapred.MapTask.run(MapTask.java:370)
at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
at java.security.AccessController.doPrivileged(Native Method)
at javax.security.auth.Subject.doAs(Subject.java:396)
at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1149)
at org.apache.hadoop.mapred.Child.main(Child.java:249)
Caused by: java.lang.NumberFormatException: For input string: "665A5FFA-32C9-9463-1943-840A5FEAE193"
at java.lang.NumberFormatException.forInputString(NumberFormatException.java:48)
at java.lang.Integer.parseInt(Integer.java:458)
at java.lang.Integer.valueOf(Integer.java:554)
at test.__loadFromFields(test.java:264)
at test.parse(test.java:201)
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:83)
... 10 more




===========







## 4.成功




[hadoop@hs11 ~]$ sqoop export --connect jdbc:mysql://10.10.20.11/test --username root  --password admin --table test --export-dir /user/hive/warehouse/actmp --input-fields-terminated-by '\01' --input-null-string '\N' --input-null-non-string '\N'
Warning: /usr/lib/hcatalog does not exist! HCatalog jobs will fail.
Please set $HCAT_HOME to the root of your HCatalog installation.
13/08/21 09:36:13 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
13/08/21 09:36:13 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
13/08/21 09:36:13 INFO tool.CodeGenTool: Beginning code generation
13/08/21 09:36:13 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `test` AS t LIMIT 1
13/08/21 09:36:13 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `test` AS t LIMIT 1
13/08/21 09:36:13 INFO orm.CompilationManager: HADOOP_MAPRED_HOME is /home/hadoop/hadoop-1.1.2
Note: /tmp/sqoop-hadoop/compile/e22d31391498b790d799897cde25047d/test.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
13/08/21 09:36:14 INFO orm.CompilationManager: Writing jar file: /tmp/sqoop-hadoop/compile/e22d31391498b790d799897cde25047d/test.jar
13/08/21 09:36:14 INFO mapreduce.ExportJobBase: Beginning export of test
13/08/21 09:36:15 INFO input.FileInputFormat: Total input paths to process : 1
13/08/21 09:36:15 INFO input.FileInputFormat: Total input paths to process : 1
13/08/21 09:36:15 INFO util.NativeCodeLoader: Loaded the native-hadoop library
13/08/21 09:36:15 WARN snappy.LoadSnappy: Snappy native library not loaded
13/08/21 09:36:16 INFO mapred.JobClient: Running job: job_201307251523_0064
13/08/21 09:36:17 INFO mapred.JobClient:  map 0% reduce 0%
13/08/21 09:36:23 INFO mapred.JobClient:  map 25% reduce 0%
13/08/21 09:36:25 INFO mapred.JobClient:  map 100% reduce 0%
13/08/21 09:36:27 INFO mapred.JobClient: Job complete: job_201307251523_0064
13/08/21 09:36:27 INFO mapred.JobClient: Counters: 18
13/08/21 09:36:27 INFO mapred.JobClient:   Job Counters
13/08/21 09:36:27 INFO mapred.JobClient:     SLOTS_MILLIS_MAPS=13151
13/08/21 09:36:27 INFO mapred.JobClient:     Total time spent by all reduces waiting after reserving slots (ms)=0
13/08/21 09:36:27 INFO mapred.JobClient:     Total time spent by all maps waiting after reserving slots (ms)=0
13/08/21 09:36:27 INFO mapred.JobClient:     Rack-local map tasks=2
13/08/21 09:36:27 INFO mapred.JobClient:     Launched map tasks=4
13/08/21 09:36:27 INFO mapred.JobClient:     SLOTS_MILLIS_REDUCES=0
13/08/21 09:36:27 INFO mapred.JobClient:   File Output Format Counters
13/08/21 09:36:27 INFO mapred.JobClient:     Bytes Written=0
13/08/21 09:36:27 INFO mapred.JobClient:   FileSystemCounters
13/08/21 09:36:27 INFO mapred.JobClient:     HDFS_BYTES_READ=1519
13/08/21 09:36:27 INFO mapred.JobClient:     FILE_BYTES_WRITTEN=234149
13/08/21 09:36:27 INFO mapred.JobClient:   File Input Format Counters
13/08/21 09:36:27 INFO mapred.JobClient:     Bytes Read=0
13/08/21 09:36:27 INFO mapred.JobClient:   Map-Reduce Framework
13/08/21 09:36:27 INFO mapred.JobClient:     Map input records=6
13/08/21 09:36:27 INFO mapred.JobClient:     Physical memory (bytes) snapshot=663863296
13/08/21 09:36:27 INFO mapred.JobClient:     Spilled Records=0
13/08/21 09:36:27 INFO mapred.JobClient:     CPU time spent (ms)=3720
13/08/21 09:36:27 INFO mapred.JobClient:     Total committed heap usage (bytes)=2013790208
13/08/21 09:36:27 INFO mapred.JobClient:     Virtual memory (bytes) snapshot=5583151104
13/08/21 09:36:27 INFO mapred.JobClient:     Map output records=6
13/08/21 09:36:27 INFO mapred.JobClient:     SPLIT_RAW_BYTES=571
13/08/21 09:36:27 INFO mapreduce.ExportJobBase: Transferred 1.4834 KB in 12.1574 seconds (124.9446 bytes/sec)
13/08/21 09:36:27 INFO mapreduce.ExportJobBase: Exported 6 records.







----------







## 5. mysql字符串长度定义太短，存不下




java.io.IOException: com.mysql.jdbc.MysqlDataTruncation: Data truncation: Data too long for column 'pid' at row 1
at org.apache.sqoop.mapreduce.AsyncSqlRecordWriter.close(AsyncSqlRecordWriter.java:192)
at org.apache.hadoop.mapred.MapTask$NewDirectOutputCollector.close(MapTask.java:651)
at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:766)
at org.apache.hadoop.mapred.MapTask.run(MapTask.java:370)
at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
at java.security.AccessController.doPrivileged(Native Method)
at javax.security.auth.Subject.doAs(Subject.java:396)
at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1149)
at org.apache.hadoop.mapred.Child.main(Child.java:249)
Caused by: com.mysql.jdbc.MysqlDataTruncation: Data truncation: Data too long for column 'pid' at row 1
at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:2983)
at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:1631)
at com.mysql.jdbc.MysqlIO.sqlQueryDirect(MysqlIO.java:1723)
at com.mysql.jdbc.Connection.execSQL(Connection.java:3283)
at com.mysql.jdbc.PreparedStatement.executeInternal(PreparedStatement.java:1332)
at com.mysql.jdbc.PreparedStatement.execute(PreparedStatement.java:882)
at org.apache.sqoop.mapreduce.AsyncSqlOutputFormat$AsyncSqlExecThread.run(AsyncSqlOutputFormat.java:233)







----------------------




## 6.日期格式问题




mysql date日期格式，hive中字符串必须是yyyy-mm-dd, 我原来使用yyyymmdd,报下面的错误。







13/08/21 17:42:44 INFO mapred.JobClient: Task Id : attempt_201307251523_0079_m_000000_1, Status : FAILED
java.io.IOException: Can't export data, please check task tracker logs
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:112)
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:39)
at org.apache.hadoop.mapreduce.Mapper.run(Mapper.java:144)
at org.apache.sqoop.mapreduce.AutoProgressMapper.run(AutoProgressMapper.java:64)
at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:764)
at org.apache.hadoop.mapred.MapTask.run(MapTask.java:370)
at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
at java.security.AccessController.doPrivileged(Native Method)
at javax.security.auth.Subject.doAs(Subject.java:396)
at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1149)
at org.apache.hadoop.mapred.Child.main(Child.java:249)
Caused by: java.lang.IllegalArgumentException
at java.sql.Date.valueOf(Date.java:138)
at cps_activation.__loadFromFields(cps_activation.java:308)
at cps_activation.parse(cps_activation.java:255)
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:83)
... 10 more







----------------------




## 7. 字段对不上或字段类型不一致




Caused by: java.lang.NumberFormatException: For input string: "06701A4A-0808-E9A8-0D28-A8020B494E37"
at java.lang.NumberFormatException.forInputString(NumberFormatException.java:48)
at java.lang.Integer.parseInt(Integer.java:458)
at java.lang.Integer.valueOf(Integer.java:554)
at test.__loadFromFields(test.java:264)
at test.parse(test.java:201)
at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:83)
... 10 more






