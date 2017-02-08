---
author: abloz
comments: true
date: 2010-05-05 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/05/05/window-close-button-to-adjust-the-position-of-ubuntu10-04/
slug: window-close-button-to-adjust-the-position-of-ubuntu10-04
title: 调整ubuntu10.04 窗口关闭按钮的位置
wordpress_id: 1220
categories:
- 技术
---

周海汉/文

  
2010.5.5

 

升级到ubuntu10.04后，且不说汉字的虚化，看起来不够舒服。最大的问题，是最小最大和关闭按钮，放到了左边。这叫ubuntu的MAC 化。这给操作带来了很大的不便。大部分的theme的窗口关闭按钮都放到左边去了。每次有窗口操作，不得不左右寻找，降低了效率。

 

如鲠在喉，必须把他修改回去。查到些资料，操作如下：

 

1. ALT+F2，在运行应用程序里输入gconf-editor，确定。（或在命令行上输入gconf-editor）

2.gconf-editor类似windows的注册表编辑器，从根/往下展开，可以看到一颗树。进入/apps/metacity/general，右边有个button_layout的设置项，如图：

  

![](http://hi.csdn.net/attachment/201005/5/0_12730533832i5K.gif)

 

双击，在弹出对话框中修改close,minimize,maxmize:为menu:minimize,maxmize,close

即改变了窗口关闭，最大最小的按钮位置。

![](http://hi.csdn.net/attachment/201005/5/0_12730535344zT4.gif)

 

补充：

_[liudongbaollz](http://hi.csdn.net/liudongbaollz) 回复：_
    _  
_
    _补充图形化调整方案： 菜单路径：system->prefrences->appearance 选择一个你喜欢的风格即可。_
      

    中文系统下即“系统->首选项->外观”，或在桌面上点右键“更改桌面背景”， 可以修改主题。某些主题的关闭按钮的确是在右边的。但大多数系统主题都在左边。而且就算做了我文中的修改，在切换主题后会恢复成原样，需要重复上面的步骤。  


参考：

[http://www.howtogeek.com/howto/13535/move-window-buttons-back-to-the-right-in-ubuntu-10.04/](http://www.howtogeek.com/howto/13535/move-window-buttons-back-to-the-right-in-ubuntu-10.04/)

[http://linux.cn/home/space-5230-do-thread-id-2736.html](http://linux.cn/home/space-5230-do-thread-id-2736.html)

  
  


![](http://img.zemanta.com/pixy.gif?x-id=a0eb3e1a-723d-86dc-9c65-c911a05b4c48)
