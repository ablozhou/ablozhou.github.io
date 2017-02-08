---
author: abloz
comments: true
date: 2009-02-04 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/02/04/vim-with-python3-0-and-check-the-file-with-the-encoding-of-chinese/
slug: vim-with-python3-0-and-check-the-file-with-the-encoding-of-chinese
title: 用python3.0 和vim配合检查文件中文的编码
wordpress_id: 887
categories:
- 社会评论
---

  
[周海汉](http://blog.csdn.net/ablo_zhou) /文 2009.2.3

  
打开一个中文文件，不清楚其中文编码到底是什么格式。python源程序文件头可能指定是utf8，而实际编码却是gbk。不一致的编码在python源码中，可能在执行时得到错误的结果。一种解决办法是查看二进制，但汉字的二进制到底对应什么编码呢？

 

python3.0内部缺省编码为utf-8。

vim的vimrc里面增加两行：

  
set fenc=utf-8  
set fileencodings=utf-8,cp936,big5,euc-jp,euc-kr,latin1,ucs-bom

  
这样，文件保存缺省的为utf-8编码。

 

在.vimrc中设置fenc以处理中文文件名。设置fileencoding=utf-8,gbk,...等让vim 7.0以上自动判别文件内码。如果不设置的话，在linux下打开gb2312内码的文件会显示乱码。设置后系统会自动判断内码。

 

set enc=cp936 这是gvim界面显示的编码，windows下用cp936,linux下用utf8，最好不要设，系统自己判断。

对新打开的已经存在的文件，如果不确定一个文件是否是utf8还是gbk，用vim打开文件，看到中文，再在命令模式下执行  
:%!xxd   
看到相应的二进制。假如文本中有“你好”，会在左边对应位置看到你好的十六进制表示。  
打开python3.0,在命令行下将文本中的特定字“你好”进行二进制转码。

  


[view plain](http://blog.csdn.net/ablo_zhou/archive/2009/02/04/3861387.aspx#)[copy to clipboard](http://blog.csdn.net/ablo_zhou/archive/2009/02/04/3861387.aspx#)[print](http://blog.csdn.net/ablo_zhou/archive/2009/02/04/3861387.aspx#)[?](http://blog.csdn.net/ablo_zhou/archive/2009/02/04/3861387.aspx#)

  1. >>> a='你好'
  2. >>> b=a.encode('utf8')
  3. >>> b
  4. b'xe4xbdxa0xe5xa5xbd'
  5. >>> c=a.encode('gbk')
  6. >>> c
  7. b'xc4xe3xbaxc3'

>>> a='你好' >>> b=a.encode('utf8') >>> b b'xe4xbdxa0xe5xa5xbd' >>> c=a.encode('gbk') >>> c b'xc4xe3xbaxc3'   
可以看到，对中文“你好”的二进制，utf8是  
0xe4ba0 0xe5a5bd  
而对gbk，gb2312，cp936，gb18030，则二进制是：  
0xc4e3 0xbac3  
与vim中二进制一比较，就看出文本中是什么编码了。  
知道编码后，再用  
:%!xxd -r  
命令将十六进制转为普通的文本，保存。  
对已经存在的文本，linux下可以用iconv将其转码。

  


  
  


![](http://img.zemanta.com/pixy.gif?x-id=fe31e89b-4be8-8e2f-b4cc-b4e79d6a2dd5)
