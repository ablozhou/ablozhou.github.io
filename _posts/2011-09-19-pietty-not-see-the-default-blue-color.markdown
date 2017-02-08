---
author: abloz
comments: true
date: 2011-09-19 08:26:29+00:00
layout: post
link: http://abloz.com/index.php/2011/09/19/pietty-not-see-the-default-blue-color/
slug: pietty-not-see-the-default-blue-color
title: pietty 缺省蓝颜色看不清
wordpress_id: 1434
categories:
- 技术
tags:
- pietty
---

用pietty或putty连接linux，缺省的颜色配置，黑底亮字，蓝颜色的目录看不清，非常废眼神。
解决办法：options->更多配置->window->colours里，一是选中“系统颜色(use system colours)”，变成白底黑字。这样看起来很清晰。
如果不喜欢白底，也可以直接调整ansi blue的值，将0 0 187 改为和ansi blue bold 一样的颜色，即85 85 255，则看起来亮了，清晰了。
