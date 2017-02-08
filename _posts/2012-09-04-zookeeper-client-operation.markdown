---
author: abloz
comments: true
date: 2012-09-04 10:34:01+00:00
layout: post
link: http://abloz.com/index.php/2012/09/04/zookeeper-client-operation/
slug: zookeeper-client-operation
title: zookeeper client操作
wordpress_id: 1845
categories:
- 技术
tags:
- hbase
- zkcli
- zookeeper
---

周海汉/文
2012.9.4

独立的zookeeper 自带zkCli.sh，可以执行后查询zookeeper节点。
但在和HBase一起发布的zookeeper，没有带相应的独立shell文件。zookeeper配置也融合到hbase-site.xml中了。
如果想操作命令行shell，可以用hbase zkcli这样的命令。

**命令行操作**

    
    
    [zhouhh@h185 bin]$ hbase zkcli -server h185:22228
    Connecting to h185:22228
    12/09/04 18:16:00 INFO zookeeper.ZooKeeper: Client environment:zookeeper.version=3.4.3-1240972, built on 02/06/2012 10:48 GMT
    12/09/04 18:16:00 INFO zookeeper.ZooKeeper: Client environment:host.name=h185
    12/09/04 18:16:00 INFO zookeeper.ZooKeeper: Client environment:java.version=1.7.0
    12/09/04 18:16:00 INFO zookeeper.ZooKeeper: Client environment:java.vendor=Oracle Corporation
    12/09/04 18:16:00 INFO zookeeper.ZooKeeper: Client environment:java.home=/usr/java/jdk1.7.0/jre
    ...
    12/09/04 18:16:00 INFO zookeeper.ClientCnxn: Opening socket connection to server /192.168.10.185:22228
    Welcome to ZooKeeper!
    12/09/04 18:16:00 INFO client.ZooKeeperSaslClient: Client will not SASL-authenticate because the default JAAS configuration section 'Client' could not be found. If you are not using SASL, you may ignore this. On the other hand, if you expected SASL to work, please fix your JAAS configuration.
    12/09/04 18:16:00 INFO zookeeper.ClientCnxn: Socket connection established to h185/192.168.10.185:22228, initiating session
    JLine support is enabled
    [zk: h185:22228(CONNECTING) 0] 12/09/04 18:16:00 INFO zookeeper.ClientCnxn: Session establishment complete on server h185/192.168.10.185:22228, sessionid = 0x398b2ce06a00b6, negotiated timeout = 30000
    
    WATCHER::
    
    WatchedEvent state:SyncConnected type:None path:null
    
    [zk: h185:22228(CONNECTED) 1] ls /
    [hbase, zookeeper]
    [zk: h185:22228(CONNECTED) 2] ls /hbase
    [splitlog, unassigned, root-region-server, rs, backup-masters, draining, table, master, shutdown, hbaseid]
    [zk: h185:22228(CONNECTED) 3] ls zookeeper
    Command failed: java.lang.IllegalArgumentException: Path must start with / character
    [zk: h185:22228(CONNECTED) 4] ls /zookeeper
    [quota]
    [zk: h185:22228(CONNECTED) 5] ls /zookeeper/quota
    []
    [zk: h185:22228(CONNECTED) 6] ls /hbase/master
    []
    [zk: h185:22228(CONNECTED) 7] ls /hbase/hbaseid
    []
    [zk: h185:22228(CONNECTED) 9] get /hbase/hbaseid
    �      7041@h185de3056fa-1bdd-4d01-bea2-22f141c7ff68
    cZxid = 0x10000000b
    ctime = Mon Aug 13 13:49:16 CST 2012
    mZxid = 0xb00000008
    mtime = Mon Sep 03 16:08:37 CST 2012
    pZxid = 0x10000000b
    cversion = 0
    dataVersion = 12
    aclVersion = 0
    ephemeralOwner = 0x0
    dataLength = 50
    numChildren = 0
    
    [zk: h185:22228(CONNECTED) 16] a
    ZooKeeper -server host:port cmd args
            connect host:port
            get path [watch]
            ls path [watch]
            set path data [version]
            rmr path
            delquota [-n|-b] path
            quit
            printwatches on|off
            create [-s] [-e] path data acl
            stat path [watch]
            close
            ls2 path [watch]
            history
            listquota path
            setAcl path acl
            getAcl path
            sync path
            redo cmdno
            addauth scheme auth
            delete path [version]
            setquota -n|-b val path
    
    [zk: h185:22228(CONNECTED) 20] ls /hbase/rs
    [h183,61020,1346670998964, h181,61020,1346659787960, h184,61020,1346659711119, h182,61020,1346659775558]
    
    [zk: h185:22228(CONNECTED) 26] ls /hbase/table
    [toplist_user_index_a_ios_total_2012-08-14_24,...]
    
    


具体用法，在[《HBase官方文档》12.4工具](http://abloz.com/hbase/book.html#trouble.tools)一节有说明。一些老的文档，直接在hbase的shell里面执行zk命令，已经过时了。
22228端口，是hbase-site.xml中hbase.zookeeper.property.clientPort配置的，缺省2181端口。

**创建和删除一个znode**

    
    
    [zk: h185:22228(CONNECTED) 49] create /zk mydata
    Created /zk
    [zk: h185:22228(CONNECTED) 50] ls /zk
    []
    [zk: h185:22228(CONNECTED) 51] get /zk
    mydata
    cZxid = 0xb00c13cd2
    ctime = Tue Sep 04 18:43:27 CST 2012
    mZxid = 0xb00c13cd2
    mtime = Tue Sep 04 18:43:27 CST 2012
    pZxid = 0xb00c13cd2
    cversion = 0
    dataVersion = 0
    aclVersion = 0
    ephemeralOwner = 0x0
    dataLength = 6
    numChildren = 0
    [zk: h185:22228(CONNECTED) 52] ls2 /zk
    []
    cZxid = 0xb00c13cd2
    ctime = Tue Sep 04 18:43:27 CST 2012
    mZxid = 0xb00c13cd2
    mtime = Tue Sep 04 18:43:27 CST 2012
    pZxid = 0xb00c13cd2
    cversion = 0
    dataVersion = 0
    aclVersion = 0
    ephemeralOwner = 0x0
    dataLength = 6
    numChildren = 0
    [zk: h185:22228(CONNECTED) 53] rmr /zk
    [zk: h185:22228(CONNECTED) 54] ls /
    [hbase, zookeeper]
    
    



另外，可以通过nc或telnet命令发送到客户端。


    
    
    [zhouhh@h184 zk]$ echo stat | nc h185 22228
    Zookeeper version: 3.4.3-1240972, built on 02/06/2012 10:48 GMT
    Clients:
     /192.168.10.184:58120[1](queued=0,recved=9300594,sent=9300604)
     /192.168.10.185:45027[1](queued=2,recved=30329742,sent=39627384)
     /192.168.10.184:35598[0](queued=0,recved=1,sent=0)
     /192.168.10.185:45031[1](queued=0,recved=1734,sent=1736)
     /192.168.10.185:50430[1](queued=0,recved=154,sent=154)
     /192.168.10.181:43237[1](queued=0,recved=1429799,sent=1429811)
     /192.168.10.182:57454[1](queued=4,recved=13751816,sent=13751824)
     /192.168.10.183:39127[1](queued=0,recved=68432,sent=68432)
    
    Latency min/avg/max: 0/13/1289
    Received: 54884167
    Sent: 64181843
    Outstanding: 7
    Zxid: 0xb00c0a138
    Mode: follower
    Node count: 2140
    
    [zhouhh@h184 zk]$ echo stat | nc h184 22228
    Zookeeper version: 3.4.3-1240972, built on 02/06/2012 10:48 GMT
    Clients:
     /192.168.10.184:36874[1](queued=0,recved=1599,sent=1599)
     /192.168.10.184:42575[0](queued=0,recved=1,sent=0)
    
    Latency min/avg/max: 0/18/318
    Received: 3083
    Sent: 3082
    Outstanding: 0
    Zxid: 0xb00c0ac92
    Mode: leader
    Node count: 2140
    
    [zhouhh@h184 zk]$ echo ruok | nc h184 22228
    imok
    
    


ruok意思是are you ok？
另外还有envi查看环境，srst重置服务统计信息，从运行zookeeper的服务器发送kill命令关闭zookeeper服务。

可以配置zookeeper JMX支持，了解更多的四字母命令。


**参考**：
http://abloz.com/hbase/book.html#trouble.tools
http://zookeeper.apache.org/
