---
author: abloz
comments: true
date: 2011-02-17 02:07:23+00:00
layout: post
link: http://abloz.com/index.php/2011/02/17/iptables-firewall-configuration-of-a-typical/
slug: iptables-firewall-configuration-of-a-typical
title: 一个典型的iptables防火墙配置
wordpress_id: 1264
categories:
- 技术
tags:
- iptables
---

周海汉 2011.2.17

机房安全是必须考虑的事情。一些服务器设备必须暴露公网IP，很容易遭到攻击。配置硬件或软件防火墙，只开放可以访问的端口，拒绝其他不合法的IP的请求，包括端口扫描。甚至拒绝ping。将大大提升服务器的安全。
本脚本配置iptables，只允许北京和香港远程访问香港的服务器。但会开放web端口给任何IP访问。可以做出更严格的限制，只允许某几个IP访问。这样，规避大部分的随意的攻击。
本脚本缺省拒绝所有连接，这是必须小心的。如果用iptables -F来清空所有iptables的规则，可能导致远程无法访问服务器，必须先修改缺省规则为ACCEPT所有。所以有一种替代方法，在规则末尾增加一条drop任何包的规则。这样清除规则后，不会导致无法访问。 centos 5.2调试通过。

    
    
    #!/bin/bash
    # 2010.10.14 modified by zhouhh
    ### 1.允许内网192.168.0.0，通过内网卡的所有协议
    ### 2.允许北京电信、网通、电信通和香港26段共4个子网通过外网访问ssh端口，允许所有ping本机
    ### 3.允许任何地址，通过任何网口访问本机web端口
    ### 4.开放所有UDP端口
    if [ $UID != 0 ]; then
    	echo "must be root to run this script!"
    	exit
    fi
    
    ### 定义子网变量
     BJ_DXT=218.249.75.128/26
     BJ_DX=219.141.178.96/28
     BJ_CNC=123.127.24.128/25
     HK_26=210.211.26.0/24
     NET_LAN=192.168.1.0/24
    ### 定义本地IP
     IP_LAN=192.168.1.
     IP_WAN=210.211.26.
    
    ### 定义服务端口
     ssh_port=60000
     web_port=80
     sip_port=5060
    
    ### 定义网络接口
     ETH_LAN=eth0
     ETH_WAN=eth1
    
    ### 定义程序及路径变量
     ipt=/sbin/iptables
    
    ### 具体规则
     echo "[+]Flushing all rules..."
     iptables --flush
     service iptables stop
    
     echo "[+]Set default policy..."
    #缺省拒绝所有接入
     $ipt -P INPUT DROP
     $ipt -I INPUT 1 -m state --state ESTABLISHED,RELATED -j ACCEPT
    
     $ipt -N TCP_ERR
     $ipt -I INPUT 2 -j TCP_ERR
    
     echo "[+]Creating rules for web port..."
     $ipt -A INPUT -p tcp --dport $web_port -m state --state NEW -j ACCEPT
    
     echo "[+] accept all UDP ports..."
     $ipt -A INPUT -p udp -j ACCEPT
    
    ### 允许北京和香港ping本机，其他拒绝
    # ping 不限制,zhouhh comment
    # echo "[+]Creating icmp rules..."
    # $ipt -A INPUT -i $ETH_WAN -s $BJ-DXT -p icmp --cmp-type 8 -j ACCEPT
    # $ipt -A INPUT -i $ETH_WAN -s $BJ-DX  -p icmp --cmp-type 8 -j ACCEPT
    # $ipt -A INPUT -i $ETH_WAN -s $BJ-CNC -p icmp --cmp-type 8 -j ACCEPT
    # $ipt -A INPUT -i $ETH_WAN -s $HK-26  -p icmp --cmp-type 8 -j ACCEPT
    # $ipt -A INPUT -i $ETH_WAN -p icmp -j DROP
    
     $ipt -A INPUT  -p icmp -j ACCEPT
    
    ###  允许内网所有IP通信
     echo "[+]Permit lan all..."
     $ipt -A INPUT -i $NET_LAN -s $NET_LAN -j ACCEPT
     $ipt -A INPUT -i lo -j ACCEPT
    
    ### 其他规则start
    
    ### 其他规则end
    
    ### 拒绝错误的TCP包
     echo "[+]Creating TCP rules for new chain TCP_ERR..."
     $ipt -I TCP_ERR 1  -p tcp --tcp-flags ALL ALL -j DROP
     $ipt -I TCP_ERR 2  -p tcp --tcp-flags ALL NONE -j DROP
     $ipt -I TCP_ERR 3  -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
     $ipt -I TCP_ERR 4  -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
     $ipt -I TCP_ERR 5  -p tcp --tcp-flags ALL FIN,URG,PSH -j LOG -m limit --limit 1/s --log-prefix  "bad package"
     $ipt -I TCP_ERR 6  -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
     $ipt -I TCP_ERR 7  -p tcp ! --syn -m state --state NEW -j DROP
    
    ### 允许北京和香港访问ssh端口
     echo "[+]Creating ssh rules..."
     $ipt -A INPUT -i $ETH_WAN -s $BJ_DXT -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
     $ipt -A INPUT -i $ETH_WAN -s $BJ_DX  -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
     $ipt -A INPUT -i $ETH_WAN -s $BJ_CNC -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
     $ipt -A INPUT -i $ETH_WAN -s $HK_25  -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
    
    
    ### 保存配置让规则随系统启动
     service iptables save
    
