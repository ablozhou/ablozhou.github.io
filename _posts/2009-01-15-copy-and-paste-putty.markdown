---
author: abloz
comments: true
date: 2009-01-15 03:52:38+00:00
layout: post
link: http://abloz.com/index.php/2009/01/15/copy-and-paste-putty/
slug: copy-and-paste-putty
title: putty的复制和粘贴
wordpress_id: 345
categories:
- 技术
tags:
- pietty
- putty
- 复制
- 粘贴
---

周海汉/文 2009.1.16
ablozhou # gmail.com
[http://blog.csdn.net/ablo_zhou](http://blog.csdn.net/ablo_zhou)

本文是putty/pietty操作的tips，可以让操作提高效率。因为复制粘贴经常使用，比重新敲入要方便许多。putty的粘贴可以配置为鼠标中键或右键，此文假设为右键。（某些环境下配置不一样，对应本文中的右键和中键切换）


### **1.在windows中复制往putty中粘贴**


windows中复制：直接选中文本，按Ctrl+C。
putty中粘贴：鼠标右键

》vi 中的复制粘贴问题
但对于vi编辑有点特殊。粘贴前应位于插于模式，不像vi快捷键P，是命令模式下的粘贴。粘贴的位置是光标所在的位置，而不是鼠标点的位置。
如果vim里有set ai （auto indent）或者set cindent,对于格式化文本，粘贴时可能导致前面不断叠加空格，使格式完全错乱。那么在.vimrc里加一句set paste，即可正确粘贴格式化文本。


### **2. putty 复制**


putty用鼠标左键选中即已经放到剪贴板。选中后即可在windows的其他编辑器或输入栏按Ctrl+V 粘贴。往putty粘贴直接点鼠标右键。

》putty选择并复制小技巧
鼠标左键按住拖拉选择，即已经复制。
双击鼠标左键，选择复制一个单词，支持中文。双击并在第二次按下时不放，拖动鼠标左键，会按单词选择。
鼠标三击，会选择并复制一行。鼠标三击并在最后一击时拖动，会按行选择。
按住左Alt，拖动鼠标左键，会选择方块。但putty菜单的windows（窗口）->move hotkey（移动热键）的左Alt+左键拖动应取消。
选择完了要补选复制，可以按下中键并拖动。补选方式和此前的选择方式一样，单击的补选是按字母，双击的补选是按单词。三击的补选是按行。窗口选择的补选是窗口选择。
