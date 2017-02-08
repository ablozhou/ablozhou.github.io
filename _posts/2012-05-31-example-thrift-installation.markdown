---
author: abloz
comments: true
date: 2012-05-31 10:22:03+00:00
layout: post
link: http://abloz.com/index.php/2012/05/31/example-thrift-installation/
slug: example-thrift-installation
title: thrift 安装测试示例
wordpress_id: 1644
categories:
- 技术
tags:
- python
- thrift
- tutorial
---

http://abloz.com

date:2012.5.31



官方：http://thrift.apache.org/
安装文档：http://thrift.apache.org/docs/install/
下载地址：http://labs.renren.com/apache-mirror/thrift/0.8.0/thrift-0.8.0.tar.gz

    
    [zhouhh@Hadoop48 ~]$ wget http://labs.renren.com/apache-mirror/thrift/0.8.0/thrift-0.8.0.tar.gz
    
    [zhouhh@Hadoop48 ~]$ tar zxvf thrift-0.8.0.tar.gz
    [zhouhh@Hadoop48 ~]$ cd thrift-0.8.0
    [zhouhh@Hadoop48 thrift-0.8.0]$ ./configure
    ...
    thrift 0.8.0
    
    Building code generators ..... :
    
    Building C++ Library ......... : yes
    Building C (GLib) Library .... : no
    Building Java Library ........ : no
    Building C# Library .......... : no
    Building Python Library ...... : yes
    Building Ruby Library ........ : no
    Building Haskell Library ..... : no
    Building Perl Library ........ : no
    Building PHP Library ......... : yes
    Building Erlang Library ...... : no
    Building Go Library .......... : no
    
    Building TZlibTransport ...... : yes
    Building TNonblockingServer .. : no
    
    Using Python ................. : /usr/local/bin/python
    
    Using php-config ............. : /usr/bin/php-config
    
    [zhouhh@Hadoop48 thrift-0.8.0]$ make


centos 可能需要安装其他环境：
[zhouhh@Hadoop48 thrift-0.8.0]$ sudo yum install automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel python-devel ruby-devel
ubuntu 可能需要安装的其他环境：
sudo apt-get install libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev

[zhouhh@Hadoop48 thrift-0.8.0]$ sudo make install

[zhouhh@Hadoop48 ~]$ mkdir test
[zhouhh@Hadoop48 ~]$ cd test

教程地址：
http://svn.apache.org/repos/asf/thrift/trunk/tutorial/
下载文件：

    
    http://svn.apache.org/repos/asf/thrift/trunk/tutorial/tutorial.thrift
    http://svn.apache.org/repos/asf/thrift/trunk/tutorial/shared.thrift
    [zhouhh@Hadoop48 test]$ wget http://svn.apache.org/repos/asf/thrift/trunk/tutorial/tutorial.thrift
    
    [zhouhh@Hadoop48 test]$ wget http://svn.apache.org/repos/asf/thrift/trunk/tutorial/shared.thrift
    
    [zhouhh@Hadoop48 test]$ thrift -r --gen py tutorial.thrift
    [FAILURE:/home/zhouhh/test/shared.thrift:26] No generator named 'd' could be found!


会编译失败，需将D语言的namespace注释掉：

    
    [zhouhh@Hadoop48 test]$ vi tutorial.thrift
    #namespace d tutorial
    [zhouhh@Hadoop48 test]$ vi shared.thrift +26
    #namespace d share
    
    [zhouhh@Hadoop48 test]$ thrift -r --gen py tutorial.thrift
    [zhouhh@Hadoop48 test]$ ls
    gen-py shared.thrift tutorial.thrift


下载python测试程序

    
    [zhouhh@Hadoop48 py]$ wget http://svn.apache.org/repos/asf/thrift/trunk/tutorial/py/PythonClient.py
    [zhouhh@Hadoop48 py]$ wget http://svn.apache.org/repos/asf/thrift/trunk/tutorial/py/PythonServer.py
    
    [zhouhh@Hadoop48 py]$ python PythonServer.py
    Traceback (most recent call last):
    File "PythonServer.py", line 25, in <module>
    from tutorial import Calculator
    File "../gen-py/tutorial/Calculator.py", line 9, in <module>
    from thrift.Thrift import TType, TMessageType, TException
    ImportError: No module named thrift.Thrift


或者直接到源码里面也自带教程：

    
    [zhouhh@Hadoop48 thrift-0.8.0]$ cd tutorial/
    [zhouhh@Hadoop48 tutorial]$ ls
    cpp csharp erl go hs java js perl php py py.twisted rb README shared.thrift tutorial.thrift
    [zhouhh@Hadoop48 tutorial]$ cd py
    [zhouhh@Hadoop48 py]$ ls
    PythonClient.py PythonServer.py
    [zhouhh@Hadoop48 tutorial]$ thrift -r --gen py tutorial.thrift
    
    [zhouhh@Hadoop48 py]$ pwd
    /home/zhouhh/thrift-0.8.0/lib/py
    [zhouhh@Hadoop48 py]$ python setup.py --help
    [zhouhh@Hadoop48 py]$ python setup.py build
    [zhouhh@Hadoop48 py]$ sudo python setup.py install
    
    [zhouhh@Hadoop48 py]$ pwd
    /home/zhouhh/thrift-0.8.0/tutorial/py
    
    [zhouhh@Hadoop48 py]$ python PythonServer.py
    Starting the server...
    Traceback (most recent call last):
    File "PythonServer.py", line 95, in <module>
    server.serve()
    File "build/bdist.linux-x86_64/egg/thrift/server/TServer.py", line 74, in serve
    File "build/bdist.linux-x86_64/egg/thrift/transport/TSocket.py", line 136, in listen
    File "build/bdist.linux-x86_64/egg/thrift/transport/TSocket.py", line 31, in _resolveAddr
    TypeError: getaddrinfo() argument 1 must be string or None
    
    [zhouhh@Hadoop48 py]$ vi PythonServer.py


第84行，
transport = TSocket.TServerSocket(9090)
改为：
transport = TSocket.TServerSocket(port = 9090)

参考我[另一篇文档](http://abloz.com/2012/05/31/thrift-typeerror-getaddrinfo-argument-1-must-be-the-string-or-none.html)，如何处理此错误： http://abloz.com/2012/05/31/thrift-typeerror-getaddrinfo-argument-1-must-be-the-string-or-none.html

    
    [zhouhh@Hadoop48 py]$ python PythonServer.py
    Starting the server...
    Traceback (most recent call last):
    File "PythonServer.py", line 95, in <module>
    server.serve()
    File "build/bdist.linux-x86_64/egg/thrift/server/TServer.py", line 74, in serve
    File "build/bdist.linux-x86_64/egg/thrift/transport/TSocket.py", line 156, in listen
    File "/usr/local/lib/python2.7/socket.py", line 224, in meth
    return getattr(self._sock,name)(*args)
    socket.error: [Errno 98] Address already in use
    [zhouhh@Hadoop48 py]$ sudo netstat -antp | grep 9090
    tcp 0 0 0.0.0.0:9090 0.0.0.0:* LISTEN 11369/java
    
    [zhouhh@Hadoop48 py]$ python PythonServer.py
    Starting the server...
    Traceback (most recent call last):
    File "PythonServer.py", line 95, in <module>
    server.serve()
    File "build/bdist.linux-x86_64/egg/thrift/server/TServer.py", line 74, in serve
    File "build/bdist.linux-x86_64/egg/thrift/transport/TSocket.py", line 156, in listen
    File "/usr/local/lib/python2.7/socket.py", line 226, in meth
    return getattr(self._sock,name)(*args)
    socket.error: [Errno 98] Address already in use
    
    [zhouhh@Hadoop48 py]$ vi PythonClient.py +36


修改
transport = TSocket.TServerSocket(9090)
为
transport = TSocket.TServerSocket('localhost',19090)
或
transport = TSocket.TServerSocket(port=9090)

[zhouhh@Hadoop48 py]$ python PythonServer.py
Starting the server...

[zhouhh@Hadoop48 py]$ python PythonClient.py
ping()
1+1=2
InvalidOperation: InvalidOperation(what=4, why='Cannot divide by 0')
15-10=5
Check log: 5

server打印：

    
    [zhouhh@Hadoop48 py]$ python PythonServer.py
    Starting the server...
    ping()
    add(1,1)
    calculate(1, Work(comment=None, num1=1, num2=0, op=4))
    calculate(1, Work(comment=None, num1=15, num2=10, op=2))
    getStruct(1)
