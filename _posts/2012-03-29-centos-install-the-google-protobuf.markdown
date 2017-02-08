---
author: abloz
comments: true
date: 2012-03-29 10:15:28+00:00
layout: post
link: http://abloz.com/index.php/2012/03/29/centos-install-the-google-protobuf/
slug: centos-install-the-google-protobuf
title: centos 安装google protobuf
wordpress_id: 1529
categories:
- 技术
tags:
- protobuf
- python
---

http://abloz.com

author:ablozhou
date:2012.3.29

**环境**
cat /etc/redhat-release
CentOS release 5.5 (Final)
**下载**
wget http://protobuf.googlecode.com/files/protobuf-2.4.1.tar.bz2
tar -jxvf protobuf-2.4.1.tar.bz2

**编译安装**
[zhouhh@Hadoop48 ~]$ cd protobuf-2.4.1
[zhouhh@Hadoop48 protobuf-2.4.1]$
[zhouhh@Hadoop48 protobuf-2.4.1]$ ./configure & make
[root@Hadoop48 protobuf-2.4.1]# make install

**安装python版的protobuf**
[root@Hadoop48 protobuf-2.4.1]# cd python
[root@Hadoop48 python]# python setup.py build
[root@Hadoop48 python]# python setup.py install

**参考**
http://code.google.com/p/protobuf/

