---
author: abloz
comments: true
date: 2012-03-17 15:18:30+00:00
layout: post
link: http://abloz.com/index.php/2012/03/17/mysql-tuning-increasing-the-number-of-connections-to-solve-the-problem-of-insufficient-number-of-connections/
slug: mysql-tuning-increasing-the-number-of-connections-to-solve-the-problem-of-insufficient-number-of-connections
title: mysql 调优1,增加连接数，解决连接数不足问题
wordpress_id: 1512
categories:
- 技术
tags:
- max_connections
- tuning mysql
---

http://abloz.com
author:ablozhou
date:2012.3.16

mysql5 以上，缺省连接只有150+1个，很容易发生[Too many connections](http://dev.mysql.com/doc/refman/5.5/en/too-many-connections.html)。
可将其调大，在/etc/my.cnf文件的mysqld节后，增加
max_connections=32000

某些版本可能是
set-variable = max_connections=32000

保存后，执行service mysql restart
检查max_connections 是不是已经变成设定的值：
mysql -uroot -p variables
输入密码，可以看到max_connections变成新设的值。
或者mysql进入命令行，执行
show variables
