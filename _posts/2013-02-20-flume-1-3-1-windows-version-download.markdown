---
author: abloz
comments: true
date: 2013-02-20 10:28:06+00:00
layout: post
link: http://abloz.com/index.php/2013/02/20/flume-1-3-1-windows-version-download/
slug: flume-1-3-1-windows-version-download
title: flume-ng 1.3.1 windows version download
wordpress_id: 2130
categories:
- 技术
tags:
- flume
- windows
---

andy zhou
http://abloz.com

(To compile flume-ng of windows, please reference http://mapredit.blogspot.com/2012/07/run-flume-13x-on-windows.html or my chinese version http://abloz.com/2013/02/18/compile-under-windows-flume-1-3-1.html)

1.download the windows version of flume 1.3.1 file apache-flume-1.3.1-bin.zip from http://abloz.com/flume/windows_download.html
2.unzip the apache-flume-1.3.1-bin.zip to a directory.
3.install jdk 1.6 from oracle,and set JAVA_HOME of the env.
download from http://www.oracle.com/technetwork/java/javase/downloads/index.html
4.test agent:
4.1 modify settings of conf/console.conf,conf/hdfs.conf for agent test.
4.2 test source syslog, sink: console out agent
4.2.1 check flume.bat,modify the variables to your env.
4.2.2 click flume.bat
4.2.3 on another computer run command:
echo "<13>test msg" >/tmp/msg
nc -v your_flume_sysloghost port < /tmp/msg
4.2.4 check your syslog host flume output
4.2.5 samples see http://abloz.com/2013/02/18/compile-under-windows-flume-1-3-1.html
4.3 test avro-client
4.3.1 run a avro source flume agent on a node.
4.3.2 modify flume-avroclient.bat and head.txt
4.3.3 run flume-avroclient.bat

tested on windows7 32bit version

enjoy!
Andy
2013.2.20
http://abloz.com
