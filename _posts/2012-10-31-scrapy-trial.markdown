---
author: abloz
comments: true
date: 2012-10-31 05:58:42+00:00
layout: post
link: http://abloz.com/index.php/2012/10/31/scrapy-trial/
slug: scrapy-trial
title: scrapy 试用
wordpress_id: 1946
categories:
- 技术
tags:
- python
- scrapy
---

周海汉

http://abloz.com
上一篇文章讲了《[scrapy 安装](http://abloz.com/2012/10/31/scrapy-installation.html)》，解决了openssl编译不通过的问题。本篇对scrapy进行试用。

    
    
    [zhouhh@Hadoop48 python]$ scrapy startproject test
    
    [zhouhh@Hadoop48 test]$ find .
    .
    ./scrapy.cfg
    ./test
    ./test/items.py
    ./test/spiders
    ./test/spiders/__init__.py
    ./test/spiders/test_spider.py
    ./test/__init__.py
    ./test/settings.py
    ./test/pipelines.py
    




    
    [zhouhh@Hadoop48 test]$ cat test/spiders/test_spider.py
    from scrapy.spider import BaseSpider
    
    class TestSpider(BaseSpider):
        name = "hadoop48"
        allowed_domains = ["hadoop48"]
        start_urls = [
            "http://hadoop48/index.php"
        ]
    
        def parse(self, response):
            filename = response.url.split("/")[-2]
            open(filename, 'wb').write(response.body)
    
    [zhouhh@Hadoop48 test]$ cat test/items.py
    
    from scrapy.item import Item, Field
    
    class TestItem(Item):
        # define the fields for your item here like:
        title = Field()
        link = Field()
        desc = Field()




    
    
    [zhouhh@Hadoop48 test]$ scrapy crawl test
    Traceback (most recent call last):
    File "/usr/local/bin/scrapy", line 4, in <module>
    execute()
    File "/usr/local/lib/python2.7/site-packages/scrapy/cmdline.py", line 96, in execute
    settings = get_project_settings()
    File "/usr/local/lib/python2.7/site-packages/scrapy/utils/project.py", line 56, in get_project_settings
    settings_module = __import__(settings_module_path, {}, {}, [''])
    ImportError: No module named settings
    


test和系统的名字有冲突，改特殊一点，用test1

[zhouhh@Hadoop48 python]$ scrapy startproject test1

将相应的源码复制到test1

[zhouhh@Hadoop48 test1]$ scrapy crawl test1

KeyError: 'Spider not found: test1'

原来test1_spider.py的name，要设为和crawl一致。

将class Test1Spider 的name由hadoop48改为test1

[zhouhh@Hadoop48 test1]$ scrapy crawl test1
2012-10-31 13:49:24+0800 [scrapy] INFO: Scrapy 0.16.1 started (bot: test1)

...

2012-10-31 13:49:24+0800 [test1] INFO: Spider closed (finished)

此时scrapy项目根目录下多了hadoop48文件，正是我要抓取的首页。

[zhouhh@Hadoop48 test1]$ ls
hadoop48 scrapy.cfg test1
[zhouhh@Hadoop48 test1]$ cat hadoop48
<html>
<head>
<title>list tables demo of zhouhh</title>
</head>
<body>
<a href="list.php">获取全部表名</a> <br/>
<a href="detail.php?date=2012-10-28&type=2&gameid=1001&userid=167094287">167094287 10.28 json详单</a><br/>
<a href="info.php?date=2012-10-29&type=2&gameid=1001&userid=100004458">100004458 10.29表格</a><br/>
</body>
</html>


**参考：**
官网：http://www.scrapy.org
教学：http://doc.scrapy.org/en/latest/intro/tutorial.
简介：http://doc.scrapy.org/en/latest/intro/overview.html
