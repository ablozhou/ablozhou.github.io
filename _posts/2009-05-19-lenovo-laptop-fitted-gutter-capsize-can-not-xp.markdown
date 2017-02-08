---
author: abloz
comments: true
date: 2009-05-19 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/05/19/lenovo-laptop-fitted-gutter-capsize-can-not-xp/
slug: lenovo-laptop-fitted-gutter-capsize-can-not-xp
title: 阴沟里翻船 联想笔记本装不了XP？
wordpress_id: 907
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文

老婆公司里一台SL500  笔记本，装了vista，慢的要死。老婆拿回来让我装个xp。我心想这种事对我来说杀鸡牛刀。为了老婆，只好浪费点时间。为此，亲自为老婆做了一个自己定 制的ghost安装盘。安装界面和oem信息都是老婆的。并且告诉老婆，半小时之内安装完成。

但事实是我花了一整个晚上来安装，搞的手忙脚乱，大汗淋漓。vista被我删了，硬盘被我格式化了，但就是装不上。

刚开始对DVD根本进不了启动菜单，进入前光标后就死了。后面刻了CD格式，进入了启动菜单。但ghost进不了。而且发现不了光驱，找不到ghost的.sno文件。

按F1进入Bios，也注意到什么问题。老婆看我平时挺牛叉的样子，问你装不上那怎么办？不会要赔公司电脑吧？我说还不至于。

又找到以前的非ghost xp的CD安装盘，不过是xp sp2的。装到一截总是蓝屏。真是郁闷啊。

正不知所措，想起以前给一个同事thinkpad X61笔记本装系统，也总装不上。后面发现是sata模式和IDE模式的问题。在Bios中修改为兼容模式。这下，DVD ghost的盘进入安装菜单了。

刚高兴了一下，发现还是不行。因为进入ghost界面后就死了。无论怎么试都不行。

到网上找了一下，有人说，必须进入dos，用ghost -noide命令来安装。一试果然成功。终于给老婆有个交待了。免得在老婆面前丢脸，老婆又在同事面前丢脸。

![oem](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20090520/oem.PNG)

oem信息

![support](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20090520/oem2.PNG)

技术支持信息

 

装个xp系统花了整整一晚上，还搭上白天的准备，真是够壮观的了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=433d4522-6c4b-853f-9d1a-e088d0faffa5)
