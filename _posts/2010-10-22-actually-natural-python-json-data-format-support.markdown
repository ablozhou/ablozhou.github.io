---
author: abloz
comments: true
date: 2010-10-22 09:05:51+00:00
layout: post
link: http://abloz.com/index.php/2010/10/22/actually-natural-python-json-data-format-support/
slug: actually-natural-python-json-data-format-support
title: python居然天然支持JSON的数据格式
wordpress_id: 883
categories:
- 技术
tags:
- JSON
- python
---

周海汉 2010.10.22

如对JSON数据：
{"doors" : 4, "color" : "blue", "year" :1995, "drivers" : ["Penny", "Dan" , "Kris"]}

可以直接转为字典：

    
    
    >>> a='{"doors" : 4, "color" : "blue", "year" :1995, "drivers" : ["Penny", "Dan" , "Kris"]}'
    >>> a
    '{"doors" : 4, "color" : "blue", "year" :1995, "drivers" : ["Penny", "Dan" , "Kris"]}'
    >>> b=eval(a)
    >>> b
    {'color': 'blue', 'drivers': ['Penny', 'Dan', 'Kris'], 'doors': 4, 'year': 1995}
    >>> b['color']
    'blue'
    >>> str(b)
    "{'color': 'blue', 'drivers': ['Penny', 'Dan', 'Kris'], 'doors': 4, 'year': 1995}"


岂不是说明，python也可以接受JSON格式的数据？
