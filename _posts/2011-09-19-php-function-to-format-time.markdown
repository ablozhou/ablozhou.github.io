---
author: abloz
comments: true
date: 2011-09-19 05:54:11+00:00
layout: post
link: http://abloz.com/index.php/2011/09/19/php-function-to-format-time/
slug: php-function-to-format-time
title: php 格式化时间的函数
wordpress_id: 1429
categories:
- 技术
tags:
- datetime
- php
---

abloz.com
2011.9.19
php页面有时为了显示帖子发布时间的人性化，三天内会显示今天，昨天，前天的小时分钟，更老的帖子则显示日期。可以用下面的工具函数。


    
    
    
    


但是，mysql的datetime类型，读出来的格式是字符串，并非int类型。可以转一下：
hort_str_time(strtotime($timestr_from_mysql));
