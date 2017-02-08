---
author: abloz
comments: true
date: 2012-06-28 03:43:07+00:00
layout: post
link: http://abloz.com/index.php/2012/06/28/interesting-in-erlang/
slug: interesting-in-erlang
title: 有趣的erlang
wordpress_id: 1727
categories:
- 技术
tags:
- erlang
---

来源：http://abloz.com  
author:ablozhou  
date: 2012-06-28

  


erlang语言以函数式编程和并发编程著称。它是从爱立信公司出来的，随着多核和并发编程，云计算越来越多，而逐渐占有一席之地。

它有很多死板的规定。如：变量以大写开头，变量不可更改，用递归代替循环等。习惯了c/c++这类语言的工程师，的确需要时间来转这个弯。

  


## 安装：

[zhouhh@Hadoop48 ~]$ sudo yum install  erlang  


或者在ubuntu下用apt-get install erlang

## 启动shell

[zhouhh@Hadoop48 ~]$ erl

Erlang (BEAM) emulator version 5.6.5 [source] [64-bit] [smp:2] [async-threads:0] [hipe] [kernel-poll:false]

  


Eshell V5.6.5  (abort with ^G)

1>

最新版erlang是V5.8.1

## 计算器：

1> 3+2.

5

3> 1/3.

0.3333333333333333

4> q().

ok

注意，每个语句用.结束。

## 编写erlang文件

计算阶乘。  


[zhouhh@Hadoop48 ~]$ vi test1.erl  

    
    -module(test1).
    -export([fac/1]).
    
    fac(1)->1;
    fac(N)->fac(N-1)*N.

-module是模块名，类似java，python的包名。-export表示输出的函数列表。 第4行第5行，表示根据条件轮流执行。 如果输入是1，则返回1.如果输入是一个数字，则递归调用，直到1为止。

shell中执行：
    
    1> c(test1).
    {ok,test1}
    2> test1:fac(10).
    3628800
    3> test1:fac(100).
    93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000
    4>

c()表示编译。调用时，用“模块名:函数().”方式。

  


[zhouhh@Hadoop48 ~]$ vi counter.erl
    
    -module(counter).
    -export([start/0, stop/1]).
    -export([inc/1, dec/1, reset/1, current/1]).
    
    start() ->
        spawn(fun() -> loop(0) end).
    
    stop(Pid) ->
    Pid ! stop.
    
    inc(Pid) ->
        Pid ! inc.
    
    dec(Pid) ->
        Pid ! dec.
    
    reset(Pid) ->
        Pid ! reset.
    
    current(Pid) ->
        Pid ! {current, self()},
        receive
            Any -> Any
        end.
    
    loop(Count) ->
        receive
            stop -> ok;
            inc -> loop(Count + 1);
            dec -> loop(Count - 1);
            reset -> loop(0);
            {current, Pid} ->
                Pid ! Count,
                loop(Count)
        end.

该模块采用进程方式工作。spawn生成进程，fun()是匿名函数，执行loop(0).

stop,inc,dec,reset,current,loop等是函数。Pid是变量。Pid!inc表示对Pid进程执行inc函数。receive表示接到进程消息，然后用正则来匹配。Any表示任何消息。所以loop函数，匹配stop,inc,dec,reset等。

  


执行：

  

    
    Eshell V5.6.5  (abort with ^G)
    1>  c(counter).
    {ok,counter}
    2> Pid=counter:start().
    <0.55.0>
    5> counter:current(Pid).
    0
    
    6> counter:inc(Pid).
    inc
    7> counter:inc(Pid).
    inc
    8> counter:current(Pid).
    2
    9> counter:dec(Pid).
    dec
    10> counter:current(Pid).
    1
    11> counter:reset(Pid).
    reset
    12> counter:current(Pid).
    0
    13> counter:stop(Pid).
    stop

## 命令行快捷方式

使用emacs行编辑命令  


◆^P 获取上一行。  
  
◆^N 获取下一行。  
  
◆^A 将输入焦点移动到当前行首。  
  
◆^E 将输入焦点移动到当前行尾首。  
  
◆^D 删除当前光标所在的字符。  
  
◆^F 向前移动一个字符。  
  
◆^B 向后移动一个字符。  
  
◆回车 执行当前命令。

请注意: ^X 表示Control + X 。尝试按下Control+P，看看什么会发生？

## 参考：

[http://learnyousomeerlang.com](http://learnyousomeerlang.com/)   


[http://www.erlang.org](http://www.erlang.org/)   

