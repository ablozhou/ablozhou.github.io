---
author: abloz
comments: true
date: 2010-11-25 08:26:06+00:00
layout: post
link: http://abloz.com/index.php/2010/11/25/svn-not-authorized-to-open-root-of-edit-operation/
slug: svn-not-authorized-to-open-root-of-edit-operation
title: svn未授权打开根进行编辑操作
wordpress_id: 1087
categories:
- 技术
---

2010.11.25  
问题：同事新配一台svn服务器，结果发现svn checkout和update时总报“未授权打开根进行编辑操作”。  
他不得不在authz文件的[/]根下加*=r  
但这样就不能防止别人查看未授权的目录了。  
  
后面发现svnserver.conf里面的配置，  
anon-access=read  
需改为  
anon-access=none  
  
这样就不与authz的配置冲突了。  
  
  
  


![](http://img.zemanta.com/pixy.gif?x-id=28fad58f-6766-8924-b2e2-b4d66aa53d93)
