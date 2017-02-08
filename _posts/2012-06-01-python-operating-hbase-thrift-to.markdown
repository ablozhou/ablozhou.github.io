---
author: abloz
comments: true
date: 2012-06-01 10:56:00+00:00
layout: post
link: http://abloz.com/index.php/2012/06/01/python-operating-hbase-thrift-to/
slug: python-operating-hbase-thrift-to
title: python通过thrift来操作hbase
wordpress_id: 1666
categories:
- 技术
tags:
- hbase
- python
- thrift
---

http://abloz.com

date:2012.6.1


## 引言


hbase用java来操作是最方便，也效率最高的方式。但java并非轻量级，不方便在任何环境下调试。而且不同的开发人员熟悉的语言不一样，开发效率也不一样。hbase 通过thrift，还可以用python,ruby,cpp,perl等语言来操作。

thrift是facebook开发开源的类似google的protobuf的远程调用组件。但protobuf只有数据的序列化，且只支持二进制协议，没有远程调用部分。protobuf原生支持cpp,python,java,另外还有第三方实现的objectc，ruby等语言。而thrift是实现了序列化，传输，协议定义，远程调用等功能，跨语言能力更多。某些方面二者可以互相替代，但一些方面则各有适用范围。




## 启动thrift服务器


首先可以将hbase的path添加到.bashrc，这样便于在在任何目录执行hbase命令。



    
    启动thrift server，默认侦听9090端口，如果有冲突，可以用-p参数修改默认端口。
     hbase thrift -p 19090 start
     [zhouhh@Hadoop48 hbase-0.94.0]$ hbase thrift -p 19090 start
     12/06/01 17:54:27 INFO util.VersionInfo: HBase 0.94.0
     12/06/01 17:54:27 INFO util.VersionInfo: Subversion https://svn.apache.org/repos/asf/hbase/branches/0.94 -r 1332822
     12/06/01 17:54:27 INFO util.VersionInfo: Compiled by jenkins on Tue May 1 21:43:54 UTC 2012
     Exception in thread "main" java.lang.AssertionError: Exactly one option out of [-hsha, -nonblocking, -threadpool, -threadedselector] has to be specified
     at org.apache.hadoop.hbase.thrift.ThriftServerRunner$ImplType.setServerImpl(ThriftServerRunner.java:201)
     at org.apache.hadoop.hbase.thrift.ThriftServer.processOptions(ThriftServer.java:169)
     at org.apache.hadoop.hbase.thrift.ThriftServer.doMain(ThriftServer.java:85)
     at org.apache.hadoop.hbase.thrift.ThriftServer.main(ThriftServer.java:192)



    
    [zhouhh@Hadoop48 hbase-0.94.0]$ hbase thrift -p 19090 -nonblocking start
     ...
     12/06/01 17:25:38 INFO thrift.ThriftServerRunner: starting HBase TNonblockingServer server on 19090
     [zhouhh@Hadoop48 hbase-0.94.0]$ hbase thrift -p 19090 -hsha start
     12/06/01 17:55:27 DEBUG thrift.ThriftServerRunner: Using binary protocol
     12/06/01 17:55:27 DEBUG thrift.ThriftServerRunner: Using framed transport
     12/06/01 17:55:27 INFO thrift.ThriftServerRunner: starting HBase THsHaServer server on 19090





## 处理Hbase.thrift


编译hbase自带的Hbase.thrift，生成python语言的调用代码

    
    [zhouhh@Hadoop48 hbase-0.94.0]$ cd src/main/resources/org/apache/hadoop/hbase/thrift/
     [zhouhh@Hadoop48 thrift]$ ls
     Hbase.thrift
     [zhouhh@Hadoop48 thrift]$ thrift --gen py Hbase.thrift
     [zhouhh@Hadoop48 thrift]$ ls
     gen-py Hbase.thrift



    
    [zhouhh@Hadoop48 thrift]$ sudo mv gen-py /usr/local/lib/python2.7/site-packages/








## 查看现有hbase表



    
    [zhouhh@Hadoop48 test]$ hbase shell
     hbase(main):003:0> list
     t1
     1 row(s) in 0.5320 seconds





## 写客户端测试代码



    
    [zhouhh@Hadoop48 test]$ vi t.py
     #!/usr/bin/env python
     #coding:utf8
     #author:abloz.com
     #date:2012.6.1
     import sys
     #Hbase.thrift生成的py文件放在这里
     sys.path.append('/usr/local/lib/python2.7/site-packages/gen-py')
     from thrift import Thrift
     from thrift.transport import TSocket
     from thrift.transport import TTransport
     from thrift.protocol import TBinaryProtocol



    
    from hbase import Hbase
     #如ColumnDescriptor 等在hbase.ttypes中定义
     from hbase.ttypes import *



    
    # Make socket
     #此处可以修改地址和端口
     transport = TSocket.TSocket('localhost', 19090)
     # Buffering is critical. Raw sockets are very slow
     # 还可以用TFramedTransport,也是高效传输方式
     transport = TTransport.TBufferedTransport(transport)
     # Wrap in a protocol
     #传输协议和传输过程是分离的，可以支持多协议
     protocol = TBinaryProtocol.TBinaryProtocol(transport)
     #客户端代表一个用户
     client = Hbase.Client(protocol)
     #打开连接
     transport.open()



    
    print client.getTableNames()




## 执行



    
    [zhouhh@Hadoop48 test]$ python t.py
     Traceback (most recent call last):
     File "t.py", line 27, in <module>
     print client.getTableNames()
     File "/usr/local/lib/python2.7/site-packages/gen-py/hbase/Hbase.py", line 769, in getTableNames
     return self.recv_getTableNames()
     File "/usr/local/lib/python2.7/site-packages/gen-py/hbase/Hbase.py", line 779, in recv_getTableNames
     (fname, mtype, rseqid) = self._iprot.readMessageBegin()
     File "build/bdist.linux-x86_64/egg/thrift/protocol/TBinaryProtocol.py", line 126, in readMessageBegin
     File "build/bdist.linux-x86_64/egg/thrift/protocol/TBinaryProtocol.py", line 203, in readI32
     File "build/bdist.linux-x86_64/egg/thrift/transport/TTransport.py", line 58, in readAll
     File "build/bdist.linux-x86_64/egg/thrift/transport/TTransport.py", line 160, in read
     File "build/bdist.linux-x86_64/egg/thrift/transport/TSocket.py", line 94, in read
     socket.error: [Errno 104] Connection reset by peer



    
    server 打印：
     12/06/01 17:55:40 ERROR server.THsHaServer: Read an invalid frame size of -2147418111. Are you using TFramedTransport on the client side?
     要想提高传输效率，必须使用TFramedTransport或TBufferedTransport.但对-hsha，-nonblocking两种服务器模式，必须使用TFramedTransport。将其改为线程方式试试。
     [zhouhh@Hadoop48 hbase-0.94.0]$ hbase thrift -p 19090 -threadpool start
     ...
     12/06/01 18:02:17 DEBUG thrift.ThriftServerRunner: Using binary protocol
     12/06/01 18:02:17 INFO thrift.ThriftServerRunner: starting TBoundedThreadPoolServer on /0.0.0.0:19090; min worker threads=16, max worker threads=1000, max queued requests=1000


[zhouhh@Hadoop48 test]$ python t.py
['t1']
打印正确


## 创建表：



    
     查看HBase.thrift中关于创建表的描述：
     /**
     * Create a table with the specified column families. The name
     * field for each ColumnDescriptor must be set and must end in a
     * colon (:). All other fields are optional and will get default
     * values if not explicitly specified.
     *
     * @throws IllegalArgument if an input parameter is invalid
     *
     * @throws AlreadyExists if the table name already exists
     */
     void createTable(
     /** name of table to create */
     1:Text tableName,



    
    /** list of column family descriptors */
     2:list<ColumnDescriptor> columnFamilies
     ) throws (1:IOError io, 2:IllegalArgument ia, 3:AlreadyExists exist)



    
    列描述符的描述：
     /**
     * An HColumnDescriptor contains information about a column family
     * such as the number of versions, compression settings, etc. It is
     * used as input when creating a table or adding a column.
     */
     struct ColumnDescriptor {
     1:Text name,
     2:i32 maxVersions = 3,
     3:string compression = "NONE",
     4:bool inMemory = 0,
     5:string bloomFilterType = "NONE",
     6:i32 bloomFilterVectorSize = 0,
     7:i32 bloomFilterNbHashes = 0,
     8:bool blockCacheEnabled = 0,
     9:i32 timeToLive = -1
     }


追加代码

    
    #创建测试表，用户信息表。每个列名都必须跟":"
    try:
        colusername = ColumnDescriptor( name = 'username:',maxVersions = 1 )
        colpass = ColumnDescriptor( name = 'pass:',maxVersions = 1 )
        colage = ColumnDescriptor( name = 'age:',maxVersions = 1 )
        colinfo = ColumnDescriptor( name = 'info:',maxVersions = 1 )
    
        client.createTable('tusers', [colusername,colpass,colage,colinfo])
    
        print client.getTableNames()
    
    except AlreadyExists, tx:
        print "Thrift exception"
        print '%s' % (tx.message)



    
    执行：
     [zhouhh@Hadoop48 test]$ python t.py
     ['t1']
     ['t1', 'tusers']
     [zhouhh@Hadoop48 test]$ python t.py
     ['t1', 'tusers']
     Thrift exception
     table name already in use




## 参考


[http://yannramin.com/2008/07/19/using-facebook-thrift-with-python-and-hbase/](http://yannramin.com/2008/07/19/using-facebook-thrift-with-python-and-hbase/)

[http://smallboby.iteye.com/blog/1526865](http://smallboby.iteye.com/blog/1526865)
