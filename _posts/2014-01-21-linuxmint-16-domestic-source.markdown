---
author: abloz
comments: true
date: 2014-01-21 23:30:28+00:00
layout: post
link: http://abloz.com/index.php/2014/01/22/linuxmint-16-domestic-source/
slug: linuxmint-16-domestic-source
title: linuxmint 16 国内源
wordpress_id: 2259
categories:
- 技术
---



http://abloz.com

2014.1.22

linuxmint 16 国内源

先将/etc/apt/sources.list 及

deb http://mirrors.oschina.net/linuxmint/ petra main upstream import

deb http://mirrors.oschina.net/ubuntu/ saucy main restricted universe multiverse


_deb http://mirrors.oschina.net/ubuntu/ saucy-backports main restricted universe multiverse
deb http://mirrors.oschina.net/ubuntu/ saucy-proposed main restricted universe multiverse
deb http://mirrors.oschina.net/ubuntu/ saucy-security main restricted universe multiverse
deb http://mirrors.oschina.net/ubuntu/ saucy-updates main restricted universe multiverse
deb http://archive.canonical.com/ubuntu/ saucy partner
deb http://ftp.stust.edu.tw/pub/Linux/LinuxMint/packages/ petra main upstream import
deb http://extra.linuxmint.com petra main_


/etc/apt/sources.list.d备份

编辑sources.list如下，并执行sudo apt-get update

其中ubuntu的源可以替换为sohu和163的源。


