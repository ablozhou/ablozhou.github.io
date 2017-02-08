---
author: abloz
comments: true
date: 2013-01-06 01:21:54+00:00
layout: post
link: http://abloz.com/index.php/2013/01/06/hadoop-simple-monitoring-script-open-source/
slug: hadoop-simple-monitoring-script-open-source
title: Hadoop简单监控脚本开源
wordpress_id: 2052
categories:
- 技术
tags:
- hadoop
---



用于监控hadoop系统各主机状态，如内存占用，硬盘占用，进程是否存在。如果达到一定阈值或进程退出则发送email告警。

下载地址：[https://code.google.com/p/hadoop-simple-monitor/](https://code.google.com/p/hadoop-simple-monitor/)


## 特点：





	
  1. 很简单的用于监控Hadoop各节点状况，包括内存占用情况，硬盘占用情况，进程是否存在等。如果出问题将发送email告警。

	
  2. 部署非常简单。只需下载或解压到一台机器上，配置完毕，即可监控所有节点。不需到远程去部署。

	
  3. 用Bash脚本写成，方便修改

	
  4. 用于监控Java(Hadoop相关的，如HBase，Thrift，ZooKeeper, Hive, Pig, Hadoop )进程。也可监控其他进程，需少量修改。




## 部署:





	
  1. 下载解压到一台机器上，远程监控的机器不需要下载和配置

	
  2. 配置config.sh,设置好要监控哪些机器，哪些进程

	
  3. 修改loopcheck.sh, 设置好路径，该文件供crontab使用。

	
  4. 可以测试一下邮件发送是否正常

	
  5. 添加到crontab，如5分钟运行一次


0-59/5 * * * * $HOME/smr/loopcheck.sh


## 测试邮件发送





	
  1. 编辑sendmail.sh

	
  2. 将EMAIL变量注释去掉,修改成自己的email

	
  3. 编辑邮件正文，保存到emailbody.txt

	
  4. 运行命令 ./sendmail.sh emailbody.txt


