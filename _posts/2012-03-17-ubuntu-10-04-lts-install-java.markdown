---
author: abloz
comments: true
date: 2012-03-17 08:03:16+00:00
layout: post
link: http://abloz.com/index.php/2012/03/17/ubuntu-10-04-lts-install-java/
slug: ubuntu-10-04-lts-install-java
title: ubuntu 10.04 LTS 安装java
wordpress_id: 1510
categories:
- 技术
tags:
- java
- jre
- ubuntu
---

http://abloz.com
author:ablozhou
date:2012.3.16

oracle收购sun公司后，新版的java协议进行了修改，所以ubuntu 10.04 LTS ppa缺省库里没有java，需要添加第三方库
sudo apt-get install sun-java6-jre
提示E: Package sun-java6-jre has no installation candidate
找不到sun-java6-jre
添加库：
sudo add-apt-repository "deb http://archive.canonical.com/ lucid partner"
但add-apt-repository 不存在，需要添加
sudo apt-get install python-software-properties
再执行add-apt-repository

 sudo apt-get update
再执行
sudo apt-get install openjdk-6-jre
sudo apt-get install openjdk-6-jdk

添加oracle jdk 7:
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-jdk7-installer
同理可添加nginx的第三方库：
sudo add-apt-repository "deb http://ppa.launchpad.net/nginx/stable/ubuntu lucid main"

参考：
http://openjdk.java.net/install/
http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html
http://wiki.ubuntu.org.cn/Java%E5%AE%89%E8%A3%85%E9%85%8D%E7%BD%AE 老一点的ubuntu 安装java6 jre
