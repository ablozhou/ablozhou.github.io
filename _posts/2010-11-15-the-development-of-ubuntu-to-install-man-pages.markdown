---
author: abloz
comments: true
date: 2010-11-15 03:07:36+00:00
layout: post
link: http://abloz.com/index.php/2010/11/15/the-development-of-ubuntu-to-install-man-pages/
slug: the-development-of-ubuntu-to-install-man-pages
title: ubuntu 下安装开发的man pages
wordpress_id: 1065
categories:
- 技术
---

周海汉 2010.11.15


## 问题：


ubuntu默认没有装pthread的man page
zhouhh@zhh64:~$ man pthread_create
没有 pthread_create 的手册页条目


## 解决方法：


安装：
sudo apt-get install manpages-posix-dev
sudo apt-get install glibc-doc

执行如下的man命令都ok
zhouhh@zhh64:~$ man pthreads

注意是pthreads,不是pthread
zhouhh@zhh64:~$ man pthread_createTechnorati


## 参考：


http://joysofprogramming.com/install-pthread-manpages-in-ubuntu/

http://www.manpagez.com/man/3/pthread/

标签: [pthread](http://technorati.com/tag/pthread), [man](http://technorati.com/tag/man), [ubuntu](http://technorati.com/tag/ubuntu)


![](http://img.zemanta.com/pixy.gif?x-id=cfb9f242-ee22-8cb7-a1f0-430cd49d7941)
