---
author: abloz
comments: true
date: 2013-09-12 07:58:36+00:00
layout: post
link: http://abloz.com/index.php/2013/09/12/awk-pass-parameters-from-the-shell/
slug: awk-pass-parameters-from-the-shell
title: awk 从shell传参数
wordpress_id: 2220
categories:
- 技术
---

2013.9.12
-v arg=value 方式传入。

[hadoop@hs12 sh]$ cat a
2|1|文字|
2|2|文字|
2|3|文字|

[hadoop@hs12 sh]$ awk -F "|"  -v b=2 '{ if($2==b) { print $0;} }' a
2|2|文字|

参考
http://blog.csdn.net/sosodream/article/details/5746315
