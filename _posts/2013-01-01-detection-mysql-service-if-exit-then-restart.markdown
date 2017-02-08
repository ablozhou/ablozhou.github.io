---
author: abloz
comments: true
date: 2013-01-01 02:20:39+00:00
layout: post
link: http://abloz.com/index.php/2013/01/01/detection-mysql-service-if-exit-then-restart/
slug: detection-mysql-service-if-exit-then-restart
title: 检测mysql服务，如果退出则重启
wordpress_id: 2046
categories:
- 技术
tags:
- crontab
---

周海汉

2013.1.1

检测重启的bash脚本如下：

root@ubuntu:~# cat my.sh
#!/bin/bash

my=`ps -ef |grep mysql |grep -v root |wc -l`
date=`date`
if [ $my != 1 ]; then
service mysql start
echo "$date mysql start"
fi

脚本单独执行没有问题，但放到crontab里一直执行不成功，能检测到mysql不存在，但不能重启成功。

root@ubuntu:~# vi /var/log/syslog

Jan 1 06:28:01 AY121229032451aac9841 CRON[30177]: (root) CMD (/root/my.sh>>myrestart.log)
Jan 1 06:28:01 AY121229032451aac9841 CRON[30176]: (CRON) info (No MTA installed, discarding output)

没有安装邮局，所以收不到crontab报错邮件。

root@ubuntu:~# apt-get install postfix

root@ubuntu:~# apt-get install mailutils

收到邮件，提示如下：

/etc/init.d/mysql: 54: /etc/init.d/mysql: initctl: not found
/etc/init.d/mysql: 82: /etc/init.d/mysql: start: not found

/usr/sbin/service: 123: exec: start: not found

这是因为crontab的环境是限制环境，PATH环境变量很短，执行service时会找不到一些文件。

root@ubuntu:~# ls /sbin/stop /sbin/start /sbin/status -l
lrwxrwxrwx 1 root root 7 Apr 26 2012 /sbin/start -> initctl
lrwxrwxrwx 1 root root 7 Apr 26 2012 /sbin/status -> initctl
lrwxrwxrwx 1 root root 7 Apr 26 2012 /sbin/stop -> initctl

ubuntu 12.04中crontab的Path中没有/sbin, 所以会找不到一些命令。

解决办法：

1.crontab -e, 在文件中直接添加PATH：

# m h dom mon dow command
PATH=/usr/sbin:/usr/bin:/sbin:/bin:$PATH
*/1 * * * * /bin/bash /root/my.sh>>myrestart.log

2.在程序中添加PATH，设置好环境变量。

3.修改/etc/crontab或/etc/profile添加环境变量。但由于是整体修改，可能对其他用户带来不良影响，所以需要谨慎，不推荐。



参考：

http://ubuntuforums.org/showthread.php?t=2022708
