---
author: abloz
comments: true
date: 2012-04-17 09:31:35+00:00
layout: post
link: http://abloz.com/index.php/2012/04/17/bash-kuai-jie-jian/
slug: bash-kuai-jie-jian
title: bash 快捷键
wordpress_id: 1549
categories:
- 技术
tags:
- bash
- 快捷键
---

http://abloz.com
date:2012.4.17

bash 操作用快捷键会快很多。但bash快捷键和vi不一样。可以记住如下几条命令。其他可以在man bash中查找Commands for Moving，Commands for Manipulating the History等。

**命令历史：**
history 显示命令历史列表
↑ 显示上一条命令
↓ 显示下一条命令
!num 执行命令历史列表的第num条命令
!! 执行上一条命令
!ls 执行最后一个以ls开头的命令
Ctrl+r 然后输入若干字符，开始向上搜索包含该字符的命令，继续按Ctrl+r，搜索上一条匹配的命令
ls !$ 执行命令ls，并以上一条命令的参数为其参数
Alt+. 上一个命令的最后一个参数，每按一次换为更上一个命令。
如
[zhouhh@Hadoop48 ~]$ mkdir -p very/long/dir
接下来，可以用cd Alt+. 命令
会替换为cd very/long/dir
[zhouhh@Hadoop48 ~]$ cd very/long/dir


**移动：**
Ctrl+a 移动到当前行的开头
Ctrl+e 移动到当前行的结尾

Alt+b 移动到当前单词的开头. 但我在操作中发现和linges的快捷键有冲突，关闭linges正常。
Alt+f   移动到当前单词的结尾

**编辑：**
Ctrl+l   清屏

Ctrl+u 删除命令行中光标所在处之前的所有字符（不包括自身）
Ctrl+k 删除命令行中光标所在处之后的所有字符（包括自身）

Ctrl+w 删除光标所在处之前的字符至其单词头（以空格、标点等为分隔符）
Alt+d   删除从光标当前位置，到当前word的结尾字符

Ctrl+y 粘贴刚才所删除的字符

**其他(不常用技巧，可不记)：**
Ctrl+t 颠倒光标所在处及其之前的字符位置，并将光标移动到下一个字符
Alt+t  颠倒两个单词，并移动光标到下一个单词

Ctrl+d 删除光标所在处字符
Ctrl+h 删除光标所在处前一个字符
set -o vi 设置vi模式
