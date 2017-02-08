---
author: abloz
comments: true
date: 2011-09-22 03:20:44+00:00
layout: post
link: http://abloz.com/index.php/2011/09/22/chinese-garbled-mysql-query-problem/
slug: chinese-garbled-mysql-query-problem
title: mysql 查询中文乱码的问题
wordpress_id: 1440
categories:
- 技术
tags:
- mysql
- php
- 乱码
---

昨天遇到一个很奇怪的问题。
mysql 里面所有字符编码设置都是utf8

    
    
    mysql> SHOW VARIABLES LIKE 'character_%';
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
    8 rows in set (0.01 sec)
    
    


php 里面缺省编码和文件header都是utf8，提交输入的入库的中文和在网页中的中文都能正确显示，但是用pietty(putty)连接到mysql服务员，用mysql客户端查询，显示中文却是乱码。无论设set names utf8,还是怎么试，都看不到查询的内容的中文，操作系统的locale也是utf8，pietty配置也是utf8，中文文件和内容都能正确显示。
所以我不敢断定数据库所存储的内容到底是不是utf8. 如果不是，为何utf8页面的html又能正确显示呢？如果是，怎么转码都得不到正确的结果。确认入库的不是utf8，也不是任何gbk，gb2312，gb18030.

经过仔细研究，发现原来我在php入库时加了htmlspecialchars进行编码。而由于nginx缺省编码是gbk，所以实际是utf8编码以htmlspecialchars再编码，以gbk保存，这样无论如何都看不到中文字符。

解决办法：

mysql连接后，加入一句：
mysql_query('set names utf8',$this->conn);
这样，在mysql后台用select语句就能查看到正确的中文文本，php同样可以正确显示中文。

