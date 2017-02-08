---
author: abloz
comments: true
date: 2012-09-19 08:56:40+00:00
layout: post
link: http://abloz.com/index.php/2012/09/19/ganglia-monitoring-hadoop/
slug: ganglia-monitoring-hadoop
title: 用ganglia监控hadoop
wordpress_id: 1881
categories:
- 技术
tags:
- ganglia
- hadoop
- jmx
---

周海汉/文

http://abloz.com

2012.9.9



ganglia可以通过JMX来监控hadoop，并生成图形。cacti也可以通过插件，利用JMX，用于监控hadoop。只是目前cacti的监控插件很久没有更新，运行起来很困难，需要多处修改。就算运行起来了，还是和现有hadoop相关产品很多指标不一致，所以不适合使用。 ganglia则在hadoop中原生支持。



[zhouhh@h185 conf]$ pwd
/home/zhouhh/hadoop-1.0.3/conf

设置用户权限

    
    
    [zhouhh@h185 conf]$ cat jmxremote.access
    monitorRole readonly
    controlRole readwrite
    [zhouhh@h185 conf]$ cat jmxremote.password
    monitorRole 123
    controlRole 123
    
    [zhouhh@h185 conf]$ vi hadoop-env.sh
    
    #add by zhh for monitor
    
    #因为认证有问题，所以认证禁止
    export HADOOP_JMX_BASE="-Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
    export HADOOP_JMX_BASE="$HADOOP_JMX_BASE -Dcom.sun.management.jmxremote.password.file=${HADOOP_INSTALL}/conf/jmxremote.password"
    export HADOOP_JMX_BASE="$HADOOP_JMX_BASE -Dcom.sun.management.jmxremote.access.file=${HADOOP_INSTALL}/conf/jmxremote.access"
    
    # Command specific options appended to HADOOP_OPTS when specified
    #zhh for monitor
    
    #设置jmx端口号
    export HADOOP_NAMENODE_OPTS="$HADOOP_JMX_BASE -Dcom.sun.management.jmxremote.port=10001"
    export HADOOP_SECONDARYNAMENODE_OPTS="$HADOOP_JMX_BASE -Dcom.sun.management.jmxremote.port=10002"
    export HADOOP_DATANODE_OPTS="$HADOOP_JMX_BASE -Dcom.sun.management.jmxremote.port=10003"
    export HADOOP_BALANCER_OPTS="$HADOOP_JMX_BASE -Dcom.sun.management.jmxremote.port=10004"
    export HADOOP_JOBTRACKER_OPTS="$HADOOP_JMX_BASE -Dcom.sun.management.jmxremote.port=10005"
    
    export HADOOP_NAMENODE_OPTS="-Dcom.sun.management.jmxremote $HADOOP_NAMENODE_OPTS"
    export HADOOP_SECONDARYNAMENODE_OPTS="-Dcom.sun.management.jmxremote $HADOOP_SECONDARYNAMENODE_OPTS"
    export HADOOP_DATANODE_OPTS="-Dcom.sun.management.jmxremote $HADOOP_DATANODE_OPTS"
    export HADOOP_BALANCER_OPTS="-Dcom.sun.management.jmxremote $HADOOP_BALANCER_OPTS"
    export HADOOP_JOBTRACKER_OPTS="-Dcom.sun.management.jmxremote $HADOOP_JOBTRACKER_OPTS"
    




修改hadoop-metrics2.properties

    
    
    [zhouhh@h185 conf]$ cat hadoop-metrics2.properties
    # syntax: [prefix].[source|sink|jmx].[instance].[options]
    # See package.html for org.apache.hadoop.metrics2 for details
    
    *.sink.file.class=org.apache.hadoop.metrics2.sink.FileSink
    
    #namenode.sink.file.filename=namenode-metrics.out
    
    #datanode.sink.file.filename=datanode-metrics.out
    
    #jobtracker.sink.file.filename=jobtracker-metrics.out
    
    #tasktracker.sink.file.filename=tasktracker-metrics.out
    
    #maptask.sink.file.filename=maptask-metrics.out
    
    #reducetask.sink.file.filename=reducetask-metrics.out
    #
    # Below are for sending metrics to Ganglia
    #
    # for Ganglia 3.0 support
    # *.sink.ganglia.class=org.apache.hadoop.metrics2.sink.ganglia.GangliaSink30
    #
    # for Ganglia 3.1 support
    
    # 大于0.20以后的版本用ganglia31
    *.sink.ganglia.class=org.apache.hadoop.metrics2.sink.ganglia.GangliaSink31
    
    *.sink.ganglia.period=10
    
    # default for supportsparse is false
    *.sink.ganglia.supportsparse=true
    
    *.sink.ganglia.slope=jvm.metrics.gcCount=zero,jvm.metrics.memHeapUsedM=both
    *.sink.ganglia.dmax=jvm.metrics.threadsBlocked=70,jvm.metrics.memHeapUsedM=40
    
    #修改广播IP地址，这是缺省的，统一设该值
    
    namenode.sink.ganglia.servers=239.2.11.71:8649
    
    datanode.sink.ganglia.servers=239.2.11.71:8649
    
    jobtracker.sink.ganglia.servers=239.2.11.71:8649
    
    tasktracker.sink.ganglia.servers=239.2.11.71:8649
    
    maptask.sink.ganglia.servers=239.2.11.71:8649
    
    reducetask.sink.ganglia.servers=239.2.11.71:8649
    
    #dfs.class=org.apache.hadoop.metrics.spi.NullContextWithUpdateThread
    #zhh add
    dfs.class=org.apache.hadoop.metrics.ganglia.GangliaContext31
    dfs.period=10
    dfs.servers=239.2.11.71:8649
    
    mapred.class=org.apache.hadoop.metrics.ganglia.GangliaContext31
    mapred.period=10
    mapred.servers=239.2.11.71:8649
    
    #jvm.class=org.apache.hadoop.metrics.spi.NullContextWithUpdateThread
    #jvm.period=300
    
    jvm.class=org.apache.hadoop.metrics.ganglia.GangliaContext31
    jvm.period=10
    jvm.servers=239.2.11.71:8649
    




修改hbase配置

    
    
    [zhouhh@h185 conf]$ pwd
    /home/zhouhh/hbase-0.94.0/conf
    [zhouhh@h185 conf]$ vi hbase-env.sh
    
    #zhh
    JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false"
    JMX_OPTS="$JMX_OPTS -Dcom.sun.management.jmxremote.password.file=$HADOOP_HOME/conf/jmxremote.passwd"
    JMX_OPTS="$JMX_OPTS -Dcom.sun.management.jmxremote.access.file=$HADOOP_HOME/conf/jmxremote.access"
    
    export HBASE_JMX_BASE="$JMX_OPTS -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
    
    export HBASE_MASTER_OPTS="$HBASE_MASTER_OPTS $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10101"
    export HBASE_REGIONSERVER_OPTS="$HBASE_REGIONSERVER_OPTS $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10102"
    export HBASE_THRIFT_OPTS="$HBASE_THRIFT_OPTS $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10103"
    export HBASE_ZOOKEEPER_OPTS="$HBASE_ZOOKEEPER_OPTS $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10104"
    



修改hbase下的hadoop-metrics.properties

    
    
    [zhouhh@h185 conf]$ cat hadoop-metrics.properties
    # See http://wiki.apache.org/hadoop/GangliaMetrics
    # Make sure you know whether you are using ganglia 3.0 or 3.1.
    # If 3.1, you will have to patch your hadoop instance with HADOOP-4675
    # And, yes, this file is named hadoop-metrics.properties rather than
    # hbase-metrics.properties because we're leveraging the hadoop metrics
    # package and hadoop-metrics.properties is an hardcoded-name, at least
    # for the moment.
    #
    # See also http://hadoop.apache.org/hbase/docs/current/metrics.html
    # GMETADHOST_IP is the hostname (or) IP address of the server on which the ganglia
    # meta daemon (gmetad) service is running
    
    # Configuration of the "hbase" context for null
    #hbase.class=org.apache.hadoop.metrics.spi.NullContext
    hbase.class=org.apache.hadoop.metrics.ganglia.GangliaContext31
    
    # Configuration of the "hbase" context for file
    # hbase.class=org.apache.hadoop.hbase.metrics.file.TimeStampingFileContext
    # hbase.period=10
    # hbase.fileName=/tmp/metrics_hbase.log
    
    # HBase-specific configuration to reset long-running stats (e.g. compactions)
    # If this variable is left out, then the default is no expiration.
    hbase.extendedperiod = 3600
    
    # Configuration of the "hbase" context for ganglia
    # Pick one: Ganglia 3.0 (former) or Ganglia 3.1 (latter)
    #zhh
    #hbase.class=org.apache.hadoop.metrics.ganglia.GangliaContext
    hbase.class=org.apache.hadoop.metrics.ganglia.GangliaContext31
    hbase.period=10
    #hbase.servers=GMETADHOST_IP:8649
    hbase.servers=239.2.11.71:8649
    
    # Configuration of the "jvm" context for null
    #jvm.class=org.apache.hadoop.metrics.spi.NullContext
    
    # Configuration of the "jvm" context for file
    # jvm.class=org.apache.hadoop.hbase.metrics.file.TimeStampingFileContext
    # jvm.period=10
    # jvm.fileName=/tmp/metrics_jvm.log
    
    # Configuration of the "jvm" context for ganglia
    # Pick one: Ganglia 3.0 (former) or Ganglia 3.1 (latter)
    # jvm.class=org.apache.hadoop.metrics.ganglia.GangliaContext
    jvm.class=org.apache.hadoop.metrics.ganglia.GangliaContext31
    jvm.period=10
    jvm.servers=239.2.11.71:8649
    
    # Configuration of the "rpc" context for null
    #rpc.class=org.apache.hadoop.metrics.spi.NullContext
    
    # Configuration of the "rpc" context for file
    # rpc.class=org.apache.hadoop.hbase.metrics.file.TimeStampingFileContext
    # rpc.period=10
    # rpc.fileName=/tmp/metrics_rpc.log
    
    # Configuration of the "rpc" context for ganglia
    # Pick one: Ganglia 3.0 (former) or Ganglia 3.1 (latter)
    # rpc.class=org.apache.hadoop.metrics.ganglia.GangliaContext
    rpc.class=org.apache.hadoop.metrics.ganglia.GangliaContext31
    rpc.period=10
    rpc.servers=239.2.11.71:8649
    
    # Configuration of the "rest" context for ganglia
    # Pick one: Ganglia 3.0 (former) or Ganglia 3.1 (latter)
    # rest.class=org.apache.hadoop.metrics.ganglia.GangliaContext
    rest.class=org.apache.hadoop.metrics.ganglia.GangliaContext31
    rest.period=10
    rest.servers=239.2.11.71:8649
    




重启hbase和hadoop，gmond,gmetad 再用浏览器访问,可以看到hadoop相关的度量。

如图：

[![](http://abloz.com/wp-content/uploads/2012/09/ganglia2.jpg)](http://abloz.com/wp-content/uploads/2012/09/ganglia2.jpg)

[![](http://abloz.com/wp-content/uploads/2012/09/ganglia3.jpg)](http://abloz.com/wp-content/uploads/2012/09/ganglia3.jpg)
