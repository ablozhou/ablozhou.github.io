---
author: abloz
comments: true
date: 2010-09-27 08:38:20+00:00
layout: post
link: http://abloz.com/index.php/2010/09/27/ubuntu-under-nginx-php-fastcgi-installation-and-configuration/
slug: ubuntu-under-nginx-php-fastcgi-installation-and-configuration
title: ubuntu下Nginx+php(fastcgi)安装配置
wordpress_id: 429
categories:
- 技术
tags:
- nginx
- php
---

周海汉 2010.9.27
http://abloz.com/2010/09/27/ubuntu-under-nginx-php-fastc.html

都说nginx比apache效率高很多，所以在ubuntu 10.04的本机配置一个nginx+php。


## **安装配置nginx**


`sudo apt-get install nginx`

启动nginx

sudo service nginx restart

启动完了测试一下。
在浏览器中输入http://localhost,显示
Welcome to nginx!
web服务器配置成功。


## **安装php5**


sudo apt-get install php5

光有php5还不行，因为nginx只支持fast-cgi模式。所以必须装fast-cgi


## **安装fast-cgi**


root@zhh64:/etc/nginx# apt-get install php5-cgi

执行：
root@zhh64:/etc/nginx# php5-cgi -b 127.0.0.1:9000

也可以再安装spawn-fcgi
zhouhh@zhh64:~$  sudo apt-get install spawn-fcgi
spawn-fcgi是fastcgi的管理程序，从Lighthttpd独立出来的项目。实际运营中可以使用php-fpm(php的fastcgi php manager). php 5.3.3中自带php-fpm,但我现在的版本是php 5.3.2.

采用spawn-fcgi执行：
zhouhh@zhh64:~$ spawn-fcgi -a 127.0.0.1 -p 9000 -u www-data -g www-data -f /usr/bin/php5-cgi
spawn-fcgi: child spawned successfully: PID: 9700


## 测试php


修改nginx配置文件：

cd /etc/nginx
root@zhh64:/etc/nginx# vi sites-available/default

    
    server {
    	listen   80 default;
    	server_name  localhost;
    
    	access_log  /var/log/nginx/localhost.access.log;
    
    	location / {
    		root   /var/www/nginx-default;
            #增加index.php
    		index  index.php index.html index.htm;
    	}
    
    	location /doc {
    		root   /usr/share;
    		autoindex on;
    		allow 127.0.0.1;
    		deny all;
    	}
    
    	location /images {
    		root   /usr/share;
    		autoindex on;
    	}
    	#去掉注释
    	location ~ .php$ {
    		fastcgi_pass   127.0.0.1:9000;
    		fastcgi_index  index.php;
    		fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    		include fastcgi_params;
    	}
    
    }


重启nginx
编写php测试程序。

root@zhh64:~# cat /var/www/nginx-default/index.php

    
    <?php
    echo "hello world";
    phpinfo();
    ?>




## **排错：**


在浏览器中输入http://localhost/index.php
显示：
No input file specified.

log里显示没有找到文件。
后面发现是default文件里location ~ .php$段的fastcgi_param必须修改。
如下：

    
    	location ~ .php$ {
    		fastcgi_pass   127.0.0.1:9000;
    		fastcgi_index  index.php;
    		fastcgi_param  SCRIPT_FILENAME  /var/www/nginx-default/$fastcgi_script_name;
    		include /etc/nginx/fastcgi_params;
    	}


即$fastcgi_script_name必须放到web根目录下。也可以用变量$document_root
fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;

重启nginx，再浏览http://localhost/,打印出hello world和php info信息。
