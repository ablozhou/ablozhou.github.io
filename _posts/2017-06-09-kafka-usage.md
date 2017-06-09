---
layout: post
title:  "Kafka 使用实例"
author: "周海汉"
date:   2017-06-09 20:18:26 +0800
categories: tech
tags:
    - kafka
---

# kafka介绍
![image](http://kafka.apache.org/images/logo.png)
本节部分摘自[ Kafka 设计与原理详解](http://blog.csdn.net/suifeng3051/article/details/48053965)。

apache kafka 由linkedin高吞吐量的分布式消息系统。基于push-subscribe的消息系统，它具备快速、可扩展、可持久化的特点。它现在是Apache旗下的一个开源系统，作为Hadoop生态系统的一部分，被各种商业公司广泛应用。它的最大的特性就是可以实时的处理大量数据以满足各种需求场景：比如基于hadoop的批处理系统、低延迟的实时系统、storm/Spark流式处理引擎。

## Kafka的特性

- 高吞吐量、低延迟：kafka每秒可以处理几十万条消息，它的延迟最低只有几毫秒
- 可扩展性：kafka集群支持热扩展
- 持久性、可靠性：消息被持久化到本地磁盘，并且支持数据备份防止数据丢失
- 容错性：允许集群中节点失败（若副本数量为n,则允许n-1个节点失败）
- 高并发：支持数千个客户端同时读写
- 
## 应用场景
- 日志收集：一个公司可以用Kafka可以收集各种服务的log，通过kafka以统一接口服务的方式开放给各种consumer，例如hadoop、Hbase、Solr等。
- 消息系统：解耦和生产者和消费者、缓存消息等。
- 用户活动跟踪：Kafka经常被用来记录web用户或者app用户的各种活动，如浏览网页、搜索、点击等活动，这些活动信息被各个服务器发布到kafka的topic中，然后订阅者通过订阅这些topic来做实时的监控分析，或者装载到hadoop、数据仓库中做离线分析和挖掘。
- 运营指标：Kafka也经常用来记录运营监控数据。包括收集各种分布式应用的数据，生产各种操作的集中反馈，比如报警和报告。
- 流式处理：比如spark streaming和storm 事件源

## 组件和基本概念
Kafka中发布订阅的对象是topic。我们可以为每类数据创建一个topic，把向topic发布消息的客户端称作producer，从topic订阅消息的客户端称作consumer。Producers和consumers可以同时从多个topic读写数据。一个kafka集群由一个或多个broker服务器组成，它负责持久化和备份具体的kafka消息。

![image](http://kafka.apache.org/images/producer_consumer.png)

- topic：消息存放的目录即主题
- Producer：生产消息到topic的一方
- Consumer：订阅topic消费消息的一方
- Broker：Kafka的服务实例就是一个broker
消息发送时都被发送到一个topic，其本质就是一个目录，而topic由是由一些Partition Logs(分区日志)组成。


![image](http://kafka.apache.org/images/log_anatomy.png)
# docker 安装kafka
```
[zhouhh@mainServer ~]$ docker search kafka
NAME                        DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
wurstmeister/kafka          Multi-Broker Apache Kafka Image                 344                  [OK]
spotify/kafka               A simple docker image with both Kafka and ...   209                  [OK]
[zhouhh@mainServer ~]$ docker pull spotify/kafka
Using default tag: latest
[zhouhh@mainServer ~]$ docker image list
REPOSITORY                    TAG                 IMAGE ID            CREATED             SIZE
redis                         latest              a858478874d1        2 weeks ago         184 MB
hub.c.163.com/public/centos   7.2-tools           4a4618db62b9        3 months ago        515 MB
hello-world                   latest              48b5124b2768        4 months ago        1.84 kB
spotify/kafka                 latest              a9e0a5b8b15e        6 months ago        443 MB

[zhouhh@mainServer java]$ wget http://mirrors.hust.edu.cn/apache/kafka/0.10.2.1/kafka_2.12-0.10.2.1.tgz

[zhouhh@mainServer kafka_2.12-0.10.2.1]$ docker run -p 2181:2181 -p 9092:9092 --env ADVERTISED_HOST=10.6.0.200 --env ADVERTISED_PORT=9092 spotify/kafka
2017-06-09 01:21:47,617 INFO success: zookeeper entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2017-06-09 01:21:47,617 INFO success: kafka entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)

[zhouhh@mainServer kafka_2.12-0.10.2.1]$ ./bin/kafka-topics.sh --create --zookeeper 10.6.0.200:2181 --replication-factor 1 --partitions 1 --topic zhhtest
Created topic "zhhtest".

[zhouhh@mainServer kafka_2.12-0.10.2.1]$ bin/kafka-topics.sh --list --zookeeper localhost:2181
zhhtest

```

# 通信

发送消息
```
[zhouhh@mainServer kafka_2.12-0.10.2.1]$ bin/kafka-console-producer.sh --broker-list localhost:9092 --topic zhhtest
hello kafka
中文不错

```
消费消息
```
[zhouhh@mainServer kafka_2.12-0.10.2.1]$ ./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic zhhtest --from-beginning
hello kafka
中文不错

# 另一个客户端
[zhouhh@mainServer kafka]$ ./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic zhhtest --from-beginning
hello kafka
中文不错
^CProcessed a total of 2 messages
[zhouhh@mainServer kafka]$ ./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic zhhtest --from-beginning
hello kafka
中文不错
^CProcessed a total of 2 messages
```

在发送端输入 “我爱中国”。

```

[zhouhh@mainServer kafka]$ ./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic zhhtest
我爱中国

```
# 在docker中查看kafka信息
```
[zhouhh@mainServer ~]$ docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS                    PORTS                                            NAMES
3ba6a64308c6        spotify/kafka        "supervisord -n"         4 hours ago         Up 4 hours                0.0.0.0:2181->2181/tcp, 0.0.0.0:9092->9092/tcp   condescending_lamport
18635a66fa6f        redis                "docker-entrypoint..."   2 days ago          Up 2 days                 6379/tcp                                         epic_darwin
[zhouhh@mainServer ~]$ docker exec 18635a66fa6f ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
redis        1     0  0 Jun07 ?        00:03:01 redis-server *:6379
root        22     0  0 06:04 ?        00:00:00 ps -ef
[zhouhh@mainServer ~]$ docker exec 3ba ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 01:21 ?        00:00:26 /usr/bin/python /usr/bin/supervisord -n
root        13     1  0 01:21 ?        00:02:48 /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
root       329     1  0 03:33 ?        00:00:26 /usr/bin/java -Dzookeeper.log.dir=/var/log/zookeeper -Dzookeeper.root.lo
root      9463     1  0 06:05 ?        00:00:00 /bin/sh /usr/bin/start-kafka.sh
root      9468  9463 30 06:05 ?        00:00:00 /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -Xmx1G
[zhouhh@mainServer ~]$ docker exec -it 3ba bash
root@3ba6a64308c6:/# ls
bin  boot  dev    etc  home  lib    lib64  media  mnt  opt    proc  root  run  sbin  srv  sys  tmp  usr  var
root@3ba6a64308c6:/# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 01:21 ?        00:00:26 /usr/bin/python /usr/bin/supervisord -n
root        13     1  0 01:21 ?        00:02:48 /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -Xmx1G -Xms1G -server -XX:+UseG1GC -XX:MaxGCPauseMillis=
root       329     1  0 03:33 ?        00:00:27 /usr/bin/java -Dzookeeper.log.dir=/var/log/zookeeper -Dzookeeper.root.logger=INFO,ROLLINGFILE -cp /etc/
root     12823     0  0 06:05 ?        00:00:00 bash

```

# 参考
- http://blog.csdn.net/suifeng3051/article/details/48053965
- http://kafka.apache.org/documentation/
