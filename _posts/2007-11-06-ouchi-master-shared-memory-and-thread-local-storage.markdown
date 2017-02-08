---
author: abloz
comments: true
date: 2007-11-06 07:22:58+00:00
layout: post
link: http://abloz.com/index.php/2007/11/06/ouchi-master-shared-memory-and-thread-local-storage/
slug: ouchi-master-shared-memory-and-thread-local-storage
title: '[转]大内高手—共享内存与线程局部存储'
wordpress_id: 241
categories:
- 技术
- 转载
tags:
- 共享内存
- 线程
---

转载时请注明出处：[http://blog.csdn.net/absurd](http://blog.csdn.net/absurd)

城里的人想出去，城外的人想进来。这是《围城》里的一句话，它可能比《围城》本身更加有名。我想这句话的前提是，要么住在城里，要么住 在城外，二者只能居其一。否则想住在城里就可以住在城里，想住在城外就可以住在城外，你大可以选择单日住在城里，双日住在城外，也就没有心思去想出去还是 进来了。

理想情况是即可以住在城里又可以住在城外，而不是走向极端。尽管像青蛙一样的两栖动物绝不会比人类更高级，但能适应于更多环境的能力毕 竟有它的优势。技术也是如此，共享内存和线程局部存储就是实例，它们是为了防止走向内存完全隔离和完全共享两个极端的产物。

当我们发明了MMU时， 大家认为天下太平了，各个进程空间独立，互不影响，程序的稳定性将大提高。但马上又认识到，进程完全隔离也不行，因为各个进程之间需要信息共享。于是就搞 出一种称为共享内存的东西。

当我们发明了线程的时，大家认为这下可爽了，线程可以并发执行，创建和切换的开销相对进程来说小多了。线程之间的内存是共享的，线程间 通信快捷又方便。但马上又认识到，有些信息还是不共享为好，应该让各个线程保留一点隐私。于是就搞出一个线程局部存储的玩意儿。

共享内存和线程局部存储是两个重要又不常用的东西，平时很少用，但有时候又离不了它们。本文介绍将两者的概念、原理和使用方法，把它们 放在自己的工具箱里，以供不时之需。

1.         共享内存

大家都知道进程空间是独立的，它们之间互不影响。比如同是0xabcd1234地址的内存，在不同的进程中，它们的数据是不同的，没有关系的。这样做的好处很多：每个进程的地址空 间变大了，它们独占4G(32位)的地址空间，让编程实现更容易。 各个进程空间独立，一个进程死掉了，不会影响其它进程，提高了系统的稳定性。

要做到进程空间独立，光靠软件是难以实现的，通常要依赖于硬件的帮助。这种硬件通常称为MMU(Memory Manage Unit)，即所谓的内存管理单元。在这种体系结构下，内存分为物理内存和虚拟内存两种。物理内存就是实际的 内存，你机器上装了多大内存就有多大内存。而应用程序中使用的是虚拟内存，访问内存数据时，由MMU根 据页表把虚拟内存地址转换对应的物理内存地址。

MMU把 各个进程的虚拟内存映射到不同的物理内存上，这样就保证了进程的虚拟内存是独立的。然而，物理内存往往远远少于各个进程的虚拟内存的总和。怎么办呢，通常 的办法是把暂时不用的内存写到磁盘上去，要用的时候再加载回内存中来。一般会搞一个专门的分区保存内存数据，这就是所谓的交换分区。

这些工作由内核配合MMU硬 件完成，内存管理是操作系统内核的重要功能。其中为了优化性能，使用了不少高级技术，所以内存管理通常比较复杂。比如：在决定把什么数据换出到磁盘上时， 采用最近最少使用的策略，把常用的内存数据放在物理内存中，把不常用的写到磁盘上，这种策略的假设是最近最少使用的内存在将来也很少使用。在创建进程时使 用COW(Copy on  Write)的技术，大大减少了内存数据的复制。为了提高 从虚拟地址到物理地址的转换速度，硬件通常采用TLB技术，把刚转换的地址存在cache里，下次可以直接使用。

从虚拟内存到物理内存的映射并不是一个字节一个字节映射的，而是以一个称为页(page)最小单位的为基础的，页的大小视硬件平台而定，通常是4K。当应用程序访问的内存所在页面不在物理内存中时，MMU产生一个缺页中断，并挂起当前进程，缺页中断负责把相应的数据从磁盘读入内存中，再唤醒挂起的进程。

进程的虚拟内存与物理内存映射关系如下图所示(灰色 页为被不在物理内存中的页):

也许我们很少直接使用共享内存，实际上除非性能上有特殊要求，我更愿意采用socket或者管道作为进程间通信的方式。但我们常常间接的使用共享内存，大家都知道共享库（或称为动态库）的 优点是，多个应用程序可以公用。如果每个应用程序都加载一份共享库到内存中，显然太浪费了。所以操作系统把共享库放在共享内存中，让多个应用程序共享。另 外，同一个应用程序运行多个实例时，也采用同样的方式，保证内存中只有一份可执行代码。这样的共享内存是设为只读属性的，防止应用程序无意中破坏它们。当 调试器要设置断点时，相应的页面被拷贝一分，设置为可写的，再向其中写入断点指令。这些事情完全由操作系统等底层软件处理了，应用程序本身无需关心。

共享内存是怎么实现的呢？我们来看看下图(黄色 页为共享内存)：

由上图可见，实现共享内存非常容易，只是把两个进程的虚拟内存映射同一块物理内存就行了。不过要注 意，物理内存相同而虚拟地址却不一定相同，如图中所示进程1的page5和进程2的page2都映射到物理内存的page1上。

如何在程序中使用共享内存呢？通常很简单，操作系统或者函数库提供了一些API给我们使用。如：

Linux:
<table cellpadding="0" cellspacing="0" align="left" border="0" bgcolor="#e6e6e6" >
<tbody >
<tr >

<td width="568" valign="top" >void  * mmap(void *start, size_t length, int prot , int flags, int fd, off_t  offset);

int  munmap(void *start, size_t length);
</td>
</tr>
</tbody>
</table>
Win32:
<table cellpadding="0" cellspacing="0" align="left" border="0" bgcolor="#e6e6e6" >
<tbody >
<tr >

<td width="568" valign="top" >

    
    HANDLE CreateFileMapping(



    
      HANDLE hFile,                       // handle to file



    
      LPSECURITY_ATTRIBUTES lpAttributes, // security



    
      DWORD flProtect,                    // protection



    
      DWORD dwMaximumSizeHigh,            // high-order DWORD of size



    
      DWORD dwMaximumSizeLow,             // low-order DWORD of size



    
      LPCTSTR lpName                      // object name



    
    );



    
    BOOL UnmapViewOfFile(



    
      LPCVOID lpBaseAddress   // starting address



    
    );



</td>
</tr>
</tbody>
</table>
2.

线程局部存储(TLS)

同一个进程中的多个线程，它们的内存空间是共享的（栈除外），在一个线程修改的内存内容，对所有线程 都生效。这是一个优点也是一个缺点。说它是优点，线程的数据交换变得非常快捷。说它是缺点，一个线程死掉了，其它线程也性命不保; 多个线程访问共享数据，需要昂贵的同步开销，也容易造成同步相关的BUG;。

在unix下，大家一直都对线程不是 很感兴趣，直到很晚以后才引入线程这东西。像X Sever要同时处理N个客户端的连接，每秒钟要响应上百万个请求，开发人员宁愿自己实现调度机制也不用线程。让人很难想象X Server是单进程单线程模型的。再如Apache(1.3x)，在unix下的实现也是采用多进程模 型的，把像记分板等公共信息放入共享内存中，也不愿意采用多线程模型。

正如《unix编程艺术》中所说，线程局 部存储的出现，使得这种情况出现了转机。采用线程局部存储，每个线程有一定的私有空间。这可以避免部分无意的破坏，不过仍然无法避免有意的破坏行为。

个人认为，这完全是因为unix程 序不喜欢面向对象方法引起的，数据没有很好的封装起来，全局变量满天飞，在多线程情况下自然容易出问题。如果采用面向对象的方法，可以让这种情况大为改 观，而无需要线程局部存储来帮忙。

当然，多一种技术就多一种选择，知道线程局部存储还是有用的。尽管只用过几次线程局部存储的方法，在那种情况下，没有线程局部存储， 确实很难用其它办法实现。

线程局部存储在不同的平台有不同的实现，可移植性不太好。幸好要实现线程局部存储并不难，最简单的办 法就是建立一个全局表，通过当前线程ID去查询相应的数据，因为各个线程的ID不 同，查到的数据自然也不同了。

大多数平台都提供了线程局部存储的方法，无需要我们自己去实现：

linux:
<table cellpadding="0" cellspacing="0" align="left" border="0" bgcolor="#e6e6e6" >
<tbody >
<tr >

<td width="568" valign="top" >方法一：

int  pthread_key_create(pthread_key_t *key, void (*destructor)(void*));

int  pthread_key_delete(pthread_key_t key);

void  *pthread_getspecific(pthread_key_t key);

int  pthread_setspecific(pthread_key_t key, const void *value);

方法二：

__thread int i;
</td>
</tr>
</tbody>
</table>
Win32
<table cellpadding="0" cellspacing="0" align="left" border="0" bgcolor="#e6e6e6" >
<tbody >
<tr >

<td width="568" valign="top" >方法一：

DWORD  TlsAlloc(VOID);

BOOL  TlsFree(

DWORD dwTlsIndex   // TLS index

);

BOOL  TlsSetValue(

DWORD dwTlsIndex,  // TLS index

LPVOID lpTlsValue  // value to  store

);

LPVOID  TlsGetValue(

DWORD dwTlsIndex   // TLS index

);

方法二：

`__declspec( thread ) int tls_i = 1;`
</td>
</tr>
</tbody>
</table>
