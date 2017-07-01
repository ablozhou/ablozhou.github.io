---
layout: post
title:  "hadoop3安装试用"
author: "周海汉"
date:   2017-07-01 20:18:26 +0800
categories: tech
tags:
    - hadoop
---

# 下载
[hadoop 3 下载](http://hadoop.apache.org/releases.html)
目前是 2017年5月发布的3.0.0-alpha3

```
wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.0.0-alpha3/hadoop-3.0.0-alpha3.tar.gz
```

# java环境
需要java sdk 1.7 以上

```
[zhouhh@mainServer hadoop-3.0.0-alpha3]$ !cat
cat /etc/redhat-release
CentOS Linux release 7.1.1503 (Core)
[zhouhh@mainServer hadoop-3.0.0-alpha3]$ echo $JAVA_HOME
/etc/alternatives/java_sdk_openjdk
[zhouhh@mainServer
[zhouhh@mainServer hadoop-3.0.0-alpha3]$ java -version
openjdk version "1.8.0_131"
OpenJDK Runtime Environment (build 1.8.0_131-b12)
OpenJDK 64-Bit Server VM (build 25.131-b12, mixed mode)
hadoop-3.0.0-alpha3]$ javac -version
javac 1.8.0_131



```

# 启动hadoop单节点

```
下面的命令可以看到帮助信息
[zhouhh@mainServer hadoop-3.0.0-alpha3]$ ./bin/hadoop
Usage: hadoop [OPTIONS] SUBCOMMAND [SUBCOMMAND OPTIONS]
 or    hadoop [OPTIONS] CLASSNAME [CLASSNAME OPTIONS]
  where CLASSNAME is a user-provided Java class

  OPTIONS is none or any of:

buildpaths                       attempt to add class files from build tree
--config dir                     Hadoop config directory
--debug                          turn on shell script debug mode
--help                           usage information
hostnames list[,of,host,names]   hosts to use in slave mode
hosts filename                   list of hosts to use in slave mode
loglevel level                   set the log4j level for this command
workers                          turn on worker mode

  SUBCOMMAND is one of:

archive       create a Hadoop archive
checknative   check native Hadoop and compression libraries availability
classpath     prints the class path needed to get the Hadoop jar and the required libraries
conftest      validate configuration XML files
credential    interact with credential providers
daemonlog     get/set the log level for each daemon
distch        distributed metadata changer
distcp        copy file or directories recursively
dtutil        operations related to delegation tokens
envvars       display computed Hadoop environment variables
fs            run a generic filesystem user client
gridmix       submit a mix of synthetic job, modeling a profiled from production load
jar <jar>     run a jar file. NOTE: please use "yarn jar" to launch YARN applications, not this command.
jnipath       prints the java.library.path
kerbname      show auth_to_local principal conversion
key           manage keys via the KeyProvider
kms           run KMS, the Key Management Server
rumenfolder   scale a rumen input trace
rumentrace    convert logs into a rumen trace
trace         view and modify Hadoop tracing settings
version       print the version

SUBCOMMAND may print help when invoked w/o parameters or with -h.
```

```
[zhouhh@mainServer java]$ ln -s hadoop-3.0.0-alpha3 hadoop

[zhouhh@mainServer ~]$ vi .bashrc

export HADOOP_HOME="${HOME}/java/hadoop"
export PATH="$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$PATH"
[zhouhh@mainServer ~]$ source .bashrc

```
下面的命令将etc下面的配置文件作为输入, 查找相关内容,并放到输出.
```
[zhouhh@mainServer ~]$ cd test
[zhouhh@mainServer test]$ ls
cnn.py
[zhouhh@mainServer test]$ mkdir hadoop
[zhouhh@mainServer test]$ cd hadoop
[zhouhh@mainServer hadoop]$ ls
[zhouhh@mainServer hadoop]$ mkdir input
[zhouhh@mainServer hadoop]$ cp $HADOOP_HOME/etc/hadoop/*.xml input
[zhouhh@mainServer hadoop]$ ls input
capacity-scheduler.xml  core-site.xml  hadoop-policy.xml  hdfs-site.xml  httpfs-site.xml  kms-acls.xml  kms-site.xml  yarn-site.xml
[zhouhh@mainServer hadoop]$ hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.0.0-alpha3.jar grep input output 'dfs[a-z.]+'
[zhouhh@mainServer hadoop]$ ls output/
part-r-00000  _SUCCESS
[zhouhh@mainServer hadoop]$ cat output/*
1	dfsadmin

```
# 伪分布式配置
可以在一台设备启动多个hadoop java进程.

```
[zhouhh@mainServer hadoop]$ vi core-site.xml

<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>

[zhouhh@mainServer hadoop]$ vi hdfs-site.xml


<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>

```

确认本地ssh不需要密码
```
[zhouhh@mainServer hadoop]$ ssh localhost
Last login: Thu Jun 29 12:15:14 2017 from localhost
```
如果需要密码,则执行下面的命令:

```
[zhouhh@mainServer ~]$ ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
[zhouhh@mainServer ~]$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
[zhouhh@mainServer ~]$ chmod 0600 ~/.ssh/authorized_keys
```

创建主节点
```
[zhouhh@mainServer ~]$ hdfs namenode -format
```
会在下面的目录创建格式化主节点
/tmp/hadoop-zhouhh/dfs/name

```
[zhouhh@mainServer ~]$ start-dfs.sh
Starting namenodes on [localhost]
Starting datanodes
Starting secondary namenodes [mainServer]

ssh: Could not resolve hostname mainserver: Name or service not known
```

```
[zhouhh@mainServer ~]$ sudo vi /etc/hosts

10.6.0.200 msvr
[zhouhh@mainServer ~]$ sudo hostname msvr
[zhouhh@msvr ~]$ sudo vi /etc/hostname
msvr

[zhouhh@msvr ~]$ stop-dfs.sh
Stopping namenodes on [localhost]
Stopping datanodes
Stopping secondary namenodes [msvr]
[zhouhh@msvr ~]$ start-dfs.sh
Starting namenodes on [localhost]
Starting datanodes
Starting secondary namenodes [msvr]
```
日志在$HADOOP_LOG_DIR 目录 (缺省值 $HADOOP_HOME/logs).
可以通过 http://10.6.0.200:9870/ 访问name node的web页面,本地访问 http://localhost:9870/

# 操作hdfs

```
[zhouhh@msvr ~]$ hdfs
Usage: hdfs [OPTIONS] SUBCOMMAND [SUBCOMMAND OPTIONS]

  OPTIONS is none or any of:

--buildpaths                       attempt to add class files from build tree
--config dir                       Hadoop config directory
--daemon (start|status|stop)       operate on a daemon
--debug                            turn on shell script debug mode
--help                             usage information
--hostnames list[,of,host,names]   hosts to use in worker mode
--hosts filename                   list of hosts to use in worker mode
--loglevel level                   set the log4j level for this command
--workers                          turn on worker mode

  SUBCOMMAND is one of:

balancer             run a cluster balancing utility
cacheadmin           configure the HDFS cache
classpath            prints the class path needed to get the hadoop jar and the required libraries
crypto               configure HDFS encryption zones
datanode             run a DFS datanode
debug                run a Debug Admin to execute HDFS debug commands
dfsadmin             run a DFS admin client
dfs                  run a filesystem command on the file system
diskbalancer         Distributes data evenly among disks on a given node
envvars              display computed Hadoop environment variables
erasurecode          run a HDFS ErasureCoding CLI
fetchdt              fetch a delegation token from the NameNode
fsck                 run a DFS filesystem checking utility
getconf              get config values from configuration
groups               get the groups which users belong to
haadmin              run a DFS HA admin client
jmxget               get JMX exported values from NameNode or DataNode.
journalnode          run the DFS journalnode
lsSnapshottableDir   list all snapshottable dirs owned by the current user
mover                run a utility to move block replicas across storage types
namenode             run the DFS namenode
nfs3                 run an NFS version 3 gateway
oev                  apply the offline edits viewer to an edits file
oiv                  apply the offline fsimage viewer to an fsimage
oiv_legacy           apply the offline fsimage viewer to a legacy fsimage
portmap              run a portmap service
secondarynamenode    run the DFS secondary namenode
snapshotDiff         diff two snapshots of a directory or diff the current directory contents with a snapshot
storagepolicies      list/get/set block storage policies
version              print the version
zkfc                 run the ZK Failover Controller daemon

SUBCOMMAND may print help when invoked w/o parameters or with -h.

```

```
[zhouhh@msvr ~]$ hdfs dfs -ls /
Found 1 items
drwxr-xr-x   - zhouhh supergroup          0 2017-06-29 15:17 /user
[zhouhh@msvr ~]$ hdfs dfs -mkdir /user/zhouhh
[zhouhh@msvr ~]$ hdfs dfs -mkdir input
[zhouhh@msvr ~]$ hdfs dfs -ls /user
Found 1 items
drwxr-xr-x   - zhouhh supergroup          0 2017-06-29 15:41 /user/zhouhh
[zhouhh@msvr ~]$ hdfs dfs -ls /user/zhouhh
Found 1 items
drwxr-xr-x   - zhouhh supergroup          0 2017-06-29 15:41 /user/zhouhh/input
[zhouhh@msvr ~]$ hdfs dfs -put $HADOOP_HOME/etc/hadoop/*.xml input

[zhouhh@msvr ~]$ hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.0.0-alpha3.jar grep input output 'dfs[a-z.]+'
[zhouhh@msvr ~]$ hdfs dfs -cat /user/zhouhh/output/*
1	dfsadmin
1	dfs.replication

或者
[zhouhh@msvr ~]$ hdfs dfs -cat output/*
1	dfsadmin
1	dfs.replication
或者拉到本地
[zhouhh@msvr hadoop]$ hdfs dfs -get output output


```

# 单机的Yarn
可以在Yarn上运行MapReduce任务. 设置一些参数, 并且运行ResourceManager和NodeManager的后台程序.

```
[zhouhh@msvr hadoop]$ cd etc/hadoop/
[zhouhh@msvr hadoop]$ cp mapred-site.xml.template mapred-site.xml
[zhouhh@msvr hadoop]$ vi mapred-site.xml

<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>

[zhouhh@msvr hadoop]$ vi yarn-site.xml
<configuration>

<!-- Site specific YARN configuration properties -->
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.env-whitelist</name>
        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
    </property>
</configuration>

```

开启ResourceManager daemon 和 NodeManager daemon

```
[zhouhh@msvr hadoop]$ start-yarn.sh
Starting resourcemanager
Starting nodemanagers
```
访问
http://10.6.0.200:8088/
或本机
http://localhost:8088/
进入ResourceManager web页面

# 执行Mapreduce任务

```
[zhouhh@msvr hadoop]$ hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.0.0-alpha3.jar grep input output 'dfs[a-z.]+'

org.apache.hadoop.mapred.FileAlreadyExistsException: Output directory hdfs://localhost:9000/user/zhouhh/output already exists
```
将此前生成的output目录清除,即去除上述错误.
可以在http://10.6.0.200:8088/看到上述任务的调度情况.

# 停止Yarn

```
[zhouhh@msvr hadoop]$ stop-yarn.sh
```
# HDFS架构
![image](http://hadoop.apache.org/docs/r3.0.0-alpha3/hadoop-project-dist/hadoop-hdfs/images/hdfsarchitecture.png)
