---
author: abloz
comments: true
date: 2010-09-06 03:02:49+00:00
layout: post
link: http://abloz.com/index.php/2010/09/06/centos5-2-take-the-php-site-problems/
slug: centos5-2-take-the-php-site-problems
title: centos5.2搭php站点遇到的问题
wordpress_id: 388
categories:
- 技术
---

操作系统缺省安装，手工选择了一些组件，可能有组件没装全。apache重启，测试http打开。

1.web显示空白页
log显示没有DB.php，其实是没有安装php-pear-DB.noarch
yum install php-pear-DB.noarch

pear组件不是操作系统光盘自带的。因此即使全部安装，这一组件也必须用yum安装。

2.web页面显示：ems db: extension not found
phpinfo()发现/etc/php.d/没有mysql.ini等。
php-mysql-i386 没有安装

yum install php-mysql-i386
3.查看php信息
<?php
phpinfo();
?>

4.查看http log
vi /var/log/httpd/error_log,access_log

5.页面显示

DB Error: connect failed。

这时可以写一个测试页面：

    
    
    getMessage());
    }
    echo "ok";
    ?>
    
