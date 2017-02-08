---
author: abloz
comments: true
date: 2012-11-24 10:26:47+00:00
layout: post
link: http://abloz.com/index.php/2012/11/24/to-his-wife-to-write-html-convert-txt-text-program/
slug: to-his-wife-to-write-html-convert-txt-text-program
title: 给老婆写的将html转成txt文本的程序
wordpress_id: 1986
categories:
- 技术
tags:
- html
- python
- text
---

老婆想在ipad读点小说，但我手头的<射雕>是html版的，有几十个html文件。写点python代码,用beautifulsoup将其转成txt文本，并合并成一个文件，生成目录。



    
    
    #!/usr/bin/env python
    # encoding:utf8
    # author:zhouhh
    # date:2012.11.20
    from bs4 import BeautifulSoup
    import os
    import codecs
    f="shedia.txt"
    t=codecs.open(f,"wb",encoding="gb18030")
    #t.write("nzhh made for my dear yff n2012.11.18n")
    ts=[]
    
    t.write("nzhh made for my dear yff n2012.11.18nn")
    for i in sorted(os.listdir(".")):
        if(i[-3:]=="htm"):
            print "convert %s title "%i
            htm=codecs.open(i,"rb",encoding="gb18030")
        soup=BeautifulSoup(htm)
            htm.close()
        #f="%stxt"%i[:-3]
        #print "write to %s"%f
            #t.write(soup.select("p")[0].text)
        title=soup.title.text[7:]
        ts.append(title)
    t.write("n".join(ts))
    
    for i in sorted(os.listdir(".")):
        if(i[-3:]=="htm"):
            print "convert %s"%i
            htm=codecs.open(i,"rb",encoding="gb18030")
        soup=BeautifulSoup(htm)
            htm.close()
        #f="%stxt"%i[:-3]
        #print "write to %s"%f
            #t.write(soup.select("p")[0].text)
        t.write("nzhh made for my dear yff n2012.11.18nn")
        title=soup.title.text[7:]
    
            t.write(title)
        t.write(soup.select("pre")[0].text)
        #t.write(soup.body.text)
    t.close()
    
    




