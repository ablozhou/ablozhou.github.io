---
author: abloz
comments: true
date: 2012-07-20 06:51:10+00:00
layout: post
link: http://abloz.com/index.php/2012/07/20/hive-exported-to-the-chinese-garbled-in-mysql/
slug: hive-exported-to-the-chinese-garbled-in-mysql
title: Hive导出到Mysql中中文乱码的问题
wordpress_id: 1770
categories:
- 技术
tags:
- hbase
- hive
- mysql
- utf8
- 乱码
---

http://abloz.com

author:周海汉

2012.7.20

在上一篇文章《[从hive将数据导出到mysql](http://abloz.com/2012/07/20/export-data-to-mysql-from-the-hive.html)》中，虽然通过hive中转，将hbase的数据成功导出到了mysql中，但是我们遇到了中文乱码问题。




## 一、mysql中的编码




    
    mysql> show variables like 'collation_%';
    +----------------------+-------------------+
    | Variable_name | Value |
    +----------------------+-------------------+
    | collation_connection | latin1_swedish_ci |
    | collation_database | latin1_swedish_ci |
    | collation_server | latin1_swedish_ci |
    +----------------------+-------------------+
    3 rows in set (0.00 sec)
    mysql> show variables like 'character_set_%';
    +--------------------------+----------------------------+
    
    | Variable_name | Value |
    +--------------------------+----------------------------+
    | character_set_client | latin1 |
    | character_set_connection | latin1 |
    | character_set_database | latin1 |
    | character_set_filesystem | binary |
    | character_set_results | latin1 |
    | character_set_server | latin1 |
    | character_set_system | utf8 |
    | character_sets_dir | /usr/share/mysql/charsets/ |
    +--------------------------+----------------------------+
    8 rows in set (0.00 sec)


可见原来缺省是latin1编码，会导致中文乱码。

可以在mysql中设置编码，单个设置
mysql> alter database name character set utf8;
mysql> set character_set_connection=utf8;

Query OK, 0 rows affected (0.00 sec)
mysql> set character_set_connection=utf8;
Query OK, 0 rows affected (0.00 sec)
mysql> set character_set_results=utf8;
Query OK, 0 rows affected (0.00 sec)
mysql> set character_set_server=utf8;
Query OK, 0 rows affected (0.00 sec)
但重启后会失效。



可以修改配置文件：

    
    [root@Hadoop48 ~]# vi /etc/my.cnf
    [mysql]
    default-character-set=utf8
    [client]
    default-character-set=utf8
    [mysqld]
    default-character-set=utf8
    character_set_server=utf8
    init_connect='SET NAMES utf8'


重启mysql，这样确保缺省编码是utf8

    
    [root@Hadoop48 ~]# service mysqld restart


查看是否变成utf8：

    
    mysql> s
    --------------
    mysql Ver 14.12 Distrib 5.0.95, for redhat-linux-gnu (x86_64) using readline 5.1
    
    Connection id: 2
    Current database: toplists
    Current user: root@localhost
    SSL: Not in use
    Current pager: stdout
    Using outfile: ''
    Using delimiter: ;
    Server version: 5.0.95 Source distribution
    Protocol version: 10
    Connection: Localhost via UNIX socket
    Server characterset: utf8
    Db characterset: utf8
    Client characterset: utf8
    Conn. characterset: utf8
    UNIX socket: /var/lib/mysql/mysql.sock
    Uptime: 39 sec
    
    Threads: 1 Questions: 12 Slow queries: 0 Opens: 15 Flush tables: 1 Open tables: 9 Queries per second avg: 0.308
    --------------
    
    mysql> show variables like "char%";
    +--------------------------+----------------------------+
    | Variable_name | Value |
    +--------------------------+----------------------------+
    | character_set_client | utf8 |
    | character_set_connection | utf8 |
    | character_set_database | utf8 |
    | character_set_filesystem | binary |
    | character_set_results | utf8 |
    | character_set_server | utf8 |
    | character_set_system | utf8 |
    | character_sets_dir | /usr/share/mysql/charsets/ |
    +--------------------------+----------------------------+
    8 rows in set (0.00 sec)
    
    mysql> show variables like "colla%";
    +----------------------+-----------------+
    | Variable_name | Value |
    +----------------------+-----------------+
    | collation_connection | utf8_general_ci |
    | collation_database | utf8_general_ci |
    | collation_server | utf8_general_ci |
    +----------------------+-----------------+
    3 rows in set (0.00 sec)


将mysql编码改成utf8，并在命令行中指定编码为utf8，执行导出报错：

    
    [zhouhh@Hadoop46 ~]$ sqoop export --connect "jdbc:mysql://Hadoop48/toplists?useUnicode=true&characterEncoding=utf-8" -m 1 --table award --export-dir /user/hive/warehouse/hive_myaward/000000_0 --input-null-string "\\N" --input-null-non-string "\\N" --input-fields-terminated-by "\01" --input-lines-terminated-by "\n"
    
    12/07/20 13:17:22 INFO mapred.JobClient: Task Id : attempt_201207191159_0233_m_000000_0, Status : FAILED
    java.io.IOException: java.sql.SQLException: Incorrect string value: 'xE6x9Dx80xE7xA0xB4...' for column 'nick' at row 1




原来我创建的表缺省编码不是utf8的，也需改变一下。

    
    mysql> ALTER TABLE award CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;
    Query OK, 0 rows affected (0.00 sec)
    Records: 0 Duplicates: 0 Warnings: 0


再导出

    
    [zhouhh@Hadoop46 ~]$ sqoop export --connect "jdbc:mysql://Hadoop48/toplists?useUnicode=true&characterEncoding=utf-8" -m 1 --table award --export-dir /user/hive/warehouse/hive_myaward/000000_0 --input-null-string "\\N" --input-null-non-string "\\N" --input-fields-terminated-by "\01" --input-lines-terminated-by "\n"
    ...
    12/07/20 14:03:10 INFO mapred.JobClient: map 0% reduce 0%
    12/07/20 14:03:24 INFO mapred.JobClient: map 100% reduce 0%
    ...
    12/07/20 14:03:29 INFO mapreduce.ExportJobBase: Exported 2 record



    
    检查表
    mysql> select * from award;
    +-------------------------------+-----------+-----------+------+-----------+-----------+--------+------+-------------+-----------------+---------+
    | rowkey | productid | matchid | rank | tourneyid | userid | gameid | gold | loginid | nick | plat |
    +-------------------------------+-----------+-----------+------+-----------+-----------+--------+------+-------------+-----------------+---------+
    | 2012-04-27 06:55:00:402713629 | 5947 | 433203828 | 2 | 4027102 | 402713629 | 1001 | NULL | 715878221 | 杀破天A | ios |
    | 2012-04-27 06:55:00:406788559 | 778 | 433203930 | 19 | 4017780 | 406788559 | 1001 | 1 | 13835155880 | 亲牛牛旦旦 | android |
    +-------------------------------+-----------+-----------+------+-----------+-----------+--------+------+-------------+-----------------+---------+
    2 rows in set (0.00 sec)




中文编码问题解决。
