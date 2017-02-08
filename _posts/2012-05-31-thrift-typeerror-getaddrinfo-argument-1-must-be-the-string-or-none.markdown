---
author: abloz
comments: true
date: 2012-05-31 09:57:03+00:00
layout: post
link: http://abloz.com/index.php/2012/05/31/thrift-typeerror-getaddrinfo-argument-1-must-be-the-string-or-none/
slug: thrift-typeerror-getaddrinfo-argument-1-must-be-the-string-or-none
title: 'thrift TypeError: getaddrinfo() argument 1 must be string or None'
wordpress_id: 1637
categories:
- 技术
tags:
- python
- thrift
- tutorial
---

thrift tutorial中执行python的PythonServer.py，遇到如下错误：



    
    [zhouhh@Hadoop48 py]$ python PythonServer.py
    Starting the server...
    Traceback (most recent call last):
      File "PythonServer.py", line 95, in <module>
        server.serve()
      File "build/bdist.linux-x86_64/egg/thrift/server/TServer.py", line 74, in serve
      File "build/bdist.linux-x86_64/egg/thrift/transport/TSocket.py", line 136, in listen
      File "build/bdist.linux-x86_64/egg/thrift/transport/TSocket.py", line 31, in _resolveAddr
    TypeError: getaddrinfo() argument 1 must be string or None




我们看一下File "PythonServer.py", line 95，是这句

    
    transport = TSocket.TServerSocket(9090)


我们看TserverSocket源码，[root@Hadoop48 py]# vim build/lib.linux-x86_64-2.7/thrift/transport/TSocket.py

    
    def __init__(self, host=None, port=9090, unix_socket=None):


这是因为其初始化函数，第一个参数是host，第二个参数是port，所以想省去host，只填port是不行的。

将File "PythonServer.py", line 95改为：

    
    transport = TSocket.TServerSocket('localhost',9090)


或者改为：

    
    transport = TSocket.TServerSocket(port=9090)


即可解决该问题。


