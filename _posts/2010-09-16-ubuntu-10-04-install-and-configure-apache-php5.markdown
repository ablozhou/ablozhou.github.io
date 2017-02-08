---
author: abloz
comments: true
date: 2010-09-16 16:30:02+00:00
layout: post
link: http://abloz.com/index.php/2010/09/17/ubuntu-10-04-install-and-configure-apache-php5/
slug: ubuntu-10-04-install-and-configure-apache-php5
title: ubuntu 10.04安装配置apache+php5
wordpress_id: 398
categories:
- 技术
tags:
- apache2
- http
- php5
- ubuntu
---

周海汉 2010.9.17 00：30
其实我是想配置测试php的。
但我的机器上什么http服务器没有，连php也没装。所以先用apt-get install php5
谁知自动给我装了一个apache2，并且启动了http服务。只是该http服务，并不支持php。

    
    
    zhouhh@zhhm:/etc/nginx$ sudo apt-get install php5
    正在读取软件包列表... 完成
    正在分析软件包的依赖关系树
    正在读取状态信息... 完成
    下列软件包是自动安装的并且现在不需要了：
      linux-headers-2.6.32-21 linux-headers-2.6.32-21-generic
    使用'apt-get autoremove'来删除它们
    将会安装下列额外的软件包：
      apache2-mpm-prefork apache2-utils apache2.2-bin apache2.2-common
      libapache2-mod-php5 libaprutil1-dbd-sqlite3 libaprutil1-ldap php5-common
    建议安装的软件包：
      apache2-doc apache2-suexec apache2-suexec-custom php-pear php5-suhosin
    下列【新】软件包将被安装：
      apache2-mpm-prefork apache2-utils apache2.2-bin apache2.2-common
      libapache2-mod-php5 libaprutil1-dbd-sqlite3 libaprutil1-ldap php5
      php5-common
    升级了 0 个软件包，新安装了 9 个软件包，要卸载 0 个软件包，有 6 个软件包未被升级。
    


做完后apache就自动起来了：

    
    
    root      2984     1  0 23:12 ?        00:00:00 /usr/sbin/apache2 -k start
    www-data  3118  2984  0 23:13 ?        00:00:00 /usr/sbin/apache2 -k start
    ...
    


此时访问http://localhost，已经可以看见It works!的页面。
发现apche配置文件放在
/etc/apache2里面，但httpd.conf是空的。实际读取的是apache2.conf，而http文件路径是在
sites-available/default里面，指向/var/www

    
    
    zhouhh@zhhm:/var/www$ ls
    index.html
    zhouhh@zhhm:/var/www$ sudo cat > index.php
    
    


用浏览器访问，php是直接下载的。

将php的配置拷贝到apache

    
    
    zhouhh@zhhm:/etc$sudo  cp -r php5/* apache2/
    zhouhh@zhhm:/etc$ sudo apache2 -k stop
    apache2: bad user name ${APACHE_RUN_USER}
    


原来是${APACHE_RUN_USER}变量没有设置。

    
    
    root@zhhm:/etc/apache2# vi apache2.conf
    


将User和Group直接设为：
User www-data
Group www-data
/etc/apache2/envvars中的上述变量已经设置。也可以通过
/etc/init.d/apache2 -k restart命令，此时会使用envvars设置的环境变量。

但我发现自己拷了错误的php的配置文件，删除：
root@zhhm:/etc/apache2# rm conf.d/pdo.ini
同时由于原来的apache已经启动，需要杀死。
root@zhhm:/etc/apache2# killall apache2
将php5模块加载到配置文件：

    
    
    
    root@zhhm:/etc/apache2# cat httpd.conf
    # Make sure there's only **1** line for each of these 2 directives:
    # Use for PHP 4.x:
    #LoadModule php4_module        modules/libphp4.so
    #AddHandler php-script   php
    
    # Use for PHP 5.x:
    LoadModule php5_module        modules/libphp5.so
    AddHandler php5-script php
    
    # Add index.php to your DirectoryIndex line:
    DirectoryIndex index.html index.php
    
    AddType text/html       php
    
    # PHP Syntax Coloring
    # (optional but useful for reading PHP source for debugging):
    AddType application/x-httpd-php-source phps
    
    root@zhhm:/etc/apache2# apache2 -k start
    [Thu Sep 16 23:58:30 2010] [warn] module php5_module is already loaded, skipping
    apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1 for ServerName
    



此时，访问http://localhost/index.php，已经可以正确显示phpinfo()函数结果了。
