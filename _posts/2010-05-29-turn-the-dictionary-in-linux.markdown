---
author: abloz
comments: true
date: 2010-05-29 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/05/29/turn-the-dictionary-in-linux/
slug: turn-the-dictionary-in-linux
title: 转：在Linux上查字典
wordpress_id: 1230
categories:
- 技术
---

http://blog.cathayan.org/item/1715

 

### [在Linux上查字典](http://blog.cathayan.org/item/1715)

* * *

[cathayan.org](http://cathayan.org/) 版权所有，保留一切权利。转载请保留此说明。谢绝商业转载。

 

 平时查字典，我主要用的是[水木社区](http://www.newsmth.net/) 提供的在线字典，这里查不到的就用浏 览器上Google，用define:word这样的方法查，如果看不懂，就用dict.cn，以前也用过在线的金山词霸[iciba.com](http://www.iciba.com/) ，但速度远不如[dict.cn](http://dict.cn/) ，页面也比较复杂。一般查英文词就是看个意思，要辨析精妙词义的时候很少，碰到这 种情况一般用m-w.com，应该没有这里更强的地方了，Google define一般情况下也够了。  
  
水木词典成为第一选择，全是因为它在终端窗口里工作，速度快，操作方便，只要有网，随时可用（有时会提示连接过多）。我希望词典都这样简单。  
  
前一段又想起来[dict.org](http://www.dict.org/links.html) ，它不光有在线词典，同时 它是一个DICT协议，分Server和Client，词典数据放在特殊格式的文件内，由服务器提供服务，客户端发出查询接受结果。它收集了一些可以免费 自由使用的字典，其中包括两个英汉字典，分别是伏建军的xdict和马苏安的Stardic，它们最初发布的时候就都是GPL授权，xdict更是有17 万词汇。但是这些词典原始来源如何就不太清楚了，但似乎没有过异议。水木的词典也很好用，但也不知道版权如何。  
  
在Debian下装dict很简单，装dictd dict-xdict  dict-stardic即可，后两个以dict开头的只是字典文件，而在本机上运行也需要启动一个dictd服务。装完就可以在终端上用命令来查词了：  
# dict mail  
8 definitions found  
  
From XDICT the English-Chinese dictionary [xdict]:  
 Mail  
    n. 邮件,邮政,邮递,盔甲  
    vt. 邮寄,给…穿盔甲  ;  
 电子邮件,(在unix操作系统另有一个名为mail的信件处理程序)  
  
From Stardic English-Chinese Dictionary [stardic]:  
 n. 邮件,邮政,盔甲;  
 v. 邮寄,～盔甲;  
  
From The Collaborative International Dictionary of English v.0.48  [gcide]:  
 Mail Mail (m[=a]l), n.  
    A spot. [Obs.]  
    [1913 Webster]  
最后一个词典是另外一个dict-gcide，the GNU version of the Collaborative International Dictionary of  English，很强大，包括了1913年的韦氏字典，Wordnet的一些词还有其他许多来源的东西，有释义词性例句等等。有这三个词典，一般就够了。  
  
在Debian系统上，dictd的配置文件在/etc/dictd下面，其中的dict.conf控制查哪些服务器，第一个是localhost，这个 比较快，另外的dict.org就只有网好才行了；dictd.conf控制哪些机器可以用本机的Dict服务以及从哪读取字典数据。这个字典文件的描述 在/var/lib/dictd/db.list，这个文件由dictdconfig这个程序来操作。还有一个dictd.order文件，里面控制字典 使用的顺序，一般中文放前面，就是那两个stardic/xdict；但似乎只改这个文件dictd并不认，此时就需要用dictdconfig -  w来把改变后的次序写入db.list文件。再重启dictd就好用了。  
  
还有一些图形界面的Dictd前端，比如kdict/gdict等等，gdict就不是很好用，还是终端吧。  
  
其他：  
http://www.dicts.info/uddl.php  
一些字典的下载，但这些字典通通只能自己用，不能分发。  
  
英文的网站，汉字数据  
http://interstitiality.net/hanziData.html  
  
http://www.mandarintools.com/cedict.html  
汉英字典，47000条以上  
  
http://freedict.org/howto/ch06.html  
Freedict，自由双语字典项目，尚无中文  
  
  
  

2007-11-12 08:43:09，由[cathayan](http://blog.cathayan.org/member/1) 发 表。目录：[电脑](http://blog.cathayan.org/category/2) [EMail This](http://blog.cathayan.org/nucleus/plugins/mailtoafriend/mailfriend.php?itemid=1715)

  
  


![](http://img.zemanta.com/pixy.gif?x-id=c667be6c-1574-8126-a922-eda6ce4c9b83)
