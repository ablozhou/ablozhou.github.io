---
author: abloz
comments: true
date: 2011-08-25 03:11:06+00:00
layout: post
link: http://abloz.com/index.php/2011/08/25/win7-how-to-access-the-lan-with-a-firewall-so-that-apache-page/
slug: win7-how-to-access-the-lan-with-a-firewall-so-that-apache-page
title: win7下如何配防火墙让局域网可以访问apache页面
wordpress_id: 1357
categories:
- 技术
---

windows7的防火墙，缺省关闭80端口的访问，局域网访问不了机器上的web服务。

配置办法：



控制面板系统和安全Windows 防火墙，

高级设置，配置入站规则

选端口

在特定协议端口页，选tcp协议，特定本地端口：80

允许连接

域，专用，公用全选。

名称：随便写，如apache

确定即可。
