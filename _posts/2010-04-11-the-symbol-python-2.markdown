---
author: abloz
comments: true
date: 2010-04-11 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/04/11/the-symbol-python-2/
slug: the-symbol-python-2
title: python 中的@符号
wordpress_id: 1201
categories:
- 技术
---

周海汉 /文  
2010.4.11  
http://blog.csdn.net/ablo_zhou

  
python 2.4以后，增加了@符号修饰函数对函数进行修饰，python3.0/2.6又增加了对类的修饰。  
我现在使用的python版本，支持对class的修饰：  
zhouhh@zhouhh-home:~$ python  
Python 2.6.4 (r264:75706, Dec 7 2009, 18:45:15)  
[GCC 4.4.1] on linux2  
Type "help", "copyright", "credits" or "license" for more information.  
@修饰符挺像是处理函数或类之前进行预处理。

 

## 语法示例：

 @dec1  
@dec2  
def test(arg):  
pass

  
其效果类似于  
dec1(dec2(test(arg)))  
修饰函数还可以带参数。  
@dec1(arg1,arg2)  
def test(testarg)  
效果类似于  
dec1(arg1,arg2)(test(arg))

##   用法示例

 **示例1 参数类型和返回值类型检查**

对于python这样的动态语言，不像C++这样的一开始就有严格静态的类型定义。但是，在某些情况下，就需要这样的类型检查，那么可以采用＠修饰的方式。下面的示例就是检查输入参数类型和返回值类型的例子。

 

#!/usr/bin/env python    
#coding:utf8    
def   accepts  (*  types)  :  
def   check_accepts  (  f)  :  
assert   len  (  types)   ==   f.  func_code.  co_argcount  
def   new_f  (*  args,   **  kwds)  :  
for   (  a,   t)   in   zip  (  args,   types)  :  
assert   isinstance  (  a,   t),      
"arg %r does not match %s  " % (  a,  t)    
return   f(*  args,   **  kwds)    
new_f.  func_name =   f.  func_name  
return   new_f  
return   check_accepts  
  
def   returns  (  rtype)  :  
def   check_returns  (  f)  :  
def   new_f  (*  args,   **  kwds)  :  
result =   f(*  args,   **  kwds)    
assert   isinstance  (  result,   rtype),      
"return value %r does not match %s  " % (  result,  rtype)    
return   result  
new_f.  func_name =   f.  func_name  
return   new_f  
return   check_returns  
  
@  accepts  (  int  ,   (  int  ,  float  ))    
@  returns  ((  int  ,  float  ))    
def   func  (  arg1,   arg2)  :  
return   arg1 *   arg2  
  
if   __name__ ==   '__main__  ':  
a =   func(  3  ,  'asdf  ')    
 

 

zhouhh@zhouhh-home:~$ ./checktype.py   
Traceback (most recent call last):  
File "./checktype.py", line 27, in <module>  
@returns((int,float))  
File "./checktype.py", line 5, in check_accepts  
assert len(types) == f.func_code.co_argcount  
AssertionError

 

其实，xml-rpc中，对于函数参数，返回值等都需要采用xml的方式传递到远程再调用，那么如何检查类型呢？就可以用到如上的＠修饰符。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=9f49a1bf-4330-8c54-8f60-e3618a689ac5)
