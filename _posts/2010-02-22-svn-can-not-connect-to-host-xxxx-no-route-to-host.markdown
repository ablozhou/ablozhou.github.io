---
author: abloz
comments: true
date: 2010-02-22 06:00:00+00:00
layout: post
link: http://abloz.com/index.php/2010/02/22/svn-can-not-connect-to-host-xxxx-no-route-to-host/
slug: svn-can-not-connect-to-host-xxxx-no-route-to-host
title: 'svn: 无法连接主机“x.x.x.x”: 没有到主机的路由'
wordpress_id: 1147
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou) /文

今天遇到一个奇怪现象。svn服务器放在另一个网段。该服务器可以ping通，可以ssh登录。但用svn更新时却显示：
    
    zhouhh@zhh64:~/svn/release/xx$ svn up
    svn: 无法连接主机“x.x.x.x”: 没有到主机的路由
    
    于是我一开始想去给该IP添加路由。但路由事实上没有问题。否则就不能登录ssh，也不能ping通了。
    搞了半天，发现是svn服务器的防火墙开着，将连接屏蔽了。将iptables关闭即解决。
    不过提示信息也太误导人了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=50a05a97-2439-804a-9960-d080e16f707f)
