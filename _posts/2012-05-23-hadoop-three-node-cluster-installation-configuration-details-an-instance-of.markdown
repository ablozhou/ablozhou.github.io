---
author: abloz
comments: true
date: 2012-05-23 12:30:11+00:00
layout: post
link: http://abloz.com/index.php/2012/05/23/hadoop-three-node-cluster-installation-configuration-details-an-instance-of/
slug: hadoop-three-node-cluster-installation-configuration-details-an-instance-of
title: hadoop 三节点集群安装配置详细实例
wordpress_id: 1608
categories:
- 技术
tags:
- hadoop
- mapreduce
---

作者：周海汉
网址：http://abloz.com
日期：2012.5.23

**topo节点：**
192.168.10.46 Hadoop46
192.168.10.47 Hadoop47
192.168.10.48 Hadoop48
Hadoop的守护进程deamons：NameNode/DataNode 和 JobTracker/TaskTracker。其中NameNode/DataNode工作在HDFS层，JobTracker/TaskTracker工作在MapReduce层。
设备列表中Hadoop48是master，担任namenode和jobtracker，46，47为slave，担任datanode和tasktracker。secondary namenode在hadoop 1.03中被废弃，用checkpoint node或backupnode来代替。暂没有配checkpoint node或backupnode。

[caption id="attachment_1609" align="aligncenter" width="400" caption="hadoop topo"][![hadoop topo](http://abloz.com/wp-content/uploads/2012/05/topo1.png)](http://abloz.com/wp-content/uploads/2012/05/topo1.png)[/caption]

在各机器建立用户zhouhh，可选自己喜欢的名称，用于管理hadoop。

**网络准备**
先对每个节点完成单节点设置,见我此前文章：[10分钟从无到有搭建hadoop环境并测试mapreduce](http://abloz.com/2012/05/22/10-minutes-from-scratch-to-build-hadoop-environment-and-test-mapreduce.html) http://abloz.com/2012/05/22/10-minutes-from-scratch-to-build-hadoop-environment-and-test-mapreduce.html。
从http://labs.renren.com/apache-mirror/hadoop/common/下载最新版本hadoop

wget http://labs.renren.com/apache-mirror/hadoop/common/hadoop-1.0.3/hadoop-1.0.3.tar.gz
然后分发到各机器，并在各机器解压，配置，测试单台设备ok。
[zhouhh@Hadoop48 ~]$ cat /etc/redhat-release
CentOS release 5.5 (Final)

[zhouhh@Hadoop48 ~]$ cat /etc/hosts
# Do not remove the following line, or various programs
# that require network functionality will fail.
127.0.0.1 localhost.localdomain localhost
::1 localhost6.localdomain6 localhost6
192.168.10.46 Hadoop46
192.168.10.47 Hadoop47
192.168.10.48 Hadoop48

[zhouhh@Hadoop48 ~]$ ping Hadoop46
PING Hadoop46 (192.168.10.46) 56(84) bytes of data.
64 bytes from Hadoop46 (192.168.10.46): icmp_seq=1 ttl=64 time=5.25 ms
64 bytes from Hadoop46 (192.168.10.46): icmp_seq=2 ttl=64 time=0.428 ms

--- Hadoop46 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1009ms
rtt min/avg/max/mdev = 0.428/2.843/5.259/2.416 ms
[zhouhh@Hadoop48 ~]$ ping Hadoop47
PING Hadoop47 (192.168.10.47) 56(84) bytes of data.
64 bytes from Hadoop47 (192.168.10.47): icmp_seq=1 ttl=64 time=7.08 ms
64 bytes from Hadoop47 (192.168.10.47): icmp_seq=2 ttl=64 time=4.27 ms

--- Hadoop47 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1007ms
rtt min/avg/max/mdev = 4.277/5.678/7.080/1.403 ms

[zhouhh@Hadoop48 ~]$ ssh-keygen -t rsa -P ""
[zhouhh@Hadoop48 ~]$ cd .ssh
[zhouhh@Hadoop48 .ssh]$ cat id_rsa.pub >> authorized_keys

由于安全原因，如果各节点的ssh连接不是标准端口，可以配置一个config文件，以方便ssh Hadoop46这样的命令自动连接。
如果是标准端口标准key文件名的话通过hosts的解析就可以用ssh Hadoop46这样的命令自动登录了。
config文件格式：

    
    
     [zhouhh@Hadoop48 .ssh]$ vi config



    
    Host Hadoop46
     Port 22
     HostName 192.168.10.46
     IdentityFile ~/.ssh/id_rsa
     Host Hadoop47
     Port 22
     HostName 192.168.10.47
     IdentityFile ~/.ssh/id_rsa
     Host Hadoop48
     Port 22
     HostName 192.168.10.48
     IdentityFile ~/.ssh/id_rsa



    
    [zhouhh@Hadoop48 ~]$ ssh-copy-id -i .ssh/id_rsa zhouhh@Hadoop46
     [zhouhh@Hadoop48 ~]$ ssh-copy-id -i .ssh/id_rsa zhouhh@Hadoop47



    
    测试用key实现无密码登录，都应该成功：
     [zhouhh@Hadoop48 ~]$ ssh Hadoop46
     [zhouhh@Hadoop48 ~]$ ssh Hadoop47
     [zhouhh@Hadoop48 ~]$ ssh Hadoop48



    
    拷贝私钥：
     [zhouhh@Hadoop47 .ssh]$ scp zhouhh@Hadoop48:~/.ssh/id_rsa .
     [zhouhh@Hadoop47 .ssh]$ scp zhouhh@Hadoop48:~/.ssh/config .
     [zhouhh@Hadoop46 .ssh]$ scp zhouhh@Hadoop48:~/.ssh/id_rsa .
     [zhouhh@Hadoop46 .ssh]$ scp zhouhh@Hadoop48:~/.ssh/config .
     至此，完成了互联互通。



    
    =================
     <strong>下面完成配置</strong>
     =================
     环境变量：
     [zhouhh@Hadoop48 ~]$ vi .bashrc
     export HADOOP_HOME=/home/zhouhh/hadoop-1.0.3
     export HADOOP_HOME_WARN_SUPPRESS=1



    
    unalias fs &> /dev/null
     alias fs="hadoop fs"
     unalias hls &> /dev/null
     alias hls="fs -ls"



    
    export PATH=$PATH:$HADOOP_HOME/bin



    
    [zhouhh@Hadoop48 ~]$ source .bashrc



    
    [zhouhh@Hadoop48 ~]$ cd hadoop-1.0.3
     [zhouhh@Hadoop48 hadoop-1.0.3]$ cd conf
     [zhouhh@Hadoop48 conf]$ ls
     capacity-scheduler.xml fair-scheduler.xml hdfs-default.xml mapred-queue-acls.xml ssl-client.xml.example
     configuration.xsl hadoop-env.sh hdfs-site.xml mapred-site.xml ssl-server.xml.example
     core-default.xml hadoop-metrics2.properties log4j.properties masters taskcontroller.cfg
     core-site.xml hadoop-policy.xml mapred-default.xml slaves
     其中几个*default.xml文件是我从相应的src中拷贝过来的，用于配置参考。
     配置文件包括环境和配置参数两部分。环境是bin目录下脚本需要的，在hadoop-env.sh 中配置。配置参数在*-site.xml中配置。


masters文件和slaves文件，仅方便用同时管理多台设备的启动和停止，也可以用手动方式来启动：
bin/hadoop-daemon.sh start [namenode | secondarynamenode | datanode | jobtracker | tasktracker]

运行bin/start-dfs.sh，表示是该设备是 NameNode，运行bin/start-mapred.sh表示该设备是 JobTracker。NameNode和JobTracker可以是同一台机器，也可以分开。
bin/start-all.sh， stop-all.sh这两个脚本在1.03中被废弃，被bin/start-dfs.sh ，bin/start-mapred.sh和bin/stop-dfs.sh，bin/stop-mapred.sh所替代。

    
    [zhouhh@Hadoop48 conf]$ vi masters
     Hadoop48
     [zhouhh@Hadoop48 conf]$ vi slaves
     Hadoop46
     Hadoop47


只读配置文件：src/core/core-default.xml, src/hdfs/hdfs-default.xml， src/mapred/mapred-default.xml
可以用于配置参考。
这三个文件用于实际配置：conf/core-site.xml, conf/hdfs-site.xml，conf/mapred-site.xml
另外，可以通过配置conf/hadoop-env.sh来控制bin目录下执行脚本的变量
配置core-site.xml
可以参考手册和src/core/core-default.xml
[zhouhh@Hadoop48 conf]$ vi core-site.xml

    
    <configuration>
    <property>
      <name>hadoop.mydata.dir</name>
      <value>/home/zhouhh/myhadoop</value>
      <description>A base for other directories.${user.name} </description>
    </property>
    
    <property>
      <name>hadoop.tmp.dir</name>
      <value>/tmp/hadoop-${user.name}</value>
      <description>A base for other temporary directories.</description>
    </property>
    
    <property>
      <name>fs.default.name</name>
      <value>hdfs://Hadoop48:54310</value>
      <description>The name of the default file system.  A URI whose
      scheme and authority determine the FileSystem implementation.  The
      uri's scheme determines the config property (fs.SCHEME.impl) naming
      the FileSystem implementation class.  The uri's authority is used to
      determine the host, port, etc. for a filesystem.</description>
    </property>
    
    </configuration>


其中hadoop.mydata.dir 是我自定义的变量，用于作为数据根目录，以后hdfs的dfs.name.dir和dfs.data.dir全配在该分区下面。
这里，config配置文件有几个变量可以用：
${hadoop.home.dir} 和$HADOOP_HOME 一致。${user.name}和用户名一致。

[zhouhh@Hadoop48 conf]$ vi hdfs-site.xml

    
    <configuration>
    <property>
      <name>hadoop.mydata.dir</name>
      <value>/home/zhouhh/myhadoop</value>
      <description>A base for other directories.${user.name} </description>
    </property>
    
    <property>
      <name>hadoop.tmp.dir</name>
      <value>/tmp/hadoop-${user.name}</value>
      <description>A base for other temporary directories.</description>
    </property>
    
    <property>
      <name>fs.default.name</name>
      <value>hdfs://Hadoop48:54310</value>
      <description>The name of the default file system.  A URI whose
      scheme and authority determine the FileSystem implementation.  The
      uri's scheme determines the config property (fs.SCHEME.impl) naming
      the FileSystem implementation class.  The uri's authority is used to
      determine the host, port, etc. for a filesystem.</description>
    </property>
    
    </configuration>





[zhouhh@Hadoop48 conf]$ vi mapred-site.xml

    
    <configuration>
    <property>
      <name>mapred.job.tracker</name>
      <value>Hadoop48:54311</value>
      <description>The host and port that the MapReduce job tracker runs
      at.  If "local", then jobs are run in-process as a single map
      and reduce task.
      </description>
    </property>
    
    <property>
      <name>mapred.local.dir</name>
      <value>${hadoop.tmp.dir}/mapred/local</value>
      <description>The local directory where MapReduce stores intermediate
      data files.  May be a comma-separated list of
      directories on different devices in order to spread disk i/o.
      Directories that do not exist are ignored.
      </description>
    </property>
    
    <property>
      <name>mapred.system.dir</name>
      <value>${hadoop.mydata.dir}/mapred/system</value>
      <description>The directory where MapReduce stores control files.
      </description>
    </property>
    <property>
      <name>mapred.tasktracker.map.tasks.maximum</name>
      <value>2</value>
      <description>The maximum number of map tasks that will be run
      simultaneously by a task tracker.vary it depending on your hardware
      </description>
    </property>
    
    <property>
      <name>mapred.tasktracker.reduce.tasks.maximum</name>
      <value>2</value>
      <description>The maximum number of reduce tasks that will be run
      simultaneously by a task tracker.vary it depending on your hardware
      </description>
    </property>
    </configuration>








配置可能会随实际情况增减。尤其是有时端口冲突，导致datanode或tasktracker起不来，需求增加相应的配置。参考对应的default配置文件和手册完成。
将配置拷贝到47，46两台机器。

```
[zhouhh@Hadoop48 hadoop-1.0.3]$ ./bin/hadoop namenode -format
12/05/23 17:04:42 INFO namenode.NameNode: STARTUP_MSG:
/************************************************************
STARTUP_MSG: Starting NameNode
STARTUP_MSG: host = Hadoop48/192.168.10.48
STARTUP_MSG: args = [-format]
STARTUP_MSG: version = 1.0.3
STARTUP_MSG: build = https://svn.apache.org/repos/asf/hadoop/common/branches/branch-1.0 -r 1335192; compiled by 'hortonfo' on Tue May 8 20:31:25 UTC 2012
************************************************************/
12/05/23 17:04:42 INFO util.GSet: VM type = 64-bit
12/05/23 17:04:42 INFO util.GSet: 2% max memory = 17.77875 MB
12/05/23 17:04:42 INFO util.GSet: capacity = 2^21 = 2097152 entries
12/05/23 17:04:42 INFO util.GSet: recommended=2097152, actual=2097152
12/05/23 17:04:42 INFO namenode.FSNamesystem: fsOwner=zhouhh
12/05/23 17:04:42 INFO namenode.FSNamesystem: supergroup=supergroup
12/05/23 17:04:42 INFO namenode.FSNamesystem: isPermissionEnabled=true
12/05/23 17:04:42 INFO namenode.FSNamesystem: dfs.block.invalidate.limit=100
12/05/23 17:04:42 INFO namenode.FSNamesystem: isAccessTokenEnabled=false accessKeyUpdateInterval=0 min(s), accessTokenLifetime=0 min(s)
12/05/23 17:04:42 INFO namenode.NameNode: Caching file names occuring more than 10 times
12/05/23 17:04:42 INFO common.Storage: Image file of size 112 saved in 0 seconds.
12/05/23 17:04:42 INFO common.Storage: Storage directory /home/zhouhh/myhadoop/dfs/name has been successfully formatted.
12/05/23 17:04:42 INFO namenode.NameNode: SHUTDOWN_MSG:
/************************************************************
SHUTDOWN_MSG: Shutting down NameNode at Hadoop48/192.168.10.48
************************************************************/
```

因为我前面在.bashrc中加了路径和环境变量，因此，也可以直接用
[zhouhh@Hadoop48 hadoop-1.0.3]$ hadoop namenode -format
该命令格式化hdfs-site.xml里面定义的dfs.name.dir路径，用于保存跟踪和协同DataNode的信息。
[zhouhh@Hadoop48 ~]$ find myhadoop/
myhadoop/
myhadoop/dfs
myhadoop/dfs/name
myhadoop/dfs/name/previous.checkpoint
myhadoop/dfs/name/previous.checkpoint/fstime
myhadoop/dfs/name/previous.checkpoint/edits
myhadoop/dfs/name/previous.checkpoint/fsimage
myhadoop/dfs/name/previous.checkpoint/VERSION
myhadoop/dfs/name/image
myhadoop/dfs/name/image/fsimage
myhadoop/dfs/name/current
myhadoop/dfs/name/current/fstime
myhadoop/dfs/name/current/edits
myhadoop/dfs/name/current/fsimage
myhadoop/dfs/name/current/VERSION

[zhouhh@Hadoop48 hadoop-1.0.3]$ start-dfs.sh
starting namenode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-namenode-Hadoop48.out
Hadoop46: Bad owner or permissions on /home/zhouhh/.ssh/config
Hadoop47: Bad owner or permissions on /home/zhouhh/.ssh/config
Hadoop48: Bad owner or permissions on /home/zhouhh/.ssh/config

[zhouhh@Hadoop48 .ssh]$ ls -l
total 20
-rw------- 1 zhouhh zhouhh 794 Apr 13 10:21 authorized_keys
-rw-rw-r-- 1 zhouhh zhouhh 288 May 23 10:37 config
原来config文件权限不对
[zhouhh@Hadoop48 .ssh]$ chmod 600 config
[zhouhh@Hadoop48 .ssh]$ ls -l
total 20
-rw------- 1 zhouhh zhouhh 794 Apr 13 10:21 authorized_keys
-rw------- 1 zhouhh zhouhh 288 May 23 10:37 config

[zhouhh@Hadoop48 ~]$ start-dfs.sh
starting namenode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-namenode-Hadoop48.out
Hadoop47: bash: line 0: cd: /home/zhouhh/hadoop-1.0.3/libexec/..: No such file or directory
Hadoop47: bash: /home/zhouhh/hadoop-1.0.3/bin/hadoop-daemon.sh: No such file or directory
Hadoop46: starting datanode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-datanode-Hadoop46.out
Hadoop48: starting secondarynamenode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-secondarynamenode-Hadoop48.out

start-dfs.sh会启动本机NameNode 和 conf/slaves 添加的DataNode

[zhouhh@Hadoop48 ~]$ ssh Hadoop47
Last login: Tue May 22 17:57:01 2012 from hadoop48
[zhouhh@Hadoop47 ~]$
[zhouhh@Hadoop47 hadoop-1.0.3]$ vi conf/hadoop-env.sh
配置$JAVA_HOME为正确的路径。
Hadoop46做同样处理。

[zhouhh@Hadoop48 ~]$ start-dfs.sh
starting namenode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-namenode-Hadoop48.out
Hadoop47: starting datanode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-datanode-Hadoop47.out
Hadoop46: starting datanode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-datanode-Hadoop46.out
Hadoop48: secondarynamenode running as process 23491. Stop it first.

HDFS已经运行成功

**排错**
[zhouhh@Hadoop47 logs]$ vi hadoop-zhouhh-datanode-Hadoop47.log

2012-05-23 17:17:14,230 INFO org.apache.hadoop.hdfs.server.datanode.DataNode: STARTUP_MSG:
/************************************************************
STARTUP_MSG: Starting DataNode
STARTUP_MSG: host = Hadoop47/192.168.10.47
STARTUP_MSG: args = []
STARTUP_MSG: version = 1.0.3
STARTUP_MSG: build = https://svn.apache.org/repos/asf/hadoop/common/branches/branch-1.0 -r 1335192; compiled by 'hortonfo' on Tue May 8 20:31:25 UTC 2012
************************************************************/
2012-05-23 17:17:14,762 INFO org.apache.hadoop.metrics2.impl.MetricsConfig: loaded properties from hadoop-metrics2.properties
2012-05-23 17:17:14,772 INFO org.apache.hadoop.metrics2.impl.MetricsSourceAdapter: MBean for source MetricsSystem,sub=Stats registered.
2012-05-23 17:17:14,772 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: Scheduled snapshot period at 10 second(s).
2012-05-23 17:17:14,772 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: DataNode metrics system started
2012-05-23 17:17:14,907 INFO org.apache.hadoop.metrics2.impl.MetricsSourceAdapter: MBean for source ugi registered.
2012-05-23 17:17:15,064 INFO org.apache.hadoop.util.NativeCodeLoader: Loaded the native-hadoop library
2012-05-23 17:17:15,187 ERROR org.apache.hadoop.hdfs.server.datanode.DataNode: java.lang.IllegalArgumentException: Does not contain a valid host:port authority: file:///
at org.apache.hadoop.net.NetUtils.createSocketAddr(NetUtils.java:162)
at org.apache.hadoop.hdfs.server.namenode.NameNode.getAddress(NameNode.java:198)
at org.apache.hadoop.hdfs.server.namenode.NameNode.getAddress(NameNode.java:228)
at org.apache.hadoop.hdfs.server.namenode.NameNode.getServiceAddress(NameNode.java:222)
at org.apache.hadoop.hdfs.server.datanode.DataNode.startDataNode(DataNode.java:337)
at org.apache.hadoop.hdfs.server.datanode.DataNode.(DataNode.java:299)
at org.apache.hadoop.hdfs.server.datanode.DataNode.makeInstance(DataNode.java:1582)
at org.apache.hadoop.hdfs.server.datanode.DataNode.instantiateDataNode(DataNode.java:1521)
at org.apache.hadoop.hdfs.server.datanode.DataNode.createDataNode(DataNode.java:1539)
at org.apache.hadoop.hdfs.server.datanode.DataNode.secureMain(DataNode.java:1665)
at org.apache.hadoop.hdfs.server.datanode.DataNode.main(DataNode.java:1682)

2012-05-23 17:17:15,187 INFO org.apache.hadoop.hdfs.server.datanode.DataNode: SHUTDOWN_MSG:
/************************************************************
SHUTDOWN_MSG: Shutting down DataNode at Hadoop47/192.168.10.47
************************************************************/
同样，需要配置相关的端口
[zhouhh@Hadoop48 bin]$ start-mapred.sh

[zhouhh@Hadoop48 ~]$ ssh Hadoop46
Last login: Wed May 23 17:33:05 2012 from hadoop47
[zhouhh@Hadoop46 ~]$ cd hadoop-1.0.3/logs
[zhouhh@Hadoop46 logs]$ vi hadoop-zhouhh-datanode-Hadoop46.log
2012-05-23 17:38:46,062 INFO org.apache.hadoop.ipc.Client: Retrying connect to server: Hadoop48/192.168.10.48:54310. Already tried 0 time(s).
2012-05-23 17:38:47,065 INFO org.apache.hadoop.ipc.Client: Retrying connect to server: Hadoop48/192.168.10.48:54310. Already tried 1 time(s).

[zhouhh@Hadoop46 logs]$ vi hadoop-zhouhh-tasktracker-Hadoop46.log
2012-05-23 17:58:13,356 INFO org.apache.hadoop.ipc.Server: IPC Server handler 3 on 54550: starting
2012-05-23 17:58:14,428 INFO org.apache.hadoop.ipc.Client: Retrying connect to server: Hadoop48/192.168.10.48:54311. Already tried 0 time(s).
2012-05-23 17:58:15,430 INFO org.apache.hadoop.ipc.Client: Retrying connect to server: Hadoop48/192.168.10.48:54311. Already tried 1 time(s).

[zhouhh@Hadoop48 conf]$ netstat -antp | grep 54310
(Not all processes could be identified, non-owned process info
will not be shown, you would have to be root to see it all.)
tcp 0 0 192.168.10.48:54310 192.168.20.188:30300 ESTABLISHED 20469/python
[zhouhh@Hadoop48 conf]$ netstat -antp | grep 54311
(Not all processes could be identified, non-owned process info
will not be shown, you would have to be root to see it all.)
tcp 0 0 192.168.10.48:54311 192.168.20.188:30300 TIME_WAIT -
原来端口被占用了，将相关占用端口python程序停掉。

[zhouhh@Hadoop48 hadoop-1.0.3]$ stop-mapred.sh
[zhouhh@Hadoop48 hadoop-1.0.3]$ stop-dfs.sh
[zhouhh@Hadoop48 hadoop-1.0.3]$ start-dfs.sh
starting namenode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-namenode-Hadoop48.out
Hadoop47: starting datanode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-datanode-Hadoop47.out
Hadoop46: starting datanode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-datanode-Hadoop46.out
Hadoop48: starting secondarynamenode, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-secondarynamenode-Hadoop48.out

[zhouhh@Hadoop48 hadoop-1.0.3]$ netstat -antp | grep 54310
(Not all processes could be identified, non-owned process info
will not be shown, you would have to be root to see it all.)
tcp 0 0 192.168.10.48:54310 0.0.0.0:* LISTEN 24716/java
tcp 0 0 192.168.10.48:51040 192.168.10.48:54310 TIME_WAIT -
tcp 0 0 192.168.10.48:51038 192.168.10.48:54310 TIME_WAIT -
tcp 0 0 192.168.10.48:54310 192.168.10.46:38202 ESTABLISHED 24716/java
[zhouhh@Hadoop48 hadoop-1.0.3]$ start-mapred.sh
starting jobtracker, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-jobtracker-Hadoop48.out
Hadoop46: starting tasktracker, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-tasktracker-Hadoop46.out
Hadoop47: starting tasktracker, logging to /home/zhouhh/hadoop-1.0.3/libexec/../logs/hadoop-zhouhh-tasktracker-Hadoop47.out
[zhouhh@Hadoop48 hadoop-1.0.3]$ netstat -antp | grep 54311
(Not all processes could be identified, non-owned process info
will not be shown, you would have to be root to see it all.)
tcp 0 0 192.168.10.48:54311 0.0.0.0:* LISTEN 25238/java
tcp 0 0 192.168.10.48:54311 192.168.10.46:33561 ESTABLISHED 25238/java
tcp 0 0 192.168.10.48:54311 192.168.10.47:55277 ESTABLISHED 25238/java

查看DataNode的log，已经正常。
[zhouhh@Hadoop48 hadoop-1.0.3]$ jps
24716 NameNode
25625 Jps
25238 JobTracker
24909 SecondaryNameNode
[zhouhh@Hadoop46 ~]$ jps
10649 TaskTracker
10352 DataNode
10912 Jps

==========================
**MapReduce 测试**
==========================
[zhouhh@Hadoop48 ~]$ vi test.txt
a b c d
a b c d
aa bb cc dd
ee ff gg hh

由前面.bashrc设置，fs为hadoop dfs的别称
hls为 hadoop -ls的别称
[zhouhh@Hadoop48 hadoop-1.0.3]$ fs -put test.txt test.txt
[zhouhh@Hadoop48 hadoop-1.0.3]$ hls
Found 1 items
-rw-r--r-- 3 zhouhh supergroup 40 2012-05-23 19:39 /user/zhouhh/test.txt

执行mapreduce测试wordcount例子：

```
[zhouhh@Hadoop48 hadoop-1.0.3]$ ./bin/hadoop jar hadoop-examples-1.0.3.jar wordcount /user/zhouhh/test.txt output
12/05/23 19:40:52 INFO input.FileInputFormat: Total input paths to process : 1
12/05/23 19:40:52 INFO util.NativeCodeLoader: Loaded the native-hadoop library
12/05/23 19:40:52 WARN snappy.LoadSnappy: Snappy native library not loaded
12/05/23 19:40:52 INFO mapred.JobClient: Running job: job_201205231824_0001
12/05/23 19:40:53 INFO mapred.JobClient: map 0% reduce 0%
12/05/23 19:41:07 INFO mapred.JobClient: map 100% reduce 0%
12/05/23 19:41:19 INFO mapred.JobClient: map 100% reduce 100%
12/05/23 19:41:24 INFO mapred.JobClient: Job complete: job_201205231824_0001
12/05/23 19:41:24 INFO mapred.JobClient: Counters: 29
12/05/23 19:41:24 INFO mapred.JobClient: Job Counters
12/05/23 19:41:24 INFO mapred.JobClient: Launched reduce tasks=1
12/05/23 19:41:24 INFO mapred.JobClient: SLOTS_MILLIS_MAPS=11561
12/05/23 19:41:24 INFO mapred.JobClient: Total time spent by all reduces waiting after reserving slots (ms)=0
12/05/23 19:41:24 INFO mapred.JobClient: Total time spent by all maps waiting after reserving slots (ms)=0
12/05/23 19:41:24 INFO mapred.JobClient: Launched map tasks=1
12/05/23 19:41:24 INFO mapred.JobClient: Data-local map tasks=1
12/05/23 19:41:24 INFO mapred.JobClient: SLOTS_MILLIS_REDUCES=9934
12/05/23 19:41:24 INFO mapred.JobClient: File Output Format Counters
12/05/23 19:41:24 INFO mapred.JobClient: Bytes Written=56
12/05/23 19:41:24 INFO mapred.JobClient: FileSystemCounters
12/05/23 19:41:24 INFO mapred.JobClient: FILE_BYTES_READ=110
12/05/23 19:41:24 INFO mapred.JobClient: HDFS_BYTES_READ=147
12/05/23 19:41:24 INFO mapred.JobClient: FILE_BYTES_WRITTEN=43581
12/05/23 19:41:24 INFO mapred.JobClient: HDFS_BYTES_WRITTEN=56
12/05/23 19:41:24 INFO mapred.JobClient: File Input Format Counters
12/05/23 19:41:24 INFO mapred.JobClient: Bytes Read=40
12/05/23 19:41:24 INFO mapred.JobClient: Map-Reduce Framework
12/05/23 19:41:24 INFO mapred.JobClient: Map output materialized bytes=110
12/05/23 19:41:24 INFO mapred.JobClient: Map input records=4
12/05/23 19:41:24 INFO mapred.JobClient: Reduce shuffle bytes=110
12/05/23 19:41:24 INFO mapred.JobClient: Spilled Records=24
12/05/23 19:41:24 INFO mapred.JobClient: Map output bytes=104
12/05/23 19:41:24 INFO mapred.JobClient: CPU time spent (ms)=1490
12/05/23 19:41:24 INFO mapred.JobClient: Total committed heap usage (bytes)=194969600
12/05/23 19:41:24 INFO mapred.JobClient: Combine input records=16
12/05/23 19:41:24 INFO mapred.JobClient: SPLIT_RAW_BYTES=107
12/05/23 19:41:24 INFO mapred.JobClient: Reduce input records=12
12/05/23 19:41:24 INFO mapred.JobClient: Reduce input groups=12
12/05/23 19:41:24 INFO mapred.JobClient: Combine output records=12
12/05/23 19:41:24 INFO mapred.JobClient: Physical memory (bytes) snapshot=271958016
12/05/23 19:41:24 INFO mapred.JobClient: Reduce output records=12
12/05/23 19:41:24 INFO mapred.JobClient: Virtual memory (bytes) snapshot=1126625280
12/05/23 19:41:24 INFO mapred.JobClient: Map output records=16
```

可见，效率不高，但成功了。
[zhouhh@Hadoop48 ~]$ hls
Found 2 items
drwxr-xr-x - zhouhh supergroup 0 2012-05-23 19:41 /user/zhouhh/output
-rw-r--r-- 3 zhouhh supergroup 40 2012-05-23 19:39 /user/zhouhh/test.txt
hls所列，实际存在于分布式系统中。
[zhouhh@Hadoop48 ~]$ hadoop dfs -get /user/zhouhh/output .
[zhouhh@Hadoop48 ~]$ cat output/*
cat: output/_logs: Is a directory
a 2
aa 1
b 2
bb 1
c 2
cc 1
d 2
dd 1
ee 1
ff 1
gg 1
hh 1
或直接远程查看：
[zhouhh@Hadoop48 ~]$ hadoop dfs -cat output/*
cat: File does not exist: /user/zhouhh/output/_logs
a 2
aa 1
...

可见，分布式hadoop配置成功。

**参考：**
群集配置教程：http://hadoop.apache.org/common/docs/r1.0.3/cluster_setup.html
命令手册：http://hadoop.apache.org/common/docs/r1.0.3/file_system_shell.html
hdfs手册：http://hadoop.apache.org/common/docs/r1.0.3/hdfs_user_guide.html
