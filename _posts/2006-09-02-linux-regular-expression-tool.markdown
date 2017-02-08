---
author: abloz
comments: true
date: 2006-09-02 08:17:34+00:00
layout: post
link: http://abloz.com/index.php/2006/09/02/linux-regular-expression-tool/
slug: linux-regular-expression-tool
title: linux 正则表达式工具
wordpress_id: 175
categories:
- 技术
tags:
- awk
- cut
- grep
- linux
- regex
---

**1.grep & egrep**


    
    
    [zhouhh@etel ~]$  vi test1
    
    line 1
    hello, I'm line 2
    line 3
    this is line 4
    


保存

    
    
    [zhouhh@etel ~]$ cat test1 | grep hello
    hello, I'm line 2
    [zhouhh@etel ~]$ grep hello < test1
    hello, I'm line 2
    [zhouhh@etel ~]$ grep hello test1
    hello, I'm line 2
    


grep不支持+,故不显示结果

    
    
    [zhouhh@etel ~]$ grep '^.+line [0-9]$' test1
    [zhouhh@etel ~]$ egrep '^.+line [0-9]$' test1
    hello, I'm line 2
    this is line 4
    


使用-v反转输出

    
    
    [zhouhh@etel ~]$ grep '^line' test1
    line 1
    line 3
    [zhouhh@etel ~]$ grep -v '^line' test1
    hello, I'm line 2
    this is line 4
    


 2. sed 流编辑器,接受输入流并加以修改,可以修改标准输入流 使用管道将文本做为输入.

s表示替换,"/"表示分隔符,""表示转义符g表示尽可能多的匹配,缺省是一行只匹配第一个.下面的sed命令将l替换为空

    
    
    [zhouhh@etel ~]$ echo "hello" | sed 's/l//g'
    heo
    


-n参数让sed不显示输出,用p选项打印匹配的行,下面的命令为了找到IP地址
[zhouhh@etel ~]$ /sbin/ifconfig eth0 | sed -n '/inet addr/p'
          inet addr:192.168.0.200  Bcast:192.168.255.255  Mask:255.255.0.0

匹配.*inet addr:开头的行,将接下来的字符串匹配任何非空格的部分,用向前引用参数1 "1"打印,得到IP

    
    
    [zhouhh@etel ~]$ /sbin/ifconfig eth0 | sed -n 's/.*inet addr:([^ ]*).*/1/p'
    192.168.0.200
    


3.awk 可以完成sed可以完成的所有事情,而且更强大,通常用作cut命令的豪华版本.

打印所有用户名

    
    
    [zhouhh@etel ~]$ cut -d: -f1 /etc/passwd
    root
    bin
    daemon
    adm
    lp
    sync
    shutdown
    halt
    mail
    ....
    


-d 定义分隔符为":", -f1打印第一个字段.

用awk做同样的事情:

    
    
    [zhouhh@etel ~]$ awk -F: '{print $1}' /etc/passwd
    root
    bin
    daemon
    adm
    lp
    sync
    shutdown
    halt
    mail
    ......
    


-F重载分隔符为":", {Print $1}是一个awk程序.

cut只能匹配单个分隔符,awk可以匹配多个空格和tab. 如要打印进程号:

    
    
    [zhouhh@etel ~]$ ps -ef
    UID        PID  PPID  C STIME TTY          TIME CMD
    root         1     0  0 Aug29 ?        00:00:00 init [5]
    root         2     1  0 Aug29 ?        00:00:00 [ksoftirqd/0]
    root         3     1  0 Aug29 ?        00:00:00 [events/0]
    
    [zhouhh@etel ~]$ ps -ef | awk '{print $2}'
    PID
    1
    2
    3
    
