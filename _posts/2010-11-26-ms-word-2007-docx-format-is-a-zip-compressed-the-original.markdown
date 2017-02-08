---
author: abloz
comments: true
date: 2010-11-26 01:45:04+00:00
layout: post
link: http://abloz.com/index.php/2010/11/26/ms-word-2007-docx-format-is-a-zip-compressed-the-original/
slug: ms-word-2007-docx-format-is-a-zip-compressed-the-original
title: docx 格式MS word 2007原来是zip压缩
wordpress_id: 1088
categories:
- 技术
---

2010.11.26  
abloz.com  
  
从网上下载一个docx文件，却变成了zip文档。打开解压，发现里面很多内容：  
  

    
    zhouhh@zhh64:~/Documents/docx$ find
    .
    ./[Content_Types].xml
    ./word
    ./word/fontTable.xml
    ./word/document.xml
    ./word/endnotes.xml
    ./word/settings.xml
    ./word/theme
    ./word/theme/theme1.xml
    ./word/footnotes.xml
    ./word/webSettings.xml
    ./word/media
    ./word/media/image3.jpeg
    ./word/media/image2.jpeg
    ./word/media/image1.jpeg
    ./word/styles.xml
    ./word/_rels
    ./word/_rels/document.xml.rels
    ./docProps
    ./docProps/app.xml
    ./docProps/core.xml
    ./_rels
    ./_rels/.rels
    
    我将该zip文件后缀改为.docx, 则可以正常打开。是一个包含3张图片的文档。
    可见docx格式是用zip压缩的以xml来描述的富媒体内容。[Content_Types].xml描述有哪些内容以及存放路径。word目录存放内容，样式和图片等。
    

Technorati 标签: [word](http://technorati.com/tag/word)  
  


![](http://img.zemanta.com/pixy.gif?x-id=adabddff-536f-8a86-b116-9a5a59472d66)
