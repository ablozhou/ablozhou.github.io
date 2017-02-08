---
author: abloz
comments: true
date: 2012-09-19 07:48:09+00:00
layout: post
link: http://abloz.com/index.php/2012/09/19/ganglia-installation/
slug: ganglia-installation
title: ganglia 安装
wordpress_id: 1878
categories:
- 技术
tags:
- ganglia
---

周海汉 /文
2012.9.19

ganglia安装

ganglia是用于超大集群监控的利器，可以和Hadoop集群度量紧密集成。新版ganglia将内核功能模块和web展示模块是分开下载的。




## 下载ganglia内核


下载地址：http://downloads.sourceforge.net/project/ganglia/

[zhouhh@h185 ~]$ wget http://downloads.sourceforge.net/project/ganglia/ganglia%20monitoring%20core/3.4.0/ganglia-3.4.0.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fganglia%2Ffiles%2Fganglia%2520monitoring%2520core%2F&ts=1346899880&use_mirror=cdnetworks-kr-1




## 编译


[zhouhh@h185 ganglia-3.4.0]$ ./configure --with-gmetad
checking for pthread_create in -lpthread... yes
checking for pthread_create in -lpthreads... no
checking rrd.h usability... no
checking rrd.h presence... no
checking for rrd.h... no
checking for rrd_create in -lrrd... no
Trying harder by including the X library path
checking for rrd_create in -lrrd... no

The Ganglia Meta Daemon uses the Round-Robin Database Tool (rrdtool)
for storing historical information. You have chosen to compile the
monitoring core with gmetad but librrd could not be found. Please
visit http://www.rrdtool.org/, download rrdtool and then try again

没找到rrdtool


## 安装rrdtool


[zhouhh@h185 ganglia-3.4.0]$ ./configure --with-gmetad --with-librrd=/usr/lib64/rrdtool
...
[zhouhh@h181 rrdtool-1.4.7]$ sudo yum -y install apr-devel apr-util check-devel cairo-devel pango-devel libxml2-devel glib2-devel dbus-devel freetype-devel fontconfig-devel gcc-c++ expat-devel python--devel libXrender-devel zlib libpng freetype libjpeg fontconfig gd libxml2 pcre pcre-devel

[zhouhh@h185 ~]$ wget http://oss.oetiker.ch/rrdtool/pub/rrdtool-1.4.7.tar.gz
[zhouhh@h185 rrdtool-1.4.7]$ ./configure --prefix=/usr/lib64/rrdtool --disable-perl
[zhouhh@h185 rrdtool-1.4.7]$ make
[zhouhh@h183 rrdtool-1.4.7]$ sudo make install
[zhouhh@h185 ganglia-3.4.0]$ ./configure --with-gmetad --with-librrd=/usr/lib64/rrdtool
...
Checking for confuse
checking for cfg_parse in -lconfuse... no
Trying harder including gettext
checking for cfg_parse in -lconfuse... no
Trying harder including iconv
checking for cfg_parse in -lconfuse... no
libconfuse not found

libconfuse是配置分析库


## 安装libconfuse


[zhouhh@h181 ganglia-3.4.0]$ sudo yum -y install libconfuse libconfuse-devel.x86_64
Loaded plugins: fastestmirror, refresh-packagekit, security
Loading mirror speeds from cached hostfile
* base: mirrors.163.com
* extras: mirrors.163.com
* updates: mirrors.163.com
Setting up Install Process
No package libconfuse available.
No package libconfuse-devel.x86_64 available.
Error: Nothing to do

[zhouhh@h181 ganglia-3.4.0]$ cat /etc/redhat-release
CentOS release 6.3 (Final)

下载并配置confuse

[zhouhh@h185 ~]$ wget http://download.savannah.gnu.org/releases/confuse/confuse-2.7.tar.gz

...

[zhouhh@h181 ganglia-3.4.0]$ ./configure --with-gmetad --with-librrd=/usr/lib64/rrdtool --sysconfdir=/etc/ganglia
...
Welcome to..
______ ___
/ ____/___ _____ ____ _/ (_)___ _
/ / __/ __ `/ __ / __ `/ / / __ `/
/ /_/ / /_/ / / / / /_/ / / / /_/ /
____/__,_/_/ /_/__, /_/_/__,_/
/____/

Copyright (c) 2005 University of California, Berkeley

Version: 3.4.0
Library: Release 3.4.0 0:0:0



**编译安装**
[zhouhh@h185 ~]$ sudo make&&install




## 配置ganglia


[zhouhh@h181 ganglia-3.4.0]$ gmetad -d 5
Going to run as user nobody
Must be root to setuid to "nobody"

[zhouhh@h185 ~]$ sudo dmetad
sudo: dmetad: command not found

[zhouhh@h185 ~]$ whereis gmetad
gmetad: /usr/local/sbin/gmetad /usr/local/etc/gmetad.conf



**添加/usr/local/sbin/到用户环境和sudo环境**
[zhouhh@h185 ~]$ vi .bashrc

export PATH=$PATH:/usr/local/sbin

[zhouhh@h185 ~]$ source .bashrc

[zhouhh@h185 ~]$ sudo visudo

Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin



**修改权限**

[zhouhh@h181 ~]$ mkdir -p /var/lib/ganglia/rrds
[zhouhh@h181 ~]$ sudo chown nobody:nobody /var/lib/ganglia/ -R

**测试**

[zhouhh@h181 ~]$ sudo gmetad -d 5
Going to run as user nobody
Sources are ...
Source: [my cluster, step 15] has 1 sources
127.0.0.1
xml listening on port 8651
interactive xml listening on port 8652
Data thread 140272050796288 is monitoring [my cluster] data source
127.0.0.1
cleanup thread has been started
data_thread() for [my cluster] failed to contact node 127.0.0.1
data_thread() got no answer from any [my cluster] datasource

**配置gmond**

[zhouhh@h181 ~]$ sudo gmond -d 5
Configuration file '/usr/local/etc/gmond.conf' not found.

loaded module: core_metrics
loaded module: cpu_module
loaded module: disk_module
loaded module: load_module
loaded module: mem_module
loaded module: net_module
loaded module: proc_module
loaded module: sys_module

[zhouhh@h185 ~]$ sudo gmond --default_config > /usr/local/etc/gmond.conf
-bash: /usr/local/etc/gmond.conf: Permission denied

[root@h181 zhouhh]# gmond --default_config > /usr/local/etc/gmond.conf




## 配置web环境


**下载ganglia web**

http://sourceforge.net/projects/ganglia/files/ganglia-web/

[zhouhh@h185 ~]$ wget http://downloads.sourceforge.net/project/ganglia/ganglia-web/3.5.2/ganglia-web-3.5.2.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fganglia%2Ffiles%2Fganglia-web%2F3.5.2%2F&ts=1347011991&use_mirror=cdnetworks-kr-1
Length: 1471659 (1.4M) [application/x-gzip]

[zhouhh@h185 ~]$ tar zxvf ganglia-web-3.5.2.tar.gz

因我的DocumentRoot目录在/home/www下面，所以需要修改一下Makefile

[zhouhh@h185 ganglia3]$ vi Makefile
GDESTDIR = /home/www/default/ganglia

用浏览器访问http://h185/ganglia/

返回：

There was an error collecting ganglia data (127.0.0.1:8652): fsockopen error: Connection refused

原来ganglia的gmond和gmetad没起来

**设置服务自启动环境**

[zhouhh@h185 ganglia-3.4.0]$ sudo cp gmond/gmond.init /etc/rc.d/init.d/gmond
[zhouhh@h185 ganglia-3.4.0]$ sudo chkconfig --add gmond
[zhouhh@h185 ganglia-3.4.0]$ sudo chkconfig gmond on
[zhouhh@h185 ganglia-3.4.0]$ sudo cp gmetad/gmetad.init /etc/rc.d/init.d/gmetad
[zhouhh@h185 ganglia-3.4.0]$ sudo chkconfig --add gmetad
[zhouhh@h185 ganglia-3.4.0]$ sudo chkconfig gmetad on
[zhouhh@h185 ganglia-3.4.0]$ sudo vi /usr/local/etc/gmetad.conf
data_source "myhadoop" h185 h181
gridname "MyHadoopGrid"
[zhouhh@h185 ganglia-3.4.0]$ sudo service gmond start
[zhouhh@h185 ganglia-3.4.0]$ sudo service gmetad start

[root@h185 gmond]# whereis gmond
gmond: /usr/local/sbin/gmond /usr/local/etc/gmond.conf

需重新配置一下gmond.init和 gmetad.init，指到安装的目录。

[root@h185 gmond]# vi gmond.init
GMOND=/usr/local/sbin/gmond
[root@h185 gmond]# cp gmond.init /etc/rc.d/init.d/gmond
[root@h185 gmetad]# vi gmetad.init
GMETAD=/usr/local/sbin/gmetad
[root@h185 gmetad]# cp gmetad.init /etc/rc.d/init.d/gmetad

[zhouhh@h185 ganglia-3.4.0]$ sudo service gmond start
[zhouhh@h185 ganglia-3.4.0]$ sudo service gmetad start

用浏览器访问http://h185/ganglia/

返回正确的结果。

依次在其他需管理的机器配置gmond，并运行起来。

监控主机运行gmond和gmetad。

如图

[![](http://abloz.com/wp-content/uploads/2012/09/ganglia1.jpg)](http://abloz.com/wp-content/uploads/2012/09/ganglia1.jpg)
