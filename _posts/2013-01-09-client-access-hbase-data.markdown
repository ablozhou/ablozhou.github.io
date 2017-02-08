---
author: abloz
comments: true
date: 2013-01-09 12:00:09+00:00
layout: post
link: http://abloz.com/index.php/2013/01/09/client-access-hbase-data/
slug: client-access-hbase-data
title: Client访问HBase数据的过程
wordpress_id: 2069
categories:
- 技术
tags:
- hbase
---

周海汉

2013.1.9

http://abloz.com



client访问HBase数据前，先要到Zookeeper查找hmaster的地址和-ROOT-表的region保存在哪里。

[zk: h47:2181(CONNECTED) 2] ls /
[hbase, zookeeper]

[zk: h47:2181(CONNECTED) 28] ls /hbase
[splitlog, unassigned, root-region-server, backup-masters, rs, draining, table, master, shutdown, hbaseid]

**-ROOT-表的region信息**

[zk: h47:2181(CONNECTED) 27] get /hbase/root-region-server
2735@h47h47,60020,1355830061153
cZxid = 0x4100000013
ctime = Tue Dec 18 19:28:05 CST 2012
mZxid = 0x4100000013
mtime = Tue Dec 18 19:28:05 CST 2012
pZxid = 0x4100000013
cversion = 0
dataVersion = 0
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 36
numChildren = 0

**HMaster地址**

[zk: h47:2181(CONNECTED) 1] get /hbase/master
� 16844@h46h46,60000,1355830059469
cZxid = 0x4100000002
ctime = Tue Dec 18 19:27:39 CST 2012
mZxid = 0x4100000002
mtime = Tue Dec 18 19:27:39 CST 2012
pZxid = 0x4100000002
cversion = 0
dataVersion = 0
aclVersion = 0
ephemeralOwner = 0x13badc4e12c0000
dataLength = 39
numChildren = 0

[zk: h47:2181(CONNECTED) 35] get /hbase/table/-ROOT-
� 32049@h46ENABLED
cZxid = 0x320000000a
ctime = Tue Dec 18 03:27:21 CST 2012
mZxid = 0x320000000b
mtime = Tue Dec 18 03:27:21 CST 2012
pZxid = 0x320000000a
cversion = 0
dataVersion = 1
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 21
numChildren = 0

[zk: h47:2181(CONNECTED) 38] get /hbase/shutdown
� 16844@h46Tue Dec 18 19:28:00 CST 2012
cZxid = 0x4100000008
ctime = Tue Dec 18 19:28:00 CST 2012
mZxid = 0x4100000008
mtime = Tue Dec 18 19:28:00 CST 2012
pZxid = 0x4100000008
cversion = 0
dataVersion = 0
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 42
numChildren = 0
[zk: h47:2181(CONNECTED) 39] get /hbase/hbaseid
� 16844@h46d6d43b67-1425-4e2d-a9e7-c32b6836941e
cZxid = 0x10000000b
ctime = Thu Sep 27 11:57:24 CST 2012
mZxid = 0x4100000006
mtime = Tue Dec 18 19:28:00 CST 2012
pZxid = 0x10000000b
cversion = 0
dataVersion = 60
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 50
numChildren = 0


