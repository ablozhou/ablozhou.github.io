---
author: abloz
comments: true
date: 2013-01-31 10:07:13+00:00
layout: post
link: http://abloz.com/index.php/2013/01/31/keyvalue-size-too-large-hadoop/
slug: keyvalue-size-too-large-hadoop
title: KeyValue size too large hadoop
wordpress_id: 2103
categories:
- 技术
tags:
- hadoop
- hbase
---

跑mapreduce任务时，在reduce时遇到下列错误：

KeyValue size too large hadoop

解决办法：

修改hbase-site.xml

增加

<property>
<name>hbase.client.keyvalue.maxsize</name>
<value>500m</value>
</property>

hbase.client.keyvalue.maxsize 缺省10MB，包括row key，qualifier, HBase meta，实际value。HBase每个单元不能超过2GB。

可以将其设为0来禁用该客户端限制。 但如果内容真的太大，就不要存HBase里了，可以存个索引，真实数据放HDFS里面。


