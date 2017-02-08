---
author: abloz
comments: true
date: 2015-06-07 17:01:44+00:00
layout: post
link: http://abloz.com/index.php/2015/06/08/wordpress-summary-word-length-adjustment/
slug: wordpress-summary-word-length-adjustment
title: wordpress 摘要字数长度调整
wordpress_id: 2670
categories:
- 技术
tags:
- wordpress
---

周海汉

由于wordpress摘要长度是针对英文的，缺省是55. 换成utf-8之后，只剩下一行：

```
“周海汉 2015.6.5 cassandra是apache开源的著名NoSQL数据库，使用起来非常简单，支持多… [Continue reading cassandra五分钟入门→](http://abloz.com/index.php/2015/06/05/getting-started-with-cassandra-five-minutes/)”，

如果是英文则有3行。
```

修改wp-includes的formatting.php文件function wp_trim_excerpt($text = '')函数，

$excerpt_length = apply_filters( 'excerpt_length', 55 );

将55改为220.

或者到plugins/themes里面修改excerpt_length过滤器，更多的字符串可以用plugins/themes下面的excerpt_more过滤器。



修改后摘要效果：“

```
周海汉 2015.6.7 JVC，sony，松下的摄像机，其文件格式是MTS或M2TS文件。摄像机或盘连接到Mac book后，如果直接通过mount的盘去查看，只能看见一个整体的视频文件，而不是根据录制时间切分的。如果用mac自带的照片查看，导入的视频也会失去时间信息，而且全部转为mov格式。用iMovie可以保留时间信息，但其文件名是类似Clip #99.mov这样的格式，文件名本身不带时间信息，不方便放在云盘保存。 所以写了个脚本… [Continue reading mac 批量改名脚本→](http://abloz.com/index.php/2015/06/07/mac-batch-renaming-scripts/)

”
```

