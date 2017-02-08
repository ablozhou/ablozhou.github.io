---
author: abloz
comments: true
date: 2009-06-03 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/06/03/centos-5-2-does-not-support-automatic-installation-of-php-mysql/
slug: centos-5-2-does-not-support-automatic-installation-of-php-mysql
title: centos 5.2自动安装的php不支持mysql？
wordpress_id: 911
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou)/文

2009.6.3

 

想在Centos5.2上装一个discuz论坛，在突破了apache权限问题后，发现discuz的提示信息里显示不支持mysql：

mysql_connect() 不支持 请检查mysql 模块是否正确加载

我自己写个测试文件

[](http://blog.csdn.net/ablo_zhou/archive/2009/06/03/4239808.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/06/03/4239808.aspx#)

  1. <?php
  2. phpinfo();
  3. ?>

<?php phpinfo(); ?>  

执行后显示：

[](http://blog.csdn.net/ablo_zhou/archive/2009/06/03/4239808.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/06/03/4239808.aspx#)

  1. System Linux cvttssw 2.6.18-92.el5PAE #1 SMP Tue Jun 10 19:22:41 EDT 2008 i686
  2. Build Date May 24 2008 14:09:32
  3. Configure Command './configure' '--build=i686-redhat-linux-gnu' '--host=i686-redhat-linux-gnu' '--target=i386-redhat-linux-gnu' '--program-prefix=' '--prefix=/usr' '--exec-prefix=/usr' '--bindir=/usr/bin' '--sbindir=/usr/sbin' '--sysconfdir=/etc' '--datadir=/usr/share' '--includedir=/usr/include' '--libdir=/usr/lib' '--libexecdir=/usr/libexec' '--localstatedir=/var' '--sharedstatedir=/usr/com' '--mandir=/usr/share/man' '--infodir=/usr/share/info' '--cache-file=../config.cache' '--with-libdir=lib' '--with-config-file-path=/etc' '--with-config-file-scan-dir=/etc/php.d' '--disable-debug' '--with-pic' '--disable-rpath' '--without-pear' '--with-bz2' '--with-curl' '--with-exec-dir=/usr/bin' '--with-freetype-dir=/usr' '--with-png-dir=/usr' '--enable-gd-native-ttf' '--without-gdbm' '--with-gettext' '--with-gmp' '--with-iconv' '--with-jpeg-dir=/usr' '--with-openssl' '--with-png' '--with-pspell' '--with-expat-dir=/usr' '--with-pcre-regex=/usr' '--with-zlib' '--with-layout=GNU' '--enable-exif' '--enable-ftp' '--enable-magic-quotes' '--enable-sockets' '--enable-sysvsem' '--enable-sysvshm' '--enable-sysvmsg' '--enable-track-vars' '--enable-trans-sid' '--enable-yp' '--enable-wddx' '--with-kerberos' '--enable-ucd-snmp-hack' '--with-unixODBC=shared,/usr' '--enable-memory-limit' '--enable-shmop' '--enable-calendar' '--enable-dbx' '--enable-dio' '--with-mime-magic=/usr/share/file/magic.mime' '--without-sqlite' '--with-libxml-dir=/usr' '--with-xml' '--with-system-tzdata' '--with-apxs2=/usr/sbin/apxs' '--without-mysql' '--without-gd' '--without-odbc' '--disable-dom' '--disable-dba' '--without-unixODBC' '--disable-pdo' '--disable-xmlreader' '--disable-xmlwriter'
  4. Server API Apache 2.0 Handler
  5. Virtual Directory Support disabled
  6. Configuration File (php.ini) Path /etc/php.ini
  7. Scan this dir for additional .ini files /etc/php.d
  8. additional .ini files parsed /etc/php.d/dbase.ini, /etc/php.d/ldap.ini, /etc/php.d/mysql.ini, /etc/php.d/mysqli.ini, /etc/php.d/pdo.ini, /etc/php.d/pdo_mysql.ini, /etc/php.d/pdo_sqlite.ini

System  Linux cvttssw 2.6.18-92.el5PAE #1 SMP Tue Jun 10 19:22:41 EDT 2008  i686   Build Date  May 24 2008 14:09:32   Configure Command  './configure' '--build=i686-redhat-linux-gnu'  '--host=i6
86-redhat-linux-gnu' '--target=i386-redhat-linux-gnu'  '--program-prefix=' '--prefix=/usr' '--exec-prefix=/usr'  '--bindir=/usr/bin' '--sbindir=/usr/sbin' '--sysconfdir=/etc'  '--datadir=/usr/share' '--includedir=/usr/include' '--libdir=/usr/lib'  '--libexecdir=/usr/libexec' '--localstatedir=/var'  '--sharedstatedir=/usr/com' '--mandir=/usr/share/man'  '--infodir=/usr/share/info' '--cache-file=../config.cache'  '--with-libdir=lib' '--with-config-file-path=/etc'  '--with-config-file-scan-dir=/etc/php.d' '--disable-debug' '--with-pic'  '--disable-rpath' '--without-pear' '--with-bz2' '--with-curl'  '--with-exec-dir=/usr/bin' '--with-freetype-dir=/usr'  '--with-png-dir=/usr' '--enable-gd-native-ttf' '--without-gdbm'  '--with-gettext' '--with-gmp' '--with-iconv' '--with-jpeg-dir=/usr'  '--with-openssl' '--with-png' '--with-pspell' '--with-expat-dir=/usr'  '--with-pcre-regex=/usr' '--with-zlib' '--with-layout=GNU'  '--enable-exif' '--enable-ftp' '--enable-magic-quotes'  '--enable-sockets' '--enable-sysvsem' '--enable-sysvshm'  '--enable-sysvmsg' '--enable-track-vars' '--enable-trans-sid'  '--enable-yp' '--enable-wddx' '--with-kerberos' '--enable-ucd-snmp-hack' '--with-unixODBC=shared,/usr' '--enable-memory-limit' '--enable-shmop'  '--enable-calendar' '--enable-dbx' '--enable-dio'  '--with-mime-magic=/usr/share/file/magic.mime' '--without-sqlite'  '--with-libxml-dir=/usr' '--with-xml' '--with-system-tzdata'  '--with-apxs2=/usr/sbin/apxs' '--without-mysql' '--without-gd'  '--without-odbc' '--disable-dom' '--disable-dba' '--without-unixODBC'  '--disable-pdo' '--disable-xmlreader' '--disable-xmlwriter'   Server API  Apache 2.0 Handler   Virtual Directory Support  disabled   Configuration File (php.ini) Path  /etc/php.ini   Scan this dir for additional .ini files  /etc/php.d   additional .ini files parsed  /etc/php.d/dbase.ini, /etc/php.d/ldap.ini, /etc/php.d/mysql.ini, /etc/php.d/mysqli.ini, /etc/php.d/pdo.ini,  /etc/php.d/pdo_mysql.ini, /etc/php.d/pdo_sqlite.ini      

--without-mysql

 

/usr/lib/php/modules/里面根本没有mysql.so

 

因此找到centos5.2安装盘，找到CentOS目录下的

php-mysql-5.1.6-20.el5.i386.rpm

上传，安装：

[zhouhh@cvttssw ~]$ sudo rpm -ivh php-mysql-5.1.6-20.el5.i386.rpm  
warning: php-mysql-5.1.6-20.el5.i386.rpm: Header V3 DSA signature: NOKEY, key ID e8562897  
error: Failed dependencies:  
php-pdo is needed by php-mysql-5.1.6-20.el5.i386

再上传php-pdo-5.1.6-20.el5.i386.rpm

 

[zhouhh@cvttssw ~]$ sudo rpm -ivh php-pdo-5.1.6-20.el5.i386.rpm

[zhouhh@cvttssw ~]$ sudo rpm -ivh php-mysql-5.1.6-20.el5.i386.rpm

成功

 

再查看so文件：

 

[zhouhh@cvttssw ~]$ ls /usr/lib/php/modules/  
dbase.so ldap.so mysqli.so mysql.so pdo_mysql.so pdo.so pdo_sqlite.so phpcups.so

mysql.so存在了。

 

配置/etc/php.ini

extension=mysql.so  
extension=mysqli.so  
extension=pdo_MySQL.so

保存，重启httpd

刷新网页，还是显示mysql_connect() 不支持

难道非要下载php源码重编译吗？

 

重启了一下mysql，刷新网页，mysql已经能连上了。

但phpinfo还是显示--without-mysql，不管他了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=7c0ee6a3-a962-85cb-8561-0d374bcacf56)
