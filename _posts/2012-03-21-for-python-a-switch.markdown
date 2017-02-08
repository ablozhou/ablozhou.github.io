---
author: abloz
comments: true
date: 2012-03-21 08:26:56+00:00
layout: post
link: http://abloz.com/index.php/2012/03/21/for-python-a-switch/
slug: for-python-a-switch
title: python switch
wordpress_id: 1519
categories:
- 技术
tags:
- python
- switch
---

python 没有switch语法，用if,else代替或用dict代替。
[dive into python](http://woodpecker.org.cn/diveintopython/)第三版有一个分析mp3文件tag的例子：



```

    tagDataMap = {"title"   : (  3,  33, stripnulls),
                  "artist"  : ( 33,  63, stripnulls),
                  "album"   : ( 63,  93, stripnulls),
                  "year"    : ( 93,  97, stripnulls),
                  "comment" : ( 97, 126, stripnulls),
                  "genre"   : (127, 128, ord)}
    .
    .
    .
            if tagdata[:3] == "TAG":
                for tag, (start, end, parseFunc) in self.tagDataMap.items():
                    self[tag] = parseFunc(tagdata[start:end])

```

就类似于switch的语法。

也可以执行lambda函数。不过，函数里执行print语句会失败。所以还是有些缺陷



```

>>> status={0:lambda x:x+1,
...             1:lambda x:x+2}
>>> status[1](2)
4

```

这里也有很多有意思的讨论，其中有用try except来处理缺省值的：



```

try:
    {'option1': function1,
     'option2': function2,
     'option3': function3,
     'option4': function4}[value]()
except KeyError:
    # default action

```

或者用dict的get语法，执行缺省值：



```

{'option1': function1,
 'option2': function2,
 'option3': function3,
 'option4': function4,
}.get(value, defaultfunction)()

```

但总之，还是很受限。
参考：
http://simonwillison.net/2004/may/7/switch/
http://woodpecker.org.cn/diveintopython/


