---
author: abloz
comments: true
date: 2013-02-26 10:00:30+00:00
layout: post
link: http://abloz.com/index.php/2013/02/26/flume-channel-source-sink-summary/
slug: flume-channel-source-sink-summary
title: flume channel,source,sink汇总
wordpress_id: 2144
categories:
- 技术
- 转载
---

这是flume-ng的channel,source,sink类型汇总，方便查询。



<table >
<tbody >
<tr >
Component
Type
Description
Implementation Class
</tr>
<tr >

<td >Channel
</td>

<td >memory
</td>

<td >In-memory, fast, non-durable event transport
</td>

<td >MemoryChannel
</td>
</tr>
<tr >

<td >Channel
</td>

<td >file
</td>

<td >A channel for reading, writing, mapping, and manipulating a file
</td>

<td >FileChannel
</td>
</tr>
<tr >

<td >Channel
</td>

<td >jdbc
</td>

<td >JDBC-based, durable event transport (Derby-based)
</td>

<td >JDBCChannel
</td>
</tr>
<tr >

<td >Channel
</td>

<td >recoverablememory
</td>

<td >A durable channel implementation that uses the local file system for its storage
</td>

<td >RecoverableMemoryChannel
</td>
</tr>
<tr >

<td >Channel
</td>

<td >org.apache.flume.channel.PseudoTxnMemoryChannel
</td>

<td >Mainly for testing purposes. Not meant for production use.
</td>

<td >PseudoTxnMemoryChannel
</td>
</tr>
<tr >

<td >Channel
</td>

<td >_(custom type as FQCN)_
</td>

<td >Your own Channel impl.
</td>

<td >_(custom FQCN)_
</td>
</tr>
<tr >

<td >Source
</td>

<td >avro
</td>

<td >Avro Netty RPC event source
</td>

<td >AvroSource
</td>
</tr>
<tr >

<td >Source
</td>

<td >exec
</td>

<td >Execute a long-lived Unix process and read from stdout
</td>

<td >ExecSource
</td>
</tr>
<tr >

<td >Source
</td>

<td >netcat
</td>

<td >Netcat style TCP event source
</td>

<td >NetcatSource
</td>
</tr>
<tr >

<td >Source
</td>

<td >seq
</td>

<td >Monotonically incrementing sequence generator event source
</td>

<td >SequenceGeneratorSource
</td>
</tr>
<tr >

<td >Source
</td>

<td >org.apache.flume.source.StressSource
</td>

<td >Mainly for testing purposes. Not meant for production use. Serves as a continuous source of events where each event has the same payload. The payload consists of some number of bytes (specified by_size_ property, defaults to 500) where each byte has the signed value Byte.MAX_VALUE (0x7F, or 127).
</td>

<td >org.apache.flume.source.StressSource
</td>
</tr>
<tr >

<td >Source
</td>

<td >syslogtcp
</td>

<td >
</td>

<td >SyslogTcpSource
</td>
</tr>
<tr >

<td >Source
</td>

<td >syslogudp
</td>

<td >
</td>

<td >SyslogUDPSource
</td>
</tr>
<tr >

<td >Source
</td>

<td >org.apache.flume.source.avroLegacy.AvroLegacySource
</td>

<td >
</td>

<td >AvroLegacySource
</td>
</tr>
<tr >

<td >Source
</td>

<td >org.apache.flume.source.thriftLegacy.ThriftLegacySource
</td>

<td >
</td>

<td >ThriftLegacySource
</td>
</tr>
<tr >

<td >Source
</td>

<td >org.apache.flume.source.scribe.ScribeSource
</td>

<td >
</td>

<td >ScribeSource
</td>
</tr>
<tr >

<td >Source
</td>

<td >_(custom type as FQCN)_
</td>

<td >Your own Source impl.
</td>

<td >_(custom FQCN)_
</td>
</tr>
<tr >

<td >Sink
</td>

<td >hdfs
</td>

<td >Writes all events received to HDFS (with support for rolling, bucketing, HDFS-200 append, and more)
</td>

<td >HDFSEventSink
</td>
</tr>
<tr >

<td >Sink
</td>

<td >org.apache.flume.sink.hbase.HBaseSink
</td>

<td >A simple sink that reads events from a channel and writes them to HBase.
</td>

<td >org.apache.flume.sink.hbase.HBaseSink
</td>
</tr>
<tr >

<td >Sink
</td>

<td >org.apache.flume.sink.hbase.AsyncHBaseSink
</td>

<td >
</td>

<td >org.apache.flume.sink.hbase.AsyncHBaseSink
</td>
</tr>
<tr >

<td >Sink
</td>

<td >logger
</td>

<td >Log events at INFO level via configured logging subsystem (log4j by default)
</td>

<td >LoggerSink
</td>
</tr>
<tr >

<td >Sink
</td>

<td >avro
</td>

<td >Sink that invokes a pre-defined Avro protocol method for all events it receives (when paired with an avro source, forms tiered collection)
</td>

<td >AvroSink
</td>
</tr>
<tr >

<td >Sink
</td>

<td >file_roll
</td>

<td >
</td>

<td >RollingFileSink
</td>
</tr>
<tr >

<td >Sink
</td>

<td >irc
</td>

<td >
</td>

<td >IRCSink
</td>
</tr>
<tr >

<td >Sink
</td>

<td >null
</td>

<td >/dev/null for Flume - blackhole all events received
</td>

<td >NullSink
</td>
</tr>
<tr >

<td >Sink
</td>

<td >_(custom type as FQCN)_
</td>

<td >Your own Sink impl.
</td>

<td >_(custom FQCN)_
</td>
</tr>
<tr >

<td >ChannelSelector
</td>

<td >replicating
</td>

<td >
</td>

<td >ReplicatingChannelSelector
</td>
</tr>
<tr >

<td >ChannelSelector
</td>

<td >multiplexing
</td>

<td >
</td>

<td >MultiplexingChannelSelector
</td>
</tr>
<tr >

<td >ChannelSelector
</td>

<td >(custom type)
</td>

<td >Your own ChannelSelector impl.
</td>

<td >_(custom FQCN)_
</td>
</tr>
<tr >

<td >SinkProcessor
</td>

<td >default
</td>

<td >
</td>

<td >DefaultSinkProcessor
</td>
</tr>
<tr >

<td >SinkProcessor
</td>

<td >failover
</td>

<td >
</td>

<td >FailoverSinkProcessor
</td>
</tr>
<tr >

<td >SinkProcessor
</td>

<td >load_balance
</td>

<td >Provides the ability to load-balance flow over multiple sinks.
</td>

<td >LoadBalancingSinkProcessor
</td>
</tr>
<tr >

<td >SinkProcessor
</td>

<td >_(custom type as FQCN)_
</td>

<td >Your own SinkProcessor impl.
</td>

<td >_(custom FQCN)_
</td>
</tr>
<tr >

<td >Interceptor$Builder
</td>

<td >host
</td>

<td >
</td>

<td >HostInterceptor$Builder
</td>
</tr>
<tr >

<td >Interceptor$Builder
</td>

<td >timestamp
</td>

<td >TimestampInterceptor
</td>

<td >TimestampInterceptor$Builder
</td>
</tr>
<tr >

<td >Interceptor$Builder
</td>

<td >static
</td>

<td >
</td>

<td >StaticInterceptor$Builder
</td>
</tr>
<tr >

<td >Interceptor$Builder
</td>

<td >regex_filter
</td>

<td >
</td>

<td >RegexFilteringInterceptor$Builder
</td>
</tr>
<tr >

<td >Interceptor$Builder
</td>

<td >_(custom type as FQCN)_
</td>

<td >Your own Interceptor$Builder impl.
</td>

<td >_(custom FQCN)_
</td>
</tr>
<tr >

<td >EventSerializer$Builder
</td>

<td >text
</td>

<td >
</td>

<td >BodyTextEventSerializer$Builder
</td>
</tr>
<tr >

<td >EventSerializer$Builder
</td>

<td >avro_event
</td>

<td >
</td>

<td >FlumeEventAvroEventSerializer$Builder
</td>
</tr>
<tr >

<td >EventSerializer
</td>

<td >org.apache.flume.sink.hbase.SimpleHbaseEventSerializer
</td>

<td >
</td>

<td >SimpleHbaseEventSerializer
</td>
</tr>
<tr >

<td >EventSerializer
</td>

<td >org.apache.flume.sink.hbase.SimpleAsyncHbaseEventSerializer
</td>

<td >
</td>

<td >SimpleAsyncHbaseEventSerializer
</td>
</tr>
<tr >

<td >EventSerializer
</td>

<td >org.apache.flume.sink.hbase.RegexHbaseEventSerializer
</td>

<td >
</td>

<td >RegexHbaseEventSerializer
</td>
</tr>
<tr >

<td >HbaseEventSerializer
</td>

<td >Custom implementation of serializer for HBaseSink.
_(custom type as FQCN)_
</td>

<td >Your own HbaseEventSerializer impl.
</td>

<td >_(custom FQCN)_
</td>
</tr>
<tr >

<td >AsyncHbaseEventSerializer
</td>

<td >Custom implementation of serializer for AsyncHbase sink.
_(custom type as FQCN)_
</td>

<td >Your own AsyncHbaseEventSerializer impl.
</td>

<td >_(custom FQCN)_
</td>
</tr>
<tr >

<td >EventSerializer$Builder
</td>

<td >Custom implementation of serializer for all sinks except for HBaseSink and AsyncHBaseSink.
_(custom type as FQCN)_
</td>

<td >Your own EventSerializer$Builder impl.
</td>

<td >_(custom FQCN)_
</td>
</tr>
</tbody>
</table>



参考来源：

[https://cwiki.apache.org/FLUME/getting-started.html](https://cwiki.apache.org/FLUME/getting-started.html)

[http://flume.apache.org/FlumeUserGuide.html](http://flume.apache.org/FlumeUserGuide.html)


