---
author: abloz
comments: true
date: 2010-09-28 02:28:27+00:00
layout: post
link: http://abloz.com/index.php/2010/09/28/will-be-joined-since-the-launch-of-php5-fcgi/
slug: will-be-joined-since-the-launch-of-php5-fcgi
title: 将php5-fcgi加入自启动
wordpress_id: 440
categories:
- 技术
tags:
- fastcgi
- nginx
- php
---

周海汉
2010.9.28

在个人开发中，php fastcgi可以手工启动。但服务器中必须自启动。
编写脚本，将其放到init.d中。


    
    
    zhouhh@zhh64:~$ cat /etc/init.d/php-fastcgi
    #!/bin/bash
    
    #php-fastcgi
    #zhouhh
    #2010.9.28
    
    case "$1" in
    	start)
    		spawn-fcgi -a 127.0.0.1 -p 9000 -u www-data -g www-data -f /usr/bin/php5-cgi
    	;;
    	stop)
    		killall -9 php5-cgi
    	;;
    	restart)
    		killall -9 php5-cgi
    		spawn-fcgi -a 127.0.0.1 -p 9000 -u www-data -g www-data -f /usr/bin/php5-cgi
    	;;
    
    esac
    



或者用start-stop-daemon.
下面的脚本参考http://tomasz.sterna.tv/2009/04/php-fastcgi-with-nginx-on-ubuntu/
fastcgi的两个参数PHP_FCGI_CHILDREN，  PHP_FCGI_MAX_REQUESTS，前者表示启动多少子进程，后者表示每个进程处理的最大请求。这是fastcgi的两个重要参数。

    
    
    #!/bin/bash
    BIND=127.0.0.1:9000
    USER=www-data
    PHP_FCGI_CHILDREN=15
    PHP_FCGI_MAX_REQUESTS=1000
    
    PHP_CGI=/usr/bin/php-cgi
    PHP_CGI_NAME=`basename $PHP_CGI`
    PHP_CGI_ARGS="- USER=$USER PATH=/usr/bin PHP_FCGI_CHILDREN=$PHP_FCGI_CHILDREN PHP_FCGI_MAX_REQUESTS=$PHP_FCGI_MAX_REQUESTS $PHP_CGI -b $BIND"
    RETVAL=0
    
    start() {
          echo -n "Starting PHP FastCGI: "
          start-stop-daemon --quiet --start --background --chuid "$USER" --exec /usr/bin/env -- $PHP_CGI_ARGS
          RETVAL=$?
          echo "$PHP_CGI_NAME."
    }
    stop() {
          echo -n "Stopping PHP FastCGI: "
          killall -q -w -u $USER $PHP_CGI
          RETVAL=$?
          echo "$PHP_CGI_NAME."
    }
    
    case "$1" in
        start)
          start
      ;;
        stop)
          stop
      ;;
        restart)
          stop
          start
      ;;
        *)
          echo "Usage: php-fastcgi {start|stop|restart}"
          exit 1
      ;;
    esac
    exit $RETVAL
    
    



将这两个脚本之一存为php-fastcgi. 修改为可执行权限， 然后加入自启动：

    
    
    update-rc.d php-fastcgi default
    



这样系统重启后，依然可以通过nginx提供php的web服务。
