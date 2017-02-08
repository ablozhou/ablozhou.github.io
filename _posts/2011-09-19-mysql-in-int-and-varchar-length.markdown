---
author: abloz
comments: true
date: 2011-09-19 06:32:05+00:00
layout: post
link: http://abloz.com/index.php/2011/09/19/mysql-in-int-and-varchar-length/
slug: mysql-in-int-and-varchar-length
title: mysql 中int和varchar的长度
wordpress_id: 1431
categories:
- 技术
tags:
- mysql
- 数据类型
- 长度
---

周海汉
abloz.com
2011.9.19
mysql 字段中int后面所跟数字有何意义？ varchar后的数字又有何意义？


    
    mysql> create table t(a int(1));
    Query OK, 0 rows affected (0.10 sec)
    mysql> insert into t values(123);
    Query OK, 1 row affected (0.02 sec)
    
    mysql> insert into t values(12345678);
    Query OK, 1 row affected (0.03 sec)
    
    mysql> select * from t;
    +----------+
    | a        |
    +----------+
    |      123 |
    | 12345678 |
    +----------+
    
    


可见，int(1)并不表示一个字节。
如果更长的数字会不会报错？

    
    
    mysql> insert into t values(1234567812345678);
    ERROR 1264 (22003): Out of range value for column 'a' at row 1
    mysql> insert into t values(2147483648);
    ERROR 1264 (22003): Out of range value for column 'a' at row 1
    mysql> insert into t values(2147483647);
    Query OK, 1 row affected (0.03 sec)
    


int 型长度最大值是2^31 -1 ，加上有符号数，应该是四个字节的长度。

    
    
    mysql> alter table t add column b int;
    Query OK, 5 rows affected (0.25 sec)
    mysql> insert into t values(2147483647,2147483648);
    ERROR 1264 (22003): Out of range value for column 'b' at row 1
    mysql> insert into t values(2147483647,2147483647);
    Query OK, 1 row affected (0.03 sec)
    
    mysql> select * from t;
    +------------+------------+
    | a          | b          |
    +------------+------------+
    |        123 |       NULL |
    |   12345678 |       NULL |
    |      65536 |       NULL |
    | 1073741824 |       NULL |
    | 2147483647 |       NULL |
    | 2147483647 | 2147483647 |
    +------------+------------+
    6 rows in set (0.00 sec)
    


可见，int后是否跟数字与最大值没有关系。

再看char 和varchar后的数字

    
    
    mysql> alter table t add column c char(2);
    Query OK, 6 rows affected (0.17 sec)
    Records: 6  Duplicates: 0  Warnings: 0
    
    mysql> alter table t add column d varchar(2);
    Query OK, 6 rows affected (0.17 sec)
    Records: 6  Duplicates: 0  Warnings: 0
    
    mysql> desc t;
    +-------+------------+------+-----+---------+-------+
    | Field | Type       | Null | Key | Default | Extra |
    +-------+------------+------+-----+---------+-------+
    | a     | int(1)     | YES  |     | NULL    |       |
    | b     | int(11)    | YES  |     | NULL    |       |
    | c     | char(2)    | YES  |     | NULL    |       |
    | d     | varchar(2) | YES  |     | NULL    |       |
    +-------+------------+------+-----+---------+-------+
    4 rows in set (0.01 sec)
    
    mysql> insert into t values(2147483647,2147483647,'abc','abc');
    ERROR 1406 (22001): Data too long for column 'c' at row 1
    mysql> insert into t values(2147483647,2147483647,'ab','abc');
    ERROR 1406 (22001): Data too long for column 'd' at row 1
    mysql> insert into t values(2147483647,2147483647,'ab','ab');
    Query OK, 1 row affected (0.02 sec)
    


可见char和varchar后的数字是存储长度。
那么对于中文字，会不会有字节数大于字数而溢出的问题呢？

    
    
    mysql> insert into t values(2147483647,2147483647,'ab','中化');
    Query OK, 1 row affected (0.02 sec)
    
    mysql> select * from t;
    +------------+------------+------+------+
    | a          | b          | c    | d    |
    +------------+------------+------+------+
    |        123 |       NULL | NULL | NULL |
    |   12345678 |       NULL | NULL | NULL |
    |      65536 |       NULL | NULL | NULL |
    | 1073741824 |       NULL | NULL | NULL |
    | 2147483647 |       NULL | NULL | NULL |
    | 2147483647 | 2147483647 | NULL | NULL |
    | 2147483647 | 2147483647 | ab   | ab   |
    | 2147483647 | 2147483647 | ab   | 中化 |
    +------------+------------+------+------+
    8 rows in set (0.00 sec)
    


中文字也是包含在2个字内的。

    
    
    mysql> insert into t values(2147483647,2147483647,'ab','中化a');
    ERROR 1406 (22001): Data too long for column 'd' at row 1
    mysql> insert into t values(2147483647,2147483647,'ab','烎镕');
    Query OK, 1 row affected (0.05 sec)
    
    mysql> select * from t;
    +------------+------------+------+------+
    | a          | b          | c    | d    |
    +------------+------------+------+------+
    |        123 |       NULL | NULL | NULL |
    |   12345678 |       NULL | NULL | NULL |
    |      65536 |       NULL | NULL | NULL |
    | 1073741824 |       NULL | NULL | NULL |
    | 2147483647 |       NULL | NULL | NULL |
    | 2147483647 | 2147483647 | NULL | NULL |
    | 2147483647 | 2147483647 | ab   | ab   |
    | 2147483647 | 2147483647 | ab   | 中化 |
    | 2147483647 | 2147483647 | ab   | 烎镕 |
    +------------+------------+------+------+
    9 rows in set (0.01 sec)
    


多一个字节都不行。
看一下字符编码。mysql字符编码由服务器，数据库，表，字段四级组成。
在windows下的mysql设置：

    
    
    mysql> show variables like "character%";
    +--------------------------+--------------------------+
    | Variable_name            | Value                    |
    +--------------------------+--------------------------+
    | character_set_client     | gbk                      |
    | character_set_connection | gbk                      |
    | character_set_database   | utf8                     |
    | character_set_filesystem | binary                   |
    | character_set_results    | gbk                      |
    | character_set_server     | utf8                     |
    | character_set_system     | utf8                     |
    | character_sets_dir       | D:mysqlsharecharsets |
    +--------------------------+--------------------------+
    8 rows in set (0.00 sec)
    mysql> show create table t;
     t     | CREATE TABLE `t` (
     `a` int(1) DEFAULT NULL,
     `b` int(11) DEFAULT NULL,
     `c` char(2) DEFAULT NULL,
     `d` varchar(2) DEFAULT NULL
     ENGINE=InnoDB DEFAULT CHARSET=utf8
    



linux下centos设置：

    
    
    mysql> show variables like "character%";
    +--------------------------+----------------------------+
    | Variable_name            | Value                      |
    +--------------------------+----------------------------+
    | character_set_client     | utf8                       |
    | character_set_connection | utf8                       |
    | character_set_database   | utf8                       |
    | character_set_filesystem | binary                     |
    | character_set_results    | utf8                       |
    | character_set_server     | utf8                       |
    | character_set_system     | utf8                       |
    | character_sets_dir       | /opt/mysql/share/charsets/ |
    +--------------------------+----------------------------+
    8 rows in set (0.00 sec)
    mysql> show full fields from t;
    mysql> show create database test;
    CREATE DATABASE `test` /*!40100 DEFAULT CHARACTER SET utf8 */
    


字符编码是utf8，
因此，对于utf8中文字符，varchar后面的数字，无论是中文还是英文，都表示相应的字数，不用担心截断。
