---
author: abloz
comments: true
date: 2010-04-13 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/04/13/vim-highlight-generate-html/
slug: vim-highlight-generate-html
title: vim 生成html 高亮
wordpress_id: 1205
categories:
- 技术
---

周海汉 /文  
2010.4.11  
http://blog.csdn.net/ablo_zhou

为了将vim的高亮语法通过html显示在网页上，可以将高亮语法文件直接导出到html。

在gvim中，具有gui，有菜单可以保存为html。

在vim的字符界面中，如何保存为html呢？

首先需要设置正确的filetype，以显示正确的高亮。也可以调整颜色为自己喜欢的形式。然后通过命令行保存html.

下面提供两个命令，效果一样。

1.可在vim中执行命令

:source $VIMRUNTIME/syntax/2html.vim

2.可在vim中执行命令

:runtime! syntax/2html.vim

或

:run! syntax/2html.vim

2html.vim不是syntax而是script

3.更简单的plugin命令

:TOhtml

可能会花一点时间。执行完后，再执行:wq，就会以原文件.html的方式保存html文件了。

可以查看帮助：

:help 2html

:help TOhtml

示例：

本来csdn的blog也支持python语法高亮，但必须放到一个插入代码的框架里。如何直接显示语法高亮或自定义的语法高亮呢？

进入html源码编辑，将生成的html源码的关键部分插入。这实用于很多blog。

#: c01:BorgSingleton.py    
# Alex Martelli's 'Borg'    
  
class   Borg  :  
_shared_state = {}  
def   __init__  (self):  
self.__dict__ = self._shared_state  
  
class   Singleton  (Borg):  
def   __init__  (self, arg):  
Borg.__init__(self)  
self.val = arg  
def   __str__  (self): return   self.val  
  
x = Singleton('sausage  ')  
print   x  
y = Singleton('eggs  ')  
print   y  
z = Singleton('spam  ')  
print   z  
print   x  
print   y  
print   'x  '  
  
 

不过生成的html颜色和在终端中看到的还是用差异。所以我的示例在白色背景下看不太清。最好是定义为深色背景。

拷贝到csdn时，将
    
    <<span class="start-tag">body</span>
    <span class="attribute-name"> bgcolor</span>
    =<span class="attribute-value">"#000000" </span>
    <span class="attribute-name">text</span>
    =<span class="attribute-value">"#ffffff"</span>
    >
    
    改为<div style="background:#000000;color:#ffffff"> </div>
    
    如下：
    
    
    
    

#: c01:BorgSingleton.py    
# Alex Martelli's 'Borg'    
  
class   Borg  :  
_shared_state = {}  
def   __init__  (self):  
self.__dict__ = self._shared_state  
  
class   Singleton  (Borg):  
def   __init__  (self, arg):  
Borg.__init__(self)  
self.val = arg  
def   __str__  (self): return   self.val  
  
x = Singleton('sausage  ')  
print   x  
y = Singleton('eggs  ')  
print   y  
z = Singleton('spam  ')  
print   z  
print   x  
print   y  
print   'x  '  
  
 

					  
  


![](http://img.zemanta.com/pixy.gif?x-id=5f11777f-7cc5-8066-8af7-a09733635e2e)
