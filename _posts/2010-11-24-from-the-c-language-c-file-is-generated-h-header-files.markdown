---
author: abloz
comments: true
date: 2010-11-24 02:08:23+00:00
layout: post
link: http://abloz.com/index.php/2010/11/24/from-the-c-language-c-file-is-generated-h-header-files/
slug: from-the-c-language-c-file-is-generated-h-header-files
title: 从C语言.c文件生成.h头文件
wordpress_id: 1081
categories:
- 技术
---

2010.11.24  
  
因为我的C文件函数都返回int，所以用下面的命令完成：  
zhouhh@zhh64:~/sms$ grep ^int protocol.c |sed 's/.*/&;/'  
int ntoh_header(header_t *head);  
int hton_header(header_t *head);  
...  
grep命令拿到函数声明，^int表示以“int”打头的行，sed命令在后面增加一个分号";". sed命令的s表示替换，第二个“.*"表示任意字符，第三栏的&表示前一个匹配。  
如果是添加新行可以直接用a命令。sed 'a newline'  
如果函数定义返回值再复杂，就得写更复杂的grep 匹配，或者多进行几次匹配再组合起来。  
  


![](http://img.zemanta.com/pixy.gif?x-id=9d4cca73-ec44-8411-a3b6-348126b93ca7)
