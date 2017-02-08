---
author: abloz
comments: true
date: 2011-12-29 05:50:07+00:00
layout: post
link: http://abloz.com/index.php/2011/12/29/apache-alias-directory-configuration/
slug: apache-alias-directory-configuration
title: apache alias 目录配置
wordpress_id: 1475
categories:
- 技术
tags:
- alias
- apache
---

一个apache网站，在不同目录下有不同网站，但在同一个域名下，这时可以配置alias，这与多域名不一样。

在http.conf里增加：

    
    Alias /fb  d:/myphp/fb/
    
    <Directory "d:/myphp/fb/">
        Options Indexes FollowSymLinks Includes ExecCGI
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
