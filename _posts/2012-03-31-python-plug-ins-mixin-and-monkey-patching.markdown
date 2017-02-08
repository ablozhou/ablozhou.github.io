---
author: abloz
comments: true
date: 2012-03-31 09:31:56+00:00
layout: post
link: http://abloz.com/index.php/2012/03/31/python-plug-ins-mixin-and-monkey-patching/
slug: python-plug-ins-mixin-and-monkey-patching
title: python插件方式mixin和monkey-patching
wordpress_id: 1536
categories:
- 技术
tags:
- mixin
- monkey-patching
- python
---

#http://abloz.com
#author:ablozhou
#date:2012.3.31

python可以用mixin方式做插件。limodou著名的ulipad python编辑器就采用这种插件机制。mixin是一个类，该类的一些属性和方法，可以传给继承的类。一些支持多继承的面向对象脚本语言，可以将某种属性采用多继承方式，让一个继承类具有mixin类的属性和方法。据[维基百科](http://en.wikipedia.org/wiki/Mixins)所说，最早使用mixin的是lisp的扩展语言[flavor](http://en.wikipedia.org/wiki/Flavors_%28computer_science%29#cite_note-0)。支持的脚本语言也相当多，如ruby,javascript等。参考《[Mixin 扫盲班](http://blog.csdn.net/lanphaday/article/details/1656969)》赖勇浩blog.csdn.net/lanphaday/article/details/1656969
但有人反对采用mixin机制，因为多继承会引起[mro(Method Resolution Order)](http://www.python.org/getit/releases/2.3/mro/)问题。

monkey-patching 不知为何叫这名字，“猴子补丁”？估计有其文化来源。但具体意思是一种在动态语言中修改执行代码的方式，如Smalltalk, JavaScript, Objective-C, Ruby, Perl, Python, Groovy等语言，不必修改原始代码。

gevent的异步socket，就采用猴子补丁。


```

from gevent import monkey

monkey.patch_all()

```

具体打猴子补丁方式：
#module ma
class A:
 def do_sth(self):
    pass

import ma
class MonkeyPatchA:
  def do_sth(self):
    pass

ma.A = MonkeyPatchA

这样将类替换掉了。
**参考**：
http://www.yosefk.com/blog/machine-code-monkey-patching.html
http://www.python.org/getit/releases/2.3/mro/
http://blog.csdn.net/lanphaday/article/details/1656969
