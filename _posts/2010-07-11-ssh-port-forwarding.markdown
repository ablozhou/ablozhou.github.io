---
author: abloz
comments: true
date: 2010-07-11 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/07/11/ssh-port-forwarding/
slug: ssh-port-forwarding
title: ssh 端口转发
wordpress_id: 1236
categories:
- 技术
---

## 周海汉 2010年07月2日

使用了goddady的linux虚拟主机，提供ssh。但使用ssh -D port xxx@server时，遇到ssh上打印如下错误：


```
 

channel 3: open failed: administratively prohibited: open failed


```
 

firefox浏览器配置了socks5指向本地的port时，浏览任何网页显示空白。

这是什么原因呢？

ssh上去，打开sshd_config看一下，


```
 

cat /etc/ssh/sshd_config


```
 

有一行：


```
 

AllowTcpForwarding no


```
 

原来主机设置了禁止ssh的tcp 端口转发。那想用ssh做代理进行端口转发肯定是不成功的。

再查看系统配置，也禁止了ip转发；


```
 

cat /etc/sysctl.conf | grep ip_forward  
net.ipv4.ip_forward = 0


```
 

所以，该虚拟主机提示端口转发被禁止，正常。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=ad53479e-7188-88f2-a0dd-f355da2c400a)
