---
author: abloz
comments: true
date: 2012-05-22 06:11:07+00:00
layout: post
link: http://abloz.com/index.php/2012/05/22/the-hadoop_home-is-marked-as-deprecated/
slug: the-hadoop_home-is-marked-as-deprecated
title: $HADOOP_HOME is deprecated.
wordpress_id: 1591
categories:
- 技术
tags:
- hadoop
---

[zhouhh@Hadoop48 hadoop-1.0.3]$ ./bin/hadoop
Warning: $HADOOP_HOME is deprecated.
取消warning：
直接设置环境变量$HADOOP_HOME_WARN_SUPPRESS=1
vi .bashrc
export HADOOP_HOME_WARN_SUPPRESS=1

bug：
https://issues.apache.org/jira/browse/HADOOP-7816
