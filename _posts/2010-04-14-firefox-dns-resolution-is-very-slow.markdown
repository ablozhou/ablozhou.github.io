---
author: abloz
comments: true
date: 2010-04-14 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/04/14/firefox-dns-resolution-is-very-slow/
slug: firefox-dns-resolution-is-very-slow
title: firefox dns解析很慢？
wordpress_id: 1207
categories:
- 技术
---

#  					 				

				

 					  					  					

周海汉 /文

2010.4.14

 

用nslookup一下就返回了。

但firefox一直提示等待dns解析。时间可能长达30s到1分钟。

网上有人提出

_在/etc/modprob.conf文件（如果是2.4.x内核，修改/etc/modules.conf），加入下面两行  
alias ipv6 off  
alias net-pf-10 off_

 

不过我的ubuntu并没有该配置文件。

怀疑是ipv6引起的问题。firefox本身的首选项没有配置ipv6的选项。

后面找到在about:config中有所有的配置。

 

在地址栏输入about:config

 

过滤ipv6,看到

 

network.dns.disableIPv6 false

双击将其值改为true，dns果然快了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=c4a29271-152d-856f-a4d3-caff5013c197)
