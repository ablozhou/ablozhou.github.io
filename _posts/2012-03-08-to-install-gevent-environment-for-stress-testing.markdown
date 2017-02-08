---
author: abloz
comments: true
date: 2012-03-08 07:33:45+00:00
layout: post
link: http://abloz.com/index.php/2012/03/08/to-install-gevent-environment-for-stress-testing/
slug: to-install-gevent-environment-for-stress-testing
title: 安装gevent环境，用于压力测试
wordpress_id: 1500
categories:
- 技术
tags:
- gevent
- greenlet
- install
---

安装gevent环境,install gevent
gevent 是基于libevent和greenlet的高性能并发IO python库，采用monkey给python中已经存在的socket，线程等打补丁，使其支持异步，而不是同步等待，但使用方式却和同步差不多。
相较twisted的回调方式用法，更加直接。
简单而言，只需安装libevent-dev和greenlet，gevent三者。不过我的是新环境，所以相关环境也安装了一下。



```
andy@ubuntu:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=10.04
DISTRIB_CODENAME=lucid
DISTRIB_DESCRIPTION="Ubuntu 10.04.3 LTS"



andy@ubuntu:~$ uname -a
Linux ubuntu 2.6.32-33-server #70-Ubuntu SMP Thu Jul 7 22:28:30 UTC 2011 x86_64 GNU/Linux

andy@ubuntu:~$ python
Python 2.6.5 (r265:79063, Apr 16 2010, 13:57:41)
[GCC 4.4.3] on linux2

```

**安装libevent-dev**



```
andy@ubuntu:~$ sudo apt-get install libevent-dev
```




没有easy_install，安装setuptools



```
andy@ubuntu:~$ wget -q http://peak.telecommunity.com/dist/ez_setup.py
andy@ubuntu:~$ sudo python ez_setup.py
```




遇到没有安装gcc,python-dev



```
andy@ubuntu:~$ sudo easy_install greenlet

greenlet.c:1085: error: ‘PyObject’ undeclared (first use in this function)

error: Setup script exited with error: command 'gcc' failed with exit status 1

andy@ubuntu:~$ sudo apt-get install build-essential


andy@ubuntu:~$ sudo apt-get install python-dev
```


也可以执行sudo apt-get install python-setuptools python-pip 来安装python 安装工具。
可以用pip 来安装：
pip install greenlet
pip install gevent
或用easy_install:
**安装greenlet**



```
andy@ubuntu:~$ sudo easy_install greenlet
```




**安装gevent**



```
andy@ubuntu:~$ sudo easy_install gevent
```




完毕

参考：
http://engineering.monetate.com/do-c10k-testing-with-gevent
https://bitbucket.org/denis/gevent/src/tip/examples/
http://www.gevent.org/contents.html
