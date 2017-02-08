---
author: abloz
comments: true
date: 2011-09-19 12:38:35+00:00
layout: post
link: http://abloz.com/index.php/2011/09/19/js-alert-pop-garbage/
slug: js-alert-pop-garbage
title: js alert弹窗乱码
wordpress_id: 1438
categories:
- 技术
---

nginx 服务器缺省编码是gbk。我的页面是utf8.所以在php中添加header('Content-type: text/html; charset=utf-8');php页面的编码问题解决了。但对独立的js文件，也是utf8编码的，缺省还是gbk返回，导致乱码。

网上各人碰到js乱码各不相同。解决办法也不一样。我这个问题至今没找到方法，除非将js存为gbk。有人说的在script里指定charset，也并不凑效。


暂用另存为 gbk解决。
