---
author: abloz
comments: true
date: 2012-03-27 03:26:00+00:00
layout: post
link: http://abloz.com/index.php/2012/03/27/python-configuration-file-in-the-logging-of/
slug: python-configuration-file-in-the-logging-of
title: python logging 的配置文件
wordpress_id: 1521
categories:
- 技术
tags:
- log
- logging
- python
- TimedRotatingFileHandler
---

http://abloz.com
author:ablozhou
date:2012.3.27

python 自带logging模块，功能和log4cpp,log4j差不多。可以用logging.conf来写log需要输出的格式和相关配置。
下面是我的一个配置文件。其中的TimedRotatingFileHandler和RotatingFileHandler配置方式可以参考，可以完成按时间段或时间点或按文件大小切换log文件。
另外，如果自定义时间格式，比如要精确到毫秒，如何配置呢？时间的参数和[time.strftime()](http://docs.python.org/library/time.html#time.strftime)一样。但格式化参数里面只有秒，没有毫秒，毫秒数如何显示呢？下面也有示例。还有就是输出格式上，增加空格以对齐，都可以参考。




```

#http://abloz.com
#author:ablozhou
#date:2012.3.27

[loggers]
keys=root,simple

[handlers]
keys=consoleHandler,TimedRotatingFileHandler,RotatingFileHandler,FileHandler

[formatters]
keys=simpleFormatter,timedRotatingFormatter

[logger_root]
level=DEBUG

#Level	Numeric value
#CRITICAL	50
#ERROR	40
#WARNING	30
#INFO	20
#DEBUG	10
#NOTSET	0

handlers=consoleHandler,TimedRotatingFileHandler
#FileHandler

[logger_simple]
level=DEBUG
handlers=consoleHandler
qualname=simple
propagate=0

[formatter_timedRotatingFormatter]
format=%(asctime)s.%(msecs)d %(name)-12s %(levelname)-8s %(message)s
datefmt=%y-%m-%d %H:%M:%S
#datefmt=%y-%m-%d %H:%M:%S %p

[handler_RotatingFileHandler]
class=handlers.RotatingFileHandler
level=INFO
formatter=simpleFormatter
args=('./logs/perfrf.log', 'a', '10240', 10)
#(filename, mode='a', maxBytes=0, backupCount=0, encoding=None, delay=0)

[handler_TimedRotatingFileHandler]
class=handlers.TimedRotatingFileHandler
level=DEBUG
formatter=timedRotatingFormatter
args=('./logs/perft.log', 'M', 10, 5)
#(filename, when='h', interval=1, backupCount=0, encoding=None, delay=False, utc=False)

#Value	Type of interval
#'S'	Seconds
#'M'	Minutes
#'H'	Hours
#'D'	Days
#'W'	Week day (0=Monday)
#'midnight'	Roll over at midnight

[handler_consoleHandler]
class=StreamHandler
level=DEBUG
formatter=simpleFormatter
args=(sys.stdout,)

[handler_FileHandler]
class=TimedRotatingFileHandler
level=DEBUG
formatter=simpleFormatter
args=("perf.log",)

[handler_FileHandler]
class=FileHandler
level=DEBUG
formatter=simpleFormatter
args=("./logs/perf.log",)


[formatter_simpleFormatter]
format=%(asctime)s [%(levelname)s][%(name)s]:%(message)s   (%(filename)s:%(lineno)d)
#format=%(asctime)s[%(levelname)s][%(name)s]:%(message)s
datefmt=

```



**参考**
配置：
http://docs.python.org/howto/logging.html#configuring-logging
时间格式：
http://docs.python.org/library/time.html#time.strftime

