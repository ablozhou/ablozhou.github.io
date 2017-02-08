---
author: abloz
comments: true
date: 2009-03-26 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/03/26/login-linux-server-using-the-key-continued/
slug: login-linux-server-using-the-key-continued
title: 用密钥登录linux服务器（续）
wordpress_id: 903
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文

 

上一篇《[用密钥登录linux服务器](http://blog.csdn.net/ablo_zhou/archive/2009/02/13/3887808.aspx)》讲了简单的配置登录密钥的办法。但对于不同的账号，不同的用户和密钥，应该如何处理呢？

 

1.对新的密钥机器生成公钥私钥  
$ ssh-keygen -t rsa  
缺省得到/home/zhouhh/.ssh/id_rsa和/home/zhouhh/.ssh/id_rsa.pub,其中前者是私钥，后者是公钥。

/etc/ssh/sshd_config里面配置

[](http://blog.csdn.net/ablo_zhou/archive/2009/03/26/4027130.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/03/26/4027130.aspx#)

  1. RSAAuthentication yes
  2. PubkeyAuthentication yes
  3. AuthorizedKeysFile .ssh/id_rsa.pub

RSAAuthentication yes PubkeyAuthentication yes AuthorizedKeysFile      .ssh/id_rsa.pub    

再编辑.ssh/id_rsa.pub

里面已经有一行公钥，假设为user1公钥.

 

这个时候如果想另一个账号user2也要通过密钥来登录这台机器。需要找到这个账号的公钥私钥对，将公钥的内容拷贝到.ssh/id_rsa.pub的新的一行中，保存。

 

这时，这一台机器domain1的user1账号就允许两个密钥同时登录了。

如果希望domain1的user1能够也用密钥登录domain2的user2，需要将user2的私钥拷贝到本用户user1的.ssh目录下。设置好权限。这样两台机器间的scp就可以不用输密码，直接拷贝了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=7b3106a3-755e-87d1-8c50-fa34c84aa90c)
