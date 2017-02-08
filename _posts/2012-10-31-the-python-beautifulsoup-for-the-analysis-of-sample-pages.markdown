---
author: abloz
comments: true
date: 2012-10-31 08:29:59+00:00
layout: post
link: http://abloz.com/index.php/2012/10/31/the-python-beautifulsoup-for-the-analysis-of-sample-pages/
slug: the-python-beautifulsoup-for-the-analysis-of-sample-pages
title: python beautifulsoup 用于分析网页示例
wordpress_id: 1951
categories:
- 技术
tags:
- beautifulsoup
- python
---

周海汉
http://abloz.com
2012.10.31 听说11.3要来暖气?

beautifulsoap只有一个py文件，但功能强大，可分析不完整的html页面。下面是用法示例。
**安装**：
[zhouhh@Hadoop48 test1]$ sudo pip install BeautifulSoup
或者去官网下载：http://www.crummy.com/software/BeautifulSoup/

python操作

    
    >>> from BeautifulSoup import BeautifulSoup
    
    >>> doc = ['<html><head><title>用BeautifulSoup对不完整网页分析测试 from abloz.com</title></head>',
    
    ... '<body><p id="f" class="test" >我的网站 <b>分析</b> from abloz.com.',
    
    ... '<p id="s" >第二行',
    
    ... '<a href="http://abloz.com">瀚海星空</a>',
    
    ... '<a href="http://google.com">google</a>',
    
    ... '</html>']
    
    >>> soup = BeautifulSoup(''.join(doc))
    
    >>> soup.html.title
    
    <title>用BeautifulSoup对不完整网页分析测试 from abloz.com</title>
    
    >>> soup.html.body.p
    
    <p id="f" class="test">我的网站 <b>分析</b> from abloz.com.</p>
    
    >>> soup.html.title.name
    
    u'title'
    
    >>> soup.html.title.text
    
    u'u7528BeautifulSoupu5bf9u4e0du5b8cu6574u7f51u9875u5206u6790u6d4bu8bd5 from abloz.com'
    
    >>> soup.html.title.string
    
    u'u7528BeautifulSoupu5bf9u4e0du5b8cu6574u7f51u9875u5206u6790u6d4bu8bd5 from abloz.com'
    
    >>> print soup.html.title.string
    
    用BeautifulSoup对不完整网页分析测试 from abloz.com
    
    >>> soup.title
    
    <title>用BeautifulSoup对不完整网页分析测试 from abloz.com</title>
    
    >>> ps = soup.findAll("p")
    
    >>> for p in ps:
    
    ... print p
    
    ...
    
    <p id="f" class="test">我的网站 <b>分析</b> from abloz.com.</p>
    
    <p id="s">第二行<a href="http://abloz.com">瀚海星空</a><a href="http://google.com">google</a></p>
    
    >>> ps[1]
    
    <p id="s">第二行<a href="http://abloz.com">瀚海星空</a><a href="http://google.com">google</a></p>
    
    >>> ps[0]
    
    <p id="f" class="test">我的网站 <b>分析</b> from abloz.com.</p>
    
    >>> aes=soup.findAll("a")
    
    >>> for a in aes:
    
    ... print a.text
    
    ... print a["href"]
    
    ...
    
    瀚海星空
    
    http://abloz.com
    
    google
    
    http://google.com
    
    >>> import re
    
    >>> ts = soup.findAll(text=re.compile("分析"))
    
    >>> print ts
    
    []
    
    >>> ts = soup.findAll(text=re.compile("goo"))
    
    >>> print ts
    
    [u'google']


注意如何支持中文：转为unicode

    
    >>> ts = soup.findAll(text=re.compile(u"分析"))
    >>> ts
    [u'u7528BeautifulSoupu5bf9u4e0du5b8cu6574u7f51u9875u5206u6790u6d4bu8bd5 from abloz.com', u'u5206u6790']
    >>> for t in ts:
    ... print t
    ...
    用BeautifulSoup对不完整网页分析测试 from abloz.com
    分析
    >>> ids = soup.findAll(id=re.compile("f"))
    >>> ids
    [<p id="f" class="test">我的网站 <b>分析</b> from abloz.com.</p>]
    
    和上一个等价的方式
    >>> ids = soup.findAll(attrs={"id":re.compile("f")})
    >>> ids
    [<p id="f" class="test">我的网站 <b>分析</b> from abloz.com.</p>]
    >>> soup.find("p")
    <p id="f" class="test">我的网站 <b>分析</b> from abloz.com.</p>
    >>> soup.find("a")
    <a href="http://abloz.com">瀚海星空</a>


**参考**：
中文文档：http://www.crummy.com/software/BeautifulSoup/bs3/documentation.zh.html
官网：http://www.crummy.com/software/BeautifulSoup/
