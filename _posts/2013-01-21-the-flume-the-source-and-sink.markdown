---
author: abloz
comments: true
date: 2013-01-21 12:08:22+00:00
layout: post
link: http://abloz.com/index.php/2013/01/21/the-flume-the-source-and-sink/
slug: the-flume-the-source-and-sink
title: flume的source和sink
wordpress_id: 2086
categories:
- 技术
tags:
- flume
---

周海汉 2013.1.21

http://abloz.com



常用source源：



	
  * **console**

	
  * 标准输入控制台

	
  * **text(“filename”)**

	
  * 单文本文件源，一行一事件

	
  * **tail(“filename”)**

	
  * 和 Unix 的tail -F 类似。一行一事件。一直打开等待数据，会跟踪文件切换。

	
  * **multitail(“file1″[,** "file2"[, …]])

	
  * 同 tail 源类似，但可以跟踪多文件。

	
  * **asciisynth(msg_count,msg_size)**

	
  * 一个源，用于产生msg_count 个msg_size大小的随机消息，转成可打印 ASCII字符。

	
  * **syslogUdp(port)**

	
  * UDP 端口上的 Syslog，和syslog兼容。

	
  * **syslogTcp(port)**

	
  * TCP 端口上的 Syslog，和syslog-ng兼容。


** 常用sink：**

`null`

Null sink. Events are dropped.

`console[("format")]`

Console sink. Display to console’s stdout. The "format" argument is optional and defaults to the "debug" output format.

`text("_txtfile_"[,"format"])`

Textfile sink. Write the events to text file `_txtfile_` using output format "format". The default format is "raw" event bodies with no metadata.

`dfs("_dfsfile_")`

DFS seqfile sink. Write serialized Flume events to a dfs path such as `hdfs://namenode/file` or `file:///file` in Hadoop’s seqfile format. Note that because of the HDFS write semantics, no data for this sink write until the sink is closed.

`syslogTcp("_host_",_port_)`

Syslog TCP sink. Forward to events to `host` on TCP port `port` in syslog wire format (syslog-ng compatible), or to other Flume nodes setup to listen for syslogTcp.



附：所有flume的sinks，sources和decorators.





## Sinks


<table >
<tbody >
<tr >

<td >accumulator
</td>
</tr>
<tr >

<td >agentBEChain
</td>
</tr>
<tr >

<td >agentBESink
</td>
</tr>
<tr >

<td >agentBestEffortSink
</td>
</tr>
<tr >

<td >agentDFOChain
</td>
</tr>
<tr >

<td >agentDFOSink
</td>
</tr>
<tr >

<td >agentE2EChain
</td>
</tr>
<tr >

<td >agentE2ESink
</td>
</tr>
<tr >

<td >agentFailoverSink
</td>
</tr>
<tr >

<td >agentSink
</td>
</tr>
<tr >

<td >autoBEChain
</td>
</tr>
<tr >

<td >autoDFOChain
</td>
</tr>
<tr >

<td >autoE2EChain
</td>
</tr>
<tr >

<td >avroSink
</td>
</tr>
<tr >

<td >collectorSink
</td>
</tr>
<tr >

<td >console
</td>
</tr>
<tr >

<td >counter
</td>
</tr>
<tr >

<td >counterHistory
</td>
</tr>
<tr >

<td >customdfs
</td>
</tr>
<tr >

<td >dfs
</td>
</tr>
<tr >

<td >escapedCustomDfs
</td>
</tr>
<tr >

<td >escapedFormatDfs
</td>
</tr>
<tr >

<td >fail
</td>
</tr>
<tr >

<td >failChain
</td>
</tr>
<tr >

<td >formatDfs
</td>
</tr>
<tr >

<td >ganglia
</td>
</tr>
<tr >

<td >irc
</td>
</tr>
<tr >

<td >logicalSink
</td>
</tr>
<tr >

<td >multigrep
</td>
</tr>
<tr >

<td >multigrepspec
</td>
</tr>
<tr >

<td >null
</td>
</tr>
<tr >

<td >regexhisto
</td>
</tr>
<tr >

<td >regexhistospec
</td>
</tr>
<tr >

<td >rpcSink
</td>
</tr>
<tr >

<td >seqfile
</td>
</tr>
<tr >

<td >syslogTcp
</td>
</tr>
<tr >

<td >text
</td>
</tr>
<tr >

<td >thriftSink
</td>
</tr>
</tbody>
</table>








## Sources


<table >
<tbody >
<tr >

<td >asciisynth
</td>
</tr>
<tr >

<td >autoCollectorSource
</td>
</tr>
<tr >

<td >avroSource
</td>
</tr>
<tr >

<td >collectorSource
</td>
</tr>
<tr >

<td >console
</td>
</tr>
<tr >

<td >exec
</td>
</tr>
<tr >

<td >execPeriodic
</td>
</tr>
<tr >

<td >execStream
</td>
</tr>
<tr >

<td >fail
</td>
</tr>
<tr >

<td >irc
</td>
</tr>
<tr >

<td >log4jfile
</td>
</tr>
<tr >

<td >logicalSource
</td>
</tr>
<tr >

<td >multitail
</td>
</tr>
<tr >

<td >nonlsynth
</td>
</tr>
<tr >

<td >null
</td>
</tr>
<tr >

<td >report
</td>
</tr>
<tr >

<td >rpcSource
</td>
</tr>
<tr >

<td >scribe
</td>
</tr>
<tr >

<td >seqfile
</td>
</tr>
<tr >

<td >stdin
</td>
</tr>
<tr >

<td >synth
</td>
</tr>
<tr >

<td >synthrndsize
</td>
</tr>
<tr >

<td >syslogTcp
</td>
</tr>
<tr >

<td >syslogTcp1
</td>
</tr>
<tr >

<td >syslogUdp
</td>
</tr>
<tr >

<td >tail
</td>
</tr>
<tr >

<td >tailDir
</td>
</tr>
<tr >

<td >text
</td>
</tr>
<tr >

<td >thriftSource
</td>
</tr>
<tr >

<td >tpriosource
</td>
</tr>
<tr >

<td >twitter
</td>
</tr>
</tbody>
</table>








## Decorators


<table >
<tbody >
<tr >

<td >ackChecker
</td>
</tr>
<tr >

<td >ackInjector
</td>
</tr>
<tr >

<td >ackedWriteAhead
</td>
</tr>
<tr >

<td >batch
</td>
</tr>
<tr >

<td >benchinject
</td>
</tr>
<tr >

<td >benchreport
</td>
</tr>
<tr >

<td >bloomCheck
</td>
</tr>
<tr >

<td >bloomGen
</td>
</tr>
<tr >

<td >choke
</td>
</tr>
<tr >

<td >delay
</td>
</tr>
<tr >

<td >digest
</td>
</tr>
<tr >

<td >diskFailover
</td>
</tr>
<tr >

<td >exDate
</td>
</tr>
<tr >

<td >flakeyAppend
</td>
</tr>
<tr >

<td >format
</td>
</tr>
<tr >

<td >gunzip
</td>
</tr>
<tr >

<td >gzip
</td>
</tr>
<tr >

<td >inmem
</td>
</tr>
<tr >

<td >insistentAppend
</td>
</tr>
<tr >

<td >insistentOpen
</td>
</tr>
<tr >

<td >intervalDroppyAppend
</td>
</tr>
<tr >

<td >intervalFlakeyAppend
</td>
</tr>
<tr >

<td >intervalSampler
</td>
</tr>
<tr >

<td >lazyOpen
</td>
</tr>
<tr >

<td >mask
</td>
</tr>
<tr >

<td >mult
</td>
</tr>
<tr >

<td >nullDeco
</td>
</tr>
<tr >

<td >probSampler
</td>
</tr>
<tr >

<td >regex
</td>
</tr>
<tr >

<td >regexAll
</td>
</tr>
<tr >

<td >reservoirSampler
</td>
</tr>
<tr >

<td >select
</td>
</tr>
<tr >

<td >split
</td>
</tr>
<tr >

<td >stubbornAppend
</td>
</tr>
<tr >

<td >unbatch
</td>
</tr>
<tr >

<td >value
</td>
</tr>
</tbody>
</table>






