---
author: abloz
comments: true
date: 2012-10-26 10:23:21+00:00
layout: post
link: http://abloz.com/index.php/2012/10/26/compile-and-install-apache-python-module-mod_wsgi/
slug: compile-and-install-apache-python-module-mod_wsgi
title: apache python 模块mod_wsgi的编译安装
wordpress_id: 1937
categories:
- 技术
tags:
- apache
- python
- wsgi
---

周海汉

2012.10.26

**前言**

要让apache支持django，首先要支持python。wsgi是目前效率最高的支持python的模块，遵循wsgi标准。

关于apache的编译安装，请参考我此前写的《[apache httpd 2.4.3编译安装》](http://abloz.com/2012/10/26/apache-compile-and-install.html)，本篇介绍如何让apache支持wsgi。



**下载**
[zhouhh@Hadoop47 ~]$ wget http://modwsgi.googlecode.com/files/mod_wsgi-3.4.tar.gz

**编译**
[zhouhh@Hadoop47 ~]$ tar zxvf mod_wsgi-3.4.tar.gz

[zhouhh@Hadoop47 ~]$ cd mod_wsgi-3.4
[zhouhh@Hadoop47 mod_wsgi-3.4]$ ./configure
checking for apxs2... no
checking for apxs... no
checking Apache version... ./configure: line 1704: apxs: command not found

centos 5.5自带的apache没有apxs模块，所以需要自己编译apache，参考《[apache httpd 2.4.3编译安装》](http://abloz.com/2012/10/26/apache-compile-and-install.html)，使其支持apxs。

另外，需要最新python版本。centos自带的是python 2.4，至少需要python 2.6 以上。我这里采用最新版python 2.7.2.，到http://www.python.org下载。

**安装python 2.7**

[zhouhh@Hadoop47 ~]$ tar zxvf Python-2.7.2.tgz

[zhouhh@Hadoop47 Python-2.7.2]$ ./configure

这里，必须用--enable-shared，生成动态库，否则会遇到wsgi不能编译的问题。

[zhouhh@Hadoop47 Python-2.7.2]$ make
[zhouhh@Hadoop47 Python-2.7.2]$ sudo make install
/usr/local/lib/python2.7
/usr/local/bin/python
[zhouhh@Hadoop47 bin]$ sudo mv python python2.4
[zhouhh@Hadoop47 bin]$ pwd
/usr/bin
[zhouhh@Hadoop47 bin]$ sudo ln -s /usr/local/bin/python python
[zhouhh@Hadoop47 bin]$ python
Python 2.7.2 (default, Oct 26 2012, 11:05:43)
[root@Hadoop47 ~]# yum
No module named yum
[root@Hadoop47 ~]# vi /usr/bin/yum
#!/usr/bin/python
改为
#!/usr/bin/python2.4
[zhouhh@Hadoop47 mod_wsgi-3.4]$ ./configure --with-apxs=/usr/local/apache2/bin/apxs
[zhouhh@Hadoop47 mod_wsgi-3.4]$ make
/usr/bin/ld: /usr/local/lib/libpython2.7.a(node.o): relocation R_X86_64_32 against `a local symbol' can not be used when making a shared object; recompile with -fPIC
/usr/local/lib/libpython2.7.a: could not read symbols: Bad value

这是32位和64位版本搞混的问题
参考http://code.google.com/p/modwsgi/wiki/InstallationIssues

将/usr/local/lib下的python和库删除
[zhouhh@Hadoop47 Python-2.7.2]$ ./configure --enable-shared
[zhouhh@Hadoop47 Python-2.7.2]$ make
[zhouhh@Hadoop47 Python-2.7.2]$ sudo make install
[zhouhh@Hadoop47 lib]$ python
python: error while loading shared libraries: libpython2.7.so.1.0: cannot open shared object file: No such file or directory

找不到库，需用ldconfig指定库路径

[zhouhh@Hadoop47 local]$ sudo ldconfig /usr/local/lib
[zhouhh@Hadoop47 local]$ python
Python 2.7.2 (default, Oct 26 2012, 11:52:55)

继续编译wsgi

[zhouhh@Hadoop47 mod_wsgi-3.4]$ ./configure --with-apxs=/usr/local/apache2/bin/apxs --with-python=/usr/local/bin/python2.7
[zhouhh@Hadoop47 mod_wsgi-3.4]$ make
[zhouhh@Hadoop47 mod_wsgi-3.4]$ sudo make install



**配置**

修改httpd.conf配置,增加

LoadModule wsgi_module modules/mod_wsgi.so

为了防止源码被下载，一般将源码放在DocumentRoot之外的目录。

但需要配置httpd.conf里面目录访问权限Allow from all，否则访问时会引起403，not allowed错误。
我将wsgi测试程序放在/home/zhouhh/www，该目录需要允许apache用户有可读权限。
[root@Hadoop47 apache2]# vi conf/httpd.conf
#same as sys.prefix
WSGIPythonHome /usr/local
<Directory />
AllowOverride none
# Require all denied
Require all granted
Order allow,deny
Allow from all
</Directory>
<Directory "/home/zhouhh/www">
Order allow,deny
Allow from all
</Directory>
# HTTP请求处理脚本
#WSGIScriptAlias /test /usr/local/apache2/htdocs/t.wsgi
WSGIScriptAlias /test /home/zhouhh/www/test.wsgi
<Directory "/usr/local/apache2/htdocs">
...
Order allow,deny
Allow from all
</Directory>
[root@Hadoop47 apache]# apachectl -k stop
[root@Hadoop47 apache]# apachectl -k start

**检查一下模块**

[zhouhh@Hadoop47 www]$ apachectl -l
Compiled in modules:
core.c
mod_so.c
http_core.c
event.c
[zhouhh@Hadoop47 www]$ apachectl -M
Loaded Modules:
core_module (static)
so_module (static)
http_module (static)
mpm_event_module (static)
authn_file_module (shared)
authn_core_module (shared)
authz_host_module (shared)
authz_groupfile_module (shared)
authz_user_module (shared)
authz_core_module (shared)
access_compat_module (shared)
auth_basic_module (shared)
reqtimeout_module (shared)
filter_module (shared)
mime_module (shared)
log_config_module (shared)
env_module (shared)
headers_module (shared)
setenvif_module (shared)
version_module (shared)
unixd_module (shared)
status_module (shared)
autoindex_module (shared)
dir_module (shared)
alias_module (shared)
rewrite_module (shared)
wsgi_module (shared)

此时能看到wsgi_module也已经加载
[zhouhh@Hadoop47 modules]$ ldd mod_wsgi.so
libpython2.7.so.1.0 => /usr/local/lib/libpython2.7.so.1.0 (0x00002b9d6e909000)
libpthread.so.0 => /lib64/libpthread.so.0 (0x00002b9d6ecd3000)
libdl.so.2 => /lib64/libdl.so.2 (0x00002b9d6eeee000)
libutil.so.1 => /lib64/libutil.so.1 (0x00002b9d6f0f3000)
libm.so.6 => /lib64/libm.so.6 (0x00002b9d6f2f6000)
libc.so.6 => /lib64/libc.so.6 (0x00002b9d6f579000)
/lib64/ld-linux-x86-64.so.2 (0x00000037d9200000)

可以看到mod_wsgi.so指向的库是正确的路径

**测试**
[zhouhh@Hadoop47 www]$ pwd
/home/zhouhh/www
[zhouhh@Hadoop47 www]$ cat test.wsgi

    
    def application(environ, start_response):
    status = '200 OK'
    output = 'Hello World!'
    response_headers = [('Content-type', 'text/plain'),
    ('Content-Length', str(len(output)))]
    start_response(status, response_headers)
    return [output]


此时访问
http://hadoop47/test.wsgi
Not Found
访问
http://hadoop47/test
Hello World!

**参考**

[http://code.google.com/p/modwsgi/wiki/InstallationIssues](http://code.google.com/p/modwsgi/wiki/InstallationIssues)

[https://code.google.com/p/modwsgi/wiki/QuickConfigurationGuide](https://code.google.com/p/modwsgi/wiki/QuickConfigurationGuide)
