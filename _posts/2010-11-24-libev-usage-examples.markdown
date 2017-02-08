---
author: abloz
comments: true
date: 2010-11-24 07:38:26+00:00
layout: post
link: http://abloz.com/index.php/2010/11/24/libev-usage-examples/
slug: libev-usage-examples
title: libev 用法示例
wordpress_id: 1083
categories:
- 技术
---

周思成 2010.11.23




ubuntu下安装libev开发包  
$ sudo apt-get install libev-dev  
将会安装下列额外的软件包：  
libev3  
下列【新】软件包将被安装：  
libev-dev libev3




但是由于libev在ubuntu软件库中的版本为3，而最新libev版本已经是4，所以会有不兼容。  
下面是libev的man page自带的libev用法示例，保存到testlibev.c：  
该示例文件演示了io输入事件和超时事件。  
// a single header file is required  
#include <ev.h>




#include <stdio.h> // for puts




// every watcher type has its own typedef'd struct  
// with the name ev_TYPE  
ev_io stdin_watcher;  
ev_timer timeout_watcher;




// all watcher callbacks have a similar signature  
// this callback is called when data is readable on stdin  
static void  
stdin_cb (EV_P_ ev_io *w, int revents)  
{  
puts ("stdin ready");  
// for one-shot events, one must manually stop the watcher  
// with its corresponding stop function.  
ev_io_stop (EV_A_ w);




// this causes all nested ev_run's to stop iterating  
ev_break (EV_A_ EVBREAK_ALL);  
}




// another callback, this time for a time-out  
static void  
timeout_cb (EV_P_ ev_timer *w, int revents)  
{  
puts ("timeout");  
// this causes the innermost ev_run to stop iterating  
ev_break (EV_A_ EVBREAK_ONE);  
}




int  
main (void)  
{  
// use the default event loop unless you have special needs  
struct ev_loop *loop = EV_DEFAULT;




// initialise an io watcher, then start it  
// this one will watch for stdin to become readable  
ev_io_init (&stdin_watcher, stdin_cb, /*STDIN_FILENO*/ 0, EV_READ);  
ev_io_start (loop, &stdin_watcher);




// initialise a timer watcher, then start it  
// simple non-repeating 5.5 second timeout  
ev_timer_init (&timeout_watcher, timeout_cb, 5.5, 0.);  
ev_timer_start (loop, &timeout_watcher);




// now wait for events to arrive  
ev_run (loop, 0);




// unloop was called, so exit  
return 0;  


```
}


```



编译：  
报告 EVBREAK_ONE 等没有定义。




ev_break等没有实现。




此时需到官网下载最新4.01源码。  
http://dist.schmorp.de/libev/  
执行./configure,make,make install




编译时头文件查找路径：  
先查找-I,在查gcc环境变量 C_INCLUDE_PATH,CPLUS_INCLUDE_PATH,OBJC_INCLUDE_PATH，再查内定目录


/usr/include   





/usr/local/include







/usr/lib/...  
所以gcc能在/usr/local/include中找到最新宏的定义。  





此时再用缺省命令编译。  
zhouhh@zhh64:~/sms/test$ gcc -o testlibev -lev testlibev.c  
/tmp/ccgDMc0G.o: In function `stdin_cb':  
testlibev.c:(.text+0x3d): undefined reference to `ev_break'  
...  
/tmp/ccgDMc0G.o: In function `main':  
testlibev.c:(.text+0x81): undefined reference to `ev_default_loop'  
testlibev.c:(.text+0x145): undefined reference to `ev_run'  
collect2: ld returned 1 exit status




报错.  
必须指定库的路径，因为gcc对库的搜寻顺序为：  
gcc会先找-L，再找gcc的环境变量LIBRARY_PATH，再找/lib：/usr/lib： /usr/local/lib  
$ gcc -o testlibev -L/usr/local/lib -lev testlibev.c  
编译通过。




测试：  
zhouhh@zhh64:~/sms/test$ ./testlibev   
./testlibev: error while loading shared libraries: libev.so.4: cannot open shared object file: No such file or directory




找不到libev.so.4动态库加载。  
动态库查找顺序和路径：  
1.在编译目标代码时指定该程序的动态库搜索路径（还可以在编译目标代码时指定程序的动态库搜索路径）。这是通过gcc 的参数"-Wl,-rpath,"指定。当指定多个动态库搜索路径时，路径之间用冒号"："分隔；  
2.通过环境变量LD_LIBRARY_PATH指定动态库搜索路径（多个用:隔开）；  
3.在配置文件/etc/ld.so.conf中指定动态库搜索路径；  
4.默认的动态库搜索路径/lib  /usr/lib  
设置动态库查找路径：  
$ export LD_LIBRARY_PATH=/usr/local/lib  
zhouhh@zhh64:~/sms/test$ ./testlibev  
timeout  
zhouhh@zhh64:~/sms/test$ ./testlibev  
a  
stdin ready  
第一个没有输入，所以等到5.5秒后超时。  
第二个输入a，所以stdin监测到事件退出。




参考：  
http://blog.csdn.net/xuzhihong_gdut/archive/2009/01/19/3836262.aspxTechnorati   
标签: [libev](http://technorati.com/tag/libev)




![](http://img.zemanta.com/pixy.gif?x-id=85f2e5d4-c74a-8f13-af6f-4ac1df2f73a4)



