---
author: abloz
comments: true
date: 2012-07-19 07:49:11+00:00
layout: post
link: http://abloz.com/index.php/2012/07/19/data-between-the-mysql-and-hdfs-system-of-mutual-conductance-using-sqoop/
slug: data-between-the-mysql-and-hdfs-system-of-mutual-conductance-using-sqoop
title: 用sqoop进行mysql和hdfs系统间的数据互导
wordpress_id: 1761
categories:
- 技术
tags:
- hbase
- hdfs
- mysql
- sqoop
---

sqoop 是apache下用于RDBMS和HDFS互相导数据的工具。
本文档是sqoop的使用实例，实现从mysql到hdfs互导数据，以及从Mysql导数据到HBase。


## 下载：


http://www.apache.org/dyn/closer.cgi/sqoop/

[zhouhh@Hadoop48 ~]$ wget http://labs.renren.com/apache-mirror/sqoop/1.4.1-incubating/sqoop-1.4.1-incubating__hadoop-1.0.0.tar.gz

最新用户手册
http://sqoop.apache.org/docs/1.4.1-incubating/SqoopUserGuide.html




## 一、从HBase库中直接导出到mysql中？


一开始我想从HBase库中直接导出到mysql中。
在mysql中创建一个库和表

    
    
    mysql> create database toplists;
    Query OK, 1 row affected (0.06 sec)
    mysql> use toplists
    Database changed
    mysql> create table t1(id int not null primary key, name varchar(255),value int);
    Query OK, 0 rows affected (0.10 sec)
    
    hbase(main):011:0> scan 't1'
    ROW COLUMN+CELL
    1001 column=info:count, timestamp=1340265059531, value=724988
    1009 column=info:count, timestamp=1340265059533, value=108051
    ...
    total column=info:count, timestamp=1340265059534, value=833039
    total_user_count column=info:, timestamp=1340266656307, value=154516
    11 row(s) in 0.0420 seconds
    
    [zhouhh@Hadoop48 ~]$ sqoop list-tables --connect jdbc:mysql://localhost/toplists --username root
    java.lang.RuntimeException: Could not load db driver class: com.mysql.jdbc.Driver
    at org.apache.sqoop.manager.SqlManager.makeConnection(SqlManager.java:657)
    at org.apache.sqoop.manager.GenericJdbcManager.getConnection(GenericJdbcManager.java:52)
    at org.apache.sqoop.manager.SqlManager.execute(SqlManager.java:473)
    at org.apache.sqoop.manager.SqlManager.execute(SqlManager.java:496)
    at org.apache.sqoop.manager.SqlManager.getColumnTypesForRawQuery(SqlManager.java:194)
    at org.apache.sqoop.manager.SqlManager.getColumnTypes(SqlManager.java:178)
    at org.apache.sqoop.manager.ConnManager.getColumnTypes(ConnManager.java:114)
    at org.apache.sqoop.orm.ClassWriter.getColumnTypes(ClassWriter.java:1235)
    at org.apache.sqoop.orm.ClassWriter.generate(ClassWriter.java:1060)
    at org.apache.sqoop.tool.CodeGenTool.generateORM(CodeGenTool.java:82)
    at org.apache.sqoop.tool.ExportTool.exportTable(ExportTool.java:64)
    at org.apache.sqoop.tool.ExportTool.run(ExportTool.java:97)
    at org.apache.sqoop.Sqoop.run(Sqoop.java:145)
    at org.apache.hadoop.util.ToolRunner.run(ToolRunner.java:65)
    at org.apache.sqoop.Sqoop.runSqoop(Sqoop.java:181)
    at org.apache.sqoop.Sqoop.runTool(Sqoop.java:220)
    at org.apache.sqoop.Sqoop.runTool(Sqoop.java:229)
    at org.apache.sqoop.Sqoop.main(Sqoop.java:238)
    at com.cloudera.sqoop.Sqoop.main(Sqoop.java:57)
    


需下载 MySQL JDBC Connector 库，并将其复制到$SQOOP_HOME/lib
**下载mysql jdbc连接库**

地址：

    
    http://www.mysql.com/downloads/connector/j/



    
    
    [zhouhh@Hadoop48 ~]$ wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.21.tar.gz/from/http://cdn.mysql.com/
    [zhouhh@Hadoop48 mysql-connector-java-5.1.21]$ cp mysql-connector-java-5.1.21-bin.jar ../sqoop/lib/.
    [zhouhh@Hadoop48 ~]$ sqoop list-tables --connect jdbc:mysql://localhost/toplists --username root
    t1
    
    [zhouhh@Hadoop48 ~]$ sqoop-export --connect jdbc:mysql://localhost/toplists --username root --table t1 --export-dir /hbase
    
    java.io.IOException: com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure
    
    The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.
    at org.apache.sqoop.mapreduce.ExportOutputFormat.getRecordWriter(ExportOutputFormat.java:79)
    at org.apache.hadoop.mapred.MapTask$NewDirectOutputCollector.<init>(MapTask.java:628)
    at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:753)
    at org.apache.hadoop.mapred.MapTask.run(MapTask.java:370)
    at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
    at java.security.AccessController.doPrivileged(Native Method)
    at javax.security.auth.Subject.doAs(Subject.java:415)
    at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1121)
    at org.apache.hadoop.mapred.Child.main(Child.java:249)
    Caused by: com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure
    


这是可能由jdbc版本引起的，换成5.1.18

    
    
    [zhouhh@Hadoop48 ~]$ sqoop-export --connect jdbc:mysql://localhost:3306/toplists --username root --table t1 --export-dir /hbase
    
    Error initializing attempt_201206271529_0006_r_000000_0:
    org.apache.hadoop.util.DiskChecker$DiskErrorException: Could not find any valid local directory for ttprivate/taskTracker/zhouhh/jobcache/job_201206271529_0006/jobToken
    at org.apache.hadoop.fs.LocalDirAllocator$AllocatorPerContext.getLocalPathForWrite(LocalDirAllocator.java:381)
    at org.apache.hadoop.fs.LocalDirAllocator.getLocalPathForWrite(LocalDirAllocator.java:146)
    at org.apache.hadoop.fs.LocalDirAllocator.getLocalPathForWrite(LocalDirAllocator.java:127)
    at org.apache.hadoop.mapred.TaskTracker.localizeJobTokenFile(TaskTracker.java:4271)
    at org.apache.hadoop.mapred.TaskTracker.initializeJob(TaskTracker.java:1177)
    at org.apache.hadoop.mapred.TaskTracker.localizeJob(TaskTracker.java:1118)
    at org.apache.hadoop.mapred.TaskTracker$5.run(TaskTracker.java:2430)
    at java.lang.Thread.run(Thread.java:722)
    


DiskErrorException ，定位半天，发现是另一台机器的空间满了，在mapreduce运行时会引起该异常。

    
    [zhouhh@Hadoop46 ~]$ df
    Filesystem 1K-blocks Used Available Use% Mounted on
    /dev/sda3 28337624 26877184 0 100% /
    




    
    
    [zhouhh@Hadoop48 ~]$ sqoop-export --connect jdbc:mysql://192.168.10.48:3306/toplists --username root --table t1 --export-dir /hbase
    Caused by: java.sql.SQLException: null, message from server: "Host 'Hadoop47' is not allowed to connect to this MySQL server"
    


这是权限问题，设置授权：

    
    
    mysql> GRANT ALL PRIVILEGES ON *.* TO '%'@'%';#允许所有用户查看和修改databaseName数据库模式的内容，否则别的IP连不上本MYSQL
    Query OK, 0 rows affected (0.06 sec)
    


这是测试，所以权限没有限制。实际工作环境需谨慎授权。

    
    
    [zhouhh@Hadoop48 ~]$ sqoop-export --connect jdbc:mysql://192.168.10.48:3306/toplists --username root --table t1 --export-dir /hbase
    Note: /tmp/sqoop-zhouhh/compile/fa1d1c042030b0ec8537c7a4cd02aab3/t1.java uses or overrides a deprecated API.
    Note: Recompile with -Xlint:deprecation for details.
    java.lang.NumberFormatException: For input string: "7"
    at java.lang.NumberFormatException.forInputString(NumberFormatException.java:65)
    at java.lang.Integer.parseInt(Integer.java:481)
    at java.lang.Integer.valueOf(Integer.java:582)
    at t1.__loadFromFields(t1.java:218)
    at t1.parse(t1.java:170)
    at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:77)
    at org.apache.sqoop.mapreduce.TextExportMapper.map(TextExportMapper.java:36)
    at org.apache.hadoop.mapreduce.Mapper.run(Mapper.java:144)
    at org.apache.sqoop.mapreduce.AutoProgressMapper.run(AutoProgressMapper.java:183)
    at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:764)
    at org.apache.hadoop.mapred.MapTask.run(MapTask.java:370)
    at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
    at java.security.AccessController.doPrivileged(Native Method)
    at javax.security.auth.Subject.doAs(Subject.java:415)
    at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1121)
    at org.apache.hadoop.mapred.Child.main(Child.java:249)
    


这是由于/hbase是hbase的库表，根本不是可以导的格式，所以报错。

    
    
    [zhouhh@Hadoop48 ~]$ sqoop-export --connect jdbc:mysql://192.168.10.48:3306/toplists --username root --table t1 --export-dir /hbase/t1
    [zhouhh@Hadoop48 ~]$ sqoop-export --verbose --connect jdbc:mysql://192.168.10.48:3306/toplists --username root --table t1 --update-key id --input-fields-terminated-by 't' --export-dir /hbase/t1
    Note: /tmp/sqoop-zhouhh/compile/8ce6556eb13b3000550a9c864eaa6820/t1.java uses or overrides a deprecated API.
    Note: Recompile with -Xlint:deprecation for details.
    [zhouhh@Hadoop48 ~]$
    


但将导出目录指到/hbase/t1表中，导出不会报错，而mysql中没有数据。后面才了解到，sqoop没有直接从hbase中将表导出到mysql的办法。必须先将hbase导出成平面文件，或者导出到hive中，才可以用sqoop将数据导出到mysql。




## 二、从mysql中导到hdfs。


创建mysql表，将其导入到hdfs

    
    
    mysql> create table test(id int not null primary key auto_increment,name varchar(64) not null,price decimal(10,2), cdate date,version int,comment varchar(255));
    Query OK, 0 rows affected (0.10 sec)
    mysql> insert into test values(null,'iphone',3900.00,'2012-7-18',1,'8g');
    Query OK, 1 row affected (0.04 sec)
    mysql> insert into test values(null,'ipad',3200.00,'2012-7-16',2,'16g');
    Query OK, 1 row affected (0.00 sec)
    mysql> select * from test;
    +----+--------+---------+------------+---------+---------+
    | id | name | price | cdate | version | comment |
    +----+--------+---------+------------+---------+---------+
    | 1 | iphone | 3900.00 | 2012-07-18 | 1 | 8g |
    | 2 | ipad | 3200.00 | 2012-07-16 | 2 | 16g |
    +----+--------+---------+------------+---------+---------+
    2 rows in set (0.00 sec)
    


导入：

    
    
    [zhouhh@Hadoop48 ~]$ sqoop import --connect jdbc:mysql://Hadoop48/toplists --table test -m 1
    java.lang.RuntimeException: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Access denied for user ''@'Hadoop48' to database 'toplists'
    at org.apache.sqoop.manager.CatalogQueryManager.getColumnNames(CatalogQueryManager.java:162)
    


给空用户授权

    
    
    mysql> GRANT ALL PRIVILEGES ON *.* TO ''@'%';
    




    
    
    [zhouhh@Hadoop48 ~]$ sqoop import --connect jdbc:mysql://Hadoop48/toplists --username root --table test -m 1
    
    12/07/18 11:10:16 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
    12/07/18 11:10:16 INFO tool.CodeGenTool: Beginning code generation
    12/07/18 11:10:16 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `index_mapping` AS t LIMIT 1
    12/07/18 11:10:16 INFO orm.CompilationManager: HADOOP_HOME is /home/zhoulei/hadoop-1.0.0/libexec/..
    注: /tmp/sqoop-zhoulei/compile/2b04bdabb7043e4f75b215d72f65388e/index_mapping.java使用或覆盖了已过时的 API。
    注: 有关详细信息, 请使用 -Xlint:deprecation 重新编译。
    12/07/18 11:10:18 INFO orm.CompilationManager: Writing jar file: /tmp/sqoop-zhoulei/compile/2b04bdabb7043e4f75b215d72f65388e/index_mapping.jar
    12/07/18 11:10:18 WARN manager.MySQLManager: It looks like you are importing from mysql.
    12/07/18 11:10:18 WARN manager.MySQLManager: This transfer can be faster! Use the --direct
    12/07/18 11:10:18 WARN manager.MySQLManager: option to exercise a MySQL-specific fast path.
    12/07/18 11:10:18 INFO manager.MySQLManager: Setting zero DATETIME behavior to convertToNull (mysql)
    12/07/18 11:10:25 INFO mapreduce.ImportJobBase: Beginning import of index_mapping
    12/07/18 11:10:26 INFO mapred.JobClient: Running job: job_201207101344_0519
    12/07/18 11:10:27 INFO mapred.JobClient: map 0% reduce 0%
    12/07/18 11:10:40 INFO mapred.JobClient: map 100% reduce 0%
    12/07/18 11:10:45 INFO mapred.JobClient: Job complete: job_201207101344_0519
    12/07/18 11:10:45 INFO mapred.JobClient: Counters: 18
    12/07/18 11:10:45 INFO mapred.JobClient: Job Counters
    12/07/18 11:10:45 INFO mapred.JobClient: SLOTS_MILLIS_MAPS=12083
    12/07/18 11:10:45 INFO mapred.JobClient: Total time spent by all reduces waiting after reserving slots (ms)=0
    12/07/18 11:10:45 INFO mapred.JobClient: Total time spent by all maps waiting after reserving slots (ms)=0
    12/07/18 11:10:45 INFO mapred.JobClient: Launched map tasks=1
    12/07/18 11:10:45 INFO mapred.JobClient: SLOTS_MILLIS_REDUCES=0
    12/07/18 11:10:45 INFO mapred.JobClient: File Output Format Counters
    12/07/18 11:10:45 INFO mapred.JobClient: Bytes Written=28
    12/07/18 11:10:45 INFO mapred.JobClient: FileSystemCounters
    12/07/18 11:10:45 INFO mapred.JobClient: HDFS_BYTES_READ=87
    12/07/18 11:10:45 INFO mapred.JobClient: FILE_BYTES_WRITTEN=30396
    12/07/18 11:10:45 INFO mapred.JobClient: HDFS_BYTES_WRITTEN=28
    12/07/18 11:10:45 INFO mapred.JobClient: File Input Format Counters
    12/07/18 11:10:45 INFO mapred.JobClient: Bytes Read=0
    12/07/18 11:10:45 INFO mapred.JobClient: Map-Reduce Framework
    12/07/18 11:10:45 INFO mapred.JobClient: Map input records=2
    12/07/18 11:10:45 INFO mapred.JobClient: Physical memory (bytes) snapshot=79167488
    12/07/18 11:10:45 INFO mapred.JobClient: Spilled Records=0
    12/07/18 11:10:45 INFO mapred.JobClient: CPU time spent (ms)=340
    12/07/18 11:10:45 INFO mapred.JobClient: Total committed heap usage (bytes)=56623104
    12/07/18 11:10:45 INFO mapred.JobClient: Virtual memory (bytes) snapshot=955785216
    12/07/18 11:10:45 INFO mapred.JobClient: Map output records=2
    12/07/18 11:10:45 INFO mapred.JobClient: SPLIT_RAW_BYTES=87
    12/07/18 11:10:45 INFO mapreduce.ImportJobBase: Transferred 28 bytes in 20.2612 seconds (1.382 bytes/sec)
    12/07/18 11:10:45 INFO mapreduce.ImportJobBase: Retrieved 2 records.
    


检查数据是否导入


    
    
    [zhouhh@Hadoop48 ~]$ fs -cat /user/zhouhh/test/part-m-00000
    1,iphone,3900.00,2012-07-18,1,8g
    2,ipad,3200.00,2012-07-16,2,16g
    


或

    
    
    [zhouhh@Hadoop48 ~]$ fs -cat test/part-m-00000
    1,iphone,3900.00,2012-07-18,1,8g
    2,ipad,3200.00,2012-07-16,2,16g
    





## 三、从hdfs导出到mysql


清空表

    
    
    mysql> delete from test;
    Query OK, 2 rows affected (0.00 sec)
    
    mysql> select * from test;
    Empty set (0.00 sec)
    


导出

    
    
    [zhouhh@Hadoop48 ~]$ sqoop-export --connect jdbc:mysql://192.168.10.48:3306/toplists --username root --table test --export-dir test
    Note: /tmp/sqoop-zhouhh/compile/7adaaa7ffe5f49ed9d794b1be8a9a983/test.java uses or overrides a deprecated API.
    Note: Recompile with -Xlint:deprecation for details.
    


导出时，--connect,--table, --export-dir是必须设置的。其中toplists是库名，--table是该库下的表名。 --export-dir是要导出的HDFS平面文件位置。如果不是绝对路径，指/user/username/datadir

检查mysql表

    
    
    mysql> select * from test;
    +----+--------+---------+------------+---------+---------+
    | id | name | price | cdate | version | comment |
    +----+--------+---------+------------+---------+---------+
    | 1 | iphone | 3900.00 | 2012-07-18 | 1 | 8g |
    | 2 | ipad | 3200.00 | 2012-07-16 | 2 | 16g |
    +----+--------+---------+------------+---------+---------+
    2 rows in set (0.00 sec)
    


可见导出成功。




## 四、不执行mapreduce，但生成导入代码



    
    
    [zhouhh@Hadoop48 ~]$ sqoop codegen --connect jdbc:mysql://192.168.10.48:3306/toplists --username root --table test --class-name Mycodegen
    Note: /tmp/sqoop-zhouhh/compile/104b871487669b89dcd5b9b2c61f905f/Mycodegen.java uses or overrides a deprecated API.
    Note: Recompile with -Xlint:deprecation for details.
    
    [zhouhh@Hadoop48 ~]$ sqoop help codegen
    usage: sqoop codegen [GENERIC-ARGS] [TOOL-ARGS]
    


sqoop导入时，可以加选择语句，以过滤和综合多表，用--query.也可以只加条件，用--where。这样可以不必每次导入整张表。 如 --where 'id > 1000'
示例，采用join选择多表数据：
sqoop import --query 'select a.*,b.* from a join b on (a.id == b.id) where $conditions' -m 1 --target-dir /usr/foo/joinresults




## 五、将mysql表导入到HBase


虽然目前，sqoop没有将HBase直接导入mysql的办法，但将mysql直接导入HBase是可以的。需指定--hbase-table，用--hbase-create-table来自动在HBase中创建表。--column-family指定列族名。--hbase-row-key指定rowkey对应的mysql的键。
[zhouhh@Hadoop48 ~]$ sqoop import --connect jdbc:mysql://Hadoop48/toplists --table test --hbase-table a --column-family name --hbase-row-key id --hbase-create-table --username 'root'

检查hbase被导入的表：

    
    
    hbase(main):002:0> scan 'a'
    ROW COLUMN+CELL
    1 column=name:cdate, timestamp=1342601695952, value=2012-07-18
    1 column=name:comment, timestamp=1342601695952, value=8g
    1 column=name:name, timestamp=1342601695952, value=iphone
    1 column=name:price, timestamp=1342601695952, value=3900.00
    1 column=name:version, timestamp=1342601695952, value=1
    2 column=name:cdate, timestamp=1342601695952, value=2012-07-16
    2 column=name:comment, timestamp=1342601695952, value=16g
    2 column=name:name, timestamp=1342601695952, value=ipad
    2 column=name:price, timestamp=1342601695952, value=3200.00
    2 column=name:version, timestamp=1342601695952, value=2
    2 row(s) in 0.2370 seconds
    


关于导入的一致性：建议停止mysql表的写入再导入到HDFS或HIVE，否则，mapreduce可能会丢失新增的数据。
关于效率：mysql直接模式(--direct)导入的方式效率高。但不支持大对象数据，类型为CLOB或BLOB的列。用JDBC效率较低，但有专用API可以支持CLOB及BLOB。


## 六、从HBase导出数据到Mysql


目前没有直接的导出命令。但有两个方法可以将HBase数据导出到mysql。

其一，将HBase导出成HDFS平面文件，再导出到mysql.
其二，将HBase数据导出到HIVE，再导出到mysql，参见后续文章《[从hive将数据导出到mysql](http://abloz.com/2012/07/20/export-data-to-mysql-from-the-hive.html)》


