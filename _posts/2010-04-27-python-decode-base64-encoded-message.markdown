---
author: abloz
comments: true
date: 2010-04-27 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/04/27/python-decode-base64-encoded-message/
slug: python-decode-base64-encoded-message
title: python 解码base64编码邮件
wordpress_id: 1218
categories:
- 技术
---

周海汉 /文

2010.4.27

 

有时会看到一个邮件文件，内容的mine部分采用了base64编码，但手头又没什么工具可以解码，这时可以用python的base64模块。

上次有个邮件，什么内容都没显示，发邮件者则坚持发了内容。查看源码，发现有base64的内容，用python来解码看看。

 

于是写个python来解码：

[](http://blog.csdn.net/ablo_zhou/archive/2010/04/27/5533410.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2010/04/27/5533410.aspx#)

  1. #!/usr/bin/env python
  2. a='''''IDxodG1sIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sJz48aGVhZD48c3R5bGUg
  3. dHlwZT0idGV4dC9jc3MiPg0KICAgICAgICAgICAgcHsNCiAgICAgICAgICAgIHRleHQtaW5kZW50
  4. OjI1cHg7DQogICAgICAgICAgICBsaW5lLWhlaWdodDoxLjY7DQogICAgICAgICAgICB9DQoNCiAg
  5. ICAgICAgICAgIGF7DQogICAgICAgICAgICBjb2xvcjojMEQzMTZGOw0KICAgICAgICAgICAgfQ0K
  6. ICAgICAgICAgICAgLmJ0bnsNCiAgICAgICAg'''
  7. import base64
  8. print base64.decodestring(a)

#!/usr/bin/env python a='''IDxodG1sIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sJz48aGVhZD48c3R5bGUg dHlwZT0idGV4dC9jc3MiPg0KICAgICAgICAgICAgcHsNCiAgICAgICAgICAgIHRleHQtaW5kZW50 OjI1cHg7DQogICAgICAgICAgICBsaW5lLWhlaWdodDoxLjY7DQogICAgICAgICAgICB9DQoNCiAg ICAgICAgICAgIGF7DQogICAgICAgICAgICBjb2xvcjojMEQzMTZGOw0KICAgICAgICAgICAgfQ0K ICAgICAgICAgICAgLmJ0bnsNCiAgICAgICAg''' import base64 print base64.decodestring(a)  

zhouhh@zhh64:~$ ./base.py   
<html xmlns='http://www.w3.org/1999/xhtml'><head><style type="text/css">  
p{  
text-indent:25px;  
line-height:1.6;  
}  
  
a{  
color:#0D316F;  
}  
.btn{  


原来果然是什么内容都没有，就一个html的头。说明发邮件的地方出问题了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=cff8b6e9-a7b7-8975-9e53-481cdbcf47f3)
