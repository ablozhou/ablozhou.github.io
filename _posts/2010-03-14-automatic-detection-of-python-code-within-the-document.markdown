---
author: abloz
comments: true
date: 2010-03-14 06:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/14/automatic-detection-of-python-code-within-the-document/
slug: automatic-detection-of-python-code-within-the-document
title: python自动检测文档内码
wordpress_id: 1157
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.3.14

 

python 内码检测模块chardet，是从firefox中移植的，判定正确率比较高。

下载地址：http://chardet.feedparser.org/

ubuntu下如果遇到ImportError: No module named chardet  
可以通过如下的命令自动安装：

zhouhh@zhh64:~$ sudo apt-get install python-chardet

 

chardet.detect(buffer)会返回一个字典。

chardet.detect(rawdata)  
{'confidence': 0.98999999999999999, 'encoding': 'GB2312'}  
其中confidence是可信度，encoding是编码。

 

下面是用法示例。

[](http://blog.csdn.net/ablo_zhou/archive/2010/03/14/5379341.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2010/03/14/5379341.aspx#)

  1. #!/usr/bin/env python
  2. # -*- coding: UTF-8 -*-
  3. # author ablozhou <a title="" href="http://blog.csdn.net /ablo_zhou" mce_href="http://blog.csdn.net/ablo_zhou" target="_blank"& gt;周海汉</a>
  4. # ablozhou@gmail.com
  5. # http://blog.csdn.net/ablo_zhou
  6. # 2010.3.14
  7. import chardet
  8. import urllib
  9. if __name__ == '__main__':
  10. mydet = {
  11. 'SHIFT_JIS':'http://www.mankan.or.jp/',
  12. 'GB2312':'http://g.cn/',
  13. 'Big5':'http://www.programmer-club.com.tw/',
  14. 'UTF8':'http://zh.wikipedia.org/'
  15. }
  16.   17. for url in mydet.values():
  18. print url
  19. rawdata = urllib.urlopen(url).read()
  20. enc = chardet.detect(rawdata)
  21. print enc['encoding']
  22. #!/usr/bin/env python # -*- coding: UTF-8 -*- # author ablozhou <a title="" href="http://blog.csdn.net/ablo_zhou"  mce_href="http://blog.csdn.net/ablo_zhou"  target="_blank">周海汉</a> # ablozhou@gmail.com # http://blog.csdn.net/ablo_zhou # 2010.3.14 import chardet import urllib if __name__ == '__main__':    mydet = {        'SHIFT_JIS':'http://www.mankan.or.jp/',        'GB2312':'http://g.cn/',        'Big5':'http://www.programmer-club.com.tw/',        'UTF8':'http://zh.wikipedia.org/'        }            for url in mydet.values():        print url        rawdata = urllib.urlopen(url).read()        enc = chardet.detect(rawdata)        print enc['encoding']       

执行：

python encdet.py   
http://zh.wikipedia.org/  
utf-8  
http://www.mankan.or.jp/  
SHIFT_JIS  
http://g.cn/  
GB2312  
http://www.programmer-club.com.tw/  
Big5

  
  


![](http://img.zemanta.com/pixy.gif?x-id=adb881c7-ac24-87eb-9f13-dd4fc73a3001)
