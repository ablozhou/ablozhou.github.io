---
author: abloz
comments: true
date: 2013-08-06 12:25:52+00:00
layout: post
link: http://abloz.com/index.php/2013/08/06/comprehend-erlang/
slug: comprehend-erlang
title: erlang领悟
wordpress_id: 2200
categories:
- 技术
tags:
- erlang
---

abloz.com

周海汉 /文 2013.8.6

erlang作为著名的并发编程语言，在大规模并发计算上很独到。但它的怪异的语法和独特的约定，让学习曲线很陡。OTP意思是open telecom platform.



1.编译安装：

很中规中矩，一点不特殊。





wget [http://www.erlang.org/download/otp_src_R16B01.tar.gz](http://www.erlang.org/download/otp_src_R16B01.tar.gz)




./configure




make




sudo make install







erl shell






    
    strider 1> erl
    Erlang (BEAM) emulator version 5.3 [hipe] [threads:0]
    
    Eshell V5.3  (abort with ^G)
    1>Str = "abcd".
    "abcd"
    2> L = length(Str).
    4
    3> Descriptor = {L, list_to_atom(Str)}.
    {4,abcd}
    4> L.
    4
    5> b().
    Descriptor = {4,abcd}
    L = 4
    Str = "abcd"
    ok
    6> f(L).
    ok
    7> b().
    Descriptor = {4,abcd}
    Str = "abcd"
    ok
    8> f(L).
    ok
    9> {L, _} = Descriptor.
    {4,abcd}
    10> L.
    4
    11> {P, Q, R} = Descriptor.
    ** exception error: no match of right hand side value {4,abcd}
    12> P.
    * 1: variable 'P' is unbound **
    13> Descriptor.
    {4,abcd}
    14>{P, Q} = Descriptor.
    {4,abcd}
    15> P.
    4
    16> f().
    ok
    17> put(aa, hello).
    undefined
    18> get(aa).
    hello
    19> Y = test1:demo(1).
    11
    20> get().
    [{aa,worked}]
    21> put(aa, hello).
    worked
    22> Z = test1:demo(2).
    ** exception error: no match of right hand side value 1
         in function  test1:demo/1
    23> Z.
    * 1: variable 'Z' is unbound **
    24> get(aa).
    hello
    25> erase(), put(aa, hello).
    undefined
    26> spawn(test1, demo, [1]).
    <0.57.0>
    27> get(aa).
    hello
    28> io:format("hello hellon").
    hello hello
    ok
    29> e(28).
    hello hello
    ok
    30> v(28).
    ok
    31> c(ex).
    {ok,ex}
    32> rr(ex).
    [rec]
    33> rl(rec).
    -record(rec,{a,b = val()}).
    ok
    34> #rec{}.
    ** exception error: undefined shell command val/0
    35> #rec{b = 3}.
    #rec{a = undefined,b = 3}
    36> rp(v(-1)).
    #rec{a = undefined,b = 3}
    ok
    37> rd(rec, {f = orddict:new()}).
    rec
    38> #rec{}.
    #rec{f = []}
    ok
    39> rd(rec, {c}), A.
    * 1: variable 'A' is unbound **
    40> #rec{}.
    #rec{c = undefined}
    ok
    41> test1:loop(0).
    Hello Number: 0
    Hello Number: 1
    Hello Number: 2
    Hello Number: 3
    
    User switch command
     --> i
     --> c
    .
    .
    .
    Hello Number: 3374
    Hello Number: 3375
    Hello Number: 3376
    Hello Number: 3377
    Hello Number: 3378
    ** exception exit: killed
    42> E = ets:new(t, []).
    17
    43> ets:insert({d,1,2}).
    ** exception error: undefined function ets:insert/1
    44> ets:insert(E, {d,1,2}).
    ** exception error: argument is of wrong type
         in function  ets:insert/2
            called as ets:insert(16,{d,1,2})
    45> f(E).
    ok
    46> catch_exception(true).
    false
    47> E = ets:new(t, []).
    18
    48> ets:insert({d,1,2}).
    * exception error: undefined function ets:insert/1
    49> ets:insert(E, {d,1,2}).
    true
    50> halt().
    strider 2>
    
    感受：
    erlang 结束语句是句号"."。所以初次使用shell像python那样用不会有任何提示，也不报错。因为没有输入点好结束。
    其变量是大写开头，并且绑定后不能改变内容。
    pid!msg 表示往pid进程发送msg。-> 可以认为是函数定义，类似于C语言的大括号。
    
    命令行用到的两个程序：







[hadoop@hs11 erl]$ cat test1.erl
-module(test1).
-export([demo/1, loop/1]).

demo(X) ->
put(aa,hello),
X + 10.


loop(N) ->
io:format("Hello Number: ~w~n",[N]),
loop(N+1).







[hadoop@hs11 erl]$ cat math1.erl
-module(math1).
-export([fib/1, fac/1]).

fib(0)->1;
fib(1)->1;
fib(N)->fib(N-1)+fib(N-2).

fac(0)->1;
fac(N)->N*fac(N-1).















