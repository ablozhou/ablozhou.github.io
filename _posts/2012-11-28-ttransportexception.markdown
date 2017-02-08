---
author: abloz
comments: true
date: 2012-11-28 10:45:16+00:00
layout: post
link: http://abloz.com/index.php/2012/11/28/ttransportexception/
slug: ttransportexception
title: TTransportException
wordpress_id: 1995
categories:
- 技术
tags:
- hbase
- php
- thrift
---

在用php通过thrift server读取Hbase数据时，出现如下错误：

[Wed Nov 28 18:23:06 2012] [error] [client 192.168.20.81] PHP Fatal error:  Uncaught exception 'TTransportException' with message 'TSocket: timed out reading 4 bytes from 192.168.10.46:9090' in /var/www/html/src/transport/TSocket.php:268nStack trace:n#0 /var/www/html/src/transport/TTransport.php(87): TSocket->read(4)n#1 /var/www/html/src/transport/TBufferedTransport.php(109): TTransport->readAll(4)n#2 /var/www/html/src/protocol/TBinaryProtocol.php(300): TBufferedTransport->readAll(4)n#3 /var/www/html/src/protocol/TBinaryProtocol.php(192): TBinaryProtocol->readI32(NULL)n#4 /var/www/html/src/packages/Hbase/Hbase.php(1765): TBinaryProtocol->readMessageBegin(NULL, 0, 0)n#5 /var/www/html/src/packages/Hbase/Hbase.php(1732): HbaseClient->recv_scannerOpenWithScan()n#6 /var/www/html/hbase_code.php(435): HbaseClient->scannerOpenWithScan('sprdgold', Object(TScan), NULL)n#7 /var/www/html/scanprgold.php(92): scanprgoldfilter('sprdgold', '', '2012-11-25', '2012-11-28', '1001', 1000)n#8 {main}n  thrown in /var/www/html/src/transport/TSocket.php on line 268, referer: http://192.168.10.48/scangamegold.php?startrow=2012-11-25&stoprow;=2012-11-28

但该46:9090端口没有任何问题，系统也很正常。
后面发现是表名sprdgold不存在，所以报了上述错误。因为我中途将数据的表名改了。但php查询的表还是老的。将表名改正后正常。
