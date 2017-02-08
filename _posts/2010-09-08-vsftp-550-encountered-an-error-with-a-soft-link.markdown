---
author: abloz
comments: true
date: 2010-09-08 04:12:29+00:00
layout: post
link: http://abloz.com/index.php/2010/09/08/vsftp-550-encountered-an-error-with-a-soft-link/
slug: vsftp-550-encountered-an-error-with-a-soft-link
title: vsftp 用软链接遇到550错误
wordpress_id: 394
categories:
- 技术
---

我在centos 5.5上新建了一个vsftp, 目标是即支持帐号密码上传，又支持匿名下载帐号密码上传的东西。

/var/ftp/pub是匿名下载的地方。已经测试OK。
新建系统帐号ftpclient，家目录在/home/ftpclient，输入用户密码可以上传。

现在想匿名帐号能下载/home/ftpclient下的东西。

于是我在/var/ftp/pub下新建一个软链接：
cd /var/ftp/pub
ln -s /home/ftpclient client

但用ftp客户端匿名连上去后，进入client目录报550错误，无权限访问。

    
    
    ftp> cd pub
    250 Directory successfully changed.
    ftp> ls
    200 PORT command successful. Consider using PASV.
    150 Here comes the directory listing.
    lrwxrwxrwx    1 0        0              15 Sep 08 03:30 client -> /home/ftpclient
    226 Directory send OK.
    ftp> cd client
    550 Failed to change directory.
    


无论怎么修改/home/ftpclient的权限都是一样。

后面找到国外网站资料，发现可以用mount --bind的方式规避权限问题。
进入/var/ftp/pub
新建一个目录client
mount --bind /home/ftpclient client
此时再用匿名帐号访问，则只读权限没有问题。
550问题解决。
