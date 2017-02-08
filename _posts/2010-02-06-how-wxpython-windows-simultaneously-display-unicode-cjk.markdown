---
author: abloz
comments: true
date: 2010-02-06 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/02/06/how-wxpython-windows-simultaneously-display-unicode-cjk/
slug: how-wxpython-windows-simultaneously-display-unicode-cjk
title: wxpython 如何在windows下同时显示unicode中日韩文
wordpress_id: 1042
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.1.6

 

python版本，python 2.6+,wxpython 2.8+

 

## 问题提出

遇到wxpython 如何在windows下同时显示中文日文韩文越南拼音的问题。

 

windows下python如何显示utf8编码呢？

  

用notepad打开utf8编码的文件，韩文是框框，中文正常。

用chrome浏览器，不指定utf8编码对多字节显示有问题。指定utf8编码则能正确显示中文韩文等。

 

我需求的正是能同时显示的方法，不知浏览器是如何正确处理的。

  

数据文件和python源文件都是utf8。遇到中文能显示，但韩语显示为问号的问题。并不是读文件编码有问题，因为linux下并无问题。

  

## 问题可能原因

1.windows只支持GBK 或GB18030，对Unicode中的中日韩同时显示有问题？问题是浏览器已经解决了同时显示的问题。

2.python 在winfows下不支持unicode 0x10000以上的编码。而unihan 5.2库有大量0x20000以上的编码，是不是python本身的问题？

3.windows字库对unicode 5.2支持太有限，以致韩语要显示成?

4.我的数据文件utf8保存有问题？以致打开后没有正确解析？

 

除了第2点，其他都不是我碰到的问题的原因。

 

其实windows下显示CJK的问题，分command命令行、pythonIDLE控制台、pyqt,pygtk,wxpython,pytk等GUI。

## 命令行

 

cmd命令行下

 

>>> u=unichr(0xc911)

>>> print u

Traceback (most recent call last):

File "<stdin>", line 1, in <module>

UnicodeEncodeError: 'gbk' codec can't encode character u'uc911' in position 0:

illegal multibyte sequence

  

>>> print u.encode('gbk')

Traceback (most recent call last):

File "<stdin>", line 1, in <module>

UnicodeEncodeError: 'gbk' codec can't encode character u'uc911' in position 0:

illegal multibyte sequence

>>> print u.encode('mbcs')

?

显示为问号。

 

u必须经过encode才能打印，所以对CJK支持非常有限。因为gbk不能显示韩语等。同时命令行字体也对显示各国语言有限制。

 

## IDLE

 

>>> u='일'

Unsupported characters in input

[view plain](http://blog.csdn.net/ablo_zhou/archive/2010/02/06/5295103.aspx#)[copy to clipboard](http://blog.csdn.net/ablo_zhou/archive/2010/02/06/5295103.aspx#)[print](http://blog.csdn.net/ablo_zhou/archive/2010/02/06/5295103.aspx#)[?](http://blog.csdn.net/ablo_zhou/archive/2010/02/06/5295103.aspx#)

  1. >>> u=u'일'
  2. Unsupported characters in input
  3. >>> u=u'일'.decode('gbk')
  4. Unsupported characters in input
  5. >>> u=u'일'.decode('utf8')
  6. Unsupported characters in input
  7. >>> u='일'.decode('gbk')
  8. Unsupported characters in input
  9. >>> u='일'.decode('utf8')
  10. Unsupported characters in input
  11. >>> u=unichr(0xc911)
  12. >>> print u
  13. >>> print u.encode('utf8')
  14. Traceback (most recent call last):
  15. File "<pyshell#41>", line 1, in <module>
  16. print u.encode('utf8')
  17. File "C:Python26libsite-packageswx-2.8-msw-unicodewx_core.py", line 7845, in write
  18. self.__write(text)
  19. File "C:Python26libsite-packageswx-2.8-msw-unicodewx_core.py", line 7850, in __write
  20. self.text.AppendText(text)
  21. File "C:Python26libsite-packageswx-2.8-msw-unicodewx_controls.py", line 1850, in AppendText
  22. return _controls_.TextCtrl_AppendText(*args, **kwargs)
  23. UnicodeDecodeError: 'gbk' codec can't decode byte 0x91 in position 2: incomplete multibyte sequence
  24. >>> print u.encode('gbk')
  25. Traceback (most recent call last):
  26. File "<pyshell#42>", line 1, in <module>
  27. print u.encode('gbk')
  28. UnicodeEncodeError: 'gbk' codec can't encode character u'uc911' in position 0: illegal multibyte sequence
  29. >>> 


>>> u=u'일' Unsupported characters in input >>> u=u'일'.decode('gbk') Unsupported characters in input >>> u=u'일'.decode('utf8') Unsupported characters in input >>> u='일'.decode('gbk') Unsupported characters in input >>> u='일'.decode('utf8') Unsupported characters in input >>> u=unichr(0xc911) >>> print u >>> print u.encode('utf8') Traceback (most recent call last):  File "<pyshell#41>", line 1, in <module>    print u.encode('utf8')  File "C:Python26libsite-packageswx-2.8-msw-unicodewx_core.py", line 7845, in write    self.__write(text)  File "C:Python26libsite-packageswx-2.8-msw-unicodewx_core.py", line 7850, in __write    self.text.AppendText(text)  File "C:Python26libsite-packageswx-2.8-msw-unicodewx_controls.py", line 1850, in AppendText    return _controls_.TextCtrl_AppendText(*args, **kwargs) UnicodeDecodeError: 'gbk' codec can't decode byte 0x91 in position 2: incomplete multibyte sequence >>> print u.encode('gbk') Traceback (most recent call last):  File "<pyshell#42>", line 1, in <module>    print u.encode('gbk') UnicodeEncodeError: 'gbk' codec can't encode character u'uc911' in position 0: illegal multibyte sequence >>>  

## wxPython GUI

 

开始发现wxPython GUI显示同时中日韩文也有问题，中文显示正确时，韩语等显示为问号。

经过研究，发现是wx.TextCtrl的SetValue方法调用的问题。

SetValue(str),str的编码最好是unicode，而不是具体的编码。

对str是utf8的字符串，应这样设置：

txtCtrl.SetValue(str.decode('utf8'))

 

我原来是这样写的：txtCtrl.SetValue(str.decode('utf8').encode(sys.getfilesystemencoding()))

 

这样就导致在mbcs编码下，只显示中文，不显示韩文和越南文。

 

## 测试程序

[view plain](http://blog.csdn.net/ablo_zhou/archive/2010/02/06/5295103.aspx#)[copy to clipboard](http://blog.csdn.net/ablo_zhou/archive/2010/02/06/5295103.aspx#)[print](http://blog.csdn.net/ablo_zhou/archive/2010/02/06/5295103.aspx#)[?](http://blog.csdn.net/ablo_zhou/archive/2010/02/06/5295103.aspx#)

  1. >>> a = wx.App()
  2. >>> f = wx.Frame(None,-1,'test')
  3. >>> t = wx.TextCtrl(f,-1)
  4. >>> t.SetValue('일')
  5. Unsupported characters in input
  6. >>> t.SetValue('中'.decode('gbk')+unichr(0xc911)+'xecxa4x91'.decode('utf8'))
  7. >>> f.Show()

>>> a = wx.App() >>> f = wx.Frame(None,-1,'test') >>> t = wx.TextCtrl(f,-1) >>> t.SetValue('일') Unsupported characters in input >>> t.SetValue('中'.decode('gbk')+unichr(0xc911)+'xecxa4x91'.decode('utf8')) >>> f.Show()

显示

 

中중중

 

于是，《汉字大全》可以发表0.7版了。

见http://code.google.com/p/hzdq

  
  


![](http://img.zemanta.com/pixy.gif?x-id=f9828831-eddf-8c79-b00c-86208bd5677e)
