---
author: abloz
comments: true
date: 2010-04-01 07:27:58+00:00
layout: post
link: http://abloz.com/index.php/2010/04/01/transfer-linux-ipv6-carefree-enjoyment-of-3/
slug: transfer-linux-ipv6-carefree-enjoyment-of-3
title: '[转]Linux下享受IPv6的畅快'
wordpress_id: 1195
categories:
- 技术
---

# 






zhh注释：本文发表于2008-05-20 17:24，linuxdesktop.cn，作者：TualatriX 。现在该网站已经被关闭。文中提到的网站也很多不能访问。供参考。

随着互联网的不断发展，当今的IPv4制式已渐渐满足不了应用，往下一代IPv6的转换也悄悄开始了。

早在去年11月，台湾的电信运营商即开始[正 式启用IPv6](http://www.cnbeta.com/articles/42859.htm) ；今年2月份，[国际互 联网从IPv4向IPv6转移也已启动](http://www.cnbeta.com/articles/48663.htm) ；而四天前，[Google也开通了IPv6网络专访的网址](http://www.cnbeta.com/articles/55805.htm) 。

一切动作显示，向IPv6的转换的脚步是越来越快了。

虽然我们还不知道什么时候会转向IPv6，但是看完了本文，你就可以在Linux下享受IPv6！

—–

本文是对bones7456兄写的的[“ipv6”](http://bones7456.blog.ubuntu.org.cn/2008/05/16/ipv6/) 进行 的扩充，并在Ubuntu 8.04下试验成功。其他Linux发行版类似，只需要安装好相关开发包即可。

**原理简介**

```
利 用現有 IPv4 網路，透過二端建立起一條 隧道(Tunnel) ，Server端透過這個 Tunnel  發送一組 IPv6  位址給另一端，使兩端可以使用 IPv6 封包在 Tunnel 內傳遞，如同現行很熱門的   VPN應用，是同相道理，使用者在外可使用公司內部私人網路，一樣是透過 Tunnel 建立，公司內部網段 IP 在 Tunnel   內傳遞，只不過這時換成 IPV6 封包。
```

**0、先决条件**

在编译这个软件前，首先确保你的Linux系统准备好了以下开发包，以顺利进行编译：gcc，g++，libc6-dev，libssl-dev

**1、下载软件**

先下载[这个包](http://download.apbb.com.tw/ipv6/gw6c-5_0-RELEASE-src.tar.gz) ， 解压至任意位置，如桌面。其中tspc-advanced/INSTALL文件内有详细的安装说明。

**2、编译并安装**

进入tspc-advanced，执行make target=linux编译：

`cd ~/Desktop/gw6c/tspc-advanced/
make target=linux`

然后执行下面的命令安装：

`sudo make target=linux installdir=/usr/local/gw6c install`

**3、修改配置文件**

`sudo gedit /usr/local/gw6c/bin/gw6c.conf`

然后找到server=那行，修改为： server=tb.ipv6.apol.com.tw，保存退出。

**4、运行**

cd /usr/local/gw6c/bin/  然后执行 sudo ./gw6c ,如果看到类似:

```
Gateway6 Client v5.0-RELEASE build May 16 2008-12:30:00
Connection to tb.ipv6.apol.com.tw established.
```

这样的输出，就表示连接成功了。这时，软件会在后台运行，需要注意的是，每次电脑启动后都需要手动加载。假如你需要自动连接，可以将/usr /local/gw6c/bin/gw6c写入/etc/init.d/rc.local文件。

**5、测试效果**

这时如果你在终端下运行ifconfig，可以发现多了一个项目，比如我是：sit1      Link  encap:IPv6-in-IPv4。

你也可以使用ping命令的ipv6版来ping Google的主页：ping6 ipv6.google.com，测试是否能通。

当然，最重要的目的，当然是上网了。

你可以访问Google的IPv6版，也可以通过sixxs.org来访问Wikipedia，无需任何代理。下面可是用普通网络不能访问的唷！而 且速度更不是普通代理所能达到的。

[http://ipv6.google.com](http://ipv6.google.com/)

[http://zh.wikipedia.org.sixxs.org](http://zh.wikipedia.org.sixxs.org/)

**所有的IPv4网站，都可以以http://(URL).sixxs.org的形式进行访问。**

下图是我用Firefox访问这两个网站的截图：

[![](http://linuxdesktop.cn/wp-content/uploads/2008/05/ipv6-1.jpg) ](http://linuxdesktop.cn/)

[(网站不存在了)
](http://linuxdesktop.cn/)

不知道朋友们还知道什么有关IPv6的应用，这样就能好好发挥我们的“IPv6”了！

参考资料: [http://www.apol.com.tw/ipv6/ipv6-tb-1.html](http://www.apol.com.tw/ipv6/ipv6-tb-1.html) (windows及其他平台的方法也请看这里)

感谢bones7456的原始文章。






![](http://img.zemanta.com/pixy.gif?x-id=1a1b7d38-8ca0-8c37-a039-80033a29985a)
