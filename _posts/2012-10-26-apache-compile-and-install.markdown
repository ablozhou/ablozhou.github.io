---
author: abloz
comments: true
date: 2012-10-26 02:45:51+00:00
layout: post
link: http://abloz.com/index.php/2012/10/26/apache-compile-and-install/
slug: apache-compile-and-install
title: apache httpd 2.4.3编译安装
wordpress_id: 1932
categories:
- 技术
tags:
- apache
- httpd
- 安装
---

周海汉

2012.10.26

**前言**

新版apache 2.4.3直接configure会报错，缺了两个模块apr和pcre，这是需要单独下载和编译的。方法和过程如下所示。



**下载**

[zhouhh@Hadoop48 ~]$ wget http://mirrors.tuna.tsinghua.edu.cn/apache/httpd/httpd-2.4.3.tar.gz



**编译**
[zhouhh@Hadoop47 httpd-2.4.3]$ ./configure
checking for chosen layout... Apache
checking for working mkdir -p... yes
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking build system type... x86_64-unknown-linux-gnu
checking host system type... x86_64-unknown-linux-gnu
checking target system type... x86_64-unknown-linux-gnu
configure:
configure: Configuring Apache Portable Runtime library...
configure:
checking for APR... no
configure: error: APR not found. Please read the documentation.

**httpd 2.4安装文档**：
http://httpd.apache.org/docs/2.4/install.html
APR and APR-Util
Apache Portable Runtime (APR)，apache 可移植运行。 地址：http://apr.apache.org/
最新版包括3个组件：
APR 1.4.6, released Feb 14, 2012
APR-util 1.5.1, released October 5, 2012
APR-iconv 1.2.1, released November 26, 2007

这是原文说明：

Make sure you have APR and APR-Util already installed on your system. If you don't, or prefer to not use the system-provided versions, download the latest versions of both APR and APR-Util from Apache APR（http://apr.apache.org/）, unpack them into ./srclib/apr and ./srclib/apr-util (be sure the domain names do not have version numbers; for example, the APR distribution must be under ./srclib/apr/) and use ./configure's --with-included-apr option. On some platforms, you may have to install the corresponding -dev packages to allow httpd to build against your installed copy of APR and APR-Util.



**安装apr**

[zhouhh@Hadoop47 srclib]$ wget http://labs.mop.com/apache-mirror//apr/apr-1.4.6.tar.gz

[zhouhh@Hadoop47 srclib]$ wget http://labs.mop.com/apache-mirror//apr/apr-util-1.5.1.tar.gz

[zhouhh@Hadoop47 srclib]$ wget http://labs.mop.com/apache-mirror//apr/apr-iconv-1.2.1.tar.gz

[zhouhh@Hadoop47 srclib]$ ln -s apr-1.4.6 apr
[zhouhh@Hadoop47 srclib]$ ln -s apr-iconv-1.2.1 apr-iconv
[zhouhh@Hadoop47 srclib]$ ln -s apr-util-1.5.1 apr-util

[zhouhh@Hadoop47 httpd-2.4.3]$ ./configure --with-include-apr
configure: error: pcre-config for libpcre not found. PCRE is required and available from http://pcre.org/



**安装pcre**

Perl-Compatible Regular Expressions Library (PCRE),Perl兼容正则表达式库，新版httpd不再随包发布，需要到 http://www.pcre.org 下载，也可以装现成版本。如果安装后找不到，用--with-pcre指定pcre路径。可能需要安装相应的dev版本。
可以从ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/或https://sourceforge.net/projects/pcre/files/pcre/下载源码。
[zhouhh@Hadoop47 srclib]$ wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.31.tar.gz
[zhouhh@Hadoop47 pcre-8.31]$ ./configure
[zhouhh@Hadoop47 pcre-8.31]$ make
[zhouhh@Hadoop47 pcre-8.31]$ sudo make install

[zhouhh@Hadoop47 httpd-2.4.3]$ ./configure --with-include-apr
[zhouhh@Hadoop47 httpd-2.4.3]$ make
[zhouhh@Hadoop47 httpd-2.4.3]$ rpm -qa | grep httpd
httpd-2.2.3-43.el5.centos
httpd-manual-2.2.3-43.el5.centos



**安装**

编译通过，安装，和原来的版本不会冲突
[zhouhh@Hadoop47 httpd-2.4.3]$ sudo make install

缺省安装到了/usr/local/apache2/



**启动httpd**
[root@Hadoop47 bin]# ./apachectl -k start
/usr/local/apache2/bin/httpd: error while loading shared libraries: libpcre.so.1: cannot open shared object file: No such file or directory
[zhouhh@Hadoop47 lib]$ ldconfig /usr/local/lib
[root@Hadoop47 bin]# ./apachectl -k start
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 192.168.10.47. Set the 'ServerName' directive globally to suppress this message

这是一个警告信息，可以忽略。此时httpd已经运行起来，可以通过浏览器访问了。
但为了不显示警告，可以修改一下httpd.conf
[root@Hadoop47 apache2]# vi conf/httpd.conf
修改#ServerName www.example.com:80为
ServerName 192.168.10.47:80
[root@Hadoop47 apache2]# ./bin/apachectl -k stop
[root@Hadoop47 apache2]# ./bin/apachectl -k start
[root@Hadoop47 apache2]#
已经没有警告信息，用浏览器访问显示it works.


