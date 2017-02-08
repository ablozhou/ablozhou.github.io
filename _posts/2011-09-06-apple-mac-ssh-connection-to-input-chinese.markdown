---
author: abloz
comments: true
date: 2011-09-06 12:28:28+00:00
layout: post
link: http://abloz.com/index.php/2011/09/06/apple-mac-ssh-connection-to-input-chinese/
slug: apple-mac-ssh-connection-to-input-chinese
title: 苹果mac ssh连接如何输入中文？
wordpress_id: 1393
categories:
- 技术
tags:
- mac
---

客户机windows7，使用pietty ssh方式连接苹果，发现命令行无法输入中文。要么无法输入，要么输入成为-----，或转为tab键了。

解决办法：

新建一个.inputrc，输入

    
    set convert-meta off
    set meta-flag on
    set output-meta on


此时能输入中文，但不能正确显示。

    
    MacBook-Pro:~ zhh$ ls -a
    %D6%D0%CE%C4
    
    .bash_history           Documents               Pictures                ??????


locale查看一下：

    
    MacBook-Pro:~ zhh$ locale
    LANG=
    LC_COLLATE="C"
    LC_CTYPE="C"
    LC_MESSAGES="C"
    LC_MONETARY="C"
    LC_NUMERIC="C"
    LC_TIME="C"
    LC_ALL=


export LANG="zh_CN.UTF-8"

将pietty 的编码设为UTF-8

即可输入和查看中文。

    
    MacBook-Pro:~ zhh$ ls
    
    Documents       Library         Music           Public                    中文


参考：

[http://blog.lauct.org/archives/864](http://blog.lauct.org/archives/864)
