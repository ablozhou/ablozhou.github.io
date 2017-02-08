---
author: abloz
comments: true
date: 2010-03-22 07:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/22/a-python-dos-and-unix-format-text-dealing-with-the-problem-of-line/
slug: a-python-dos-and-unix-format-text-dealing-with-the-problem-of-line
title: 一个python处理dos和unix格式文本的换行的问题
wordpress_id: 1177
categories:
- 技术
---

看到以前limod写的一篇文章，

说python读纯文本已经将r,rn,n全部用n来处理了。但我的系统中好像并没有这样。  
我在ubuntu下面，Python 2.6.4  
  
读写方式如下：  
>>> data = open('dosfile.txt','r').read()  
>>> print data  
结果看到换行还是rn.  
这样，我处理文本时如果想通过nn(两个换行)来作为分段的话，对dos格式的无效。  
items = data.split('nn')就并不能达到我想分的段。  
  
lines = data.splitline()倒能正确处理rn为n，分行正确.但这不是我想要的。

  


执行：  

    
    if hasattr(open, 'newlines'):
    
                print 'We have universal newline support'
    
    

我的没打印，说明没有设置open的  

    
    universal newline support

但不知在哪里设。  
  
所以我用  
open('dostext.txt','rU').read()解决了该问题。

在打开参数中，'rb'肯定是不会转的，'rU'是会转的。U不能和+,w等mode参数配。  


  


==========  


参考：

http://en.wikipedia.org/wiki/Newline

http://www.python.org/dev/peps/pep-0278/

http://bugs.python.org/issue6759

  
  


![](http://img.zemanta.com/pixy.gif?x-id=b514bf77-631e-8fa7-8482-890a7d63903c)
