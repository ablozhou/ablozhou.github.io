---
author: abloz
comments: true
date: 2009-02-12 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/02/12/svn-update-encoding-problems-encountered-can-not-be-updated/
slug: svn-update-encoding-problems-encountered-can-not-be-updated
title: svn update 碰到编码问题无法更新
wordpress_id: 893
categories:
- 技术
---

#  					 				

				

 					  					  					

svn update 碰到编码问题无法更新

  

$ svn up  
svn: Can't convert string from native encoding to 'UTF-8':  
svn:  ?231?153?187?229?189?149?230?156?141?229?138?161?229?153?168?230?168?161?229?157?151?232?174?190?232?174?161.pdf

pdf文件是中文文件，不能将其转到uTF-8，查看一下locale：

$ locale  
LANG=zh_CN.GB2312  
LC_CTYPE="zh_CN.GB2312"  
LC_NUMERIC="zh_CN.GB2312"  
LC_TIME="zh_CN.GB2312"  
LC_COLLATE="zh_CN.GB2312"  
LC_MONETARY="zh_CN.GB2312"  
LC_MESSAGES="zh_CN.GB2312"  
LC_PAPER="zh_CN.GB2312"  
LC_NAME="zh_CN.GB2312"  
LC_ADDRESS="zh_CN.GB2312"  
LC_TELEPHONE="zh_CN.GB2312"  
LC_MEASUREMENT="zh_CN.GB2312"  
LC_IDENTIFICATION="zh_CN.GB2312"  
LC_ALL=zh_CN.GB2312

将locale改为UTF-8

$ export LC_ALL=zh_CN.UTF-8

 

$ svn up

于修订版 415。

 

成功了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=99cc5513-5bab-8f8c-ac4f-b36cadc9fd64)
