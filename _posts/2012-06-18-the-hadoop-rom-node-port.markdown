---
author: abloz
comments: true
date: 2012-06-18 10:28:54+00:00
layout: post
link: http://abloz.com/index.php/2012/06/18/the-hadoop-rom-node-port/
slug: the-hadoop-rom-node-port
title: hadoop连不上节点端口？
wordpress_id: 1706
categories:
- 技术
tags:
- hadoop
- 防火墙
---

原因：DataNode 47系统cpu过高重启后，出现下述问题。
[zhouhh@Hadoop48 ~]$ fs -rm 1.txt
rm: org.apache.hadoop.hdfs.server.namenode.SafeModeException: Cannot delete /user/zhouhh/1.txt. Name node is in safe mode.
进入了安全模式？
重启hadoop也不能解决。只好强制离开安全模式。

    
    
     [zhouhh@Hadoop48 hadoop-1.0.3]$ hadoop dfsadmin -safemode leave
     [zhouhh@Hadoop48 ~]$ fs -rm 1.txt
     Deleted hdfs://Hadoop48:54310/user/zhouhh/1.txt


删除文件成功。

    
    
     [zhouhh@Hadoop48 ~]$ hadoop fs -put 1.txt .
     12/06/18 18:14:53 INFO hdfs.DFSClient: Exception in createBlockOutputStream 192.168.10.46:50010 java.io.IOException: Bad connect ack with firstBadLink as 192.168.10.47:54313
     12/06/18 18:14:53 INFO hdfs.DFSClient: Abandoning block blk_6739152855033658770_1512
     12/06/18 18:14:53 INFO hdfs.DFSClient: Excluding datanode 192.168.10.47:54313
     到47上看，jps 进程都在。
     [zhouhh@Hadoop47 ~]$ jps
     4067 HQuorumPeer
     3913 TaskTracker
     3803 DataNode
     9951 Jps
     4216 HRegionServer
     查看端口，也都在监听：
     [zhouhh@Hadoop47 ~]$ netstat -antp |grep 543
     (Not all processes could be identified, non-owned process info
     will not be shown, you would have to be root to see it all.)
     tcp 0 0 0.0.0.0:54313 0.0.0.0:* LISTEN 3803/java
     tcp 0 0 0.0.0.0:54314 0.0.0.0:* LISTEN 3803/java
     tcp 0 0 0.0.0.0:54315 0.0.0.0:* LISTEN 3803/java
     tcp 0 0 192.168.10.47:48636 192.168.10.48:54310 TIME_WAIT -
     tcp 0 0 192.168.10.47:48639 192.168.10.48:54310 TIME_WAIT -
     tcp 0 0 192.168.10.47:59779 192.168.10.48:54311 ESTABLISHED 3913/java
     tcp 0 0 192.168.10.47:55475 192.168.10.48:54310 ESTABLISHED 3803/java


重启hadoop，没有解决问题。困惑了很久，忽然想到了防火墙。
有时系统没有配好防火墙，重启后导致防火墙屏蔽了hadoop的端口。测试时可以将防火墙全部关闭。



    
    [root@Hadoop47 ~]# iptables -L
     Chain INPUT (policy ACCEPT)
     target prot opt source destination
     RH-Firewall-1-INPUT all -- anywhere anywhere



    
    Chain FORWARD (policy ACCEPT)
     target prot opt source destination
     RH-Firewall-1-INPUT all -- anywhere anywhere



    
    Chain OUTPUT (policy ACCEPT)
     target prot opt source destination



    
    Chain RH-Firewall-1-INPUT (2 references)
     target prot opt source destination
     ACCEPT all -- anywhere anywhere
     ACCEPT icmp -- anywhere anywhere icmp any
     ACCEPT esp -- anywhere anywhere
     ACCEPT ah -- anywhere anywhere
     ACCEPT udp -- anywhere 224.0.0.251 udp dpt:mdns
     ACCEPT udp -- anywhere anywhere udp dpt:ipp
     ACCEPT tcp -- anywhere anywhere tcp dpt:ipp
     ACCEPT all -- anywhere anywhere state RELATED,ESTABLISHED
     ACCEPT tcp -- anywhere anywhere state NEW tcp dpt:ssh
     REJECT all -- anywhere anywhere reject-with icmp-host-prohibited




关闭防火墙：



    
    [root@Hadoop47 ~]# service iptables stop
     Flushing firewall rules: [ OK ]
     Setting chains to policy ACCEPT: filter [ OK ]
     Unloading iptables modules: [ OK ]
     [root@Hadoop47 ~]# chkconfig iptables off




在生产系统中再配置域外的防火墙。

[zhouhh@Hadoop48 ~]$ fs -put 1.txt .
成功
