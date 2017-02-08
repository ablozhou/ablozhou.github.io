---
author: abloz
comments: true
date: 2013-02-25 10:44:36+00:00
layout: post
link: http://abloz.com/index.php/2013/02/25/flume-org-apache-flume-channelexception-unable-to-put-batch-on-required-channel/
slug: flume-org-apache-flume-channelexception-unable-to-put-batch-on-required-channel
title: 'flume org.apache.flume.ChannelException: Unable to put batch on required channel'
wordpress_id: 2141
categories:
- 技术
tags:
- batch
- capacity
- flume
---


执行flume windows版本时遇到如下错误：


    
    
    
    2013-02-25 12:05:37,818 (pool-4-thread-1) [INFO - org.apache.flume.client.avro.SpoolingFileLineReader.readLines(Spooling
    FileLineReader.java:167)] Last read was never comitted - resetting mark position.
    2013-02-25 12:05:41,297 (pool-5-thread-1) [ERROR - org.apache.flume.source.SpoolDirectorySource$SpoolDirectoryRunnable.r
    un(SpoolDirectorySource.java:148)] Uncaught exception in Runnable
    org.apache.flume.ChannelException: Unable to put batch on required channel: org.apache.flume.channel.MemoryChannel{name:
     memch1}
            at org.apache.flume.channel.ChannelProcessor.processEventBatch(ChannelProcessor.java:200)
            at org.apache.flume.source.SpoolDirectorySource$SpoolDirectoryRunnable.run(SpoolDirectorySource.java:143)
            at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:441)
            at java.util.concurrent.FutureTask$Sync.innerRunAndReset(FutureTask.java:317)
            at java.util.concurrent.FutureTask.runAndReset(FutureTask.java:150)
            at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$101(ScheduledThreadPoolExecutor.j
    ava:98)
            at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.runPeriodic(ScheduledThreadPoolExecutor.
    java:181)
            at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:205
    )
            at java.util.concurrent.ThreadPoolExecutor$Worker.runTask(ThreadPoolExecutor.java:886)
            at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:908)
            at java.lang.Thread.run(Thread.java:619)
    Caused by: org.apache.flume.ChannelException: Space for commit to queue couldn't be acquired Sinks are likely not keepin
    g up with sources, or the buffer size is too tight
            at org.apache.flume.channel.MemoryChannel$MemoryTransaction.doCommit(MemoryChannel.java:126)
            at org.apache.flume.channel.BasicTransactionSemantics.commit(BasicTransactionSemantics.java:151)
            at org.apache.flume.channel.ChannelProcessor.processEventBatch(ChannelProcessor.java:192)
            ... 10 more
    2013-02-25 12:05:41,874 (pool-5-thread-1) [INFO - org.apache.flume.client.avro.SpoolingFileLineReader.readLines(Spooling
    FileLineReader.java:167)] Last read was never comitted - resetting mark position.
    
    



source为spooldir,sink 为avro。
我们在运行flume时将java选项--Xms=200m，还是有该错误。spooldir里面的内容大约有1GB，数10个文件。后面有人说memory channel 的capacity 应为 每秒传输event条数 * 要传输的时间秒数。然后capacity 应为agent1.channels.memch1.transactionCapactiy的10-100倍。我们刚开始将这两个值设为
agent1.channels.memch1.capacity = 10000
agent1.channels.memch1.transactionCapactiy = 100
结果报了上述错误。后面将capacity设为1000000,该错误消失(报了outofmemory错误。因为我们内存设小了。)但程序可以正确运行。
