---
author: abloz
comments: true
date: 2012-06-18 03:11:25+00:00
layout: post
link: http://abloz.com/index.php/2012/06/18/the-hadoop-suite-matching-and-problem/
slug: the-hadoop-suite-matching-and-problem
title: hadoop 套件匹配问题
wordpress_id: 1697
categories:
- 技术
tags:
- hadoop
---

因为hadoop相关组件很多，有hadoop，hbase，hive，pig等，但没有发行套件。而每个组件的开发进度不一，一些组件还没有稳定，版本号很低，经常遇到组件之间不配套引发的莫名其妙的问题。

由于hadoop是这套系统的核心，可能需要找一个大家都兼容的版本。
目前hadoop已经出了一个1.03和2.0 alpha的版本，这是所有组件中版本最高的。但其他组件都没有跟上，为了兼容可能得花很大精力。我们以hadoop为核心，看目前2012.6.18为止，各组件应该采用什么版本，配合较好。


**Hadoop：**23 May, 2012: Release 2.0.0-alpha available

**Hadoop：**27 December, 2011: release 1.0.0 available
**hbase:**Release Date: 14/May/12 0.94

**zookeeper：**20 March, 2012: release 3.3.5 available
**hive:**30 April, 2012: release 0.9.0 available
**pig:**25 April, 2012: release 0.10.0 available

配套：
hbase 0.92 - hadoop 0.22
hbase 0.94 - hadoop 0.23
hive 0.9 - hadoop 0.20.x
pig 0.10 - hadoop 0.20.x

可见，当前hadoop周边配套组件版本落后hadoop较大。就低不就高，最好选hadoop 0.20.x版本作为测试的核心，以减少麻烦。未来再逐步往最新版本上迁移。hadoop 2.0版本将解决namenode的单点问题，并使用google protobuf来封装传递数据。

版本配套选择：
hadoop 0.20.x - hbase 0.92 - hive 0.9 - pig 0.10 - zookeeper-3.3.4 - jdk 1.7.0
