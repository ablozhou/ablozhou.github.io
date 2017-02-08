---
author: abloz
comments: true
date: 2013-01-29 07:00:38+00:00
layout: post
link: http://abloz.com/index.php/2013/01/29/flume-windows-agent-reports-outofmemory/
slug: flume-windows-agent-reports-outofmemory
title: flume windows agent reports OutOfMemory
wordpress_id: 2095
categories:
- 技术
tags:
- flume
- outofmemory
---

周海汉

2013.1.29

http://abloz.com



when i start the flume node service,the agent is OPENING.
I need to gather logs from windows 7, but the flume master and collector is running on linux. I download 0.9.4 exe file from flume official web.

When I start the node from windows, the status is OPENING.
<table border="1" >
<tbody >
<tr >

<td >zhouhh.TKOffice.local
</td>

<td >zhouhh.TKOffice.local
</td>

<td >zhouhh.TKOffice.local
</td>

<td >OPENING
</td>

<td >Fri Jan 25 11:45:01 CST 2013
</td>

<td >4
</td>
</tr>
</tbody>
</table>
And the log reports OutOfMemoryError.

================
D:Program FilesClouderaFlume 0.9.4logflumenode-stdout.2013-01-25.log

2013-01-25 15:31:03 Commons Daemon procrun stdout initializedListening for transport dt_socket at address: 8888
java.lang.OutOfMemoryError: Java heap space
Dumping heap to java_pid8100.hprof ...
Heap dump file created [13270531 bytes in 0.115 secs]

===============
D:Program FilesClouderaFlume 0.9.4logflumenode-stderr.2013-01-25.log
...
Exception in thread "logicalNode zhouhh.TKOffice.local-25" java.lang.OutOfMemoryError: Java heap space
at org.apache.hadoop.io.DataOutputBuffer$Buffer.write(DataOutputBuffer.java:59)
at org.apache.hadoop.io.DataOutputBuffer.write(DataOutputBuffer.java:101)
at org.apache.hadoop.io.SequenceFile$Reader.next(SequenceFile.java:1945)
at org.apache.hadoop.io.SequenceFile$Reader.next(SequenceFile.java:1845)
at org.apache.hadoop.io.SequenceFile$Reader.next(SequenceFile.java:1891)
at com.cloudera.flume.handlers.hdfs.SeqfileEventSource.next(SeqfileEventSource.java:62)
at com.cloudera.flume.core.EventUtil.dumpAll(EventUtil.java:47)
at com.cloudera.flume.agent.durability.NaiveFileWALManager.checkAndStripAckFraming(NaiveFileWALManager.java:378)
at com.cloudera.flume.agent.durability.NaiveFileWALManager.recoverLog(NaiveFileWALManager.java:288)
at com.cloudera.flume.agent.durability.NaiveFileWALManager.recover(NaiveFileWALManager.java:411)
at com.cloudera.flume.agent.durability.NaiveFileWALDeco.open(NaiveFileWALDeco.java:240)
at com.cloudera.flume.agent.AgentSink.open(AgentSink.java:150)
at com.cloudera.flume.core.connector.DirectDriver$PumperThread.run(DirectDriver.java:88)

I have 4GB memory, and the source file to tail only 1KB, What can I do to remove this error?

I found that if I change windows agent configure from
<table border="1" >
<tbody >
<tr >

<td >tail("c:\test.txt")
</td>

<td >agentSink("hadoop48",35853) ;
</td>
</tr>
</tbody>
</table>
to
<table border="1" >
<tbody >
<tr >

<td >tail("c:\test.txt")
</td>

<td >agentDFOSink("hadoop48",35853) ;
</td>
</tr>
</tbody>
</table>
then the agent changes status from OPENING to ACTIVE.


my windows agent is :192.168.20.81, while linux collector is : 192.168.10.48




another linux agent is 192.168.10.46. 10.46 have no problem of agentSink.







 in the flume0.9.4 tray icon menu I could edit the parameter, and edit registry is also ok.


I add two parameter:







-XX:MaxDirectMemorySize=500m




-XX:MaxNewSize=500m




and change JvmMs from 128 to 500(-Xms 500,-Xmx 1024)

increase -Xms and -Xmx values which are shown as "Initial memory pool" and "Maximum memory pool" in "Java" tab of configuration of tray icon.




(HKEY_LOCAL_MACHINE > SOFTWARE > Apache Software Foundation > Procrun 2.0 > FlumeNode > Parameters > Java also can change the javavm parameter)










it dosen't work while using agentSink and report OutOfMemory again after configured agentDFOSink to agentSink. So I removed the WAL dir because there may be currupted due to previous out of memory.







I  removed those directories below of WAL , configured the agent sink to agentSink, and restart flume service,It's OK!










C:tmpflume-ZHOUHH$agentzhouhh.TKOffice.local>ls




dfo_error   dfo_logged   dfo_writing  error   logged   sent




dfo_import  dfo_sending  done         import  sending  writing










Thanks to Jeong-shik Jang's help.






