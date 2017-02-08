---
author: abloz
comments: true
date: 2008-04-02 09:21:23+00:00
layout: post
link: http://abloz.com/index.php/2008/04/02/python-script-to-generate-source-dictionary/
slug: python-script-to-generate-source-dictionary
title: 生成源码字典的python脚本
wordpress_id: 309
categories:
- 技术
tags:
- c
- python
- vim
---

vim在编写C语言代码时，可以设置字典，以自动完成。:set dictionary=mydict 将其放到.vimrc中。
在编辑模式，Ctrl+x,Ctrl+k即可以根据字典自动完成输入。
将下面的脚本放到源码目录执行，即可生成mydict字典文件。
该脚本稍做修改即可用于对文本进行统计，生成统计数据。可用于搜索或者输入法，或者语音合成。

    
    
    #!/usr/bin/env python
    # file name :mkdict
    # author: zhouhh
    # blog: http://blog.csdn.net/ablo_zhou
    # Email: ablozhou@gmail.com
    # Date : 2008.4.02
    
    import subprocess
    import glob
    import re
    import os
    
    files = glob.glob("*") #raw_input("input your file name:")
    
    dict = {}
    for i in files:
        print i
        if not os.path.isfile(i):
            continue
    
        f=open(i,"r")
        key=""
        for line in f.readlines():
            key = re.findall("^[a-zA-Z]w*",line)
            for j in key:
                dict[j] =dict.get(j,0)+ 1
    
        f.close()
    
    w = open("mydict","w+")
    for k in sorted(dict.keys()):
        w.write(k)
        w.write(" ")
    
    w.close()
    
