---
author: abloz
comments: true
date: 2010-01-11 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/01/11/ssh-port-forwarding-can-be-used-over-the-wall/
slug: ssh-port-forwarding-can-be-used-over-the-wall
title: SSH 端口转发（可以用于翻墙）
wordpress_id: 1012
categories:
- 社会评论
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.1.11

 

SSH端口转发可以提供一条加密隧道，该隧道可以用于穿透防火墙，防止窃听。但隧道两侧仍是明文。

 

1. LocalForward

应用场景：

你需要访问邮箱pop.163.com 端口110，但你本地localhost不能直接连接到邮箱，而远程一台服务器MySer可以访问到。

 

zhouhh@zhouhh-home:~$ssh -p 60066 -L 9999:pop.163.com:110 root@MySer  
root@Myser's password:   
Last login: Sun Jan 10 23:42:21 2010 from 125.39.109.34

 

其中-p 参数是Myser ssh连接的端口 9999是本地端口。-L 是LocalForward

 

本地连接：

 

zhouhh@zhouhh-home:~$nc localhost 9999  
+OK Welcome to coremail Mail Pop3 Server (163coms[d0a67bcd290bb19fb165d92968971e20s])  
USER ablo_zhou  
+OK core mail  
PASS xxxxx

LIST  
+OK 61 38689853  
1 6402  
2 2478  
3 5780  
QUIT  
+OK core mail

 

2. RemoteForward

应用场景：你周末需要加班，但你不想去公司干活，想在家里干。而很多资源如subversion都只有公司内网才能访问到。防火墙不允许你从家里直接连公司。VPN又在周末出了问题，需维护。

 

可以在下班前，先配置工作机器，远程连接到你家里的电脑，采用远程转发RemoteForward.

工作机器配置：
    
    vi ~/.ssh/config
           Host myhome
           Hostname      123.45.67.8
           RemoteForward 2222:localhost:22
           User          ablozhou
    
    远程连接到家里：
    
    
    zhouhh@zhhofs$ssh myhome<span class="body"><pre><span class="body"><pre>zhouhh@123.45.67.8's password:

远程连接到家里后，为防止防火墙对不活动连接关闭，做一个定期的ping  

    
    zhouhh@zhouhh-home$ ping -i 5 127.0.0.1<br />  PING 127.0.0.1 (127.0.0.1): 56 data bytes<br /><span class="body"><pre>  64 bytes from 127.0.0.1: icmp_seq=0 ttl=255 time=0.1 ms<br />
    
    这样就会有回显，连接才不会断。<br />回家后，可以连接<br /><br />zhouhh@zhouhh-home$ ssh -p 2222 zhouhh@localhost<strong> </strong><br /> zhouhh@localhost's password: <strong><em></em></strong><br />zhouhh@zhhofs$<br /><span class="body"><pre>成功<br />参考：<br />

http://www.securityfocus.com/infocus/1816  
  


![](http://img.zemanta.com/pixy.gif?x-id=1b88fa64-d5dc-82fd-b64e-06779e33a1b6)
