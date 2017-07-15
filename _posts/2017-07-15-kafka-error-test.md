---
layout: post
title:  "kafka使用和容错性测试"
author: "周海汉"
date:   2017-07-15 10:18:26 +0800
categories: tech
tags:
    - kafka
---

# 下载安装
[下载地址](http://kafka.apache.org/downloads)
最新版本kafka_2.12-0.11.0.0.tgz. 
```
zhouhh@/Users/zhouhh/java $ curl http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/0.11.0.0/kafka_2.12-0.11.0.0.tgz -o kafka_2.12-0.11.0.0.tgz

zhouhh@/Users/zhouhh/java $ tar zxvf kafka_2.12-0.11.0.0.tgz kafka_2.12-0.11.0.0/
zhouhh@/Users/zhouhh/java $ ln -s kafka_2.12-0.11.0.0 kafka
zhouhh@/Users/zhouhh/java $ vi ~/.zshrc

# kafka
export KAFKA_HOME="/Users/zhouhh/java/kafka"
export PATH="$KAFKA_HOME/bin:$PATH"
zhouhh@/Users/zhouhh/java $ source ~/.zshrc

```
# 安装zookeeper
安装zookeeper.并配置kafka连接到zookeeper, 测试可以采用kafka自带zookeeper.

# 启动zookeeper
```
zhouhh@/Users/zhouhh/java/kafka $ zookeeper-server-start.sh config/zookeeper.properties


```
# 启动kafka

```

zhouhh@/Users/zhouhh/java/kafka $ kafka-server-start.sh  config/server.properties


```

# 操作kafka


## 创建topic
```
zhouhh@/Users/zhouhh/java $ kafka-topics.sh --create --zookeeper localhost:2181 --partitions 1 --replication-factor 1 --topic zhhtest
Created topic "zhhtest".
```

## 查看topic

```
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --list --zookeeper localhost:2181
zhhtest
```

## 生产消息
```
zhouhh@/Users/zhouhh/java/kafka $ kafka-console-producer.sh --broker-list localhost:9092 --topic zhhtest
>hello
>中文

```
## 消费消息

```
zhouhh@/Users/zhouhh/java/kafka $ kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic zhhtest --from-beginning
hello
中文

```

# kafka集群

```
zhouhh@/Users/zhouhh/java/kafka/config $ cp server.properties server-1.properties
zhouhh@/Users/zhouhh/java/kafka/config $ vi server-1.properties

broker.id=1

log.dirs=/tmp/kafka-logs-1
############################# Socket Server Settings #############################

# The address the socket server listens on. It will get the value returned from
# java.net.InetAddress.getCanonicalHostName() if not configured.
listeners=PLAINTEXT://:9093

zhouhh@/Users/zhouhh/java/kafka/config $ cp server-1.properties server-2.properties
zhouhh@/Users/zhouhh/java/kafka/config $ vi server-2.properties


broker.id=2
listeners=PLAINTEXT://:9094
log.dirs=/tmp/kafka-logs-2

```

## 启动服务
```
zhouhh@/Users/zhouhh/java/kafka $ kafka-server-start.sh config/server-1.properties
zhouhh@/Users/zhouhh/java/kafka $ kafka-server-start.sh config/server-2.properties


```

## 创建topic
创建一个复制三份的topic, 一个分区
```
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic zhh-replicated-topic
Created topic "zhh-replicated-topic".

```
## 查看topic
用describe 查看集群中该topic每个节点情况

```
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --describe --zookeeper localhost:2181 --topic zhh-replicated-topic
Topic:zhh-replicated-topic	PartitionCount:1	ReplicationFactor:3	Configs:
	Topic: zhh-replicated-topic	Partition: 0	Leader: 2	Replicas: 2,0,1	Isr: 2,0,1

```
第一行表示汇总信息. 有1个分区, 3份备份
第二行表示每个分区的信息,对分区0,领导节点id是2, 备份到2,0,1.
- leader 表示负责某分区全部读写的节点.  每个分区都会有随机选择的leader.
- Replicas 表示需要复制到的节点, 不管是否活着.
- Isr 表示("in-sync" replicas), 正在同步的备份, 表示可用的活着的节点

## 多备份,多分区
```
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 3 --topic zhh-replicated-partitions-topic
Created topic "zhh-replicated-partitions-topic".
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --describe --zookeeper localhost:2181 --topic zhh-replicated-partitions-topic
Topic:zhh-replicated-partitions-topic	PartitionCount:3	ReplicationFactor:3	Configs:
	Topic: zhh-replicated-partitions-topic	Partition: 0	Leader: 2	Replicas: 2,0,1Isr: 2,0,1
	Topic: zhh-replicated-partitions-topic	Partition: 1	Leader: 0	Replicas: 0,1,2Isr: 0,1,2
	Topic: zhh-replicated-partitions-topic	Partition: 2	Leader: 1	Replicas: 1,2,0Isr: 1,2,0

```
可以看到每个分区, 其leader不在一个节点上.

## 没有备份的节点详情
```
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh  --zookeeper localhost:2181 --list
__consumer_offsets
connect-test
zhh-replicated-partitions-topic
zhh-replicated-topic
zhhtest

zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --describe --zookeeper localhost:2181 --topic zhhtest
Topic:zhhtest	PartitionCount:1	ReplicationFactor:1	Configs:
	Topic: zhhtest	Partition: 0	Leader: 0	Replicas: 0	Isr: 0
	


```
只有一个备份和一个分区.

## 消息测试

```
zhouhh@/Users/zhouhh/java/kafka $ kafka-console-producer.sh --broker-list localhost:9092 --topic zhh-replicated-topic
>第一个消息
>second

zhouhh@/Users/zhouhh/java/kafka $ kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic zhh-replicated-topic
第一个消息
second

```

## 可用性检测
### 节点崩溃

```
zhouhh@/Users/zhouhh/java/kafka_2.12-0.11.0.0 $ ps aux | grep server.properties
zhouhh           73370   0.2  2.1  6239704 175116 s000  S+   11:37上午   1:34.39 ...
zhouhh@/Users/zhouhh/java/kafka_2.12-0.11.0.0 $ kill -9 73370

[1]    73370 killed     kafka-server-start.sh config/server.properties

```

另两个节点打印错误信息
```
[2017-07-15 16:17:54,838] INFO zookeeper state changed (SyncConnected) (org.I0Itec.zkclient.ZkClient)
[2017-07-15 16:17:57,662] INFO Partition [zhh-replicated-partitions-topic,2] on broker 1: Shrinking ISR from 1,2,0 to 1,2 (kafka.cluster.Partition)
[2017-07-15 16:18:05,858] WARN [ReplicaFetcherThread-0-0]: Error in fetch to broker 0, request (type=FetchRequest, replicaId=1, maxWait=500, minBytes=1, maxBytes=10485760, fetchData={zhh-replicated-partitions-topic-1=(offset=0, logStartOffset=0, maxBytes=1048576)}) (kafka.server.ReplicaFetcherThread)
java.io.IOException: Connection to 0 was disconnected before the response was read
	at org.apache.kafka.clients.NetworkClientUtils.sendAndReceive(NetworkClientUtils.java:93)
	at kafka.server.ReplicaFetcherBlockingSend.sendRequest(ReplicaFetcherBlockingSend.scala:93)
	at kafka.server.ReplicaFetcherThread.fetch(ReplicaFetcherThread.scala:207)
	at kafka.server.ReplicaFetcherThread.fetch(ReplicaFetcherThread.scala:42)
	at kafka.server.AbstractFetcherThread.processFetchRequest(AbstractFetcherThread.scala:151)
	at kafka.server.AbstractFetcherThread.doWork(AbstractFetcherThread.scala:112)
	at kafka.utils.ShutdownableThread.run(ShutdownableThread.scala:64)
[2017-07-15 16:18:07,310] INFO [ReplicaFetcherManager on broker 1] Removed fetcher for partitions zhh-replicated-partitions-topic-1 (kafka.server.ReplicaFetcherManager)
[2017-07-15 16:18:07,310] INFO Partition [zhh-replicated-partitions-topic,1] on broker 1: zhh-replicated-partitions-topic-1 starts at Leader Epoch 1 from offset 0. Previous Leader Epoch was: 0 (kafka.cluster.Partition)
[2017-07-15 16:18:07,312] INFO [ReplicaFetcherThread-0-0]: Shutting down (kafka.server.ReplicaFetcherThread)
[2017-07-15 16:18:07,322] INFO [ReplicaFetcherThread-0-0]: Stopped (kafka.server.ReplicaFetcherThread)
[2017-07-15 16:18:07,323] INFO [ReplicaFetcherThread-0-0]: Shutdown completed (kafka.server.ReplicaFetcherThread)

```
zookeeper 错误信息
```
[2017-07-15 16:17:54,394] WARN caught end of stream exception (org.apache.zookeeper.server.NIOServerCnxn)
EndOfStreamException: Unable to read additional data from client sessionid 0x15d453002070003, likely client has closed socket
	at org.apache.zookeeper.server.NIOServerCnxn.doIO(NIOServerCnxn.java:239)
	at org.apache.zookeeper.server.NIOServerCnxnFactory.run(NIOServerCnxnFactory.java:203)
	at java.lang.Thread.run(Thread.java:745)
[2017-07-15 16:17:54,404] INFO Closed socket connection for client /0:0:0:0:0:0:0:1:49913 which had sessionid 0x15d453002070003 (org.apache.zookeeper.server.NIOServerCnxn)

```
consumer 端错误信息
此时收不到信息. 因为该consumer连接到localhost:9092
而该节点被杀掉了.
```
[2017-07-15 16:18:05,872] WARN Connection to node 0 could not be established. Broker may not be available. (org.apache.kafka.clients.NetworkClient)
[2017-07-15 16:18:05,878] WARN Auto-commit of offsets {zhh-replicated-topic-0=OffsetAndMetadata{offset=4, metadata=''}} failed for group console-consumer-97557: Offset commit failed with a retriable exception. You should retry committing offsets. The underlying error was: null (org.apache.kafka.clients.consumer.internals.ConsumerCoordinator)

```

### 查看节点情况
```
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --describe --zookeeper localhost:2181 --topic zhh-replicated-topic
Topic:zhh-replicated-topic	PartitionCount:1	ReplicationFactor:3	Configs:
	Topic: zhh-replicated-topic	Partition: 0	Leader: 2	Replicas: 2,0,1	Isr: 2,1
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --describe --zookeeper localhost:2181 --topic zhh-replicated-partitions-topic
Topic:zhh-replicated-partitions-topic	PartitionCount:3	ReplicationFactor:3	Configs:
	Topic: zhh-replicated-partitions-topic	Partition: 0	Leader: 2	Replicas: 2,0,1	Isr: 2,1
	Topic: zhh-replicated-partitions-topic	Partition: 1	Leader: 1	Replicas: 0,1,2	Isr: 1,2
	Topic: zhh-replicated-partitions-topic	Partition: 2	Leader: 1	Replicas: 1,2,0	Isr: 1,2

```

### 消息消费
```
zhouhh@/Users/zhouhh/java/kafka_2.12-0.11.0.0 $ kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic zhh-replicated-topic
[2017-07-15 16:32:36,078] WARN Connection to node -1 could not be established. Broker may not be available. (org.apache.kafka.clients.NetworkClient)
zhouhh@/Users/zhouhh/java/kafka_2.12-0.11.0.0 $ kafka-console-consumer.sh --bootstrap-server localhost:9093 --from-beginning --topic zhh-replicated-topic


```
都收不到消息. 必须启动第一个节点, 才能收到消息. 不知是何原因.

## 杀掉其他节点,则不影响消息.
producer端会有警告, consumer端没有警告

```
>[2017-07-15 16:37:39,148] WARN Connection to node 2 could not be established. Broker may not be available. (org.apache.kafka.clients.NetworkClient)

zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --describe --zookeeper localhost:2181 --topic zhh-replicated-topic
Topic:zhh-replicated-topic	PartitionCount:1	ReplicationFactor:3	Configs:
	Topic: zhh-replicated-topic	Partition: 0	Leader: 0	Replicas: 2,0,1	Isr: 0,1
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --describe --zookeeper localhost:2181 --topic zhh-replicated-partitions-topic
Topic:zhh-replicated-partitions-topic	PartitionCount:3	ReplicationFactor:3	Configs:
	Topic: zhh-replicated-partitions-topic	Partition: 0	Leader: 0	Replicas: 2,0,1Isr: 0,1
	Topic: zhh-replicated-partitions-topic	Partition: 1	Leader: 1	Replicas: 0,1,2Isr: 1,0
	Topic: zhh-replicated-partitions-topic	Partition: 2	Leader: 1	Replicas: 1,2,0Isr: 1,0
zhouhh@/Users/zhouhh/java/kafka $ kafka-topics.sh --describe --zookeeper localhost:2181 --topic zhhtest
Topic:zhhtest	PartitionCount:1	ReplicationFactor:1	Configs:
	Topic: zhhtest	Partition: 0	Leader: 0	Replicas: 0	Isr: 0


```

# kafka connect 输入输出数据

命令行可以方便演示和操作. 但实际环境经常需要和外部数据打交道, 向kafka输入数据, 从kafka输出数据. 这是kafka connect的工作.

下面演示基于文件的数据输入输出, 会在kafka中创建相应的topic

```
zhouhh@/Users/zhouhh/java/kafka $ cat config/connect-standalone.properties
bootstrap.servers=localhost:9092
offset.storage.file.filename=/tmp/connect.offsets
# Flush much faster than normal, which is useful for testing/debugging
offset.flush.interval.ms=10000

zhouhh@/Users/zhouhh/java/kafka $ cat config/connect-file-source.properties
name=local-file-source
connector.class=FileStreamSource
tasks.max=1
file=test.txt
topic=connect-test
zhouhh@/Users/zhouhh/java/kafka $ cat config/connect-file-sink.properties
name=local-file-sink
connector.class=FileStreamSink
tasks.max=1
file=test.sink.txt
topics=connect-test
zhouhh@/Users/zhouhh/java/kafka $ connect-standalone.sh config/connect-standalone.properties config/connect-file-source.properties config/connect-file-sink.properties

```

```
zhouhh@/Users/zhouhh/java/kafka $ echo -e "foo\nbar" > test.txt

zhouhh@/Users/zhouhh/java/kafka $ cat test.sink.txt
foo
bar
zhouhh@/Users/zhouhh/java/kafka $ kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic connect-test --from-beginning
{"schema":{"type":"string","optional":false},"payload":"foo"}
{"schema":{"type":"string","optional":false},"payload":"bar"}
zhouhh@/Users/zhouhh/java/kafka $ echo -e "中文" >> test.txt
zhouhh@/Users/zhouhh/java/kafka $ cat test.sink.txt
foo
bar
中文
zhouhh@/Users/zhouhh/java/kafka $ kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic connect-test --from-beginning
{"schema":{"type":"string","optional":false},"payload":"foo"}
{"schema":{"type":"string","optional":false},"payload":"bar"}
{"schema":{"type":"string","optional":false},"payload":"中文"}
```
# 参考

http://kafka.apache.org/quickstart

