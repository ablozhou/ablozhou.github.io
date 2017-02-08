---
author: abloz
comments: true
date: 2012-04-05 08:53:47+00:00
layout: post
link: http://abloz.com/index.php/2012/04/05/python-da-yin-hao-miao/
slug: python-da-yin-hao-miao
title: python 打印毫秒
wordpress_id: 1539
categories:
- 技术
tags:
- millisecond
- python
- strftime
---

http://abloz.com
author:ablozhou
date:2012.4.5


python 如果打印到秒，可以用如下语句：


```


>>> import time
>>> time.localtime(time.time())
time.struct_time(tm_year=2012, tm_mon=4, tm_mday=5, tm_hour=16, tm_min=0, tm_sec=29, tm_wday=3, tm_yday=96, tm_isdst=0)

>>> time.strftime('%m-%d %H:%M:%S',time.localtime(time.time()))
'04-05 16:02:04'

```

但如果需要打印到毫秒呢？
localtime里面没有精确到毫秒。
在python 2.6以后，strftime有%f参数可以打印毫秒，不过应该用datetime模块，而不是time模块




```

>>> import datetime
>>> datetime.datetime.now().strftime("%H:%M:%S.%f")
'16:24:07.346000'

```


如果直接用time.strftime，则%f不会打印正确的毫秒，而是打印%f


