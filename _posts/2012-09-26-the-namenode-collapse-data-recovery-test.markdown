---
author: abloz
comments: true
date: 2012-09-26 07:21:23+00:00
layout: post
link: http://abloz.com/index.php/2012/09/26/the-namenode-collapse-data-recovery-test/
slug: the-namenode-collapse-data-recovery-test
title: namenode崩溃的数据恢复测试
wordpress_id: 1889
categories:
- 技术
tags:
- hadoop
- 恢复
---

周海汉/文
http://abloz.com
2012.9.9

**前言**
用second namenode 数据恢复测试。datanode由于采用2-3个备份，即使一台设备损坏，还是能自动恢复并找回全部数据。
hadoop 1.0.3和0.20之前的版本，namenode存在单点问题。如果namenode损坏，会导致整个系统数据彻底丢失。所以second namenode就显得特别重要。本文主要探讨namenode损坏的数据恢复实践，包括配置文件，部署，namenode崩溃，namenode数据损坏和namenode meta数据恢复。

hadoop版本是hadoop1.0.3
一共三台机器参与测试。
机器角色：
Hadoop48 Namenode
Hadoop47 Second Namenode, Datanode
Hadoop46 Datanode

**1.编辑core-site,增加checkpoint相关配置**
fs.checkpoint.dir 是恢复文件存放目录
fs.checkpoint.period 同步检查时间，缺省是3600秒1小时。测试时设为20秒。
fs.checkpoint.size 当edit 日志文件大于这个字节数时，即使检查时间没到，也会触发同步。

[zhouhh@Hadoop48 conf]$ vi core-site.xml
<property>
<name>hadoop.mydata.dir</name>
<value>/data/zhouhh/myhadoop</value>
<description>A base for other directories.${user.name} </description>
</property>

<property>
<name>hadoop.tmp.dir</name>
<value>/tmp/hadoop-${user.name}</value>
<description>A base for other temporary directories.</description>
</property>

<property>
<name>fs.checkpoint.dir</name>
<value>${hadoop.data.dir}/dfs/namesecondary</value>
<description>Determines where on the local filesystem the DFS secondary
name node should store the temporary images to merge.
If this is a comma-delimited list of directories then the image is
replicated in all of the directories for redundancy.
</description>
</property>

<property>
<name>fs.checkpoint.edits.dir</name>
<value>${fs.checkpoint.dir}</value>
<description>Determines where on the local filesystem the DFS secondary
name node should store the temporary edits to merge.
If this is a comma-delimited list of directoires then teh edits is
replicated in all of the directoires for redundancy.
Default value is same as fs.checkpoint.dir
</description>
</property>
<property>
<name>fs.checkpoint.period</name>
<value>20</value>
<description>The number of seconds between two periodic checkpoints.default is 3600 second
</description>
</property>

<property>
<name>fs.checkpoint.size</name>
<value>67108864</value>
<description>The size of the current edit log (in bytes) that triggers
a periodic checkpoint even if the fs.checkpoint.period hasn't expired.
</description>
</property>

**2.将second namenode设置到另一台机器。**
设置masters文件，这是指定seconde namenode启动的机器。
[zhouhh@Hadoop48 conf]$ cat masters
Hadoop47

编辑dfs.secondary.http.address，指定second namenode的http web UI 域名或IP到namenode Hadoop48不同的机器Hadoop47，而不是缺省的0.0.0.0

[zhouhh@Hadoop48 conf]$ vi hdfs-site.xml
<property>
<name>dfs.name.dir</name>
<value>${hadoop.mydata.dir}/dfs/name</value>
<description>Determines where on the local filesystem the DFS name node
should store the name table(fsimage). If this is a comma-delimited list
of directories then the name table is replicated in all of the
directories, for redundancy.
Default value is:${hadoop.tmp.dir}/dfs/name
</description>
</property>
<property>
<name>dfs.secondary.http.address</name>
<value>Hadoop47:55090</value>
<description>
The secondary namenode http server address and port.
If the port is 0 then the server will start on a free port.
</description>
</property>

**3.测试时如果name node指定的目录没有初始化，需初始化一下**
[zhouhh@Hadoop48 logs]$ hadoop namenode -format

**4.同步conf下的配置到Hadoop47/46(略)，启动hadoop**
[zhouhh@Hadoop48 conf]$ start-all.sh

[zhouhh@Hadoop48 conf]$ jps
9633 Bootstrap
10746 JobTracker
10572 NameNode
10840 Jps

[zhouhh@Hadoop47 ~]$ jps
23157 DataNode
23362 TaskTracker
23460 Jps
23250 SecondaryNameNode

Namenode log报的error：
2012-09-25 19:27:54,816 ERROR security.UserGroupInformation - PriviledgedActionException as:zhouhh cause:org.apache.hadoop.hdfs.server.namenode.SafeModeException: Cannot delete /data/zhouhh/myhadoop/mapred/ system. Name node is in safe mode.
请不要急，NameNode会在开始启动阶段自动关闭安全模式，然后启动成功。如果你不想等待，可以运行：

bin/hadoop dfsadmin -safemode leave 强制结束。
NameNode启动时会从fsimage和edits日志文件中装载文件系统的状态信息，接着它等待各个DataNode向它报告它们各自的数据块状态，这样，NameNode就不会过早地开始复制数据块，即使在副本充足的情况下。这个阶段，NameNode处于安全模式下。NameNode的安全模式本质上是HDFS集群的一种只读模式，此时集群不允许任何对文件系统或者数据块修改的操作。通常NameNode会在开始阶段自动地退出安全模式。如果需要，你也可以通过’bin/hadoop dfsadmin -safemode’命令显式地将HDFS置于安全模式。NameNode首页会显示当前是否处于安全模式。

**5.编辑放置测试文件**
[zhouhh@Hadoop48 hadoop-1.0.3]$ fs -put README.txt /user/zhouhh/README.txt
[zhouhh@Hadoop48 hadoop-1.0.3]$ fs -ls .
Found 1 items
-rw-r--r-- 2 zhouhh supergroup 1381 2012-09-26 14:03 /user/zhouhh/README.txt
[zhouhh@Hadoop48 hadoop-1.0.3]$ cat test中文.txt
这是测试文件
test001 by zhouhh
http://abloz.com
2012.9.26

**6. 放到HDFS中**
[zhouhh@Hadoop48 hadoop-1.0.3]$ hadoop fs -put test中文.txt .

[zhouhh@Hadoop48 hadoop-1.0.3]$ hadoop fs -ls .
Found 2 items
-rw-r--r-- 2 zhouhh supergroup 1381 2012-09-26 14:03 /user/zhouhh/README.txt
-rw-r--r-- 2 zhouhh supergroup 65 2012-09-26 14:10 /user/zhouhh/test中文.txt
[zhouhh@Hadoop48 ~]$ hadoop fs -cat test中文.txt
这是测试文件
test001 by zhouhh
http://abloz.com
2012.9.26

**7 杀死Namenode，模拟崩溃**
[zhouhh@Hadoop48 ~]$ jps
9633 Bootstrap
23006 Jps
19691 NameNode
19867 JobTracker
[zhouhh@Hadoop48 ~]$ kill -9 19691
[zhouhh@Hadoop48 ~]$ jps
9633 Bootstrap
23019 Jps
19867 JobTracker

[zhouhh@Hadoop47 hadoop-1.0.3]$ jps
1716 DataNode
3825 Jps
1935 TaskTracker
1824 SecondaryNameNode

**8. 将dfs.name.dir下的内容清空，模拟硬盘损坏**
[zhouhh@Hadoop48 ~]$ cd /data/zhouhh/myhadoop/dfs/name/
[zhouhh@Hadoop48 name]$ ls
current image in_use.lock previous.checkpoint
[zhouhh@Hadoop48 name]$ cd ..
采用改名的方式进行测试
[zhouhh@Hadoop48 dfs]$ mv name name1
此时，name 目录不存在，namenode是会启动失败的

**9.数据恢复，从second namenode 复制数据**

查看second namenode文件，并打包复制到namenode的fs.checkpoint.dir
[zhouhh@Hadoop47 hadoop-1.0.3]$ cd /data/zhouhh/myhadoop/dfs/
[zhouhh@Hadoop47 dfs]$ ls
data namesecondary
[zhouhh@Hadoop47 dfs]$ cd namesecondary/
[zhouhh@Hadoop47 namesecondary]$ ls
current image in_use.lock
[zhouhh@Hadoop47 namesecondary]$ cd ..
[zhouhh@Hadoop47 dfs]$ scp sec.tar.gz Hadoop48:/data/zhouhh/myhadoop/dfs/
sec.tar.gz

[zhouhh@Hadoop48 dfs]$ ls
name1 sec.tar.gz
[zhouhh@Hadoop48 dfs]$ tar zxvf sec.tar.gz
namesecondary/
namesecondary/current/
namesecondary/current/VERSION
namesecondary/current/fsimage
namesecondary/current/edits
namesecondary/current/fstime
namesecondary/image/
namesecondary/image/fsimage
namesecondary/in_use.lock
[zhouhh@Hadoop48 dfs]$ ls
name1 namesecondary sec.tar.gz

如果dfs.name.dir配置的name不存在，需创建name目录(我测试时将其改名了，也可以进入name目录用rm * -f)
[zhouhh@Hadoop48 dfs]$ mkdir name

[zhouhh@Hadoop48 dfs]$ hadoop namenode -importCheckpoint
此时name下面已经有数据
Ctrl+C 结束

**10.恢复成功，检查数据正确性**
[zhouhh@Hadoop48 dfs]$ start-all.sh
[zhouhh@Hadoop48 dfs]$ jps
23940 Jps
9633 Bootstrap
19867 JobTracker
23791 NameNode
[zhouhh@Hadoop48 dfs]$ hadoop fs -ls .
Found 2 items
-rw-r--r-- 2 zhouhh supergroup 1381 2012-09-26 14:03 /user/zhouhh/README.txt
-rw-r--r-- 2 zhouhh supergroup 65 2012-09-26 14:10 /user/zhouhh/test中文.txt
[zhouhh@Hadoop48 dfs]$ hadoop fs -cat test中文.txt
这是测试文件
test001 by zhouhh
http://abloz.com
2012.9.26


[zhouhh@Hadoop48 dfs]$ hadoop fsck /user/zhouhh
FSCK started by zhouhh from /192.168.10.48 for path /user/zhouhh at Wed Sep 26 14:42:31 CST 2012
..Status: HEALTHY

恢复成功
