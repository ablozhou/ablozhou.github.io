---
author: abloz
comments: true
date: 2015-06-08 03:16:57+00:00
layout: post
link: http://abloz.com/index.php/2015/06/08/baas-background-system/
slug: baas-background-system
title: 周海汉：Baas 后台系统推荐
wordpress_id: 2680
categories:
- 技术
tags:
- app
- baas
---

周海汉 2015.6.8

Baas(Backend as a service)，类似于专门给移动应用做服务的云，可以是公有云，也可以是私有云。

为什么需要BAAS呢？其实很多app应用后台都大同小异。都是请求响应模式。用户管理，群组管理，文件管理，数据集管理，认证管理，安全管理，社交管理，消息推送。

如果BAAS还支持第三方扩展，插件扩展，那就可以为应用后台开发省去大量重复性劳动。

**国外Baas有**：



	
  * Usergid：[http://usergrid.incubator.apache.org/](http://usergrid.incubator.apache.org/), 是Ed Anuff（http://www.anuff.com) 2011年10月创立的，2012年1月被apigee收购，2012年10月，韩国电信hitel公司开发分支，2013年10月向apache提交的开源baas(backend as a service)，目前在孵化状态。韩国电信，三星等有使用该baas。实现了用户，数据，文件，安全，设备，社交，统计，电邮，自定义API等功能。数据库有抽象层，自带支持cassandra。

	
  * BaasBox：[http://baasbox.com](http://baasbox.com)，基于play框架开发的开源java baas。采用插件机制。实现了用户管理，数据集管理，文件管理，权限管理，push，后台管理等功能。

	
  * Parse:[ https://parse.com/](https://parse.com/) ,2011年创立，2013年4月被facebook收购。实现了用户，push，云代码，托管，社交功能。

	
  * Kinvey：[http://www.kinvey.com/](http://www.kinvey.com/) , 2010年建立，获得1.78亿美元第4轮投资。实现了用户，push，数据管理，自定义api。

	
  * StackMob：[https://www.stackmob.com/](https://www.stackmob.com/) ,2010年1月建立，2013年12月被paypal收购。2014年5月被关闭。

	
  * FireBase:[https://www.firebase.com/](https://www.firebase.com/), 2011年9月建立，2014年10月被谷歌收购。主要功能是服务于实时app应用。


**国内：**



	
  * Bmob: [http://www.bmob.cn/](http://www.bmob.cn/), 实现了文件服务，数据服务，推送服务和扩展功能。

	
  * LeanCloud: http://leancloud.cn, 原名avos cloud，实现了数据存储，实时聊天，消息推送，数据分析等服务。提供android，iOS，Windows Phone，JS的sdk。


原文链接地址：[http://abloz.com/index.php/2015/06/08/baas-background-system/](http://abloz.com/index.php/2015/06/08/baas-background-system/%20‎) ‎
