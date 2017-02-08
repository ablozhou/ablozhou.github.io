---
author: abloz
comments: true
date: 2013-09-23 03:44:07+00:00
layout: post
link: http://abloz.com/index.php/2013/09/23/linux-vpn-connection/
slug: linux-vpn-connection
title: linux vpn 连接
wordpress_id: 2230
categories:
- 技术
tags:
- linux
- vpn
---

周海汉/文 2013.09.23

[root@s1 andy]# cat /etc/redhat-release
CentOS release 6.4 (Final)
[root@s1 andy]# uname -a

Linux s1 2.6.32-358.el6.x86_64 #1 SMP Fri Feb 22 00:31:26 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
更新epel

[root@s1 network-scripts]# rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

[root@s1 andy]# yum install ppp pptp  pptp-setup


	1. pptpsetup  --create  --server  [--domain ] --username  [--password ] [--encrypt] [--start]
	2. pptpsetup –delete  删除一个节点


[root@s1 andy]# pptpsetup  --create myvpn --server ip  --username  myuser  --password mypasswd  --encrypt --start

[root@s1 andy]# route add -net 10.0.0.0/8 gw 10.10.10.244 dev ppp0

[root@s1 andy]# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
114.113.96.80   localhost       255.255.255.255 UGH   0      0        0 eth0
localhost       *               255.255.255.255 UH    0      0        0 ppp0
192.168.10.0    *               255.255.255.0   U     0      0        0 eth0
link-local      *               255.255.0.0     U     1002   0        0 eth0
10.0.0.0        localhost       255.0.0.0       UG    0      0        0 ppp0
default         localhost       0.0.0.0         UG    0      0        0 eth0

[andy@s1 ~]$ ping 10.10.20.11
PING 10.10.20.11 (10.10.20.11) 56(84) bytes of data.
^C
--- 10.10.20.11 ping statistics ---
4 packets transmitted, 0 received, 100% packet loss, time 3334ms

[root@s1 andy]# route del default

[root@s1 andy]# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
114.113.96.80   192.168.10.1    255.255.255.255 UGH   0      0        0 eth0
10.10.10.11     *               255.255.255.255 UH    0      0        0 ppp0
192.168.10.0    *               255.255.255.0   U     0      0        0 eth0
link-local      *               255.255.0.0     U     1002   0        0 eth0
10.0.0.0        10.10.10.244    255.0.0.0       UG    0      0        0 ppp0

[root@s1 andy]# ping 10.10.20.11
PING 10.10.20.11 (10.10.20.11) 56(84) bytes of data.
64 bytes from 10.10.20.11: icmp_seq=1 ttl=63 time=8.25 ms
64 bytes from 10.10.20.11: icmp_seq=2 ttl=63 time=9.34 ms
64 bytes from 10.10.20.11: icmp_seq=3 ttl=63 time=6.80 ms
64 bytes from 10.10.20.11: icmp_seq=4 ttl=63 time=9.96 ms
^C
--- 10.10.20.11 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3533ms

