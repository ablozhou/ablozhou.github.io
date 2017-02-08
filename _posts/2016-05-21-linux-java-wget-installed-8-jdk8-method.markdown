---
author: abloz
comments: true
date: 2016-05-21 13:04:22+00:00
layout: post
link: http://abloz.com/index.php/2016/05/21/linux-java-wget-installed-8-jdk8-method/
slug: linux-java-wget-installed-8-jdk8-method
title: linux wget安装 java 8 jdk8方法
wordpress_id: 2741
categories:
- 技术
tags:
- java
---

dev@uhost2:~$ java -version




java version "1.7.0_95"




OpenJDK Runtime Environment (IcedTea 2.6.4) (7u95-2.6.4-0ubuntu0.14.04.1)




OpenJDK 64-Bit Server VM (build 24.95-b01, mixed mode)







dev@uhost2:~$ wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" [http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz](http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz)







$ sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_77/bin/javac 300




update-alternatives: using /usr/lib/jvm/jdk1.8.0_77/bin/javac to provide /usr/bin/javac (javac) in 自动模式




$ sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_77/bin/java 300




$ sudo update-alternatives --config java




$ sudo update-alternatives --config javac







安装jre




wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" [http://download.oracle.com/otn-pub/java/jdk/8u92-b14/server-jre-8u92-linux-x64.tar.gz](http://download.oracle.com/otn-pub/java/jdk/8u92-b14/server-jre-8u92-linux-x64.tar.gz)










wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  [http://download.oracle.com/otn-pub/java/jdk/8u91-b14/server-jre-8u91-linux-x64.tar.gz](http://download.oracle.com/otn-pub/java/jdk/8u91-b14/server-jre-8u91-linux-x64.tar.gz)










[root@heptax jvm]# update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_92/bin/javac 300




update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_92/bin/java 300
