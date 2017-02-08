---
author: abloz
comments: true
date: 2010-03-30 07:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/30/linux-time-server-settings/
slug: linux-time-server-settings
title: linux设置时间服务器
wordpress_id: 1185
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.3.30

 

对多个linux服务器，时间保持一致是很必要的。根据精确度要求，应该有相应的时间间隔进行时间同步。如果不进行时间同步，时间久了就会差别很大，遇到问题时定位就很困难。因为多台设备的配合，log之间可能有前因后果，时间是同步事件的先后的重要依据。

 

一般来说，对一个机房内的设备，可以设置一台时间服务器，由它定期从一个标准的时间服务器上获取时间。其他的服务器可以通过内网的连接从这台服务器进行同步。这样不仅时间会一致，而且照顾到一些没有公网的设备。

 

本文测试系统：

[root@test ~]# cat /etc/*release  
CentOS release 5.2 (Final)

 

[root@test ~]# rpm -qf /usr/sbin/ntpd  
ntp-4.2.2p1-8.el5.centos.1

在安装时应该确定ntp包已经安装。

 

## 启动服务器  


如果ntpd已经安装，则可以直接启动：

[root@test ~]# service ntpd start  
Starting ntpd: [ OK ]

 

同时，也需要检查一下配置文件，centos缺省都配置好了。

[root@test ~]# vi /etc/ntp.conf

server 0.centos.pool.ntp.org

driftfile /var/lib/ntp/drift

keys /etc/ntp/keys

 

检查一下时间服务器是否可用：

[root@test ~]# ping 0.centos.pool.ntp.org  
PING 0.centos.pool.ntp.org (74.88.39.232) 56(84) bytes of data.  
64 bytes from ool-4a5827e8.dyn.optonline.net (74.88.39.232): icmp_seq=1 ttl=54 time=251 ms  
如果不可用，则确定一下网络是否能连接到外网。检查一下域名解析是否配置。

[root@test ~]# cat /etc/resolv.conf  
nameserver 8.8.8.8

 

## 设置ntpd自启动

[root@test ~]# find /etc/rc.d/ -name "*ntpd"  
/etc/rc.d/rc6.d/K74ntpd  
/etc/rc.d/init.d/ntpd  
/etc/rc.d/rc3.d/K74ntpd  
/etc/rc.d/rc4.d/K74ntpd  
/etc/rc.d/rc5.d/K74ntpd  
/etc/rc.d/rc2.d/K74ntpd  
/etc/rc.d/rc1.d/K74ntpd  
/etc/rc.d/rc0.d/K74ntpd  
[root@test ~]# /sbin/chkconfig --level 345 ntpd on  
[root@test ~]# !find  
find /etc/rc.d/ -name "*ntpd"  
/etc/rc.d/rc6.d/K74ntpd  
/etc/rc.d/init.d/ntpd  
/etc/rc.d/rc3.d/S58ntpd  
/etc/rc.d/rc4.d/S58ntpd  
/etc/rc.d/rc5.d/S58ntpd  
/etc/rc.d/rc2.d/K74ntpd  
/etc/rc.d/rc1.d/K74ntpd  
/etc/rc.d/rc0.d/K74ntpd  
说明在3，4，5三个级别已经可以自启动。

 

## 检查防火墙

[root@test ~]# iptables -L

对比较严格的防火墙，应该对ntp端口123进行配置：

[root@test ~]# iptables -A INPUT -p udp --dport 123 -j ACCEPT  
[root@test ~]# iptables -L  
Chain INPUT (policy ACCEPT)  
target prot opt source destination   
ACCEPT udp -- anywhere anywhere udp dpt:ntp

 

## 客户端配置  


客户端采用ntpdate来更新，配置在crontab中。根据需要决定频率。在每一台需要同步时间的设备上设置crontab

[root@test1 ~]# crontab -e

 

00 00 * * * /usr/sbin/ntpdate 192.168.12.31

 

192.168.12.31是test服务器的内网地址。

crontab 设置的是每天0点同步时间。

为了保证时间服务器可用，将命令先在命令行下执行一下。

[root@test1 ~]# ntpdate 192.168.12.31  
30 Mar 17:45:24 ntpdate[16495]: step time server 192.168.12.31 offset 0.694312 sec  
[root@test1 ~]# date  
Tue Mar 30 17:45:37 CST 2010

说明同步时间成功。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=4fc85268-6c13-899d-9b68-4aaa57aca84d)
