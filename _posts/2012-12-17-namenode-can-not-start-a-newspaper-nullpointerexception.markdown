---
author: abloz
comments: true
date: 2012-12-17 11:11:11+00:00
layout: post
link: http://abloz.com/index.php/2012/12/17/namenode-can-not-start-a-newspaper-nullpointerexception/
slug: namenode-can-not-start-a-newspaper-nullpointerexception
title: NameNode不能启动报 NullPointerException
wordpress_id: 2012
categories:
- 技术
tags:
- hadoop
- hbase
---

hadoop 1.02，hbase 0.92.系统所有node改了ip地址后，second name node过了一段时间退出，报如下错误：

    
    
    2012-12-17 17:09:05,646 ERROR org.apache.hadoop.hdfs.server.namenode.NameNode: java.lang.NullPointerException
            at org.apache.hadoop.hdfs.server.namenode.FSDirectory.addChild(FSDirectory.java:1094)
            at org.apache.hadoop.hdfs.server.namenode.FSDirectory.addChild(FSDirectory.java:1106)
            at org.apache.hadoop.hdfs.server.namenode.FSDirectory.addNode(FSDirectory.java:1009)
            at org.apache.hadoop.hdfs.server.namenode.FSDirectory.unprotectedAddFile(FSDirectory.java:208)
            at org.apache.hadoop.hdfs.server.namenode.FSEditLog.loadFSEdits(FSEditLog.java:626)
            at org.apache.hadoop.hdfs.server.namenode.FSImage.loadFSEdits(FSImage.java:1015)
            at org.apache.hadoop.hdfs.server.namenode.FSImage.loadFSImage(FSImage.java:833)
            at org.apache.hadoop.hdfs.server.namenode.FSImage.recoverTransitionRead(FSImage.java:372)
            at org.apache.hadoop.hdfs.server.namenode.FSDirectory.loadFSImage(FSDirectory.java:100)
            at org.apache.hadoop.hdfs.server.namenode.FSNamesystem.initialize(FSNamesystem.java:388)
            at org.apache.hadoop.hdfs.server.namenode.FSNamesystem.<init>(FSNamesystem.java:362)
            at org.apache.hadoop.hdfs.server.namenode.NameNode.initialize(NameNode.java:276)
            at org.apache.hadoop.hdfs.server.namenode.NameNode.<init>(NameNode.java:496)
            at org.apache.hadoop.hdfs.server.namenode.NameNode.createNameNode(NameNode.java:1279)
            at org.apache.hadoop.hdfs.server.namenode.NameNode.main(NameNode.java:1288)
    


可能的原因，是edits文件损坏。我们做了网络系统的备份，但备份文件和现有文件一模一样，也损坏了。
停止所有进程后，重启，结果name node启动失败，报同样错误。
[hbase@h46 ~]$ hadoop fsck /
The filesystem under path '/' is CORRUPT

[网上有人想了3种解决办法](http://lucene.472066.n3.nabble.com/NullPointerException-on-namenode-startup-td3983799.html)：

    
    
    1. Use the checkpoint and revert to May 4th
    2. Manually repair the "edits" or "edits.new" file
    3. Temporarily edit the Hadoop code
    修改hadoop源码 FSEditLog.java:626边上的代码，加上try catch,系统起来后再改回去。
       INodeFile node = null;
       try {
           node = (INodeFile)fsDir.unprotectedAddFile(path, permissions,
    blocks, replication, mtime, atime, blockSize);
       }
       catch (NullPointerException e) {
       }
    



我用的是第二种方法，删除edits.new,在edits文件中输入16进制内容0xffffffeeff
用python写入该二进制文件

    
    
    import binascii
    f=open("edits","wb")
    d="ffffffeeff"
    hb=binascii.a2b_hex(d)
    f.write(hb)
    f.close()
    


将原namenode current目录备份后，用该edits文件替换原来的edits。
结果namenode重启成功。
带来的问题是HBase 会有问题，找不到一些region，shell中list table报异常。可能失去的的记录中正好保存了meda数据。
因此考虑从second namenode恢复或者从check point恢复。部分数据的丢失不可避免了。
这种办法可能对没有使用HBase的有效。
