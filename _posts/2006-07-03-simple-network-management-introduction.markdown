---
author: abloz
comments: true
date: 2006-07-03 04:07:51+00:00
layout: post
link: http://abloz.com/index.php/2006/07/03/simple-network-management-introduction/
slug: simple-network-management-introduction
title: 简单网管介绍
wordpress_id: 154
categories:
- 技术
tags:
- snmp
---

周海汉

1. 网管是什么？

网管有两个对象，一个是对网络计算机软件的管理，另一个是对硬件的管理。

a. 被管理的设备
b.代理Agent 用于屏蔽设备差异
c.协议 一般用简单网管协议snmp
d.管理端

2.网管的体系结构

最下层是设备，中间是Agent，最上层是Manager

3.网管的一些概念

SNMP 简单网管协议 rfc1213

MIB 管理信息数据库 通常是一定格式的文本文件，用于描述要管理的节点

SMI 就是 管理信息结构

4.如何管理设备

最简单的方式，管理端可以轮询设备。但是频度不好掌握。另一种方式，就是出错时汇报。但有两个问题，一是设备没有瘫痪；二是产生出错陷阱的资源消耗和网络消耗有多大。可以将两种方式结合起来。

5.相关软件和网站

 http://www.rotman.utoronto.ca/~huang/snmp.html

简单网管介绍，适合入门阅读。

snmp4j和westhawk两种开源软件包

joesnmp类库

开源的net-snmp开发包

收费的AdventNet 和mg-soft mib builder工具

www.opennms.org  
