---
author: abloz
comments: true
date: 2012-06-07 03:30:37+00:00
layout: post
link: http://abloz.com/index.php/2012/06/07/the-hbase-cluster-installation-and-configuration/
slug: the-hbase-cluster-installation-and-configuration
title: hbase 集群安装配置
wordpress_id: 1677
categories:
- 技术
tags:
- hbase
---

http://abloz.com

date:2012.6.7

有了[hadoop集群安装](http://abloz.com/2012/05/23/hadoop-three-node-cluster-installation-configuration-details-an-instance-of.html)的经验，hbase的安装还是比较简单的。

拓扑还是同hadoop一样，HBase Master为hadoop48，另外两台hadoop46，hadoop47作为region server。



**下载hbase**

****hbase版本需与hadoop相配。但版本号hbase和hadoop已经不再一致。目前最新版hadoop版本是1.0.3,而hbase是0.94.

[http://www.apache.org/dyn/closer.cgi/hbase/](http://www.apache.org/dyn/closer.cgi/hbase/)

hbase最新版0.94

http://labs.renren.com/apache-mirror/hbase/hbase-0.94.0/hbase-0.94.0.tar.gz



**配置**

下载后，先解压，然后进入conf目录，编辑配置：

[zhouhh@Hadoop48 conf]$ vi hbase-site.xml

在configuration里添加：

    
    <property>
        <name>hbase.rootdir</name>
        <!-- value>file:///home/zhouhh/hbase</value -->
        <value>hdfs://Hadoop48:54310/hbase</value>
      </property>
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
    </property>
    <property>
        <name>hbase.master.port</name>
        <value>60000</value>
      </property>
    <property>
          <name>hbase.zookeeper.quorum</name>
          <value>Hadoop48,Hadoop47,Hadoop46</value>
    </property>




**编辑env**

设置JAVA_HOME：

[zhouhh@Hadoop48 conf]$ vi hbase-env.sh

export JAVA_HOME=/usr/java/jdk1.7.0/



**编辑regionservers：**

[zhouhh@Hadoop48 conf]$ vi regionservers

    
    Hadoop46
    Hadoop47


添加两个RegionServer



**配置另外两台**

将hbase安装文件拷贝到另两台机器

[zhouhh@Hadoop48 conf]$ scp hbase-0.94.0.tar.gz zhouhh@Hadoop47:~/.

[zhouhh@Hadoop48 conf]$ scp hbase-0.94.0.tar.gz zhouhh@Hadoop46:~/.

登录另两台机器，解压。将Hadoop48上的hbase configure文件拷贝过去覆盖(略)。



**运行HBase**

[zhouhh@Hadoop48 hbase-0.94.0]$ ./bin/start-hbase.sh

停止HBase用命令

[zhouhh@Hadoop48 hbase-0.94.0]$ ./bin/stop-hbase.sh



**HBase数据测试**

用shell登录，创建一个表t1，有列族c1,并添加一条记录myrow

[zhouhh@Hadoop48 hbase-0.94.0]$ hbase shell

hbase(main):003:0> create 't1',{NAME=>'c1',VERSIONS=>1}

    
    hbase(main):004:0> list
    TABLE
    t1
    1 row(s) in 0.0310 seconds



    
    hbase(main):005:0> scan 't1'
    ROW                           COLUMN+CELL
    0 row(s) in 0.0730 seconds



    
    hbase(main):004:0> put 't1','myrow','c1:','hello world'
    0 row(s) in 0.2180 seconds
    
    hbase(main):005:0> scan 't1'
    ROW                           COLUMN+CELL
     myrow                        column=c1:, timestamp=1339037087160, value=hello world
    1 row(s) in 0.0340 seconds


然后，登入其他两台机器，检查是否能查询到该表和数据

    
    [zhouhh@Hadoop47 hbase-0.94.0]$ hadoop fs -ls /
    Found 4 items
    drwxr-xr-x   - zhouhh supergroup          0 2012-06-07 10:41 /hbase
    drwxr-xr-x   - zhouhh supergroup          0 2012-05-23 18:09 /home
    drwxr-xr-x   - zhouhh supergroup          0 2012-05-23 19:40 /tmp
    drwxr-xr-x   - zhouhh supergroup          0 2012-05-23 19:39 /user


数据目录在47已经生效

    
    [zhouhh@Hadoop47 hbase-0.94.0]$ hbase shell
    HBase Shell; enter 'help<RETURN>' for list of supported commands.
    Type "exit<RETURN>" to leave the HBase Shell
    Version 0.94.0, r1332822, Tue May  1 21:43:54 UTC 2012
    
    hbase(main):001:0> list
    TABLE
    t1
    1 row(s) in 0.4430 seconds
    
    hbase(main):002:0> scan 't1'
    ROW                                      COLUMN+CELL
     myrow                                   column=c1:, timestamp=1339037087160, value=hello world
    1 row(s) in 0.2070 seconds


同样方法验证46.

**在web网页上查询**：

[http://192.168.10.48:60010](http://192.168.10.48:60010/)

如果配置了本地hosts，也可以通过http://Hadoop48:60010来看到服务器状况。最好配置本地hosts：

    
    #C:WindowsSystem32driversetchosts
    192.168.10.46 Hadoop46
    192.168.10.47 Hadoop47
    192.168.10.48 Hadoop48
