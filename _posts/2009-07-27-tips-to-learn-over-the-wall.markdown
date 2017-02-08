---
author: abloz
comments: true
date: 2009-07-27 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/07/27/tips-to-learn-over-the-wall/
slug: tips-to-learn-over-the-wall
title: 多学几招来翻墙
wordpress_id: 925
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou)/文

 

[  
](http://yeelou.com/)

 

搞技术的没有什么突然变阔的能力。毛主席早就看透知识分子的命运：知识越多越反动。反过来说，越反动则知识越多。否则就只能看到被人咀嚼过，阉割过没有营养没有繁殖能力的东西，当然也就没什么知识了。

60国庆要来，网封的也比较厉害，什么饭否嘀咕干啥，一看就网站名字就反动，必须关停整顿。理解政府。GFW和绿霸不是想一个漏网鱼没有，但至少把大部分的给网住。

 

其实我平时都懒得翻墙，一般就看看订阅的maillist，谷歌论坛。除非想了解真相和西方敌对势力的原始观点，需去BBC或CNN。不过翻翻陈芝麻烂谷子，也许饥饿的兄弟用的着。

 

1. ssh

一位同事看我在用某IM工具，惊奇的说你怎么能用？company不是封了吗？我被逼无法，只好演示一下。先弄到某linux服务器的账号，然后用 pietty登陆。在配置选项的connection->ssh->tunnels页，source  port填一个7070之类的端口，将local 和remote的设置为Dynamic，将ipv4和ipv6的选择为auto，点击Add。如下图：

![pietty 配置](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20090727/ssh.PNG)

 

然后在IE或者QQ里的代理，选socks5，IP地址为本地127.0.0.1，端口为刚配的7070.确定。

这相当于在本地开了个代理，打洞到所连接的linux服务器。如果linux服务器没有被封，又提供转发，则事成。

[view plain](http://blog.csdn.net/ablo_zhou/archive/2009/07/27/4384267.aspx#)[copy to clipboard](http://blog.csdn.net/ablo_zhou/archive/2009/07/27/4384267.aspx#)[print](http://blog.csdn.net/ablo_zhou/archive/2009/07/27/4384267.aspx#)[?](http://blog.csdn.net/ablo_zhou/archive/2009/07/27/4384267.aspx#)

  1. a本地local (127.0.0.1 7070) （ssh加密）->b 公司or政府网关(gateway) ->c 合法linux服务器地址（ssh解密） ->d（明文） 目标地址

a本地local (127.0.0.1 7070) （ssh加密）->b 公司or政府网关(gateway) ->c 合法linux服务器地址（ssh解密） ->d（明文） 目标地址    

在完成整个路由过程中，可能block的地方为b端，因为b端看到的是密文，没办法block，如果要绕过的也是b，则翻墙成功。

 

2. google 的gmail订阅mail list。gmail通过标签可以对邮件很好的分类，不怕口水多。本人有时看看python 的mail list [python-cn@googlegroups.com](mailto:python-cn@googlegroups.com) 等技术组，参考消息[Go2group@googlegroups.com](mailto:Go2group@googlegroups.com) 等新闻组。

 

3.用tor，freegate等暴力穿墙方式，有时灵，有时挺不灵（慢，或者失效）。由于本人掌握有服务器资源，所以现在很少用了。一般都用第1，2种。

 

4.网上代理。自从GAE被封，网上代理又失去一块领地。总有一天，gmail也要被封。前段时间的谷歌低俗的报道，说明了这一种趋势。

 

5.翻公司外网可以用wifi无线，3G网卡，GPRS网卡，自己开ADSL，手机做无线代理等花钱的方式绕开公司网关。

 

6.翻公司墙还可以请网管吃饭或请有出网权限的人吃饭，让他帮你开代理等方式出去。

 

7.其他暂未想到或提到的，欢迎补充。

 

古语道，防民甚于防川。只有广开言路，社会才能进步。但也理解政府想降低管理难度的初衷。如果交税的全是傻子就好了。只交税，不用监督政府官员。做 官的成本可以最低，但利益可以最高。虽然言论不足以撼动政府地位，但网络言论的确影响了政府，也看到了政府的一些改变。创造力是从头脑的自由开始的。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=9296f72e-cb0c-885f-aa7c-98c76d012686)
