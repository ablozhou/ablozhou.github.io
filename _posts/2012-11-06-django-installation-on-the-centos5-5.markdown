---
author: abloz
comments: true
date: 2012-11-06 03:33:26+00:00
layout: post
link: http://abloz.com/index.php/2012/11/06/django-installation-on-the-centos5-5/
slug: django-installation-on-the-centos5-5
title: django 在centos5.5上的安装
wordpress_id: 1961
categories:
- 技术
tags:
- django
- mysql
- python
---

周海汉

2012.11.6

[zhouhh@Hadoop47 ~]$ cat /etc/redhat-release
CentOS release 5.5 (Final)

**下载django**

[zhouhh@Hadoop47 ~]$ wget https://www.djangoproject.com/download/1.4.2/tarball/

[zhouhh@Hadoop47 Django-1.4.2]$ python setup.py build
[zhouhh@Hadoop47 Django-1.4.2]$ sudo python setup.py install

**安装pip**
[zhouhh@Hadoop47 pip-1.2.1]$ python setup.py build
Traceback (most recent call last):
File "setup.py", line 5, in <module>
from setuptools import setup
ImportError: No module named setuptools

**安装setuptools**
http://pypi.python.org/pypi/setuptools
[zhouhh@Hadoop47 python]$ wget http://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg#md5=fe1f997bc722265116870bc7919059ea
[zhouhh@Hadoop47 python]$ bash setuptools-0.6c11-py2.7.egg
[Errno 13] Permission denied: '/usr/local/lib/python2.7/site-packages/test-easy-install-8677.write-test'

[zhouhh@Hadoop47 python]$ sudo bash setuptools-0.6c11-py2.7.egg
setuptools-0.6c11-py2.7.egg: line 3: exec: python2.7: not found
[zhouhh@Hadoop47 python]$ which python
/usr/local/bin/python
[zhouhh@Hadoop47 python]$ which python2.7
/usr/local/bin/python2.7

在root下visudo，修改/etc/sudoers，将Defaults env_reset改成Defaults !env_reset
[zhouhh@Hadoop47 python]$ sudo bash setuptools-0.6c11-py2.7.egg

**再安装pip**
[zhouhh@Hadoop47 python]$ sudo curl -k https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python

error: could not create '/usr/local/lib/python2.7/site-packages/pip': Permission denied

[root@Hadoop47 ~]# curl -k https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python
Downloading pip-1.2.1.tar.gz
安装pip完毕

**安装 MySQLdb**
地址：http://www.djangoproject.com/r/python-mysql/

[zhouhh@Hadoop47 t3]$ sudo pip install MySQLdb
No distributions at all found for MySQLdb
http://sourceforge.net/projects/mysql-python/
[zhouhh@Hadoop47 python]$ wget http://sourceforge.net/projects/mysql-python/files/mysql-python/1.2.3/MySQL-python-1.2.3.tar.gz/download
[zhouhh@Hadoop47 MySQL-python-1.2.3]$ python setup.py build
_mysql.c:36:23: error: my_config.h: No such file or directory
...
[zhouhh@Hadoop47 ~]$ sudo yum install MySQL-python.x86_64
MySQL-python-1.2.3-0.1.c1.el5.x86_64 from base has depsolving problems
Error: Missing Dependency: libmysqlclient_r.so.15()(64bit)

找不到libmysqlclient_r.so.15，需安装它。
[zhouhh@Hadoop47 ~]$ wget ftp://rpmfind.net/linux/centos/5.8/updates/x86_64/RPMS/mysql-5.0.95-1.el5_7.1.x86_64.rpm
[zhouhh@Hadoop47 ~]$ sudo rpm -ivh mysql-5.0.95-1.el5_7.1.x86_64.rpm
error: Failed dependencies:
perl(DBI) is needed by mysql-5.0.95-1.el5_7.1.x86_64

**安装perl-DBI和mysql**
[zhouhh@Hadoop47 ~]$ sudo yum install perl-DBI.x86_64

[zhouhh@Hadoop47 ~]$ sudo rpm -ivh mysql-5.0.95-1.el5_7.1.x86_64.rpm
Preparing... ########################################### [100%]
package mysql-5.5.15-1.el5.remi.x86_64 (which is newer than mysql-5.0.95-1.el5_7.1.x86_64) is already installed
file /etc/my.cnf from install of mysql-5.0.95-1.el5_7.1.x86_64 conflicts with file from package mysql-libs-5.5.15-1.el5.remi.x86_64
...

mysql版本有冲突，已安装版本较新，需卸载降级

[zhouhh@Hadoop47 ~]$ sudo yum remove mysql.x86_64
[zhouhh@Hadoop47 ~]$ sudo yum remove mysql-libs*
[zhouhh@Hadoop47 ~]$ sudo yum install mysql-5.0.95-1.el5_7.1.x86_64
Installed:
mysql.x86_64 0:5.0.95-1.el5_7.1

Complete!
[zhouhh@Hadoop47 ~]$ sudo yum install MySQL-python.x86_64
Installed:
MySQL-python.x86_64 0:1.2.3-0.1.c1.el5

Complete!

    
    对ubuntu，用sudo apt-get install python-mysqldb 解决django.core.exceptions.ImproperlyConfigured: Error loading MySQLdb module: No module named MySQLdb错误。


[zhouhh@Hadoop47 lib]$ sudo pip install mysql-python
_mysql.c:44:23: error: my_config.h: No such file or directory

_mysql.c:46:19: error: mysql.h: No such file or directory
...
**安装mysql-server**
[zhouhh@Hadoop47 lib]$ sudo yum instlall mysql-devel.x86_64
[zhouhh@Hadoop47 lib]$ sudo yum install mysql-server.x86_64
[zhouhh@Hadoop47 lib]$ sudo pip install mysql-python
Successfully installed mysql-python
Cleaning up...



**创建项目，django hello**

[zhouhh@Hadoop47 www]$ django-admin.py startproject t3
[zhouhh@Hadoop47 www]$ find t3
t3
t3/t3
t3/t3/__init__.py
t3/t3/settings.py
t3/t3/wsgi.py
t3/t3/urls.py
t3/manage.py
[zhouhh@Hadoop47 t3]$ cat t3/settings.py

DATABASES = {
'default': {
'ENGINE': 'django.db.backends.mysql'
'NAME': 't3', # Or path to database file if using sqlite3.
'USER': 'root', # Not used with sqlite3.
'PASSWORD': '', # Not used with sqlite3.
'HOST': 'hadoop48', # Set to empty string for localhost. Not used with sqlite3.
'PORT': '', # Set to empty string for default. Not used with sqlite3.
}
}
...
TIME_ZONE = 'Asia/Hong_Kong'
...
[zhouhh@Hadoop47 t3]$ cat t3/views.py
#/usr/bin/env python
# -- coding:utf8--
from django.http import HttpResponse

def hello(request):

return HttpResponse("hello,world");

[zhouhh@Hadoop47 t3]$ cat t3/urls.py
...
from t3.views import hello
urlpatterns = patterns('',
# Examples:
('^hello/$', hello),
...
[zhouhh@Hadoop47 t3]$ ./manage.py runserver 192.168.10.47:8000
如果MySQLdb和mysql程序没装好，会出如下错误：
django.core.exceptions.ImproperlyConfigured: Error loading MySQLdb module: No module named MySQLdb
所以需要先安装mysql和MySQLdb python模块

[zhouhh@Hadoop47 t3]$ ./manage.py runserver
Validating models...

0 errors found
Django version 1.4.2, using settings 't3.settings'
Development server is running at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
但这个不能在其他机器访问
[zhouhh@Hadoop47 t3]$ ./manage.py runserver 192.168.10.47:8000
Validating models...

0 errors found
Django version 1.4.2, using settings 't3.settings'
Development server is running at http://192.168.10.47:8000/
Quit the server with CONTROL-C.

**访问**

此时用浏览器访问 http://hadoop47:8000/hello
返回：
hello,world

**参考：**

django book 中文翻译：[http://djangobook.py3k.cn/2.0](http://djangobook.py3k.cn/2.0)
