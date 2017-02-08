---
author: abloz
comments: true
date: 2007-12-05 07:30:26+00:00
layout: post
link: http://abloz.com/index.php/2007/12/05/zhou-haihan-standard-template-library-stl-containers-thread-safe/
slug: zhou-haihan-standard-template-library-stl-containers-thread-safe
title: 周海汉：标准模板库stl 容器的线程安全
wordpress_id: 249
categories:
- 技术
tags:
- stl
- 多线程
---

周海汉/文

标准模板库现在应用越来越广泛。但它的容器是不是线程安全的呢？我们看到Windows平台VC用的PJ STL，MSDN是这样说的：








Thread Safety in the Standard C++ Library
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)When /MT, /MTd, /MD, or /MDd is used, the following thread-safety rules are in effect:
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)Container Classes and complex
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)The container classes are vector, deque, list, queue, stack , priority_queue, valarray, map, multimap, set, multiset, basic_string, bitset.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For reads to the same object, the object is thread safe for reading in the following scenarios:
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From one thread at a time when no writers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From many threads at a time when no writers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For writes to the same object, the object is thread safe for writing from one thread when no readers on other threads
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For reads to different objects of the same class, the object is thread safe for reading in the following scenarios:
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From one thread at a time.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From one thread at a time when no writers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From many threads at a time.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From many threads at a time when no writers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For writes to different objects of the same class, the object is thread safe for writing in the following scenarios:
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From one thread when no readers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From many threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For example, given objects A and B of the same class, it is safe if object A is being written in thread 1 and B is being read in thread 2.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)iostream Classes
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)Note that reading from a stream buffer is not considered to be a read operation. It should be considered as a write operation, because this changes the state of the class.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For reads to the same object, the object is thread safe for reading in the following scenarios:
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From one thread at a time when no writers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From many threads at a time when no writers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For writes to the same object, the object is thread safe for writing in the following scenarios:
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From one thread when no readers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From many threads (when accesses are limited to stream buffers).
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For reads to different objects of the same class, the object is thread safe for reading in the following scenarios:
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From one thread at a time.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From one thread at a time when no writers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From many threads at a time.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From many threads at a time when no writers on other threads.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For writes to different objects of the same class, the object is thread safe for writing in the following scenarios:
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From one thread when no readers on other threads
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)From many threads
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)





意思就是：设置/MT, /MTd, /MD, or /MDd 标 志时，对vector, deque, list, queue, stack , priority_queue, valarray, map, multimap, set, multiset, basic_string, bitset 容器，多线程读同一对象或同一个类的不同对象，没有写时，读安全。可以多线程同时写一个对象或一个类的不同对象，但不能有读的线程。例如，一个线程写一个 类对象A，另一线程写该类的另一对象B，就是安全。
对iostream操作，从buffer读操作也看成写因为读会更改stream状态。其线程 安全和容器类似，也是可以同时读，同时写，但不能又读又写。如果会有并发读写的可能，对一个对象，必须加互斥。而如果是同一个类的不同对象，则不会影响。

那 么SGL STL实现的多线程安全如何呢？

从[http://www.sgi.com/tech/stl/thread_safety.html](http://www.sgi.com/tech/stl/thread_safety.html) 上 面找到答案：





Thread-safety for SGI STL
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)SGI STL provides what we believe to be the most useful form of thread-safety. This explains some of the design decisions made in the SGI STL implementation.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)Client must lock shared mutable containers
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)The SGI implementation of STL is thread-safe only in the sense that simultaneous accesses to distinct containers are safe, and simultaneous read accesses to to shared containers are safe. If multiple threads access a single container, and at least one thread may potentially write, then the user is responsible for ensuring mutual exclusion between the threads during the container accesses.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)This is the only way to ensure full performance for containers that do not need concurrent access. Locking or other forms of synchronization are typically expensive and should be avoided when not necessary.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)It is easy for the client or another library to provide the necessary locking by wrapping the underlying container operations with a lock acquisition and release. For example, it would be possible to provide a locked_queue container adapter that provided a container with atomic queue operations.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)For most clients, it would be insufficient to simply make container operations atomic; larger grain atomic actions are needed. If a user's code needs to increment the third element in a vector of counters, it would be insuffcient to guarantee that fetching the third element and storing the third element is atomic; it is also necessary to guarantee that no other updates occur in the middle. Thus it would be useless for vector operations to acquire the lock; the user code must provide for locking in any case.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)This decision is different from that made by the Java designers. There are two reasons for that. First, for security reasons Java must guarantee that even in the presence of unprotected concurrent accesses to a container, the integrity of the virtual machine cannot be violated. Such safety constraints were clearly not a driving force behind either C++ or STL. Secondly, performance was a more important design goal for STL than it was for the Java standard library.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)On the other hand, this notion of thread-safety is stronger than that provided by reference-counted string implementations that try to follow the CD2 version of the draft standard. Such implementations require locking between multiple readers of a shared string.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)Lock implementation
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)The SGI STL implementation removes all nonconstant static data from container implementations. The only potentially shared static data resides in the allocator implementations. To this end, the code to implement per-class node allocation in HP STL was transformed into inlined code for per-size node allocation in the SGI STL allocators. Currently the only explicit locking is performed inside allocators.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)Many other container implementations should also benefit from this design. It will usually be possible to implement thread-safe containers in portable code that does not depend on any particular thread package or locking primitives.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)Alloc.h uses three different locking primitives depending on the environment. In addition, it can be forced to perform no locking by defining _NOTHREADS. The three styles of locking are:
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)Pthread mutexes. These are used if _PTHREADS is defined by the user. This may be done on SGI machines, but is not recommended in performance critical code with the currently (March 1997) released versions of the SGI Pthreads libraries.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)Win32 critical sections. These are used by default for win32 compilations with compiler options that request multi-threaded code.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)An SGI specific spin-lock implementation that is usable with both pthread and sproc threads. This could serve as a prototype implementation for other platforms. This is the default on SGI/MIPS platforms.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)It would be preferable if we could always use the OS-supplied locking primitives. Unfortunately, these often do not perform well, for very short critical sections such as those used by the allocator.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)Allocation intensive applications using Pthreads to obtain concurrency on multiprocessors should consider using pthread_alloc from pthread_alloc.h. It imposes the restriction that memory deallocated by a thread can only be reallocated by that thread. However, it often obtains significant performance advantages as a result.
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)
![](http://images.csdn.net/syntaxhighlighting/OutliningIndicators/None.gif)





其大意也是，为了效率，没有给所有操作加锁。不同线程同时读同一容器对象没关系，不同线程同时写不同的容器对象没关系。但不能同时又读又写同一容器 对象的。因此，多线程要同时读写时，还是要自己加锁。

STLPort基于SGI STL，只不过是支持跨平台的，其实现和SGI STL没有本质差别。

**结 论：**

**STL 的实现，是部分线程安全的。就是说，对容器和iostream，如果不同线程同时读同一容器对象线程安全。不同线程同时写同一容器的不同对象，线程安全。 但不同线程同时读写同一对象，必须在外面自己做线程互斥和同步。**
