---
author: abloz
comments: true
date: 2012-08-28 07:04:13+00:00
layout: post
link: http://abloz.com/index.php/2012/08/28/how-to-let-ren-py-display-chinese/
slug: how-to-let-ren-py-display-chinese
title: 何让Ren'Py显示中文
wordpress_id: 1829
categories:
- 技术
tags:
- python
- renpy
---

Ren'Py是一个编写可视小说或游戏的python脚本框架。但并不缺省支持中文。所以转载一篇支持中文的文档。官网：[http://www.renpy.org](http://www.renpy.org/)


# 何让Ren'Py显示中文





	
  1. 脚本要保存为UTF-8编码。

	
  2. 将True Type中文字体(.ttf文件）复制到游戏目录，并改名为font.ttf（当然，你可以改为任何名称。也可以是中文，不过不推荐。）。

	
  3. 在脚本中初始块中加入这行代码：




    
    init:
        $ style.default.font = "font.ttf"


如果字体名是中文，代码要稍稍变动一下：

    
    init:
        $ style.default.font = u"黑体.ttf"


如上所示，要在前面加一个前缀u，表明是统一码(unicode)，这样程序才能正确识别。



	
  1. 

	
    1. 4 将extra目录中的east_asian.rpy复制到游戏目录。

	
    2. 6.3.2 版后不需要 east_aisan.rpy, 只需要设定 style.language 参数为 "eastasian" 即可






	
  1. 

	
    1. 在目前最新的6.11.2中，经过测试，只需将中文字体复制到ren'py的common目录下，而后编辑游戏game目录下的option.rpy，将里面 # style.default.font = "font.ttf" 这行的font.ttf改为你复制的字体文件名，并且去掉前面的注释符号#就可以了。








Retrieved from "[http://www.renpy.org/wiki/renpy/chs/doc/tutorials/%E5%A6%82%E4%BD%95%E8%AE%A9Ren%27Py%E6%98%BE%E7%A4%BA%E4%B8%AD%E6%96%87](http://www.renpy.org/wiki/renpy/chs/doc/tutorials/%E5%A6%82%E4%BD%95%E8%AE%A9Ren%27Py%E6%98%BE%E7%A4%BA%E4%B8%AD%E6%96%87)"






