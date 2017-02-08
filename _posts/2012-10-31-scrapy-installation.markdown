---
author: abloz
comments: true
date: 2012-10-31 04:20:49+00:00
layout: post
link: http://abloz.com/index.php/2012/10/31/scrapy-installation/
slug: scrapy-installation
title: scrapy安装
wordpress_id: 1943
categories:
- 技术
tags:
- install
- scrapy
---



周海汉

http://abloz.com

scrapy是python网页抓取框架。本文介绍安装方法。

环境：

[zhouhh@Hadoop48 python]$ cat /etc/redhat-release
CentOS release 5.5 (Final)

[zhouhh@Hadoop48 python]$ python -V
Python 2.7.2



如果没有安装pip，可以下载安装一下。下载地址：

[zhouhh@Hadoop48 python]$ wget http://pypi.python.org/packages/source/p/pip/pip-1.2.1.tar.gz

用pip安装scrapy 0.16版

[zhouhh@Hadoop48 test]$ sudo pip install  scrapy

...

OpenSSL/ssl/connection.c: In function ‘ssl_Connection_set_context’:

OpenSSL/ssl/connection.c:289: warning: implicit declaration of function ‘SSL_set_SSL_CTX’

OpenSSL/ssl/connection.c: In function ‘ssl_Connection_get_servername’:

OpenSSL/ssl/connection.c:313: error: ‘TLSEXT_NAMETYPE_host_name’ undeclared (first use in this function)

OpenSSL/ssl/connection.c:313: error: (Each undeclared identifier is reported only once

OpenSSL/ssl/connection.c:313: error: for each function it appears in.)

OpenSSL/ssl/connection.c:320: warning: implicit declaration of function ‘SSL_get_servername’

OpenSSL/ssl/connection.c:320: warning: assignment makes pointer from integer without a cast

OpenSSL/ssl/connection.c: In function ‘ssl_Connection_set_tlsext_host_name’:

OpenSSL/ssl/connection.c:346: warning: implicit declaration of function ‘SSL_set_tlsext_host_name’

error: command 'gcc' failed with exit status 1

报错了。原来是pyopenssl 0.13的版本和openssl不兼容，需要打补丁。

[zhouhh@Hadoop48 test]$ wget https://bugs.launchpad.net/pyopenssl/+bug/845445/+attachment/2666639/+files/pyOpenSSL-0.13.centos5.patch
thanks to Philip K. Warren (pkwarren)
[zhouhh@Hadoop48 test]$ wget http://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.13.tar.gz
[zhouhh@Hadoop48 test]$ grep "#define OPENSSL_VERSION_TEXT" /usr/include/openssl/opensslv.h
#define OPENSSL_VERSION_TEXT "OpenSSL 0.9.8e-fips-rhel5 01 Jul 2008"
#define OPENSSL_VERSION_TEXT "OpenSSL 0.9.8e-rhel5 01 Jul 2008"

[zhouhh@Hadoop48 test]$ mv *.patch pyOpenSSL-0.13
[zhouhh@Hadoop48 test]$ cd pyOpenSSL-0.13

[zhouhh@Hadoop48 pyOpenSSL-0.13]$ patch -p1 < pyOpenSSL-0.13.centos5.patch
patching file OpenSSL/ssl/connection.c
patching file OpenSSL/ssl/context.c

[zhouhh@Hadoop48 pyOpenSSL-0.13]$ sudo python setup.py install
[zhouhh@Hadoop48 test]$ sudo pip install --upgrade scrapy

ok
