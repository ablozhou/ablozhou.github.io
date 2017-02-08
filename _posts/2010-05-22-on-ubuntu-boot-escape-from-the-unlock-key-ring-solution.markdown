---
author: abloz
comments: true
date: 2010-05-22 05:25:37+00:00
layout: post
link: http://abloz.com/index.php/2010/05/22/on-ubuntu-boot-escape-from-the-unlock-key-ring-solution/
slug: on-ubuntu-boot-escape-from-the-unlock-key-ring-solution
title: 再论ubuntu 开机跳出“解锁密钥环”解决办法
wordpress_id: 116
categories:
- 技术
tags:
- ubuntu
- 密钥环
---

周海汉 /文

  
2010.5.22

 

ubuntu 9.10时碰到开机跳出“解锁密钥环”这个问题，所以写了一篇《[Ubuntuone 开机跳出“解锁密钥环”解决办法](http://blog.csdn.net/ablo_zhou/archive/2009/12/13/4978872.aspx) 》。方法仍然实用于ubuntu10.04.

我在ubuntu 10.04仍然碰到这个问题。

![](http://hi.csdn.net/attachment/201005/22/0_12744900612dP2.gif)

1.如果开机不是自动登录，可以将密钥环密码设为和登录密码一致。这样登录后自动解密密钥环。

2.如果是自动登录，可以将密钥环密码留空。

![](http://hi.csdn.net/attachment/201005/22/0_1274490135vuWd.gif)

 

确认警告：

![](http://hi.csdn.net/attachment/201005/22/0_1274490328eJpm.gif)

但空密码带来安全问题，密钥环密码全被明文存储了。

 

此时可以直接看到~/.gnome2/keyrings/login.keyring里面明文存储的密码。

不过，幸好该文件仅当前用户可读写。

zhouhh@zhhm:~$ ls -l ~/.gnome2/keyrings -a  
总计 20  
drwxr-xr-x 2 zhouhh zhouhh 4096 2010-05-22 08:34 .  
drwxr-xr-x 9 zhouhh zhouhh 4096 2010-05-22 08:30 ..  
-rw-r--r-- 1 zhouhh zhouhh 5 2010-05-22 08:26 default  
-rw------- 1 zhouhh zhouhh 1428 2010-05-22 08:30 login.keyring  
-rw------- 1 zhouhh zhouhh 207 2010-05-04 22:35 user.keystore  


如果在有安全问题的环境，比如其他不可信任的人可以登录你的系统，并能获得root权限，那是不安全的。

如果是那样，必须不设自动登录，并让缺省密钥环密码和登录密码一致，并注意人离开时锁屏。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=96dcbc91-64fe-89bc-90f1-5239d338ee6a)
