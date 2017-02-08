---
author: abloz
comments: true
date: 2010-03-25 07:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/25/gateway-to-set-iptables-to-do-with-linux/
slug: gateway-to-set-iptables-to-do-with-linux
title: 用linux设置iptables做网关
wordpress_id: 1181
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010-3-25

http://blog.csdn.net/ablo_zhou

 

为了安全起见，web服务器，数据库，计费等有重要内容的机器，可能是藏在防火墙后面的，甚至没有外网地址。在此，我们假定需要给一台只有内网地址的web服务器设置linux网关，让外网可以访问web，但又屏蔽其他端口的访问。

 

iptables是linux 2.4以上内核自带的防火墙，可以用于阻挡非法的端口和IP访问，也可以用于做网关设备，配置NAT/防火墙，做port forward.

 

iptables  的逻辑，由表tables，链chains，规则rules组成。根据报文头进行相应的处理。系统接受到包时，底层路由根据目的地分发。如果目的地是本 机，则进入INPUT链。本机处理完，再进入OUTPUT链，发送出去。如果目的地不是本机，则进入FORWARD链，符合规则，则转发出去。

 

设备设置：

web site ip port: 192.168.12.50 80 (windows IIS server or linux apache)

gateway public ip(eth0): 210.211.22.20, private ip(eth1): 192.168.12.10 (centos 5.2)

 

现在我们希望访问http://210.211.22.20 即可访问http://192.168.12.50:80.

 

1.gateway上设置允许IP转送：

 

vi /etc/sysctl.conf 

设置：

 

net.ipv4.ip_forward = 1 

 

执行

sysctl -p

应该看到

net.ipv4.ip_forward = 1 

 

2.gateway上设置iptables

 

[view plain](http://blog.csdn.net/ablo_zhou/archive/2010/03/25/5416239.aspx#)[copy to clipboard](http://blog.csdn.net/ablo_zhou/archive/2010/03/25/5416239.aspx#)[print](http://blog.csdn.net/ablo_zhou/archive/2010/03/25/5416239.aspx#)[?](http://blog.csdn.net/ablo_zhou/archive/2010/03/25/5416239.aspx#)

  1. #nat表，PREROUTING链，设置对eth0的目标端口是80的tcp协议，放到DNAT，forward到192.168.12.50:80
  2. iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j DNAT --to 192.168.12.50:80
  3. #filter表，对接到的eth0的，从eth1转到192.168.12.50:80
  4. iptables -A FORWARD -p tcp -i eth0 -o eth1 -d 192.168.12.50 --dport 80 -j ACCEPT
  5. #但是，也要做nat变换，维护一份映射表，从eth1送出时采用内网地址，回来时变为公网地址。否则外网会收不到回复。
  6. iptables -t nat -A POSTROUTING -j MASQUERADE -o eth1

#nat表，PREROUTING链，设置对eth0的目标端口是80的tcp协议，放到DNAT，forward到192.168.12.50:80 iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j DNAT --to 192.168.12.50:80 #filter表，对接到的eth0的，从eth1转到192.168.12.50:80 iptables -A FORWARD -p tcp -i eth0 -o eth1 -d 192.168.12.50 --dport 80 -j ACCEPT #但是，也要做nat变换，维护一份映射表，从eth1送出时采用内网地址，回来时变为公网地址。否则外网会收不到回复。 iptables -t nat -A POSTROUTING -j MASQUERADE -o eth1   

设置完毕，执行service iptables save

此时，从外网访问http://210.211.22.20已经可以看到内网的网页。

 

3.举一反三，根据需要，可以将端口设置为数据库的1433或ftp的20，21，smtp和pop的25，110等，协议和转发需要稍有改动和调试。

例如，设置mssql数据库的代理。

[](http://blog.csdn.net/ablo_zhou/archive/2010/03/25/5416239.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2010/03/25/5416239.aspx#)

  1. #1.在nat表设置PREROUTING链，这里没有 -o选项。
  2. iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 1433 -j DNAT --to 192.168.12.123:1433
  3. #2.设置filter表
  4. iptables -A FORWARD -p tcp -i eth0 -o eth1 --dport 1433 -d 192.168.12.123 -j ACCEPT
  5. #3.nat变换，如果有了就可以不设置
  6. iptables -t nat -A POSTROUTING -j MASQUERADE -o eth1

#1.在nat表设置PREROUTING链，这里没有 -o选项。 iptables -t nat -A PREROUTING -p tcp -i eth0  --dport 1433 -j DNAT --to 192.168.12.123:1433 #2.设置filter表 iptables -A FORWARD -p tcp -i eth0 -o eth1 --dport 1433 -d 192.168.12.123 -j ACCEPT #3.nat变换，如果有了就可以不设置 iptables -t nat -A POSTROUTING -j MASQUERADE -o eth1    

4.设置好iptables，将不允许的访问全部禁止。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=69b9968a-6149-8b13-a614-9f6f1ecd3656)
