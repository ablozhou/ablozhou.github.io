---
author: abloz
comments: true
date: 2010-09-14 02:38:33+00:00
layout: post
link: http://abloz.com/index.php/2010/09/14/ubuntu-10-04-wrong-button-function-keys/
slug: ubuntu-10-04-wrong-button-function-keys
title: ubuntu 10.04 的功能键按键错误
wordpress_id: 396
categories:
- 技术
tags:
- bug
- gnome
- linux
- vim
- xterm
---

周海汉 2010.9.14

ubuntu 10.04在gnome-terminal中使用vim时，如果使用ctrl+f2,ctrl+f3,ctrl+f4,会插入1;5Q 1;5R 1;5S,开始以为是vim配的键映射有问题。但检查发现没有问题。后面发现在gvim中输入同样的按键，则不会有上述问题。而在gnome-terminal和xterm中输入上述组合键，同样会有类似的输入。


    
    
    zhouhh@zhh64:~$ echo $TERM
    xterm
    按C-F2,C-F3,C-F4得到的输入：
    zhouhh@zhh64:~$ ;5Q;5R;5S
    在dash中：
    zhouhh@zhh64:~$ sh
    $ ls -l /bin/sh
    lrwxrwxrwx 1 root root 4 2010-05-05 09:34 /bin/sh -> dash
    输入C-F2,C-F3,C-F4得到的输入：
    $ ^[O1;5Q^[O1;5R^[O1;5S
    



不知道在哪里可以配置该键映射。搜索网上有人提交bug，可能是gnome-terminal和xterm的bug。在centos 5上也有同样的问题。
ubuntu bug：
https://bugs.launchpad.net/ubuntu/+source/xterm/+bug/96676

该bug会给vim设置键盘映射时带来很大困惑，因为如果映射C-F2,C-F3,C-F4不会生效。
