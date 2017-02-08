---
author: abloz
comments: true
date: 2010-07-22 09:44:15+00:00
layout: post
link: http://abloz.com/index.php/2010/07/22/ubuntu-evince-view-the-pdf-under-the-issue-of-chinese-garbled/
slug: ubuntu-evince-view-the-pdf-under-the-issue-of-chinese-garbled
title: ubuntu下evince 查看pdf中文乱码的问题
wordpress_id: 254
categories:
- 技术
tags:
- evince
- pdf
- 中文
- 乱码
---

evince查看中文pdf有乱码，可能是好几个层面的问题。





	
  * pdf没有带中文字体

	
  * 系统没有安装中文字体

	
  * 系统有中文字体但缺省是用的西文字体（此时显示为方框）


所以碰到乱码问题，下面的一步或几步可以解决问题。根据情况不同，生效方法也不一样。





### 1.evince 升级到最新版







sudo apt-get install evince




sudo  apt-get install cmap-adobe-gb1 gsfonts-x11 xpdf-chinese-simplified  xpdf-common
升级中文包




### 2.安装Poppler


由于evince使用poppler后端，ubuntu下可以安装poppler所带中文字体

    
    sudo apt-get install poppler-data
    


某些系统也可以直接去[poppler网站下载字体](http://poppler.freedesktop.org/)，地址http://poppler.freedesktop.org/，解压后执行

sudo make  install datadir=/usr/share


### 3.打开/etc/xpdf/xpdfrc-chinese-simplefied


将 displayCIDFontTT改为

displayCIDFontTT Adobe-GB1  /usr/share/fonts/truetype/xpfonts/wqy/wqy-zenhei.ttc

具体字体和路径请根据系统情况设置。
这时大部分中文都能看了。但还是有一部分中文显示有问题。


### 4.修改缺省字体


由于一部分pdf文档并未带有字体，而系统缺省字体是西文字体，需要修改缺省显示字体为中文。

    
    # rm /etc/fonts/conf.d/49-sansserif.conf
    


或者修改：




    
    <edit name="family" mode="append_last">
         <string>sans-serif</string>
    </edit>





为




    
    <edit name="family" mode="append_last">
        <string>文泉驿正黑</string>
    </edit>





这时一些windows下生成，没有安装字体的pdf文档，（中文全是方框），可以显示了。


### 5.利用windows中文字体：




下面的命令是我系统windows下的中文字体，连接到/usr/share  /fonts下，后缀名ttc改为ttf
sudo ln -s  /media/sda1/WINDOWS/Fonts/simsun.ttc   simsun.ttc simsun.ttf




或者将windows系统的c:/windows/fonts /simsun.ttc,simhei.ttc,拷贝到/usr/share/fonts/truetype/xpfonts下面，修改后缀为ttf




执 行




sudo mkfontsdir




sudo mkfontscale




sudo  fc-cache




不过我发现自己安装的字体，evince一直没有发现。而openoffice和firefox都能发现。幸好有了兜底的第4步，中文能够显示出来。
