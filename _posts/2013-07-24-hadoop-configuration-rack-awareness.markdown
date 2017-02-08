---
author: abloz
comments: true
date: 2013-07-24 13:00:12+00:00
layout: post
link: http://abloz.com/index.php/2013/07/24/hadoop-configuration-rack-awareness/
slug: hadoop-configuration-rack-awareness
title: hadoop 配置机架感知
wordpress_id: 2196
categories:
- 技术
tags:
- hadoop
---

周海汉 2013.7.24

http://abloz.com

假如设备链接层次分3层，第一层交换机d1下面连多个交换机rk1,rk2,rk3,rk4,.... 每个交换机对应一个机架。

d1(rk1(hs11,hs12,...),rk2(hs21,hs22,...), rk3(hs31,hs32,...),rk4(hs41,hs42,...),...)

可以用程序或脚本完成由host到设备的映射。比如，用python，生成一个topology.py：

然后在core-site.xml中配置
<property>
<name>topology.script.file.name</name>
<value>/home/hadoop/hadoop-1.1.2/conf/topology.py</value>
<description> The script name that should be invoked to resolve DNS names to
NetworkTopology names. Example: the script would take host.foo.bar as an
argument, and return /rack1 as the output.
</description>
</property>



python机架脚本：

[hadoop@hs11 conf]$ cat topology.py
#!/usr/bin/env python

'''
This script used by hadoop to determine network/rack topology. It
should be specified in hadoop-site.xml via topology.script.file.name
Property.
topology.script.file.name
/home/hadoop/hadoop-1.1.2/conf/topology.py

To generate dict:
for i in range(xx):
#print ""hs%d":"/rk%d/hs%d","%(i,(i-1)/10,i)

print ""hs%d":"/rk%d","%(i,(i-1)/10)

Andy 2013.7.23
'''

import sys
from string import join

DEFAULT_RACK = '/rk0';

RACK_MAP = {
"hs11":"/rk1",
"hs12":"/rk1",
"hs13":"/rk1",
"hs14":"/rk1",
"hs15":"/rk1",
"hs16":"/rk1",
"hs17":"/rk1",
"hs18":"/rk1",
"hs19":"/rk1",
"hs20":"/rk1",
"hs21":"/rk2",
"hs22":"/rk2",
"hs23":"/rk2",
"hs24":"/rk2",
"hs25":"/rk2",
"hs26":"/rk2",
"hs27":"/rk2",
"hs28":"/rk2",
"hs29":"/rk2",
"hs30":"/rk2",
"hs31":"/rk3",
"hs32":"/rk3",
"hs33":"/rk3",
"hs34":"/rk3",
"hs35":"/rk3",
"hs36":"/rk3",
"hs37":"/rk3",
"hs38":"/rk3",
"hs39":"/rk3",
"hs40":"/rk3",
"hs41":"/rk4",
"hs42":"/rk4",
"hs43":"/rk4",
"hs44":"/rk4",
"hs45":"/rk4",
"hs46":"/rk4",

...

"10.10.20.11":"/rk1",
"10.10.20.12":"/rk1",
"10.10.20.13":"/rk1",
"10.10.20.14":"/rk1",
"10.10.20.15":"/rk1",
"10.10.20.16":"/rk1",
"10.10.20.17":"/rk1",
"10.10.20.18":"/rk1",
"10.10.20.19":"/rk1",
"10.10.20.20":"/rk1",
"10.10.20.21":"/rk2",
"10.10.20.22":"/rk2",
"10.10.20.23":"/rk2",
"10.10.20.24":"/rk2",
"10.10.20.25":"/rk2",
"10.10.20.26":"/rk2",
"10.10.20.27":"/rk2",
"10.10.20.28":"/rk2",
"10.10.20.29":"/rk2",
"10.10.20.30":"/rk2",
"10.10.20.31":"/rk3",
"10.10.20.32":"/rk3",
"10.10.20.33":"/rk3",
"10.10.20.34":"/rk3",
"10.10.20.35":"/rk3",
"10.10.20.36":"/rk3",
"10.10.20.37":"/rk3",
"10.10.20.38":"/rk3",
"10.10.20.39":"/rk3",
"10.10.20.40":"/rk3",
"10.10.20.41":"/rk4",
"10.10.20.42":"/rk4",
"10.10.20.43":"/rk4",
"10.10.20.44":"/rk4",
"10.10.20.45":"/rk4",
"10.10.20.46":"/rk4",

...
}

if len(sys.argv)==1:
print DEFAULT_RACK
else:
print join([RACK_MAP.get(i, DEFAULT_RACK) for i in sys.argv[1:]]," ")

原来这个程序我返回的是

"hs11":"/rk1/hs11",

结果执行mapreduce程序时报如下错误：


Total MapReduce jobs = 1
Launching Job 1 out of 1
Number of reduce tasks is set to 0 since there's no reduce operator
Starting Job = job_201307241502_0003, Tracking URL = http://hs11:50030/jobdetails.jsp?jobid=job_201307241502_0003
Kill Command = /home/hadoop/hadoop-1.1.2/libexec/../bin/hadoop job  -kill job_201307241502_0003
Hadoop job information for Stage-1: number of mappers: 0; number of reducers: 0
2013-07-24 18:38:11,854 Stage-1 map = 100%,  reduce = 100%
Ended Job = job_201307241502_0003 with errors
Error during job, obtaining debugging information...
Job Tracking URL: http://hs11:50030/jobdetails.jsp?jobid=job_201307241502_0003
FAILED: Execution Error, return code 2 from org.apache.hadoop.hive.ql.exec.MapRedTask
MapReduce Jobs Launched:
Job 0:  HDFS Read: 0 HDFS Write: 0 FAIL
Total MapReduce CPU Time Spent: 0 msec







通过http://hs11:50030/jobdetails.jsp?jobid=job_201307241502_0002 可以看到：







Job initialization failed:

java.lang.NullPointerException

at org.apache.hadoop.mapred.JobTracker.resolveAndAddToTopology(JobTracker.java:2751)
at org.apache.hadoop.mapred.JobInProgress.createCache(JobInProgress.java:578)
at org.apache.hadoop.mapred.JobInProgress.initTasks(JobInProgress.java:750)

at org.apache.hadoop.mapred.JobTracker.initJob(JobTracker.java:3775)

at org.apache.hadoop.mapred.EagerTaskInitializationListener$InitJob.run(EagerTaskInitializationListener.java:90)
at java.util.concurrent.ThreadPoolExecutor$Worker.runTask(ThreadPoolExecutor.java:886)
at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:908)
at java.lang.Thread.run(Thread.java:662)










原来系统在配置机架敏感时，并不需要在脚本中返回设备ns或hostname，系统会自动添加。改为上面的topology.py后，系统执行正确。



