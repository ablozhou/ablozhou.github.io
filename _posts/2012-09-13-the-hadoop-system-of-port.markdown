---
author: abloz
comments: true
date: 2012-09-13 09:28:41+00:00
layout: post
link: http://abloz.com/index.php/2012/09/13/the-hadoop-system-of-port/
slug: the-hadoop-system-of-port
title: hadoop系统的端口
wordpress_id: 1868
categories:
- 技术
tags:
- hadoop
- hbase
- 端口
---



周海汉 /文
2012.9.13

本文地址：http://abloz.com/2012/09/13/the-hadoop-system-of-port.html

hadoop系统部署时用到不少端口。有的是Web UI所使用的，有的是内部通信所使用的，有的是监控所使用的。实际系统中可能用于防火墙的端口设计。一些内部通信用的端口可能也需要外部能访问。如两个集群的数据对拷。


## 1.系统


8080，80 用于tomcat和apache的端口。

22 ssh的端口




## 2.Web UI


用于访问和监控Hadoop系统运行状态
<table >
<tbody >
<tr >

<td width="56" valign="top" >
</td>

<td width="163" valign="top" >Daemon
</td>

<td width="116" valign="top" >缺省端口
</td>

<td width="213" valign="top" >配置参数
</td>
</tr>
<tr >

<td width="56" rowspan="4" valign="center" >HDFS
</td>

<td width="163" valign="center" >Namenode
</td>

<td width="116" valign="center" >50070
</td>

<td width="213" valign="center" >dfs.http.address
</td>
</tr>
<tr >

<td width="163" valign="center" >Datanodes
</td>

<td width="116" valign="center" >50075
</td>

<td width="213" valign="center" >dfs.datanode.http.address
</td>
</tr>
<tr >

<td width="163" valign="center" >Secondarynamenode
</td>

<td width="116" valign="center" >50090
</td>

<td width="213" valign="center" >dfs.secondary.http.address
</td>
</tr>
<tr >

<td width="163" valign="center" >Backup/Checkpoint node*
</td>

<td width="116" valign="center" >50105
</td>

<td width="213" valign="center" >dfs.backup.http.address
</td>
</tr>
<tr >

<td width="56" rowspan="2" valign="center" >MR
</td>

<td width="163" valign="center" >Jobracker
</td>

<td width="116" valign="center" >50030
</td>

<td width="213" valign="center" >mapred.job.tracker.http.address
</td>
</tr>
<tr >

<td width="163" valign="center" >Tasktrackers
</td>

<td width="116" valign="center" >50060
</td>

<td width="213" valign="center" >mapred.task.tracker.http.address
</td>
</tr>
<tr >

<td width="56" rowspan="2" valign="center" >HBase
</td>

<td width="163" valign="center" >HMaster
</td>

<td width="116" valign="center" >60010
</td>

<td width="213" valign="center" >hbase.master.info.port
</td>
</tr>
<tr >

<td width="163" valign="center" >HRegionServer
</td>

<td width="116" valign="center" >60030
</td>

<td width="213" valign="center" >hbase.regionserver.info.port
</td>
</tr>
<tr >

<td colspan="4" width="550" valign="center" >* hadoop 0.21以后代替secondarynamenode .
</td>
</tr>
</tbody>
</table>



## 3.内部端口


<table >
<tbody >
<tr >

<td width="64" valign="top" >Daemon
</td>

<td width="60" valign="top" >缺省端口
</td>

<td width="129" valign="top" >配置参数
</td>

<td width="178" valign="top" >协议
</td>

<td width="143" valign="top" >用于
</td>
</tr>
<tr >

<td width="64" valign="center" >Namenode
</td>

<td width="60" valign="center" >9000
</td>

<td width="129" valign="center" >fs.default.name
</td>

<td width="178" valign="center" >IPC: ClientProtocol
</td>

<td width="143" valign="center" >Filesystem metadata operations.
</td>
</tr>
<tr >

<td width="64" valign="center" >Datanode
</td>

<td width="60" valign="center" >50010
</td>

<td width="129" valign="center" >dfs.datanode.address
</td>

<td width="178" valign="center" >Custom Hadoop Xceiver: DataNodeand DFSClient
</td>

<td width="143" valign="center" >DFS data transfer
</td>
</tr>
<tr >

<td width="64" valign="center" >Datanode
</td>

<td width="60" valign="center" >50020
</td>

<td width="129" valign="center" >dfs.datanode.ipc.address
</td>

<td width="178" valign="center" >IPC:InterDatanodeProtocol,ClientDatanodeProtocol
ClientProtocol
</td>

<td width="143" valign="center" >Block metadata operations and recovery
</td>
</tr>
<tr >

<td width="64" valign="center" >Backupnode
</td>

<td width="60" valign="center" >50100
</td>

<td width="129" valign="center" >dfs.backup.address
</td>

<td width="178" valign="center" >同 namenode
</td>

<td width="143" valign="center" >HDFS Metadata Operations
</td>
</tr>
<tr >

<td width="64" valign="center" >Jobtracker
</td>

<td width="60" valign="center" >9001
</td>

<td width="129" valign="center" >mapred.job.tracker
</td>

<td width="178" valign="center" >IPC:JobSubmissionProtocol,InterTrackerProtocol
</td>

<td width="143" valign="center" >Job submission, task tracker heartbeats.
</td>
</tr>
<tr >

<td width="64" valign="center" >Tasktracker
</td>

<td width="60" valign="center" >127.0.0.1:0*
</td>

<td width="129" valign="center" >mapred.task.tracker.report.address
</td>

<td width="178" valign="center" >IPC:TaskUmbilicalProtocol
</td>

<td width="143" valign="center" >和 child job 通信
</td>
</tr>
<tr >

<td colspan="6" width="576" valign="center" >* 绑定到未用本地端口
</td>
</tr>
</tbody>
</table>


##  4.相关产品端口


<table >
<tbody >
<tr >

<td width="67" valign="top" >产品
</td>

<td width="93" valign="top" >服务
</td>

<td width="55" valign="top" >缺省端口
</td>

<td width="128" valign="top" >参数
</td>

<td width="57" valign="top" >范围
</td>

<td width="42" valign="top" >协议
</td>

<td width="92" valign="top" >说明
</td>
</tr>
<tr >

<td width="67" rowspan="10" valign="top" >HBase 
















</td>

<td width="93" valign="top" >Master
</td>

<td width="55" valign="top" >60000
</td>

<td width="128" valign="top" >hbase.master.port
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >IPC
</td>
</tr>
<tr >

<td width="93" valign="top" >Master
</td>

<td width="55" valign="top" >60010
</td>

<td width="128" valign="top" >hbase.master.info.port
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >HTTP
</td>
</tr>
<tr >

<td width="93" valign="top" >RegionServer
</td>

<td width="55" valign="top" >60020
</td>

<td width="128" valign="top" >hbase.regionserver.port
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >IPC
</td>
</tr>
<tr >

<td width="93" valign="top" >RegionServer
</td>

<td width="55" valign="top" >60030
</td>

<td width="128" valign="top" >hbase.regionserver.info.port
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >HTTP
</td>
</tr>
<tr >

<td width="93" valign="top" >HQuorumPeer
</td>

<td width="55" valign="top" >2181
</td>

<td width="128" valign="top" >hbase.zookeeper.property.clientPort
</td>

<td width="57" valign="top" >
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >HBase-managed ZK mode
</td>
</tr>
<tr >

<td width="93" valign="top" >HQuorumPeer
</td>

<td width="55" valign="top" >2888
</td>

<td width="128" valign="top" >hbase.zookeeper.peerport
</td>

<td width="57" valign="top" >
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >HBase-managed ZK mode
</td>
</tr>
<tr >

<td width="93" valign="top" >HQuorumPeer
</td>

<td width="55" valign="top" >3888
</td>

<td width="128" valign="top" >hbase.zookeeper.leaderport
</td>

<td width="57" valign="top" >
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >HBase-managed ZK mode
</td>
</tr>
<tr >

<td width="93" valign="top" >REST Service
</td>

<td width="55" valign="top" >8080
</td>

<td width="128" valign="top" >hbase.rest.port
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >
</td>
</tr>
<tr >

<td width="93" valign="top" >ThriftServer
</td>

<td width="55" valign="top" >9090
</td>

<td width="128" valign="top" >Pass -p <port> on CLI
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >
</td>
</tr>
<tr >

<td width="93" valign="top" > Avro server
</td>

<td width="55" valign="top" >9090
</td>

<td width="128" valign="top" >Pass --port <port> on CLI
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >
</td>
</tr>
<tr >

<td width="67" rowspan="2" valign="top" >Hive
</td>

<td width="93" valign="top" >Metastore
</td>

<td width="55" valign="top" >9083
</td>

<td width="128" valign="top" >
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >
</td>
</tr>
<tr >

<td width="93" valign="top" >HiveServer
</td>

<td width="55" valign="top" >10000
</td>

<td width="128" valign="top" >
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >
</td>
</tr>
<tr >

<td width="67" valign="top" >Sqoop
</td>

<td width="93" valign="top" >Metastore
</td>

<td width="55" valign="top" >16000
</td>

<td width="128" valign="top" >sqoop.metastore.server.port
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >
</td>
</tr>
<tr >

<td width="67" rowspan="5" valign="top" >ZooKeeper 






</td>

<td width="93" valign="top" >Server
</td>

<td width="55" valign="top" >2181
</td>

<td width="128" valign="top" >clientPort
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >Client port
</td>
</tr>
<tr >

<td width="93" valign="top" >Server
</td>

<td width="55" valign="top" >2888
</td>

<td width="128" valign="top" >X in server.N=host:X:Y
</td>

<td width="57" valign="top" >Internal
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >Peer
</td>
</tr>
<tr >

<td width="93" valign="top" >Server
</td>

<td width="55" valign="top" >3888
</td>

<td width="128" valign="top" >Y in server.N=host:X:Y
</td>

<td width="57" valign="top" >Internal
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >Peer
</td>
</tr>
<tr >

<td width="93" valign="top" >Server
</td>

<td width="55" valign="top" >3181
</td>

<td width="128" valign="top" >X in server.N=host:X:Y
</td>

<td width="57" valign="top" >Internal
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >Peer
</td>
</tr>
<tr >

<td width="93" valign="top" >Server
</td>

<td width="55" valign="top" >4181
</td>

<td width="128" valign="top" >Y in server.N=host:X:Y
</td>

<td width="57" valign="top" >Internal
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >Peer
</td>
</tr>
<tr >

<td width="67" rowspan="3" valign="top" >Hue 


</td>

<td width="93" valign="top" >Server
</td>

<td width="55" valign="top" >8888
</td>

<td width="128" valign="top" >
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >
</td>
</tr>
<tr >

<td width="93" valign="top" >Beeswax Server
</td>

<td width="55" valign="top" >8002
</td>

<td width="128" valign="top" >
</td>

<td width="57" valign="top" >Internal
</td>

<td width="42" valign="top" >
</td>

<td width="92" valign="top" >
</td>
</tr>
<tr >

<td width="93" valign="top" >Beeswax Metastore
</td>

<td width="55" valign="top" >8003
</td>

<td width="128" valign="top" >
</td>

<td width="57" valign="top" >Internal
</td>

<td width="42" valign="top" >
</td>

<td width="92" valign="top" >
</td>
</tr>
<tr >

<td width="67" rowspan="2" valign="top" >Oozie
</td>

<td width="93" valign="top" >Oozie Server
</td>

<td width="55" valign="top" >11000
</td>

<td width="128" valign="top" >OOZIE_HTTP_PORT in oozie-env.sh
</td>

<td width="57" valign="top" >External
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >HTTP
</td>
</tr>
<tr >

<td width="93" valign="top" >Oozie Server
</td>

<td width="55" valign="top" >11001
</td>

<td width="128" valign="top" >OOZIE_ADMIN_PORT in oozie-env.sh
</td>

<td width="57" valign="top" >localhost
</td>

<td width="42" valign="top" >TCP
</td>

<td width="92" valign="top" >Shutdown port
</td>
</tr>
</tbody>
</table>


## 5.YARN(Hadoop 2.0)缺省端口


<table >
<tbody >
<tr >

<td width="78" valign="top" >产品
</td>

<td width="117" valign="top" >服务
</td>

<td width="67" valign="top" >缺省端口
</td>

<td width="213" valign="top" >配置参数
</td>

<td width="36" valign="top" >协议
</td>
</tr>
<tr >

<td width="78" rowspan="10" valign="top" >Hadoop YARN 
















</td>

<td width="117" valign="top" >ResourceManager
</td>

<td width="67" valign="top" >8032
</td>

<td width="213" valign="top" >yarn.resourcemanager.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
<tr >

<td width="117" valign="top" >ResourceManager
</td>

<td width="67" valign="top" >8030
</td>

<td width="213" valign="top" >yarn.resourcemanager.scheduler.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
<tr >

<td width="117" valign="top" >ResourceManager
</td>

<td width="67" valign="top" >8031
</td>

<td width="213" valign="top" >yarn.resourcemanager.resource-tracker.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
<tr >

<td width="117" valign="top" >ResourceManager
</td>

<td width="67" valign="top" >8033
</td>

<td width="213" valign="top" >yarn.resourcemanager.admin.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
<tr >

<td width="117" valign="top" >ResourceManager
</td>

<td width="67" valign="top" >8088
</td>

<td width="213" valign="top" >yarn.resourcemanager.webapp.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
<tr >

<td width="117" valign="top" >NodeManager
</td>

<td width="67" valign="top" >8040
</td>

<td width="213" valign="top" >yarn.nodemanager.localizer.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
<tr >

<td width="117" valign="top" >NodeManager
</td>

<td width="67" valign="top" >8042
</td>

<td width="213" valign="top" >yarn.nodemanager.webapp.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
<tr >

<td width="117" valign="top" >NodeManager
</td>

<td width="67" valign="top" >8041
</td>

<td width="213" valign="top" >yarn.nodemanager.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
<tr >

<td width="117" valign="top" >MapReduce JobHistory Server
</td>

<td width="67" valign="top" >10020
</td>

<td width="213" valign="top" >mapreduce.jobhistory.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
<tr >

<td width="117" valign="top" >MapReduce JobHistory Server
</td>

<td width="67" valign="top" >19888
</td>

<td width="213" valign="top" >mapreduce.jobhistory.webapp.address
</td>

<td width="36" valign="top" >TCP
</td>
</tr>
</tbody>
</table>



## 6.第三方产品端口


ganglia用于监控Hadoop和HBase运行情况。kerberos是一种网络认证协议，相应软件由麻省理工开发。
<table >
<tbody >
<tr >

<td width="61" valign="top" >产品
</td>

<td width="66" valign="top" >服务
</td>

<td width="56" valign="top" >安全
</td>

<td width="36" valign="top" >缺省端口
</td>

<td width="52" valign="top" >协议
</td>

<td width="68" valign="top" >访问
</td>

<td width="171" valign="top" >配置
</td>
</tr>
<tr >

<td width="61" rowspan="2" valign="top" >Ganglia
</td>

<td width="66" valign="top" >ganglia-gmond
</td>

<td width="56" valign="top" >
</td>

<td width="36" valign="top" >8649
</td>

<td width="52" valign="top" >UDP/TCP
</td>

<td width="68" valign="top" >Internal
</td>

<td width="171" valign="top" >
</td>
</tr>
<tr >

<td width="66" valign="top" >ganglia-web
</td>

<td width="56" valign="top" >
</td>

<td width="36" valign="top" >80
</td>

<td width="52" valign="top" >TCP
</td>

<td width="68" valign="top" >External
</td>

<td width="171" valign="top" >通过 Apache httpd
</td>
</tr>
<tr >

<td width="61" rowspan="2" valign="top" >Kerberos
</td>

<td width="66" valign="top" >KRB5 KDC Server
</td>

<td width="56" valign="top" >Secure
</td>

<td width="36" valign="top" >88
</td>

<td width="52" valign="top" >UDP*/TCP
</td>

<td width="68" valign="top" >External
</td>

<td width="171" valign="top" >[kdcdefaults] 或 [realms]段下的kdc_ports 和 kdc_tcp_ports
</td>
</tr>
<tr >

<td width="66" valign="top" >KRB5 Admin Server
</td>

<td width="56" valign="top" >Secure
</td>

<td width="36" valign="top" >749
</td>

<td width="52" valign="top" >TCP
</td>

<td width="68" valign="top" >Internal
</td>

<td width="171" valign="top" > Kdc.conf 文件：[realms]段kadmind_port
</td>
</tr>
</tbody>
</table>
*缺省UDP协议


## 7.参考


[https://ccp.cloudera.com/display/CDH4DOC/Configuring+Ports+for+CDH4](https://ccp.cloudera.com/display/CDH4DOC/Configuring+Ports+for+CDH4)
