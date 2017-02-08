---
author: abloz
comments: true
date: 2007-08-10 07:07:46+00:00
layout: post
link: http://abloz.com/index.php/2007/08/10/solaris-multithread/
slug: solaris-multithread
title: solaris 下多线程编程
wordpress_id: 235
categories:
- 技术
tags:
- posix
- solaris
- 多线程
---

本文遵循CPL协议，可以免费自由使用，但不得去掉作者信息。
作者: [周海汉](http://blog.csdn.net/ablo_zhou)
Email:ablozhou  at gmail.com
日期：2007.8.9

本文根据作者PPT讲稿整理。

参考资源：

[http://gceclub.sun.com.cn/solaris/819-7051-10.pdf](http://gceclub.sun.com.cn/solaris/819-7051-10.pdf) sun公司培训多线程编程教材
[http://developers.sun.com/sunstudio/reference/docs/index.jsp](http://developers.sun.com/sunstudio/reference/docs/index.jsp) sun studio
[http://gceclub.sun.com.cn/](http://gceclub.sun.com.cn/) sun中国技术社区
[www.unix-center.net](http://www.unix-center.net/) solaris 体验区

进程概念
正在执行的一道程序
是拥有独立资源的可执行的基本单位
多任务系统
并发执行

线程的概念
计算机程序中可执行的最小单位
60年代提出
80年代实现产品
轻量级进程

Solaris 线程库
POSIX 线程库，叫pthread
特定于Solaris 的线程库

POSIX
POSIX:Portable Operating System Interface
IEEE Std 1003.1  1996 版（又称作ISO/IEC 9945–1第二版）。
IEEE Std 1003.1:2001（又称作ISO/IEC  9945:2002和单一UNIX 规范版本3）

用户级线程状态
线程ID
寄存器状态
栈
信号掩码
优先级
线程专用存储

线程间同步
互斥量 mutual exclustion lock
条件变量 condition variable
读写锁  read-write lock
计数信号量 counting semaphore

第一个多线程程序
头文件：
#include <stdio.h>
#include  <pthread.h>
线程函数：

extern “C” void* start_routine(void* arg)
{
printf("thread %d  running...n",*(int*)arg);
return NULL;
}
int main()
{
pthread_t  tid1;
int arg = 1;
int ret;
ret =  pthread_create(&tid1,NULL,start_routine,(void*)&arg);
return  ret;
}
编译执行
$ CC –o thread1 –g thread1.cpp
$ ./thread1
thread  1 running...

缺省线程
进程范围
非分离
缺省栈和缺省栈大小
零优先级

pthread_create 语法
int pthread_create(
pthread_t *tid,
const pthread_attr_t *tattr,
void*(*start_routine)(void *),
void *arg
);

等待线程终止
pthread_join()
pthread_join 语法
int pthread_join
(
thread_t  tid,
void **status
);

生成两个线程
int main()
{
pthread_attr_t tattr;
void*  status=NULL;
pthread_t tid1,tid2;
int arg = 1;
int ret;
ret  = pthread_create(&tid1,NULL,start_routine,(void*)&arg);
pthread_join(tid1,&status);

ret  = pthread_attr_init(&tattr);
arg=2;
ret =  pthread_create(&tid2,&tattr,start_routine,(void*)&arg);
pthread_join(tid2,&status);
return  ret;
}

结束线程
从线程函数返回
调用pthread_exit()，提供退出状态
使用POSIX 取消函数执行终止操作

POSIX 通用对象模型
图
初始化属性
pthread_attr_init 语法
int  pthread_attr_init(pthread_attr_t *tattr);

缺省属性值
<table cellpadding="0" cellspacing="0" border="0" width="486" >
<tbody >
<tr >

<td width="145" valign="top" >


属性

</td>

<td width="200" valign="top" >


值

</td>

<td width="141" valign="top" >


结果

</td>
</tr>
<tr >

<td width="145" valign="top" >


_scope _

</td>

<td width="200" valign="top" >


PTHREAD_SCOPE_PROCESS

</td>

<td width="141" valign="top" >


新线程与进程中的其他线程发生竞

</td>
</tr>
<tr >

<td width="145" valign="top" >


_detachstate_

</td>

<td width="200" valign="top" >


PTHREAD_CREATE_JOINABLE

</td>

<td width="141" valign="top" >


线程退出后，保留完成状态和线程_ID_。

</td>
</tr>
<tr >

<td width="145" valign="top" >
</td>

<td width="200" valign="top" >
</td>

<td width="141" valign="top" >
</td>
</tr>
<tr >

<td width="145" valign="top" >


_stacksize_

</td>

<td width="200" valign="top" >


0

</td>

<td width="141" valign="top" >
</td>
</tr>
<tr >

<td width="145" valign="top" >


_priority_

</td>

<td width="200" valign="top" >


0

</td>

<td width="141" valign="top" >
</td>
</tr>
<tr >

<td width="145" valign="top" >


_stackaddr_

</td>

<td width="200" valign="top" >


NULL

</td>

<td width="141" valign="top" >


新线程具有系统分配的栈地址

</td>
</tr>
<tr >

<td width="145" valign="top" >


_inheritsched_

</td>

<td width="200" valign="top" >


PTHREAD_EXPLICIT_SCHED

</td>

<td width="141" valign="top" >


新线程不继承父线程调度优先级

</td>
</tr>
<tr >

<td width="145" valign="top" >


_schedpolicy_

</td>

<td width="200" valign="top" >


SCHED_OTHER

</td>

<td width="141" valign="top" >
</td>
</tr>
</tbody>
</table>
