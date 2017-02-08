---
author: abloz
comments: true
date: 2009-11-09 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/11/09/update-ubuntu-themes-windows-and-icons-look/
slug: update-ubuntu-themes-windows-and-icons-look
title: 更新ubuntu themes窗口外观和图标
wordpress_id: 945
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

有人可能不喜欢系统自带对黄色主题，可以去下载一些外观主题。如：

从ubuntu geeks 添加 themes

 

1.设置源

sudo gedit /etc/apt/sources.list

加入：

deb http://ppa.launchpad.net/bisigi/ppa/ubuntu karmic main

deb-src http://ppa.launchpad.net/bisigi/ppa/ubuntu karmic main

 

执行 sudo apt-get update时有如下错误：

W: GPG签名验证错误： http://ppa.launchpad.net karmic Release: 由于没有公钥，下列签名无法进行验证： NO_PUBKEY 6E871C4A881574DE

 

2.设置源证书

对9.10，执行

zhouhh@zhhofs:~$ sudo add-apt-repository ppa:bisigi  
Executing: gpg --ignore-time-conflict --no-options --no-default-keyring  --secret-keyring /etc/apt/secring.gpg --trustdb-name  /etc/apt/trustdb.gpg --keyring /etc/apt/trusted.gpg --keyserver  keyserver.ubuntu.com --recv 1781BD45C4C3275A34BB6AEC6E871C4A881574DE  
gpg: 下载密钥‘881574DE’，从 hkp 服务器 keyserver.ubuntu.com  
gpg: 公钥服务器超时  
gpg: 从公钥服务器接收失败：公钥服务器错误

 

可能会报错，我多试一次才成功。  
zhouhh@zhhofs:~$ sudo add-apt-repository ppa:bisigi  
Executing: gpg --ignore-time-conflict --no-options --no-default-keyring  --secret-keyring /etc/apt/secring.gpg --trustdb-name  /etc/apt/trustdb.gpg --keyring /etc/apt/trusted.gpg --keyserver  keyserver.ubuntu.com --recv 1781BD45C4C3275A34BB6AEC6E871C4A881574DE  
gpg: 下载密钥‘881574DE’，从 hkp 服务器 keyserver.ubuntu.com  
gpg: 密钥 881574DE：公钥“Launchpad PPA for Bisigi”已导入  
gpg: 合计被处理的数量：1  
gpg: 已导入：1 (RSA: 1)

 

3.更新源目录

再执行： sudo apt-get update

 

W: 无法下载 http://ppa.launchpad.net/bisigi/ppa/ubuntu/dists/karmic/main/binary-i386/Packages.bz2 Hash 校验和不符  
  
E: 有一些索引文件不能下载，它们可能被忽略了，也可能转而使用了旧的索引文件。

 

4.下载theme

我没有管该错误提示，执行  
zhouhh@zhhofs:~$ sudo apt-get install aquadreams-theme  
...

0 个软件包被升级，新安装 7 个， 0 个将被删除， 同时 114 个将不升级。  
需要获取 19.6MB 的存档。 解包后将要使用 32.5MB。  
您要继续吗？[Y/n/?] y

 

下载完自动安装，在系统外观对主题可以选aquadreams，应用后外观如下图：

![s](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091109/Screenshot.png)

 

同时，网友提供多个主题：

	安装所有主题：

<blockquote>		sudo aptitude install zgegblog-themes
> 
> 
```
 
> 
> 	如果你想单独安装其中一种的话也可以，
> 
>  
> 
> 	sudo aptitude install showtime-theme
> 
> 	sudo aptitude install balanzan-theme
> 
> 	sudo aptitude install infinity-theme
> 
> 	sudo aptitude install wild-shine-theme
> 
> 	sudo aptitude install exotic-theme
> 
> 	sudo aptitude install tropical-theme
> 
> 	sudo aptitude install bamboo-zen-theme
> 
> 	sudo aptitude install ubuntu-sunrise-theme
> 
> 	sudo aptitude install aquadreams-theme
> 
> 	（选择其中一条语句即可安装）
> 
> 参考：http://res0w.com/2009/10/29/nice-themes-for-ubuntu-9-10%E4%B8%80 %E4%B8%AA%E6%BC%82%E4%BA%AE%E7%9A%84ubuntu%E4%B8%BB%E9%A2%98%E5%8C%85/
> 
>   
  

> 
> ![](http://img.zemanta.com/pixy.gif?x-id=6e2a765b-9b1b-8460-a404-2230fd8e44bb)
