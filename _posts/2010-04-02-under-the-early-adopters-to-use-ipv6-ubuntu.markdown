---
author: abloz
comments: true
date: 2010-04-02 07:29:40+00:00
layout: post
link: http://abloz.com/index.php/2010/04/02/under-the-early-adopters-to-use-ipv6-ubuntu/
slug: under-the-early-adopters-to-use-ipv6-ubuntu
title: ubuntu 下尝鲜使用IPv6
wordpress_id: 1197
categories:
- 技术
tags:
- ipv6
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.4.2

http://blog.csdn.net/ablo_zhou

ablozhou # gmail.com


## IPv6杂谈


话说IPv4地址不够用了，只有2的32次方个，尤其是中国这样的发展中的人口大国，所分到的IP地址非常少，以至于中国公司里最常见的都是内部网 址，公网IP非常稀缺。而美国的大学，人手一个公网地址，还有大把IP不知怎么用出去。既然不够用，分配又不均，那么扩展一下吧，将IP地址由32位扩展 到128位，[据说](http://zh.wikipedia.org/wiki/IPv6) 等价于地球上每平方毫米6.7×1017 个地址。这下大家都不用争了。不仅电源插头可以分一个IP，连地球上的蚂蚁都可以分一个IP，让他们也沾一下信息技术的光。

不过，IPv6虽然唱了很多年，除了研究机构在提，并不见平民百姓应用。其实呢，像我等并不具备IPv6网络条件的，也可以借助 linux，mac, win7等系统，采用曲线救国的方式，率先尝鲜IPv6.  甚至还可以代表技术的先进性，突破GFW，访问一些无端被封的又支持IPv6的网络，如youtube，用的人多了，GFW也得升级，让做GFW的孙子们 免于失业（此语并非骂人，出处：未来是我们的，也是儿子们的，但最终是孙子们的），也算是为促进中国的高新技术发展和拉升GDP做了贡献。


## linux对ipv6的支持情况概述


linux内核2.2.1以上的版本就支持IPv6，只不过不同的linux发行版由于对IPv6态度不同，有的发行版已经带有，有的需要额外加入［[1](http://www.jijiao.com.cn/Networking/prosect/ipv6/00000021.htm) ］。由于网络等原因，大多数人没有用上IPv6，国内实验性的IPv6网络在一些高校有部署。ubuntu9.10也是支持IPv6的。








[](http://blog.csdn.net/ablo_zhou/archive/2010/04/02/5443934.aspx#)[
](http://blog.csdn.net/ablo_zhou/archive/2010/04/02/5443934.aspx#)








	
  1. zhouhh@zhh64:~$ ifconfig

	
  2. eth0      Link encap:以太网  硬件地址 00:1f:c6:f3:ed:99

	
  3. inet 地址:192.168.11.116  广播:192.168.11.255  掩码:255.255.255.0

	
  4. inet6 地址: fe80::21f:c6ff:fef3:ed99/64 Scope:Link

	
  5. UP BROADCAST RUNNING MULTICAST  MTU:1500  跃点数:1

	
  6. 接收数据包:2675133 错误:0 丢弃:0 过载:0 帧数:0

	
  7. 发送数据包:2067074 错误:0 丢弃:0 过载:0 载波:0

	
  8. 碰撞:0 发送队列长度:1000

	
  9. 接收字节:456461801 (456.4 MB)  发送字节:166684495 (166.6 MB)

	
  10. 中断:19 基本地址:0xcc00

	
  11. lo        Link encap:本地环回

	
  12. inet 地址:127.0.0.1  掩码:255.0.0.0

	
  13. inet6 地址: ::1/128 Scope:Host

	
  14. UP LOOPBACK RUNNING  MTU:16436  跃点数:1

	
  15. 接收数据包:62110 错误:0 丢弃:0 过载:0 帧数:0

	
  16. 发送数据包:62110 错误:0 丢弃:0 过载:0 载波:0

	
  17. 碰撞:0 发送队列长度:0

	
  18. 接收字节:11457430 (11.4 MB)  发送字节:11457430 (11.4 MB)





可以看到eth0和lo的ipv6地址。

然而由于网络不支持ipv6的原因，一般我们是无法访问到ipv6的地址的。

下面是几个测试用的网站：



	
  * http://www.kame.net/  如果看到乌龟在动，说明你支持ipv6

	
  * http://www.sixxs.net/tools/ipv6calc/ 如果看到你的ip地址不是ipv4的地址，说明支持ipv6

	
  * http://ipv6.beijing2008.cn/  如果能看到页面支持ipv6

	
  * http://ipv6.google.com/ 如果能看到页面，说明ipv6支持


那么在命令行下，linux也提供一系列工具进行测试，如ping6， tracert6：

zhouhh@zhh64:~$ ping6 ipv6.google.com
PING ipv6.google.com(pv-in-x6a.1e100.net) 56 data bytes
64 bytes from pv-in-x6a.1e100.net: icmp_seq=1 ttl=52 time=389 ms
64 bytes from pv-in-x6a.1e100.net: icmp_seq=2 ttl=52 time=383 ms
^C64 bytes from pv-in-x6a.1e100.net: icmp_seq=3 ttl=52 time=375 ms

--- ipv6.google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1999ms
rtt min/avg/max/mdev = 375.472/382.975/389.489/5.764 ms
zhouhh@zhh64:~$
zhouhh@zhh64:~$ tracert6 ipv6.beijing2008.cn
程序“tracert6”尚未安装。  您可以使用以下命令安装：
sudo apt-get install ndisc6
tracert6: command not found

需要net-tools版本大于1.5.1，ubuntu9.10的net-tools版本是 1.6


## IPv4网络下使用IPv6原理


有点类似于VPN，采用tunnel模式，向ipv6服务器获取一个ipv6的地址，然后通过隧道访问ipv6网络。

![ipv6](http://www.apol.com.tw/ipv6/images/ipv6-tb-1-01.gif)


## ubuntu9.10下使用ipv6


**1.下载隧道客户端软件gw6c (gateway6 client)**

sudo apt-get install gw6c

该版本是6.0.1dfsg.1-4.

其原理是采用TSP协议，建立和维护静态隧道。gw6c运行后，连接到隧道代理（tunnel broker)。

**2.[解决该版本gw6c的bug](https://bugs.launchpad.net/ubuntu/+source/gw6c/+bug/438658) **

本版本没有生成gw6c.conf到/etc/gw6c.

我们必须手工修复。

zhouhh@zhh64:/etc/gw6c$ cd /usr/share/doc/gw6c/

zhouhh@zhh64:/usr/share/doc/gw6c/examples$ ls
gw6c.conf.sample.gz
zhouhh@zhh64:/usr/share/doc/gw6c/examples$ sudo gzip -d gw6c.conf.sample.gz
zhouhh@zhh64:/usr/share/doc/gw6c/examples$ ls
gw6c.conf.sample
zhouhh@zhh64:/usr/share/doc/gw6c/examples$ sudo vi gw6c.conf.sample

修改：

if_tunnel_v6v4=sit1

if_tunnel_v6udpv4=tun0
if_tunnel_v4v6=sit0
template=linux

可以看到

server=anonymous.freenet6.net

也可以设置为台湾的：

server=tb.ipv6.apol.com.tw

另存为~/gw6c.conf

zhouhh@zhh64:~$ sudo cp gw6c.conf /etc/gw6c/.

**3. 启动gw6c**

此前还不支持ipv6

zhouhh@zhh64:~$ ifconfig
eth0      Link encap:以太网  硬件地址 00:1f:c6:f3:ed:99
inet 地址:192.168.11.116  广播:192.168.11.255  掩码:255.255.255.0
inet6 地址: fe80::21f:c6ff:fef3:ed99/64 Scope:Link
UP BROADCAST RUNNING MULTICAST  MTU:1500  跃点数:1
接收数据包:2600649 错误:0 丢弃:0 过载:0 帧数:0
发送数据包:2012937 错误:0 丢弃:0 过载:0 载波:0
碰撞:0 发送队列长度:1000
接收字节:437236207 (437.2 MB)  发送字节:161545732 (161.5 MB)
中断:19 基本地址:0xcc00

lo        Link encap:本地环回
inet 地址:127.0.0.1  掩码:255.0.0.0
inet6 地址: ::1/128 Scope:Host
UP LOOPBACK RUNNING  MTU:16436  跃点数:1
接收数据包:61335 错误:0 丢弃:0 过载:0 帧数:0
发送数据包:61335 错误:0 丢弃:0 过载:0 载波:0
碰撞:0 发送队列长度:0
接收字节:11332448 (11.3 MB)  发送字节:11332448 (11.3 MB)

zhouhh@zhh64:~$ ping6 ipv6.google.com
connect: Network is unreachable

访问http://www.sixxs.net/tools/ipv6calc/

看到的是ipv4的地址：








[](http://blog.csdn.net/ablo_zhou/archive/2010/04/02/5443934.aspx#)[
](http://blog.csdn.net/ablo_zhou/archive/2010/04/02/5443934.aspx#)








	
  1. http://www.sixxs.net/tools/ipv6calc/

	
  2. IPv4 address

	
  3. 218.249.75.164

	
  4. 
	
  5. Registry of IPv4 address

	
  6. APNIC

	
  7. 
	
  8. Reverse DNS resolution

	
  9. 3(NXDOMAIN)

	
  10. 
	
  11. 
	
  12. Generated by ipv6calcweb.cgi, (P) & (C) 2002 by Peter Bieringer

	
  13. Powered by ipv6calc, (P) & (C) 2001-2007 by Peter Bieringer <pb (at) bieringer.de>

	
  14. Modified to SixXS-style by Jeroen Massar

	
  15. 
	
  16. 
	
  17. 
	
  18. 
	
  19. Your Browser: Mozilla/5.0 X11 U Linux x8664 zh-CN rv1.9.1.8) Gecko/20100214 Ubuntu/9.10 karmic) Firefox/3.5.8





编辑系统->首选项->网络连接，编辑eth0，IPv6设置标签的方法，有忽略设为自动，应用。

用超级用户权限执行gw6c。

再测试ipv6:

zhouhh@zhh64:~$ sudo gw6c
zhouhh@zhh64:~$ ps -ef | grep gw6c
root     17980     1  0 10:03 ?        00:00:00 gw6c
zhouhh   18007  8593  0 10:03 pts/1    00:00:00 grep --color=auto gw6c

**4.测试使用ipv6**








[](http://blog.csdn.net/ablo_zhou/archive/2010/04/02/5443934.aspx#)[
](http://blog.csdn.net/ablo_zhou/archive/2010/04/02/5443934.aspx#)








	
  1. zhouhh@zhh64:~$ ifconfig

	
  2. eth0      Link encap:以太网  硬件地址 00:1f:c6:f3:ed:99

	
  3. inet 地址:192.168.11.116  广播:192.168.11.255  掩码:255.255.255.0

	
  4. inet6 地址: fe80::21f:c6ff:fef3:ed99/64 Scope:Link

	
  5. UP BROADCAST RUNNING MULTICAST  MTU:1500  跃点数:1

	
  6. 接收数据包:2625933 错误:0 丢弃:0 过载:0 帧数:0

	
  7. 发送数据包:2032156 错误:0 丢弃:0 过载:0 载波:0

	
  8. 碰撞:0 发送队列长度:1000

	
  9. 接收字节:443452120 (443.4 MB)  发送字节:163293807 (163.2 MB)

	
  10. 中断:19 基本地址:0xcc00

	
  11. lo        Link encap:本地环回

	
  12. inet 地址:127.0.0.1  掩码:255.0.0.0

	
  13. inet6 地址: ::1/128 Scope:Host

	
  14. UP LOOPBACK RUNNING  MTU:16436  跃点数:1

	
  15. 接收数据包:61521 错误:0 丢弃:0 过载:0 帧数:0

	
  16. 发送数据包:61521 错误:0 丢弃:0 过载:0 载波:0

	
  17. 碰撞:0 发送队列长度:0

	
  18. 接收字节:11363324 (11.3 MB)  发送字节:11363324 (11.3 MB)

	
  19. tun0      Link encap:未指定  硬件地址 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00

	
  20. inet6 地址: 2001:5c0:1000:b::5a13/128 Scope:Global

	
  21. UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1280  跃点数:1

	
  22. 接收数据包:571 错误:0 丢弃:0 过载:0 帧数:0

	
  23. 发送数据包:537 错误:0 丢弃:0 过载:0 载波:0

	
  24. 碰撞:0 发送队列长度:500

	
  25. 接收字节:500599 (500.5 KB)  发送字节:87274 (87.2 KB)





可以看到，多了一个tun0,其inet6 地址: 2001:5c0:1000:b::5a13/128 Scope:Global以2001打头，正是隧道用ipv6地址。

zhouhh@zhh64:~$ ping6 ipv6.google.com
PING ipv6.google.com(pv-in-x63.1e100.net) 56 data bytes
64 bytes from pv-in-x63.1e100.net: icmp_seq=1 ttl=52 time=378 ms
64 bytes from pv-in-x63.1e100.net: icmp_seq=2 ttl=52 time=384 ms
64 bytes from pv-in-x63.1e100.net: icmp_seq=3 ttl=52 time=382 ms

打开firefox浏览器，浏览如下网页：

http://www.kame.net/ 终于看到乌龟动起来了。

http://www.sixxs.net/tools/ipv6calc/  看到地址如下：








[](http://blog.csdn.net/ablo_zhou/archive/2010/04/02/5443934.aspx#)[
](http://blog.csdn.net/ablo_zhou/archive/2010/04/02/5443934.aspx#)








	
  1. Your client

	
  2. 
	
  3. EUI-64 scope

	
  4. local

	
  5. 
	
  6. Interface identifier

	
  7. 0000:0000:0000:5a13

	
  8. 
	
  9. IPv6 address

	
  10. 2001:05c0:1000:000b:0000:0000:0000:5a13

	
  11. 
	
  12. Registry of IPv6 address

	
  13. ARIN

	
  14. 
	
  15. Reverse DNS resolution

	
  16. 3.1.a.5.0.0.0.0.0.0.0.0.0.0.0.0.b.0.0.0.0.0.0.1.0.c.5.0.1.0.0.2.ip6.arpa.

	
  17. 
	
  18. Site Level Aggregator (subnet)

	
  19. 000b

	
  20. 
	
  21. Address type

	
  22. unicast,global-unicast

	
  23. 
	
  24. 




访问http://ipv6.beijing2008.cn/ 和 http://ipv6.google.com 可以正常浏览网页。

**5.翻墙浏览被禁ipv6网站**

由于目前GFW只针对IPv4的网页进行封禁和reset，IPv6可以免疫。

不过，未经设置，并不能直接通过域名访问到被禁网站，如youtube.com.

因为系统首先会采用IPv4去访问。

此时访问http://www.youtube.com会被屏蔽。

参考下面的网页文档，在/etc/hosts内设置支持IPv6网站的IPv6地址:

http://docs.google.com/View?docID=0ARhAbsvps1PlZGZrZG14bnRfNjFkOWNrOWZmcQ&revision=_latest&hgd=1

测试访问

http://www.youtube.com已经没有障碍，速度挺快。


## 参考资料


http://www.kame.net/

http://www.sixxs.net/tools/ipv6calc/

http://ipv6.beijing2008.cn/

http://ipv6.google.com/

http://zh.wikipedia.org/wiki/IPv6

http://www.moonv6.org/

http://www.apol.com.tw/ipv6/ipv6-tb-1.html

http://forum.ubuntu.org.cn/viewtopic.php?f=73&t=124378

http://www.jijiao.com.cn/Networking/prosect/ipv6/00000021.htm

http://blog.csdn.net/ablo_zhou/archive/2010/04/01/5441840.aspx


## 注释


============

［1］http://www.jijiao.com.cn/Networking/prosect/ipv6/00000021.htm  linux支持IPv6么？
