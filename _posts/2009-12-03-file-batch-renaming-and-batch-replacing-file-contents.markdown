---
author: abloz
comments: true
date: 2009-12-03 01:57:01+00:00
layout: post
link: http://abloz.com/index.php/2009/12/03/file-batch-renaming-and-batch-replacing-file-contents/
slug: file-batch-renaming-and-batch-replacing-file-contents
title: 文件批量改名和批量替换文件内容
wordpress_id: 975
categories:
- 社会评论
---

# 

[周海汉](http://blog.csdn.net/ablo_zhou) /文

09.12.3

文本操作中经常有整体查找和替换以及改名的操作，在linux下还是比较方便的，windows下则需要采用特殊工具。下面是linux下一些简单方法，在ubuntu9.10中调试通过。

1.批量改名采用命令rename

rename 语法：

rename [ -v ] [ -n ] [ -f ] perlexpr [ files ]

-v表示显示详细信息，-n表示不实际执行替换，只是看哪些文件会受影响。 -f 表示强制，不管是否有重名。

perlexpr是perl语法的表达式， files则是匹配项。因此,该命令执行结果与perlexpr有关，不一定就是改文件名。

实例： 将所有文件名*.html 改为对应的.htm

rename 's/.html$/.htm$/' *.html

去bak后缀

rename 's/.bak$//' *.bak

将文件名大写改为小写

rename 'y/A-Z/a-z/' *

但rename不能递归修改。

2.递归改名，用find+rename

将文件名的abc改为xyz

find . -name "abc*" -exec rename 's/abc/xyz/' {} ;

该命令可以将当前目录下所有子目录的文件都改名。

3.内容替换，用find+sed

将所有ablo 替换为ablozhou

find . -type f -exec sed -i -e "s/ablo/ablozhou/g" {} ;

sed 命令 -i 表示 --in-place，文件原地替换。-e 后跟替换表达式。

![](http://img.zemanta.com/pixy.gif?x-id=40d48fb1-8de3-8e78-a693-156e8c6cc39c)
