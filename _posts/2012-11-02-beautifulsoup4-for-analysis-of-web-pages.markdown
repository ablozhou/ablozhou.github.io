---
author: abloz
comments: true
date: 2012-11-02 09:53:24+00:00
layout: post
link: http://abloz.com/index.php/2012/11/02/beautifulsoup4-for-analysis-of-web-pages/
slug: beautifulsoup4-for-analysis-of-web-pages
title: beautifulsoup4 用于分析网页
wordpress_id: 1958
categories:
- 技术
tags:
- beautifulsoup4
- python
---

**安装**：
[zhouhh@Hadoop48 ~]$ sudo pip install beautifulsoup4

beautifulsoup4 对css等处理相当强大，提供了新的select方法。

**使用**：
在scrapy中使用

    
    
    #!/usr/bin/env python
    # coding:utf-8
    # author:zhouhh
    # date:2012.11.1
    import sys, os, re
    import cStringIO
    from bs4 import BeautifulSoup
    
    from scrapy.spider import BaseSpider
    #import HtmlXPathSelector
    class TestSpider(BaseSpider):
        name = "test3"
        allowed_domains = ["localhost"]
        start_urls = [
             "http://localhost/test.html"
        ]
    
        def parse(self, response):
            #print dir(response)
            soup = BeautifulSoup(response.body, from_encoding="gb18030")
            #print response.body
            #titles = soup.findAll('div', {'id':'name'})
            #urls = soup.findAll('a')
    
            urls = soup.select("div.cname > a")
            #print urls
            for u in urls:
                print u.text
                print "------------"
                print u.get("href")
            #print response.url
            #x = HtmlXPathSelector(response)
            #print x.select("//a/text()").extract()
            #filename = response.url.split("/")[-2]
            #open(filename, 'wb').write(response.body)
    
    


**执行**：
[zhouhh@Hadoop48 test1]$ scrapy crawl test3

**参考：**
[官方文档](http://www.crummy.com/software/BeautifulSoup/bs4/doc/)
