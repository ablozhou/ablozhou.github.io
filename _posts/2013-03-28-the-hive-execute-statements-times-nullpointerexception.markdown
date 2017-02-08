---
author: abloz
comments: true
date: 2013-03-28 06:59:51+00:00
layout: post
link: http://abloz.com/index.php/2013/03/28/the-hive-execute-statements-times-nullpointerexception/
slug: the-hive-execute-statements-times-nullpointerexception
title: hive执行语句时报NullPointerException
wordpress_id: 2170
categories:
- 技术
tags:
- hive
---

java.lang.RuntimeException: Error in configuring object
    	at org.apache.hadoop.util.ReflectionUtils.setJobConf(ReflectionUtils.java:93)
    	at org.apache.hadoop.util.ReflectionUtils.setConf(ReflectionUtils.java:64)
    	at org.apache.hadoop.util.ReflectionUtils.newInstance(ReflectionUtils.java:117)
    	at org.apache.hadoop.mapred.MapTask.runOldMapper(MapTask.java:432)
    	at org.apache.hadoop.mapred.MapTask.run(MapTask.java:372)
    	at org.apache.hadoop.mapred.Child$4.run(Child.java:255)
    	at java.security.AccessController.doPrivileged(Native Method)
    	at javax.security.auth.Subject.doAs(Subject.java:415)
    	at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1121)
    	at org.apache.hadoop.mapred.Child.main(Child.java:249)
    Caused by: java.lang.reflect.InvocationTargetException
    	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
    	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
    	at java.lang.reflect.Method.invoke(Method.java:601)
    	at org.apache.hadoop.util.ReflectionUtils.setJobConf(ReflectionUtils.java:88)
    	... 9 more
    Caused by: java.lang.RuntimeException: Error in configuring object
    	at org.apache.hadoop.util.ReflectionUtils.setJobConf(ReflectionUtils.java:93)
    	at org.apache.hadoop.util.ReflectionUtils.setConf(ReflectionUtils.java:64)
    	at org.apache.hadoop.util.ReflectionUtils.newInstance(ReflectionUtils.java:117)
    	at org.apache.hadoop.mapred.MapRunner.configure(MapRunner.java:34)
    	... 14 more
    Caused by: java.lang.reflect.InvocationTargetException
    	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
    	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
    	at java.lang.reflect.Method.invoke(Method.java:601)
    	at org.apache.hadoop.util.ReflectionUtils.setJobConf(ReflectionUtils.java:88)
    	... 17 more
    Caused by: java.lang.RuntimeException: Map operator initialization failed
    	at org.apache.hadoop.hive.ql.exec.ExecMapper.configure(ExecMapper.java:121)
    	... 22 more
    Caused by: org.apache.hadoop.hive.ql.metadata.HiveException: java.lang.NullPointerException
    	at org.apache.hadoop.hive.ql.exec.FileSinkOperator.initializeOp(FileSinkOperator.java:373)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:360)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:436)
    	at org.apache.hadoop.hive.ql.exec.Operator.initializeChildren(Operator.java:392)
    	at org.apache.hadoop.hive.ql.exec.SelectOperator.initializeOp(SelectOperator.java:62)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:360)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:436)
    	at org.apache.hadoop.hive.ql.exec.Operator.initializeChildren(Operator.java:392)
    	at org.apache.hadoop.hive.ql.exec.SelectOperator.initializeOp(SelectOperator.java:62)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:360)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:436)
    	at org.apache.hadoop.hive.ql.exec.Operator.initializeChildren(Operator.java:392)
    	at org.apache.hadoop.hive.ql.exec.FilterOperator.initializeOp(FilterOperator.java:78)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:360)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:436)
    	at org.apache.hadoop.hive.ql.exec.Operator.initializeChildren(Operator.java:392)
    	at org.apache.hadoop.hive.ql.exec.TableScanOperator.initializeOp(TableScanOperator.java:166)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:360)
    	at org.apache.hadoop.hive.ql.exec.MapOperator.initializeOp(MapOperator.java:441)
    	at org.apache.hadoop.hive.ql.exec.Operator.initialize(Operator.java:360)
    	at org.apache.hadoop.hive.ql.exec.ExecMapper.configure(ExecMapper.java:98)
    	... 22 more
    Caused by: java.lang.NullPointerException
    	at org.apache.hadoop.hive.ql.exec.FileSinkOperator.initializeOp(FileSinkOperator.java:315)
    	... 42 more


此语句此前执行通过。开始怀疑是否hive表的原始数据格式有问题？后面排除。 经过检查，原来是环境变量设置的问题。
在hive-env.sh中添加

    
    [hbase@h46 hive-0.10.0]$ vi conf/hive-env.sh
    export HIVE_CONF_DIR=$HIVE_HOME/conf
    export HIVE_AUX_JARS_PATH=$HIVE_HOME/lib


或者在.bashrc中添加：
export HIVE_CONF_DIR=$HIVE_HOME/conf
export HIVE_AUX_JARS_PATH=$HIVE_HOME/lib

引起问题是原因是我在.bashrc中将HIVE_AUX_JARS_PATH指到另一个目录去了。

也可以在启动hive CLI时，指定相关库。
$HIVE_HOME/bin/hive --auxpath $HIVE_HOME/lib/hive-hbase-handler-0.10.0.jar,$HIVE_HOME/lib/hbase-0.94.3.jar,$HIVE_HOME/lib/zookeeper-3.3.4.jar,$HIVE_HOME/lib/guava-r09.jar -hiveconf hbase.master=com.abloz:60000

或者在hive-site.xml中配置：

    
    <property>
    <name>hive.zookeeper.quorum</name>
    <value>h1,h2,h3</value>
    <description>The list of zookeeper servers to talk to. This is only needed for read/write locks.</description>
    </property>
    <property>
    <name>hive.aux.jars.path</name>
    <value>file:///home/aaa/hive-0.10.0/lib/hive-hbase-handler-0.10.0.jar,file:///home/aaa/hive-0.10.0/lib/hbase-0.94.3.jar,file:///home/aaa/hive-0.10.0/lib/zookeeper-3.4.3.jar</value>
    </property>
