---
author: abloz
comments: true
date: 2009-06-04 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/06/04/windows-install-discuz-forum/
slug: windows-install-discuz-forum
title: windows下安装discuz论坛
wordpress_id: 913
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文

 

下载了

apache_2.2.11-win32-x86-openssl-0.9.8i.msi

Discuz_7.0.0_FULL_SC_UTF8.zip

ZendStudioEnterpriseEdition-v5.5.0.270.rar

php-5.2.9-2-Win32.zip

mysql-5.0.22-win32.zip

安装完毕

配置好apache的httpd.conf

执行[http://localhost](http://localhost/)

 

1.php 不解析，下载或直接显示源文件，需要安装php5

配置httpd.conf  
LoadModule php5_module "d:/php52/php5apache2_2.dll"  
AddType application/x-httpd-php .php

 

2.php检测不到mysql问题

  
运行环境检测失败  
服务器不支持 MySql 数据库，无法安装论坛程序

您必须解决以上问题，安装才可以继续

 

直接运行mysql -uroot -p

可以登录，所以mysql没有问题。

 

php.ini-dist 复制为php.ini  
extension_dir = "d:/php52/ext"

 

extension=php_gd2.dll

extension=php_mbstring.dll

extension=php_mysql.dll

配置[mysql]和[mysqli]里面的mysql账号  
重启apache

需要配置PHPRC变量为d:/php52

重启操作系统

解决该问题。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=882c29e6-916f-88a7-8e84-c61f93f79fda)
