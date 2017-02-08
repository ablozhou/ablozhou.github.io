---
author: abloz
comments: true
date: 2012-11-25 09:30:06+00:00
layout: post
link: http://abloz.com/index.php/2012/11/25/mysql-5-5-utf8-configuration-method/
slug: mysql-5-5-utf8-configuration-method
title: mysql 5.5 utf8 配置方法
wordpress_id: 1993
categories:
- 技术
tags:
- mysql
- ubuntu
- utf8
---

周海汉 (http://abloz.com)
2012.11.25

ubuntu 12.04所带的mysql 5.5，在/etc/mysql/my.cnf的[mysqld]中添加default-character-set=utf8 以支持utf8会导致msql无法启动。
在my.cnf的[mysqld]中添加 log_error = /var/log/mysql/error.log
重启后可以看到如下错误：
root@ubuntu:~# service mysql start

start: Job failed to start
root@ubuntu:~#
root@ubuntu:~# cat /var/log/mysql/error.log
121125 17:07:38 [Note] Plugin 'FEDERATED' is disabled.
121125 17:07:38 InnoDB: The InnoDB memory heap is disabled
121125 17:07:38 InnoDB: Mutexes and rw_locks use GCC atomic builtins
121125 17:07:38 InnoDB: Compressed tables use zlib 1.2.3.4
121125 17:07:38 InnoDB: Initializing buffer pool, size = 128.0M
121125 17:07:38 InnoDB: Completed initialization of buffer pool
121125 17:07:38 InnoDB: highest supported file format is Barracuda.
121125 17:07:39 InnoDB: Waiting for the background threads to start
121125 17:07:40 InnoDB: 1.1.8 started; log sequence number 2054581
121125 17:07:40 [ERROR] /usr/sbin/mysqld: unknown variable 'default-character-set=utf8'
121125 17:07:40 [ERROR] Aborting

121125 17:07:40 InnoDB: Starting shutdown...
121125 17:07:40 InnoDB: Shutdown completed; log sequence number 2054581
121125 17:07:40 [Note] /usr/sbin/mysqld: Shutdown complete

原来mysql 5.5不再支持default-character-set=utf8，而是改为支持character-set-server=utf8
最后，将my.cnf中utf8支持改为如下内容，启动成功：
[client]
default-character-set=utf8
[mysqld]
init_connect='SET collation_connection = utf8_unicode_ci'
init_connect='SET NAMES utf8'
character-set-server=utf8
collation-server=utf8_unicode_ci
skip-character-set-client-handshake

**参考：**
bug报告和诊断：https://bugs.launchpad.net/ubuntu/+source/mysql-5.5/+bug/1081675
utf8配置参考：http://www.onaxer.com/tag/change-mysql-default-character-set-to-utf8-in-mysql-5-5/
