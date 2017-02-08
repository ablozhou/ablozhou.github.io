---
author: abloz
comments: true
date: 2010-09-20 09:04:01+00:00
layout: post
link: http://abloz.com/index.php/2010/09/20/empathy-2-30-3-msn-can-not-log-on/
slug: empathy-2-30-3-msn-can-not-log-on
title: Empathy 2.30.3 msn不能登录
wordpress_id: 401
categories:
- 技术
tags:
- empathy
- msn
---

可能是系统升级后没有重启的原因，Empathy登录msn时立即返回网络错误。开始以为是我1863端口错了。将帐号删了，新建msn帐号还是如此。
[![](http://abloz.com/wp-content/uploads/2010/09/Screenshot-消息和-VoIP-帐户.png)](http://abloz.com/wp-content/uploads/2010/09/Screenshot-消息和-VoIP-帐户.png)
后面通过google发现可能是telepathy-butterfly的问题。执行如下的命令：

    
    
    zhouhh@zhh64:~$ killall telepathy-butterfly
    



重新登录，果然可以了。
