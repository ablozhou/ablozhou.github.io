---
author: abloz
comments: true
date: 2012-03-31 07:38:39+00:00
layout: post
link: http://abloz.com/index.php/2012/03/31/of-twisted-12-0-pairs-of-the-windows-iocp-support-or-have-a-problem/
slug: of-twisted-12-0-pairs-of-the-windows-iocp-support-or-have-a-problem
title: twisted 12.0对windows iocp支持还是有问题
wordpress_id: 1531
categories:
- 技术
tags:
- bug
- iocp
- python
- twisted
---

http://abloz.com
author:ablozhou
date:2012.3.31

实验中，用twisted的iocp，和服务器建立多个tcp长连接。然后持续发送较小的包。如果压力较小时，系统表现很正常。当压力较大，如建立3000个以上的连接，持续发送较小包，就会有包出错。

相同程序，改成epoll，迁移到centos，建立5000个连接，持续压力，一切正常。

我没有定位具体原因。
C:Python26Libsite-packagestwistedinternetiocpreactortcp.py的writeToHandle函数，是直接调用_iocp.send的入口。这个地方增加的打印信息显示，包出错了。
而在C:Python26Libsite-packagestwistedinternetiocpreactorabstract.py的doWrite是调用上述tcp.py的writeToHandle的入口。

[据iteye网友说](http://mathgl.iteye.com/blog/1457556)(http://mathgl.iteye.com/blog/1457556),这是因为ERROR_IO_PENDING引起的连接关闭所致。

