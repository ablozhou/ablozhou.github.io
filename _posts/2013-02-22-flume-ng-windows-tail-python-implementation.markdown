---
author: abloz
comments: true
date: 2013-02-22 06:23:46+00:00
layout: post
link: http://abloz.com/index.php/2013/02/22/flume-ng-windows-tail-python-implementation/
slug: flume-ng-windows-tail-python-implementation
title: flume-ng windows tail 的python实现
wordpress_id: 2134
categories:
- 技术
tags:
- flume-ng
- tail
- windows
---

周海汉
2013.2.22
http://abloz.com

flume-ng 不再有tail和tailSrc这两种源，可以用exec源来实现类似的功能。在linux下，只需将exec源的command设为 tail 或tail -F file。但在windows下，如果想要类似功能，就需要自己去实现了。一种替代方案是用spooldir，但这种方式需改名，且不是实时的。

我用python写了一个tail.py, 用于exec source的command，实现了类似tail的功能。但tail的毛病还是得提：一旦出错可能会漏发或重复发送。
本实现的改进方式应该是将已传送的位置写到一个文件中。


    
    
    #author:zhouhh
    #date:2013.2.22
    #http://abloz.com
    import time, os
    import sys
    #Set the filename and open the file for test
    #filename = 'mylog'
    
    def tail_f(file):
      interval = 1.0
    
      while True:
        where = file.tell()
        line = file.readline()
        if not line:
          time.sleep(interval)
          file.seek(where)
        else:
          yield line
    for line in tail_f(open(sys.argv[1])):
      print line,
    



tailsrc.conf

    
    
    #author andy zhou
    #email: ablozhou@gmail.com
    #date:2013.2.20
    #http://abloz.com
    
    #agent name: agent1
    
    #common:
    agent1.sources = userlogsrc
    agent1.channels = memch1
    agent1.sinks = avrosink1
    
    #channels:
    agent1.channels.memch1.type = memory
    agent1.channels.memch1.capacity = 10000
    agent1.channels.memch1.transactionCapactiy = 100
    
    #sources:
    #userlogsrc:
    #agent1.sources.userlogsrc.type = syslogTcp
    agent1.sources.userlogsrc.type = exec
    agent1.sources.userlogsrc.command = D:\apache-flume-1.3.1-bin\bin\tail.bat
    #agent1.sources.userlogsrc.command = C:\Python27\python.exe D:\apache-flume-1.3.1-bin\tail.py E:\mydoc\gamelog\gameht.log
    agent1.sources.userlogsrc.interceptors = i1 i2 i3
    #for %{host}
    agent1.sources.userlogsrc.interceptors.i1.type = org.apache.flume.interceptor.HostInterceptor$Builder
    agent1.sources.userlogsrc.interceptors.i1.preserveExisting = false
    #agent1.sources.userlogsrc.interceptors.i1.hostHeader = hostname
    agent1.sources.userlogsrc.interceptors.i1.useIP = false
    #for %Y%m%d
    agent1.sources.userlogsrc.interceptors.i2.type = org.apache.flume.interceptor.TimestampInterceptor$Builder
    #forstatic header
    agent1.sources.userlogsrc.interceptors.i3.type = static
    agent1.sources.userlogsrc.interceptors.i3.key = datacenter
    agent1.sources.userlogsrc.interceptors.i3.value = userdata
    agent1.sources.userlogsrc.channels = memch1
    
    #sinks:
    agent1.sinks.avrosink1.channel = memch1
    
    agent1.sinks.avrosink1.type = avro
    agent1.sinks.avrosink1.hostname=Hadoop48
    agent1.sinks.avrosink1.port=5140
    agent1.sinks.avrosink1.batch-size=100
    
    
    


tail.bat

    
    
    C:Python27python.exe D:apache-flume-1.3.1-bintail.py e:mydocgameloggameht.log
    


或者直接在conf中配置下面的命令也可：
agent1.sources.userlogsrc.command = C:\Python27\python.exe D:\apache-flume-1.3.1-bin\tail.py E:\mydoc\gamelog\gameht.log

测试中会有一部分内容没有及时发送过去。但随着文件的追加，会被发送。

flume-ng windows 版下载地址：[flume-ng 1.3.1 windows版下载](http://abloz.com/flume/windows_download.html)
