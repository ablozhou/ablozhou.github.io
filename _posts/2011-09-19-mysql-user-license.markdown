---
author: abloz
comments: true
date: 2011-09-19 11:49:54+00:00
layout: post
link: http://abloz.com/index.php/2011/09/19/mysql-user-license/
slug: mysql-user-license
title: mysql 给用户授权
wordpress_id: 1436
categories:
- 技术
tags:
- mysql
- 授权
---

php报错：mysql error:No database selected
可是明明调用了mysql_select_db啊，怎么会有这个问题？并且在另一台机器就没有问题。

原来，在新部署的机器上，库表用root创建，但操作用另一个用户。所以一直没有权限。
应该检查mysql_select_db的返回值，并用Mysql_error()打印出来：
 error:Access denied for user 'myuser'@'192.168.132.%' to database 'feedback'

原来如此，赶紧授权：
mysql> grant all on feedback.* to 'myuser'@'*' identified by '1234';
Query OK, 0 rows affected (0.00 sec)

可是还是报拒绝访问的错误。原来，我的语法犯了个很容犯的错误。
容易犯错误的语法：
@'*'其实是@'%'
但mysql并不报错。
mysql> grant all on feedback.* to 'myuser'@'*' identified by '1234';
Query OK, 0 rows affected (0.00 sec)

这样就ok了。




