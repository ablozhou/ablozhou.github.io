---
author: abloz
comments: true
date: 2012-09-27 10:33:48+00:00
layout: post
link: http://abloz.com/index.php/2012/09/27/hadoop-1-0-3-namenode-real-time-backup/
slug: hadoop-1-0-3-namenode-real-time-backup
title: hadoop 1.0.3 NameNode 实时备份
wordpress_id: 1897
categories:
- 技术
tags:
- hadoop
- namenode
---

作者：周海汉
网址：http://abloz.com
日期：2012.9.27

上一篇文章[讲到NFS安装](http://abloz.com/2012/09/27/centos-5-5-nfs-installation.html)。本篇基于上一篇的配置。前一篇讲到[secondnamenode备份测试](http://abloz.com/2012/09/26/the-namenode-collapse-data-recovery-test.html)，以防[namenode崩溃](http://abloz.com/2012/09/26/the-namenode-collapse-data-recovery-test.html)。本篇讲利用NFS进行NameNode数据实时备份。

**编辑配置文件**

[zhouhh@Hadoop48 conf]$ vi hdfs-site.xml
<property>
<name>dfs.name.dir</name>
<value>${hadoop.mydata.dir}/dfs/name,${hadoop.mydata.dir}/name_bak</value>
</property>

记得将配置文件同步到其他机器。
修改曾修改userid和groupid的文件属性
[zhouhh@Hadoop47 ~]$ ls -al
total 157988
drwx------ 8 zhouhh 668 4096 Sep 27 14:30 .
drwxr-xr-x 9 root root 4096 May 22 17:51 ..
drwxr-xr-x 17 zhouhh 668 4096 Sep 19 15:07 hadoop-1.0.3

[zhouhh@Hadoop47 ~]$ sudo chown zhouhh:zhouhh .* -R

[zhouhh@Hadoop47 ~]$ ls -al
total 157988
drwx------ 8 zhouhh zhouhh 4096 Sep 27 14:30 .
drwxr-xr-x 9 zhouhh zhouhh 4096 May 22 17:51 ..
drwxr-xr-x 17 zhouhh zhouhh 4096 Sep 19 15:07 hadoop-1.0.3
[zhouhh@Hadoop48 ~]$ start-all.sh

问题：
2012-09-27 16:21:31,947 ERROR common.Storage - Cannot create lock on /data/zhouhh/myhadoop/name_bak/in_use.lock
java.io.IOException: No locks available
2012-09-27 16:21:31,949 ERROR namenode.FSNamesystem - FSNamesystem initialization failed.
java.io.IOException: No locks available
2012-09-27 16:21:31,949 ERROR namenode.NameNode - java.io.IOException: No locks available
解决办法，nfs client和server端启动nfslock服务即可：
[zhouhh@Hadoop47 myhadoop]$ sudo service nfslock restart
Stopping NFS locking: [ OK ]
Stopping NFS statd: [ OK ]
Starting NFS statd: [ OK ]
[zhouhh@Hadoop48 hadoop-1.0.3]$ sudo service nfslock start
Starting NFS statd: [ OK ]
[zhouhh@Hadoop48 hadoop-1.0.3]$ start-all.sh



问题
Hadoop47: /home/zhouhh/hadoop-1.0.3/bin/hadoop-daemon.sh: line 136: /tmp/hadoop-zhouhh-secondarynamenode.pid: Permission denied
Hadoop47: Exception in thread "main" java.net.BindException: Address already in use
[zhouhh@Hadoop47 myhadoop]$ ls /tmp -l
total 72
drwxrwxr-x 4 668 668 4096 Sep 25 18:55 hadoop-zhouhh
-rw-rw-r-- 1 668 668 5 Sep 26 11:04 hadoop-zhouhh-datanode.pid
-rw-rw-r-- 1 668 668 5 Sep 26 11:04 hadoop-zhouhh-secondarynamenode.pid
-rw-rw-r-- 1 668 668 5 Sep 26 11:04 hadoop-zhouhh-tasktracker.pid
还是文件所有权属性的问题
[zhouhh@Hadoop47 tmp]$ sudo chown zhouhh:zhouhh hadoop-zhouhh -R
...
[zhouhh@Hadoop47 tmp]$ ls -l
total 72
drwxrwxr-x 4 zhouhh zhouhh 4096 Sep 25 18:55 hadoop-zhouhh
-rw-rw-r-- 1 zhouhh zhouhh 5 Sep 26 11:04 hadoop-zhouhh-datanode.pid
-rw-rw-r-- 1 zhouhh zhouhh 5 Sep 26 11:04 hadoop-zhouhh-secondarynamenode.pid
-rw-rw-r-- 1 zhouhh zhouhh 5 Sep 26 11:04 hadoop-zhouhh-tasktracker.pid

另外还有原用户id运行的程序，必须杀掉，占着端口
[zhouhh@Hadoop47 tmp]$ ps -ef
UID PID PPID C STIME TTY TIME CMD
668 1824 1 0 Sep26 ? 00:01:49 /usr/java/jdk1.7.0/bin/java -Dproc_secondarynamenode -Xmx1000m
[zhouhh@Hadoop47 tmp]$ kill -9 1824
-bash: kill: (1824) - Operation not permitted
[zhouhh@Hadoop47 tmp]$ sudo kill -9 1824
[zhouhh@Hadoop47 tmp]$ jps
25704 Jps
25566 TaskTracker
25458 SecondaryNameNode

问题：DataNode没起来
[zhouhh@Hadoop47 logs]$ vi hadoop-zhouhh-datanode-Hadoop47.log
2012-09-27 16:54:25,233 ERROR datanode.DataNode - java.io.IOException: Cannot lock storage /data/zhouhh/myhadoop/dfs/data. The directory is already locked.
2012-09-27 16:54:19,890 WARN datanode.DataNode - java.io.IOException: Call to Hadoop48/192.168.10.48:54310 failed on local exception: java.io.IOException: Connection reset by peer
[zhouhh@Hadoop47 logs]$ jps
25883 Jps
[zhouhh@Hadoop47 logs]$ ps -ef
UID PID PPID C STIME TTY TIME CMD
zhouhh 24804 1 0 16:45 ? 00:00:01 /usr/java/jdk1.7.0/bin/java -Dproc_datanode -Xmx1000m -server
datanode进程还在，占着端口。但由于用户改了id，所以jps列不出来了。stop-all也无法停止。手动杀死。

[zhouhh@Hadoop48 hadoop-1.0.3]$ start-all.sh
[zhouhh@Hadoop48 myhadoop]$ diff -r name_bak/ dfs/name
diff -r name_bak/current/VERSION dfs/name/current/VERSION
1c1
< #Thu Sep 27 17:09:48 CST 2012
---
> #Thu Sep 27 17:09:47 CST 2012
所以网络盘和本地盘一致。
