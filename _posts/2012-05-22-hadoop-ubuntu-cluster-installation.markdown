---
author: abloz
comments: true
date: 2012-05-22 10:08:11+00:00
layout: post
link: http://abloz.com/index.php/2012/05/22/hadoop-ubuntu-cluster-installation/
slug: hadoop-ubuntu-cluster-installation
title: hadoop ubuntu集群安装
wordpress_id: 1595
categories:
- 技术
tags:
- hadoop
- ubuntu
---


andy@ubuntu:~$ sudo apt-get install openjdk-6-jre openjdk-6-jdk

andy@ubuntu:~$ java -version
java version "1.6.0_20"
OpenJDK Runtime Environment (IcedTea6 1.9.13) (6b20-1.9.13-0ubuntu1~10.04.1)
OpenJDK 64-Bit Server VM (build 19.0-b09, mixed mode)

master:NameNode,JobTracker
master203
slaves:DataNode,TaskTracker
node205,node206
andy@ubuntu:~$ sudo addgroup hadoop

andy@ubuntu:~$ sudo adduser --ingroup hadoop hduser

用visudo将hduser添加到sudoers里面。

andy@ubuntu:~$ su - hduser

hduser@ubuntu:~$ ssh-keygen -t rsa -P ""

hduser@ubuntu:~$ cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys



hduser@ubuntu:~$ vi .ssh/config

Host master203
        Port 50022
        HostName 124.207.177.203
        IdentityFile ~/.ssh/id_rsa

Host node205
        Port 50022
        HostName 124.207.177.205
        IdentityFile ~/.ssh/id_rsa


Host node206
        Port 50022
        HostName 124.207.177.206
        IdentityFile ~/.ssh/id_rsa



hduser@ubuntu:~$ chmod 600 .ssh/config

 save your local machine’s host key fingerprint to the hduser user’s known_hosts file
hduser@ubuntu:~$ ssh master
The authenticity of host '[124.207.177.203]:50022 ([124.207.177.203]:50022)' can't be established.
RSA key fingerprint is 4e:ae:62:83:44:8f:1c:56:a1:80:33:82:68:82:aa:af.
Are you sure you want to continue connecting (yes/no)? yes

debug
 ssh -vvv master

 /etc/ssh/sshd_config, in particular the options PubkeyAuthentication (which should be set to yes) and AllowUsers (if this option is active, add the hduser user to it). If you made any changes to the SSH server configuration file, you can force a configuration reload with sudo /etc/init.d/ssh reload.

更改主机名：
hduser@ubuntu:~$ sudo vi /etc/hostname
改为
master203
再执行sudo hostname master203
使hostname生效。

修改hosts文件
hduser@master203:~$ sudo vi /etc/hosts
124.207.177.203 master203
124.207.177.205 node205
124.207.177.206 node206

hduser@master203:~$ scp -P 50022 .ssh/id_rsa hduser@124.207.177.205:~/.ssh

hduser@master203:~$ scp -P 50022 .ssh/id_rsa.pub hduser@124.207.177.205:~/.ssh

hduser@node205:~/.ssh$ cat id_rsa.pub >> authorized_keys

download Hadoop:
http://www.apache.org/dyn/closer.cgi/hadoop/core
http://labs.renren.com/apache-mirror/hadoop/core

hduser@master203:~$ wget http://labs.renren.com/apache-mirror/hadoop/core/hadoop-1.0.2/hadoop_1.0.2-1_x86_64.deb

hduser@master203:~$ sudo dpkg -i hadoop_1.0.2-1_x86_64.deb

hduser@master203:~$ sudo vi /etc/hadoop/masters
将localhost改为
master203
hduser@master203:~$ sudo vi /etc/hadoop/slaves
将localhost去掉，并改为
master203
node205
node206

hduser@master203:~$ ls /usr/lib/jvm/
java-1.6.0-openjdk  java-6-openjdk
hduser@master203:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=10.04
DISTRIB_CODENAME=lucid
DISTRIB_DESCRIPTION="Ubuntu 10.04.3 LTS"
hduser@master203:~$ uname -a
Linux master203 2.6.32-33-server #70-Ubuntu SMP Thu Jul 7 22:28:30 UTC 2011 x86_64 GNU/Linux

配置
1.只读缺省配置文件：src/core/core-default.xml, src/hdfs/hdfs-default.xml src/mapred/mapred-default.xml.
2.站点特定文件：conf/core-site.xml, conf/hdfs-site.xml  conf/mapred-site.xml
hduser@master203:~$ sudo vi /etc/hadoop/hadoop-env.sh

#export JAVA_HOME=/usr/lib/jvm/java-6-sun
根据版本修改
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
还可以配
Daemon			Configure Options
-------------------------------------------
NameNode		HADOOP_NAMENODE_OPTS
DataNode		HADOOP_DATANODE_OPTS
SecondaryNamenode	HADOOP_SECONDARYNAMENODE_OPTS
JobTracker		HADOOP_JOBTRACKER_OPTS
TaskTracker		HADOOP_TASKTRACKER_OPTS

这两个可能会更改：
HADOOP_LOG_DIR，log目录
HADOOP_HEAPSIZE，daemon最大heap值，缺省是1000MB

添加文件core-site.xml
添加属性fs.default.name，值为NameNode 的URI，如hdfs://master203:9000
hduser@master203:~$ sudo vi /etc/hadoop/core-site.xml



    
        fs.default.name
        hdfs://master203:9000
    


hduser@master203:~$ sudo vi /etc/hadoop/hdfs-site.xml


  dfs.replication
  3
  Default block replication.
  

value值根据实际情况填写。
hduser@master203:~$ sudo vi /etc/hadoop/mapred-site.xml

     
         mapred.job.tracker
         master203:9001
     


参考：
http://hadoop.apache.org/common/docs/r1.0.2/api/org/apache/hadoop/conf/Configuration.html
http://hadoop.apache.org/common/docs/r1.0.2/single_node_setup.html
http://hadoop.apache.org/common/docs/r1.0.2/cluster_setup.html
http://hadoop.apache.org/hdfs/docs/current/hdfs_design.html
http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/
http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-multi-node-cluster/
