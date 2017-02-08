---
author: abloz
comments: true
date: 2012-12-27 22:24:21+00:00
layout: post
link: http://abloz.com/index.php/2012/12/28/scrapyd-run-spider-encounter-an-error/
slug: scrapyd-run-spider-encounter-an-error
title: scrapyd 运行spider时遇到的一个错误
wordpress_id: 2039
categories:
- 技术
tags:
- scrapy
---

**andy 2012.12.28**

from http://abloz.com

2012-12-28 05:57:33+0800 [Launcher,29590/stderr] main()
File "/usr/local/lib/python2.7/dist-packages/scrapyd/runner.py", line 36, in main
execute()
File "/usr/local/lib/python2.7/dist-packages/scrapy/cmdline.py", line 131, in execute
_run_print_help(parser, _run_command, cmd, args, opts)
File "/usr/local/lib/python2.7/dist-packages/scrapy/cmdline.py", line 76, in _run_print_help
func(*a, **kw)
File "/usr/local/lib/python2.7/dist-packages/scrapy/cmdline.py", line 138, in _run_command
cmd.run(args, opts)
File "/usr/local/lib/python2.7/dist-packages/scrapy/commands/crawl.py", line 43, in run
spider = self.crawler.spiders.create(spname, **opts.spargs)
File "/usr/local/lib/python2.7/dist-packages/scrapy/spidermanager.py", line 44, in create
return spcls(**spider_kwargs)
TypeError: __init__() got an unexpected keyword argument '_job'

或类似

2012-12-28 06:02:20+0800 [Launcher,29663/stderr] func(*a, **kw)
File "/usr/local/lib/python2.7/dist-packages/scrapy/cmdline.py", line 138, in _run_command
cmd.run(args, opts)
File "/usr/local/lib/python2.7/dist-packages/scrapy/commands/crawl.py", line 43, in run
spider = self.crawler.spiders.create(spname, **opts.spargs)
File "/usr/local/lib/python2.7/dist-packages/scrapy/spidermanager.py", line 44, in create
return spcls(**spider_kwargs)
TypeError: __init__() got an unexpected keyword argument '_job'

这是因为spider的__init__函数没有加**kwargs参数，不能接受相应的参数。

改为如下：

def __init__(self,**kwargs):
super(ProductSpider, self).__init__(self, **kwargs)

另外，需添加__str__函数，否则也会报错

def __str__(self):
return "ProductSpider"


