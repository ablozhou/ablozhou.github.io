---
author: abloz
comments: true
date: 2011-01-07 09:36:05+00:00
layout: post
link: http://abloz.com/index.php/2011/01/07/libxml2-string/
slug: libxml2-string
title: libxml2 的字符串
wordpress_id: 1120
categories:
- 技术
---

http://abloz.com
2011-1-7

1.xmlChar
libxml2里面的字符串，都是xmlChar类型。在libxml/xmlString.h里定义。



```
typedef unsigned char xmlChar;
```



所以，xmlChar是无符号的char类型。这么定义主要是为了utf-8兼容。在一些字符串操作中必须进行转换才能避免warning。
如

    
    
     xmlNodePtr curNode = NULL;
    xmlChar *szValue = NULL;
    szValue = xmlGetProp(curNode,BAD_CAST "module_id");
    


其中，字符串常量"module_id"前面必须加宏BAD_CAST，否则会有警告。BAD_CAST也在libxml/xmlString.h里定义，如下：




```
#define BAD_CAST (xmlChar *)
```


因为对xmlChar的重定义，libxml2对字符串操作进行了封装。



```
xmlStrlen                (const xmlChar *str);
xmlStrEqual              (const xmlChar *str1,
                                         const xmlChar *str2);
xmlStrcmp                (const xmlChar *str1,
                                         const xmlChar *str2);
xmlUTF8Strlen                    (const xmlChar *utf);
```


但并没有提供xmlStrcpy这样的函数。
也没有提供直接将xmlChar字符串"123"转为数值的函数。



