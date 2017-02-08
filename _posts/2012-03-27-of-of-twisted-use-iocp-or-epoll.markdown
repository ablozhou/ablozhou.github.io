---
author: abloz
comments: true
date: 2012-03-27 09:21:24+00:00
layout: post
link: http://abloz.com/index.php/2012/03/27/of-of-twisted-use-iocp-or-epoll/
slug: of-of-twisted-use-iocp-or-epoll
title: twisted 使用iocp或epoll
wordpress_id: 1523
categories:
- 技术
tags:
- epoll
- iocp
- python
- twisted
---

#http://abloz.com
#author:ablozhou
#date:2012.3.27
windows 的socket的select，缺省只有512个。所以一个进程最多建512个连接。如果要建更多，就要用到完成端口IOCP。
twisted 缺省的reactor是只能建512个连接的，需实现成iocp方式，才能提高连接数和数据处理效率。
装载iocp reactor或epoll reactor的方法：

```

import os
if os.name!='nt':
    from twisted.internet import epollreactor
    try:
        epollreactor.install()
    except:
        pass
else:

    from twisted.internet import iocpreactor as iocpreactor
    try:

        iocpreactor.install()
    except:
        pass
from twisted.internet import reactor

```


注意先后顺序。
这样，就变成epoll或iocp这种高效的连接方式了。
不过，如果不加try,except，系统会警告说已经安装了reactor. 加了try之后，系统正常使用。

