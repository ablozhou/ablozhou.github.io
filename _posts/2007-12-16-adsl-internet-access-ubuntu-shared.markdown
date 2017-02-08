---
author: abloz
comments: true
date: 2007-12-16 09:46:17+00:00
layout: post
link: http://abloz.com/index.php/2007/12/16/adsl-internet-access-ubuntu-shared/
slug: adsl-internet-access-ubuntu-shared
title: ubuntu 共享ADSL上网
wordpress_id: 257
categories:
- 技术
tags:
- ubuntu
- 共享上网
---

# 




Windows  下的共享上网比较简单，选中ADSL连接，右键属性，将共享选上即可。在ubuntu下，也需要设置，但是使用iptables进行IP伪装。或者使用 firestarter之类的图形界面的工具。
ubuntu下用ADSL拨号，需要在终端输入sudo  pppoeconf，然后根据提示，自动检测网卡和ADSL拨号modem，如果找到，则提示输入用户名和密码，注意将用户名前面的username几个 英文字母去掉。
以后使用 sudo pon dsl-provider 拨号上网，使用sudo poff  dsl-provider下线。sudo plog查看拨号日志。
通过 系统－>系统管理－>网络  来配置网卡IP，或通过命令行方式。
网卡IP和配置放在/etc/network/interfaces ，可以用超级用户进行编辑。
对 于无线网卡，配置同上。

下面摘自ubuntu 共享上网的帮助。
IP 伪装的目的是为了允许您网络上那些有着私有的、不可路由的  IP 地址的机器可以通过做伪装的机器访问 Internet。来自您私有网络并要访问 Internet  的传输必须是可以操作的，也就是说回复要可以被路由回来以送到发出请求的机器上。要做到这一点，内核必须修改每个包 源 IP  地址以便回复能被路由回它这里，而不是发出请求的私有 IP 地址，因为它们对于 Internet 来说是不存在的。Linux 使用  Connection Tracking (conntrack)  来保持那个连接是属于哪个机器的，并相应地对每个返回包重新做路由。发自您私有网络的流量就这样被伪装成源于您的网关机器。这一过程在  Microsoft 文档中被称为 Internet 连接共享。

这可以用单条 iptables  规则来完成，也许基于您网络配置来说会有一些小的差异：

sudo iptables -t nat -A POSTROUTING -s  192.168.0.0/16 -o ppp0 -j MASQUERADE

上述命令假设您的私有地址空间是 192.168.0.0/16，您与 Internet 相连的设备是 ppp0。语法分解如下所示：

* -t nat --  该规则将进入 nat 表
* -A POSTROUTING -- 该规则将被追加 (-A) 到 POSTROUTING 链
* -s 192.168.0.0/16 -- 该规则将被应用在源自指定地址空间的流量上
* -o ppp0 --  该规则应用于计划通过指定网络设备的流量。
* -j MASQUERADE -- 匹配该规则的流量将如上所述 "跳转" (-j) 到  MASQUERADE (伪装) 目标。

在过滤表 (缺省表，在那里有着大多数或全部包过滤指令) 中的每条链 (chain)  都有一个默认的 ACCEPT 策略，但如果您还在网关设备上设置防火墙，那么您也许还要设置 DROP 或 REJECT  策略，这时您被伪装过的流量还需要被 FORWARD 链 (chain) 中的规则允许才能正常工作：

sudo iptables  -A FORWARD -s 192.168.0.0/16 -o ppp0 -j ACCEPT
sudo iptables -A  FORWARD -d 192.168.0.0/16 -m state --state ESTABLISHED,RELATED -i ppp0  -j ACCEPT

上述命令将允许通过从您局域网到 Internet  的所有连接，这些连接所有的相关流量也都返回到发起它们的机器。

有很多工具可以帮助您构建一个完整的防火墙，而不需要  iptables 的专业知识。偏好图形界面的，Firestarter 非常流行也易于使用，fwbuilder 则非常强大而且其界面对于用过诸如  Checkpoint FireWall-1 商业防火墙工具的管理员来说相当熟悉。如果您偏好有着纯文本配置文档的命令行工具，Shorewall  是个非常强大的解决方案，可以帮您为任何网络配置一个高级防火墙。如果您的网络相对简单，或如果您没有网络，那么 ipkungfu  将给您一个无需配置就可以工作的防火墙，也允许您通过编辑简单友好的配置文件来轻松设置更高级的防火墙。另一个感兴趣的工具就是fireflier，被设 计成桌面防火墙应用程序。它由一个服务器 (fireflier-server) 和可选的 GUI 客户端 (GTK 或 QT) 组成，操作就象  Windows 中许多流行的交互式防火墙应用程序一样。
