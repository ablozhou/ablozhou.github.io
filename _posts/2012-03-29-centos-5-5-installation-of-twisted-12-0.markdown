---
author: abloz
comments: true
date: 2012-03-29 10:04:05+00:00
layout: post
link: http://abloz.com/index.php/2012/03/29/centos-5-5-installation-of-twisted-12-0/
slug: centos-5-5-installation-of-twisted-12-0
title: centos 5.5 安装twisted 12.0
wordpress_id: 1527
categories:
- 技术
tags:
- centos
- python
- twisted
---

http://abloz.com
author:ablozhou
date:2012.3.29

**环境准备**
centos缺省安装的python 是2.4的，可以安装兼容的最新版本python 2.7.2
下载源码：[Python 2.7.2 compressed source tarball (for Linux, Unix or Mac OS X)](http://python.org/ftp/python/2.7.2/Python-2.7.2.tgz)
[zhouhh@Hadoop48 ~]$ tar -zxvf Python-2.7.2.tgz
[zhouhh@Hadoop48 Python-2.7.2]$ ./configure & make
[root@Hadoop48 Python-2.7.2]# make install

将python 2.4改为2.7
[root@Hadoop48 bin]# mv python python.bk
[root@Hadoop48 bin]# ln -s /usr/local/bin/python python
/usr/local/bin/python 是2.7的版本

**下载twisted：**
最新版12.0
 [Twisted 12.0.0 tar.bz2](http://pypi.python.org/packages/source/T/Twisted/Twisted-12.0.0.tar.bz2#md5=cf49a8676c21c50faf1b42b528049471)
http://pypi.python.org/packages/source/T/Twisted/Twisted-12.0.0.tar.bz2#md5=cf49a8676c21c50faf1b42b528049471
安装setuptools
[root@Hadoop48 zhouhh]# wget http://peak.telecommunity.com/dist/ez_setup.py
[root@Hadoop48 zhouhh]#python ez_setup.py
tiwsted依赖zope.interface,可以到http://pypi.python.org/pypi/zope.interface 下载，也可以用easy_setup来安装。
[root@Hadoop48 zhouhh]#easy_install zope.interface

[root@Hadoop48 zhouhh]# wget http://pypi.python.org/packages/source/T/Twisted/Twisted-12.0.0.tar.bz2#md5=cf49a8676c21c50faf1b42b528049471
[root@Hadoop48 zhouhh]# tar -jxvf Twisted-12.0.0.tar.bz2
[root@Hadoop48 zhouhh]# cd Twisted-12.0.0
[root@Hadoop48 Twisted-12.0.0]#python setup.py   build
[root@Hadoop48 Twisted-12.0.0]#python setup.py   install

至此，python twisted 完成
**参考：**
http://python.org/getit/
http://pypi.python.org/pypi/zope.interface
http://peak.telecommunity.com/dist/ez_setup.py
http://twistedmatrix.com/trac/
