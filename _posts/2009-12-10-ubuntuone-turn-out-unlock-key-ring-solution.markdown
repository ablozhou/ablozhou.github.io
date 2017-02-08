---
author: abloz
comments: true
date: 2009-12-10 05:58:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/10/ubuntuone-turn-out-unlock-key-ring-solution/
slug: ubuntuone-turn-out-unlock-key-ring-solution
title: Ubuntuone开机跳出“解锁密钥环”解决办法
wordpress_id: 981
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2009.12.10

 

ubuntu  有一个密码管理器，用密钥环加密密码。一般来说，如果登录时输入密码，则密码环会自动解锁。而个人用户一般登录时选取自动登录，不输入密码，进入桌面后会 弹出如下的对话框，要求解锁密钥环。如果不解锁，那么开机时一些需要授权的操作，如wifi登录，ubuntuone登录，邮箱等，都可能无法登录。解锁 密钥环，相当于让你具有访问密钥的权限。问题是，如果不禁止或确定，窗口管理器都不能用，不能移动窗口。

开机时会自动弹出一个对话框，输入密码，解锁密钥环，如下图：

 

Ubuntuone 密钥环解锁

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091210/Screenshot-6.png)

 

这时，可以输入密码解锁，即可连上ubuntuone. 挺繁琐。一种直接禁止不用，可在ubuntuone的配置里，将自动登录改为不登录。

 

如果有需要，可以如下方式解决。

1.在“附件->密码和加密密钥”里，将已有的部分全部删除。缺省的一般是"密码:login"，点右键删除。或者在命令行下执行

sudo rm -rf ~/.gnome2/keyrings/*

2.注销后重新登录，要求解锁密钥环的窗口会弹出来，不过多了一个自动解锁的多选，如下图。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091210/Screenshot-5.png)

 

3.下图是我配完后的“密码和加密密钥”，有解锁密码和ubuntuone,pop密码。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091210/Screenshot-%E5%AF%86%E7%A0%81%E5%92%8C%E5%8A%A0%E5%AF%86%E5%AF%86%E9%92%A5.png)

这以后，每次登录都不需输入解锁密钥环的密码了。

 

但这里可能存在bug，导致登入时自动解锁此密钥环设置不能保存，下次登录还需要填写“解锁密钥环”。如果还碰到这种现象，还如上操作，但在密码和加密密钥的密码页，右键点击"密码：login",点“修改密码”，将缺省解锁密码置空，不要管安全提示。

 

本文在ubuntu 9.10测试完成。更早的版本设置界面不完全一样。

 

参考：https://answers.launchpad.net/ubuntu/+source/gnome-keyring/+question/61775

http://brainstorm.ubuntu.com/idea/2393/

  
  


![](http://img.zemanta.com/pixy.gif?x-id=35267024-5052-8659-bf37-f0990d29ad7c)
