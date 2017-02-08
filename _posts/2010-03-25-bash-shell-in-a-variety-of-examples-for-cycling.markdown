---
author: abloz
comments: true
date: 2010-03-25 07:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/25/bash-shell-in-a-variety-of-examples-for-cycling/
slug: bash-shell-in-a-variety-of-examples-for-cycling
title: bash shell的for循环的各种示例
wordpress_id: 1179
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

 

先确定shell是bash：

 

zhouhh@zhh64:~$ echo $SHELL  
/bin/bash

zhouhh@zhh64:~$ ps  
PID TTY TIME CMD  
2761 pts/1 00:00:00 bash  
5125 pts/1 00:00:00 ps

 

bash shell的for循环的各种示例：

zhouhh@zhh64:~$ vi ./testfor.sh

输入：

#/bin/bash  
# author: <a title="" href="http://blog.csdn.net/ablo_zhou" target="_blank">周海汉</a>  
# date :2010.3.25  
# blog.csdn.net/ablo_zhou  
arr=("a" "b" "c")  
echo "arr is (${arr[@]})"  
echo "item in array:"  
for i in ${arr[@]}  
do  
echo "$i"  
done  
echo "参数,$*表示脚本输入的所有参数："  
for i in $* ;   
do  
echo $i  
done  
echo  
echo '处理文件 /proc/sys/net/ipv4/conf/*/accept_redirects：'  
for File in /proc/sys/net/ipv4/conf/*/accept_redirects; do  
echo $File  
done  
echo "直接指定循环内容"  
for i in f1 f2 f3 ;do  
echo $i  
done  
echo   
echo "C 语法for 循环:"  
for (( i=0; i<10; i++)); do  
echo $i  
done   
  


zhouhh@zhh64:~$ ./testfor.sh p1 p2 p3  
arr is (a b c)  
item in array:  
a  
b  
c  
参数,$*表示脚本输入的所有参数：  
p1  
p2  
p3

 

处理文件 /proc/sys/net/ipv4/conf/*/accept_redirects：  
/proc/sys/net/ipv4/conf/all/accept_redirects  
/proc/sys/net/ipv4/conf/default/accept_redirects  
/proc/sys/net/ipv4/conf/eth0/accept_redirects  
/proc/sys/net/ipv4/conf/lo/accept_redirects  
/proc/sys/net/ipv4/conf/vboxnet0/accept_redirects  
/proc/sys/net/ipv4/conf/virbr0/accept_redirects

  
直接指定循环内容  
f1  
f2  
f3  
  
C 语法for 循环:  
0  
1  
2  
3  
4  
5  
6  
7  
8  
9

  
在shell命令直接输入for循环：

zhouhh@zhh64:~$ for i in a b c ; do echo $i ; done  
a  
b  
c

  
  


![](http://img.zemanta.com/pixy.gif?x-id=9650f56f-1700-8d20-a9c0-288626a52e9e)
