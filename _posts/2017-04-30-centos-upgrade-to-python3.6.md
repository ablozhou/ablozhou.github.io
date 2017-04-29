---
layout: post
title:  "Centos安装升级python3.6"
date:   2017-05-1 20:18:26 +0800
categories: 技术
tags:
    - python
    
---

安装流程
- 安装python3.6可能使用的依赖
- 下载解压安装包
- 编译安装

```
[zhouhh@mainServer ~]$ cat /etc/redhat-release
CentOS Linux release 7.1.1503 (Core)
[zhouhh@mainServer ~]$ sudo yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel

[zhouhh@mainServer ~]$ wget  https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz
[zhouhh@mainServer ~]$ tar zxvf Python-3.6.0.tgz

[zhouhh@mainServer ~]$ cd Python-3.6.0/
[zhouhh@mainServer Python-3.6.0]$ ./configure --prefix=/usr/local --enable-optimizations

[zhouhh@mainServer Python-3.6.0]$ make
[zhouhh@mainServer Python-3.6.0]$ sudo make altinstall
[zhouhh@mainServer Python-3.6.0]$ cd /usr/local/bin

```
- python3.6程序的执行文件：/usr/local/bin/python3.6
- python3.6应用程序目录：/usr/local/lib/python3.6
- pip3的执行文件：/usr/local/bin/pip3.6
- pyenv3的执行文件：/usr/local/bin/pyenv-3.6
- pydoc3 执行文件： /usr/local/bin/pydoc3.6
- 2to3：/usr/local/bin/2to3-3.6
- idle3：/usr/local/bin/idle3.6
- python3-config：/usr/local/bin/python3.6-config

## 修改链接
```
[zhouhh@mainServer bin]$ sudo rm idle3 2to3 pydoc3 python3  python3-config pyvenv

[zhouhh@mainServer bin]$ sudo ln -s 2to3-3.6 2to3
[zhouhh@mainServer bin]$ sudo ln -s idle3.6 idle3
[zhouhh@mainServer bin]$ sudo ln -s pydoc3.6 pydoc3
[zhouhh@mainServer bin]$ sudo ln -s python3.6 python3
[zhouhh@mainServer bin]$ sudo ln -s python3.6m-config python3.6-config
[zhouhh@mainServer bin]$ sudo ln -s python3.6-config python3-config
[zhouhh@mainServer bin]$ sudo ln -s pyvenv-3.6 pyvenv3
```

也可以考虑将python缺省值替换到python3，但相关yum 调用也需要修改。

```
[zhouhh@mainServer bin]$ ls -l python*
lrwxrwxrwx. 1 root root    7 Oct 26  2016 python -> python2
lrwxrwxrwx. 1 root root    9 Oct 26  2016 python2 -> python2.7
-rwxr-xr-x. 1 root root 7136 Jun 18  2014 python2.7
[zhouhh@mainServer bin]$ python3
Python 3.6.0 (default, Apr 27 2017, 14:53:11)
[GCC 4.8.5 20150623 (Red Hat 4.8.5-4)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> quit()
```
# 参考
[CentOS7.3安装Python3.6](http://blog.csdn.net/hobohero/article/details/54381475)
