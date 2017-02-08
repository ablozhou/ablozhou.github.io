---
author: abloz
comments: true
date: 2012-08-14 11:02:08+00:00
layout: post
link: http://abloz.com/index.php/2012/08/14/another-method-of-the-data-of-the-hbase-cross-cluster-replication/
slug: another-method-of-the-data-of-the-hbase-cross-cluster-replication
title: HBase跨集群复制数据的另一种方法
wordpress_id: 1808
categories:
- 技术
tags:
- hadoop
- hbase
- 备份
---

http://abloz.com
date:2012.8.14

上一篇文章《[hbase 复制备份数据](http://abloz.com/2012/06/19/hbase-copy-the-backup-data.html)》 中提到用工具CopyTable来在集群间复制数据。另外还有一种更暴力的方式，来共享HBase备份表。因为有时候两个集群并不连通。



# 一、从源hbase集群中复制出HBase数据库表到本地目录


最好停止HBase，否则可能会丢部分数据

    
    
    [hbase@hadoop200 ~]$ hadoop fs -get /hbase/toplist_ware_total_1009_201232 toplist_ware_total_1009_201232
    


压缩

    
    
    [hbase@hadoop200 ~]$ tar zcvf topl.tar.gz toplist_ware_total_1009_201232
    


远程复制到目标机器

    
    
    [hbase@hadoop200 ~]$ scp topl.tar.gz zhouhh@h185:~/.
    





# 二、目标HBase导入


解压
[zhouhh@h185 ~]$ tar zxvf topl.tar.gz

如果目标HBase里有这个表，需disable并drop掉。如果有该目录，则用hadoop fs -rmr /hbase/table的方式删除，再往HDFS上复制。以免数据出错。

放到集群下面

    
    
    [zhouhh@h185 ~]$ fs -put toplist_ware_total_1009_201232 /hbase
    [zhouhh@h185 ~]$
    



此时可以list出来，但scan报错

    
    
    hbase(main):055:0> list 'toplist_ware_total_1009_201232'
    TABLE
    toplist_ware_total_1009_201232
    1 row(s) in 0.0220 seconds
    
    hbase(main):062:0> scan 'toplist_ware_total_1009_201232'
    ROW                                        COLUMN+CELL
    
    ERROR: Unknown table toplist_ware_total_1009_201232!
    


.META.表里面没有相关记录
hbase(main):064:0> scan '.META.'
里面没有toplist_ware_total_1009_201232 开头的行




# 三、修复.META.表和重新分配数据到各RegionServer



在.META.表没修复时执行重新分配，会报错

    
    
    [zhouhh@h185 ~]$ hbase hbck -fixAssignments
    ...
    ERROR: Region { meta => null, hdfs => hdfs://h185:54310/hbase/toplist_ware_total_1009_201232/0403552001eb2a31990e443dcae74ee8, deployed =>  } on HDFS, but not listed in META or deployed on any region server
    ...
    



先修复.META.表

    
    
    [zhouhh@h185 ~]$ hbase hbck -fixMeta
    ...
    ERROR: Region { meta => null, hdfs => hdfs://h185:54310/hbase/toplist_ware_total_1009_201232/0403552001eb2a31990e443dcae74ee8, deployed =>  } on HDFS, but not listed in META or deployed on any region server
    12/08/14 18:25:15 INFO util.HBaseFsck: Patching .META. with .regioninfo: {NAME => 'toplist_ware_total_1009_201232,,1344187094829.0403552001eb2a31990e443dcae74ee8.', STARTKEY => '', ENDKEY => '', ENCODED => 0403552001eb2a31990e443dcae74ee8,}
    ...
    
    此时.META.表已经有表的数据了，但scan还是失败
    hbase(main):065:0> scan '.META.'
    ROW                                        COLUMN+CELL
    ...
    toplist_ware_total_1009_201232,,134418709 column=info:regioninfo, timestamp=1344939930752, value={NAME => 'toplist_ware_total_1009_201232,,1344187094829.0403552001eb
     4829.0403552001eb2a31990e443dcae74ee8.    2a31990e443dcae74ee8.', STARTKEY => '', ENDKEY => '', ENCODED => 0403552001eb2a31990e443dcae74ee8,}
    16 row(s) in 0.0550 seconds
    
    scan还是失败
    hbase(main):066:0> scan 'toplist_ware_total_1009_201232'
    ROW                                        COLUMN+CELL
    
    ERROR: org.apache.hadoop.hbase.client.NoServerForRegionException: No server address listed in .META. for region toplist_ware_total_1009_201232,,1344187094829.0403552001eb2a31990e443dcae74ee8. containing row
    



重新分配到各分区服务器

    
    
    [zhouhh@h185 ~]$ hbase hbck -fixAssignments
    ...
    ERROR: Region { meta => toplist_ware_total_1009_201232,,1344187094829.0403552001eb2a31990e443dcae74ee8., hdfs => hdfs://h185:54310/hbase/toplist_ware_total_1009_201232/0403552001eb2a31990e443dcae74ee8, deployed =>  } not deployed on any region server.
    Trying to fix unassigned region...
    12/08/14 18:28:01 INFO util.HBaseFsckRepair: Region still in transition, waiting for it to become assigned: {NAME => 'toplist_ware_total_1009_201232,,1344187094829.0403552001eb2a31990e443dcae74ee8.', STARTKEY => '', ENDKEY => '', ENCODED => 0403552001eb2a31990e443dcae74ee8,}
    12/08/14 18:28:02 INFO util.HBaseFsckRepair: Region still in transition, waiting for it to become assigned: {NAME => 'toplist_ware_total_1009_201232,,1344187094829.0403552001eb2a31990e443dcae74ee8.', STARTKEY => '', ENDKEY => '', ENCODED => 0403552001eb2a31990e443dcae74ee8,}
    12/08/14 18:28:04 INFO util.HBaseFsckRepair: Region still in transition, waiting for it to become assigned: {NAME => 'toplist_ware_total_1009_201232,,1344187094829.0403552001eb2a31990e443dcae74ee8.', STARTKEY => '', ENDKEY => '', ENCODED => 0403552001eb2a31990e443dcae74ee8,}
    12/08/14 18:28:05 INFO util.HBaseFsckRepair: Region still in transition, waiting for it to become assigned: {NAME => 'toplist_ware_total_1009_201232,,1344187094829.0403552001eb2a31990e443dcae74ee8.', STARTKEY => '', ENDKEY => '', ENCODED => 0403552001eb2a31990e443dcae74ee8,}
    ...
    



scan成功!

    
    
    hbase(main):067:0> scan 'toplist_ware_total_1009_201232'
    ROW                                        COLUMN+CELL
     0000000001                                column=info:loginid, timestamp=1344187147972, value=jjm167258611
     0000000001                                column=info:nick, timestamp=1344187147972, value=?xE9x97xB4?xE6xB5xA3?
     0000000001                                column=info:score, timestamp=1344187147972, value=200
     0000000001                                column=info:userid, timestamp=1344187147972, value=167258611
    ...
    330 row(s) in 0.8630 seconds
    


如果目标集群是空的，则可以直接将源HBase的/hbase目录复制出来，然后在目标HBase系统上fs -rmr /hbase  或fs -mv /hbase /hbase1
然后用hadoop fs -put hbase / 即可
