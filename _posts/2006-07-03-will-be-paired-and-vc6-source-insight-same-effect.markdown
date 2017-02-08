---
author: abloz
comments: true
date: 2006-07-03 06:25:21+00:00
layout: post
link: http://abloz.com/index.php/2006/07/03/will-be-paired-and-vc6-source-insight-same-effect/
slug: will-be-paired-and-vc6-source-insight-same-effect
title: 将source insight配成和VC6一样的效果
wordpress_id: 223
categories:
- 技术
tags:
- source insight
- style
- vc6
---

_本文可以免费自由使用，但不得去掉作者信息。
作者: [周海汉](http://blog.csdn.net/ablo_zhou)_

_主页：[http://blog.csdn.net/ablo_zhou](http://blog.csdn.net/ablo_zhou)
Email:ablozhou  at gmail.com
日期：2007.7.3_

如果一个软件的文件数达到1000以上，那么对代码的管理和阅读将是一件比较困难的事情。在VC下，不得不安装Visual  Assist软件，以提升阅读和编写代码的效率。

Source  Insight是一款非常优秀的商业代码阅读和编写软件。在管理大型源码方面具有非常独到的优势。其最新版本，应该是3.5。因为是商业软件，一些正规的 大公司如果没有购买，是禁止使用的。以前在华为有人私自使用Source Insight，还被处罚。最后公司买了正版。

但Source Insight的缺省样式有时候觉得过于凌乱。看代码久了就累。而VC在装有Visual  Assist的情况下，界面上面则好很多，舒服很多，但功能上还是赶不上Source Insight。以前传言微软要收购Source  Insight。如果真是这样，那Visual  studio将是史上最牛的集成开发环境。可惜比尔一直没有行动。虽然挖了Delphi的创始人，使VS2003以后，编程序轻松了不少。

既然比尔不行动，那我自己动手好了，把Source Insight配的和VC差不多，除了不能编译之外。 Source  Insight的显示效果的确不太好。对中文支持也不好，所以经过我多次试验，才找到这比较好的方法。

1.配置缺省字体。菜单Options->Document Options, 配置Screen Fonts为Arial 10  Bold。点Auto Indent按钮，Auto Indent Type选为Smart，将Indent Open Brace 和 Indent  Close Brace复选框去掉，确认。这个时候字体具有了VC里面缺省的System字体的黑体效果。而且这种字体在Source  Insight里面最美化，别的字体则比较难看。包括其缺省字体。Arial 10 Bold还能正常支持中文，这也是必须的。

2.配置关键字颜色。点选菜单Options->Style Properties，设置样式。在Default  Text样式，Foreground color选Pick，RGB填为0，0，128。这种藏青色比黑色舒服一点。同样，将Ref to local,  Ref to parameter,Ref to member,Standard Object,Standard  Property设为128,128,128的灰色。将Null value，Keyword,Ref to Class,Ref to  struct,Ref to typedef,string都设为0,0,255。将Ref to macro,Ref to Const,Ref to  Enum,Ref to EnumConst设为160,0,160;将Ref to Method, Ref to Method  Proto,Ref to Proto,Ref to Func,Standard  Function的颜色设为136，0，0的深红色，将Comment设为33,133,33的绿色。

3.微调颜色。如果看到关键字颜色不符合自己要求，在该关键字上点右键，在弹出菜单上有一个Style  Properties，进去后就是对应的条目，可以设置其样式，通常是颜色。

4.保存。自己满意后，进入Style Properties后点Save 按钮，将其保存起来，甚至可以存到网上，以便下次使用和与朋友共享。
![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/source.PNG)

应[oywoywoyw](http://hi.csdn.net/oywoywoyw) 要求，将该配置上传于

[http://abloz.com/downloads/srcinsight_vc_style.cf3](http://abloz.com/downloads/srcinsight_vc_style.cf3)
