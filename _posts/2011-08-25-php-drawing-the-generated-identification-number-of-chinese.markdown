---
author: abloz
comments: true
date: 2011-08-25 08:02:22+00:00
layout: post
link: http://abloz.com/index.php/2011/08/25/php-drawing-the-generated-identification-number-of-chinese/
slug: php-drawing-the-generated-identification-number-of-chinese
title: php 画图，生成中文的识别码
wordpress_id: 1360
categories:
- 技术
---


    
    


[![](http://abloz.com/wp-content/uploads/2011/08/li.png)](http://abloz.com/wp-content/uploads/2011/08/li.png)

中文汉字进行了角度转换。使用了系统的字体。但如果字体不指定绝对目录，则显示不出来。这里有点疑惑。
另外，imagestring函数，不支持utf8. 而imagettftext支持utf8，对其他编码则支持不到位。所以整个php文件是utf8编码的。
