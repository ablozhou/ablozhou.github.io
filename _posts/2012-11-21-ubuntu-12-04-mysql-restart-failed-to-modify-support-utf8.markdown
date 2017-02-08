---
author: abloz
comments: true
date: 2012-11-21 15:59:45+00:00
layout: post
link: http://abloz.com/index.php/2012/11/21/ubuntu-12-04-mysql-restart-failed-to-modify-support-utf8/
slug: ubuntu-12-04-mysql-restart-failed-to-modify-support-utf8
title: ubuntu 12.04 mysql 修改支持utf8 重启失败
wordpress_id: 1979
categories:
- 技术
tags:
- mysql
- ubuntu
---

周海汉
2012.11.21

ubuntu 12.04 mysql 修改支持utf8 重启失败，无log。
root@zhh:/var/log# service mysql start
start: Job failed to start

只要在/etc/mysql/my.conf的[mysqld]段下添加default-character-set=utf8,启动就失败，去掉启动就成功。

找到一篇遇到同样问题的文章：http://www.linuxidc.com/Linux/2012-06/63362.htm
用他的方法启动成功。

修改/etc/mysql/my.conf的[client]和[mysqld]段
修改如下的部分：
root@zhh:/etc/mysql# vi my.cnf
[client]
default-character-set=utf8
[mysqld]
init_connect='SET collation_connection = utf8_unicode_ci'
init_connect='SET NAMES utf8'
character-set-server=utf8
collation-server=utf8_unicode_ci
skip-character-set-client-handshake

重启：

root@zhh:/etc/mysql# service mysql start
mysql start/running, process 5427

进入mysql

zhouhh@zhh:~$ mysql -uroot
Welcome to the MySQL monitor.  Commands end with ; or g.
Your MySQL connection id is 37
Server version: 5.5.24-0ubuntu0.12.04.1-log (Ubuntu)

Copyright (c) 2000, 2011, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

mysql> show variables like "char%"
    -> ;
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
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
8 rows in set (0.00 sec)

mysql> show variables like "colla%"
    -> ;
+----------------------+-----------------+
| Variable_name        | Value           |
+----------------------+-----------------+
| collation_connection | utf8_unicode_ci |
| collation_database   | utf8_unicode_ci |
| collation_server     | utf8_unicode_ci |
+----------------------+-----------------+
3 rows in set (0.00 sec)

已经缺省支持utf8

