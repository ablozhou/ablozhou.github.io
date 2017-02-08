---
author: abloz
comments: true
date: 2010-04-22 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/04/22/the-next-fun-linux-sfx-script/
slug: the-next-fun-linux-sfx-script
title: linux下一个好玩的自解压脚本
wordpress_id: 1213
categories:
- 技术
---

周海汉 /文

2010.4.22

 

看集群的东西时无意中看到几年前流行的分布式科学计算seti@home，美国伯克利大学等科学界用于计算天体数据的。[SETI@home ](http://setiathome.berkeley.edu/) 是一项利用全球联网的计算机共同搜寻地外文明（SETI）的科学实验计划。你可以通过运行一个免费程序下载并分析从射电望远镜传来的数据来加入这个项目。 不过我再次使用其客户端时，居然说没有计算任务。看来外太空探索在美国也不受重视了。

 

SETI@home的客户端 [BOINC 软件](http://boinc.berkeley.edu/download.php) ，linux下是一个sh脚本。有意思的是该脚本有4M多。我想什么脚本这么大啊？

下下来执行一下，居然在目录下生成一堆东西。原来该脚本是个自解压脚本。

 

分析了一下，自己并仿做了一个。

 

脚本前三行：

先建一个目录test，并塞入一些要打包的东西

zhouhh@zhh64:~/test$ ls  
sendmail.py test.c testfor.sh 

zhouhh@zhh64:~/test$ vi test.sh

输入：

#!/bin/sh  
( read l; read l; read l ;exec cat ) < "$0" | gunzip | tar xf - && ls -l  
exit  
保存，并改为可执行属性。

该脚本的意思，三个read l，随后一个cat,其实是读取test.sh的前三行，并丢弃。即将该脚本的三行不做处理。从第四行开始，送给gunzip，再送给tar解压，最后显示解压的结果。

 

zhouhh@zhh64:~/test$ tar -zcvf data.tar.gz *  
sendmail.py  
test.c  
testfor.sh  
test.sh

zhouhh@zhh64:~/test$ ls  
data.tar.gz sendmail.py test.c testfor.sh test.sh

此时看到有一个tar.gz文件。

将其放到test.sh中：

zhouhh@zhh64:~/test$ cat data.tar.gz >> test.sh

zhouhh@zhh64:~/test$ ls -lh test.sh  
-rwxr-xr-x 1 zhouhh zhouhh 1.4K 2010-04-22 17:04 test.sh

此时脚本有1.4k了。

新建个目录去做实验：

zhouhh@zhh64:~/test$ mkdir data  
zhouhh@zhh64:~/test$ mv test.sh data  
zhouhh@zhh64:~/test$ cd data  
zhouhh@zhh64:~/test/data$ ls  
test.sh  
zhouhh@zhh64:~/test/data$ ./test.sh  
总用量 16  
-rwxr-xr-x 1 zhouhh zhouhh 975 2010-04-12 16:50 sendmail.py  
-rw-r--r-- 1 zhouhh zhouhh 92 2010-04-22 12:06 test.c  
-rwxr-xr-x 1 zhouhh zhouhh 558 2010-03-25 11:20 testfor.sh  
-rwxr-xr-x 1 zhouhh zhouhh 88 2010-04-22 16:49 test.sh  
zhouhh@zhh64:~/test/data$ ls  
sendmail.py test.c testfor.sh test.sh  
zhouhh@zhh64:~/test/data$ cat test.sh  
#!/bin/sh  
( read l; read l; read l ;exec cat ) < "$0" | gunzip | tar xf - && ls -l  
exit  
此时data目录下已经自解压了原来test目录下压缩到data.tar.gz中的文件。

 

该脚本复杂一点可以继续完成安装等工作，有点类似于windows下winzip做的exe自解压安装文件。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=99969ea6-763c-8010-8446-48f3a087caeb)
