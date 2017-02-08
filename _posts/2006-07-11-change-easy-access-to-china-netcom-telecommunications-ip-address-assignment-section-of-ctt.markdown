---
author: abloz
comments: true
date: 2006-07-11 05:33:36+00:00
layout: post
link: http://abloz.com/index.php/2006/07/11/change-easy-access-to-china-netcom-telecommunications-ip-address-assignment-section-of-ctt/
slug: change-easy-access-to-china-netcom-telecommunications-ip-address-assignment-section-of-ctt
title: '[转]轻松获得网通、电信、铁通IP地址分配段'
wordpress_id: 156
categories:
- 技术
- 转载
tags:
- ip
- whois
---

有时搞一些跨网段的工程和应用，需要尽量准确的知道电信、网通、铁通等电信运营商的IP地址段分配情况，可网上的资料不但很少，而且经常都是N个月前的过期资料……

    APNIC是管理亚太地区IP地址分配的机构，它有着丰富准确的IP地址分配库，同时这些信息也是对外公开的！下面就让我们看看如何在Linux下获得一些电信运营商的IP地址分配情况：

    shell> wget http://ftp.apnic.net/apnic/dbase …… se-client-v3.tar.gz shell> tar xzvf ripe-dbase-client-v3.tar.gz shell> cd whois-3.1 shell> ./configure shell> make完成上述编译安装工作后，我们开始获取IP地址段；

    中国网通：shell> ./whois3 -h whois.apnic.net -l -i mb MAINT-CNCGROUP > /var/cnc

    中国电信：shell> ./whois3 -h whois.apnic.net -l -i mb MAINT-CHINANET > /var/chinanet

    中国铁通：shell> ./whois3 -h whois.apnic.net -l -i mb MAINT-CN-CRTC > /var/crtc

    打开获取后的文件可以看到里面的信息非常详细，甚至可以看到各个分公司的负责人、电话、电子邮件等等信息。如果想得到一份整齐干净的IP地址段文件，只要用grep和awk简单过滤就可以了：）
  
