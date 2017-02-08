---
author: abloz
comments: true
date: 2009-02-09 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/02/09/to-do-with-the-squid-proxy-access/
slug: to-do-with-the-squid-proxy-access
title: 用squid做代理上网
wordpress_id: 891
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文 2009.2.9 元宵节

 

因搬了办公室，网管对https，msn，qq等端口全部封禁，只留下80端口可以上网。其他的服务都需要申请，而申请不一定批。虽然可以用meebo.com的web方式来使用msn，还是不太方便。这给工作开展带来了麻烦。

考虑到我们机房有机器可以直接连到外网，因此我们采用squid配置了代理，成功绕过办公网的网关，让msn，qq，gmail服务都可以使用。

squid代理服务器一般的Unix,Linux都自带。我使用的是Redhat AS4自带的squid。

 

打开/etc/squid/squid.conf

配置

$vi /etc/squid/squid.conf

#http_port ,是代理的端口，如果没有其他的http服务占用80端口或8080，可以配置这两个端口，比较好记。我配的是8086。缺省端口是3128

http_port 8086 

 

#设置cache 内存大小为1G，我的服务器内存为4G。

cache_mem 1000 MB

#设置cache_dir 地址，第一个数字参数不能小于cache_mem设置的大小，否则会出警告“WARNING cache_mem is larger than total disk cache space!”，所以设为1000。16，256表示第一级和第二级目录。设置完了需用  squid -z来使cache目录生效。

cache_dir ufs /var/spool/squid 1000 16 256

 

#设置允许所有人访问，缺省是禁止任何人使用代理。报错：“The requested URL could not be retrieved While trying to retrieve the URL: ...”

http_access allow all

 

#设置 visible_hostname ，否则会报错：“FATAL: Could not determine fully qualified hostname. ” Please set 'visible_hostname'

visible_hostname zhhproxy

 

#其他的用缺省值，保存。

 

$squid -z

Creating Swap Directories

$squid -NCd1

在前台运行，便于调试。调试完成直接执行squid让其以精灵进程运行。

看到打印Ready to serve requests.就准备好了。

 

在IE7的工具->Internet 选项里连接页，点击“局域网设置”按钮，选中“为LAN使用代理服务器”，配置地址为运行squid的IP，端口为刚配置的8086,确定。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20090209/proxy.PNG)

输入[http://news.sohu.com](http://news.sohu.com/)测试OK。

其他浏览器类似配置。

 

live messenger 9可以自动使用IE的代理配置，IE可以上网时，msn也就可以了。

QQ 2008可以在系统配置里的代理页，选中“使用浏览器的网络配置”，也可以正常登录。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=f447bb31-f4b4-82a5-95e1-1505cf21d58a)
