---
author: abloz
comments: true
date: 2010-11-24 08:43:48+00:00
layout: post
link: http://abloz.com/index.php/2010/11/24/linux-posix-standard-timer-usage/
slug: linux-posix-standard-timer-usage
title: linux posix标准 timer用法
wordpress_id: 1085
categories:
- 技术
---

2010.11.24  
http://abloz.com  
  
linux中有setitimer等一组函数，但该组函数已经在POSIX.1-2008废弃。现在基于 2.6 版本内核定时器posix替代函数是timer_gettime(2), timer_settime(2)。  
接口：  

    
    #include <signal.h>
     #include <time.h>
    
     int timer_create(clockid_t clockid, struct sigevent *evp,
     timer_t *timerid);
     int timer_settime(timer_t timerid, int flags,
     const struct itimerspec *new_value,
     struct itimerspec * old_value);
     int timer_gettime(timer_t timerid, struct itimerspec *curr_value);
     int timer_getoverrun(timer_t timerid);
    
     int timer_delete(timer_t timerid);

  
示例：  
#include <stdlib.h>  
#include <unistd.h>  
#include <stdio.h>  
#include <signal.h>  
#include <time.h>  
  
#define CLOCKID CLOCK_REALTIME  
#define SIG SIGRTMIN  
  
#define errExit(msg) do { perror(msg); exit(EXIT_FAILURE);   
} while (0)  
  
static void  
print_siginfo(siginfo_t *si)  
{  
timer_t *tidp;  
int or;  
  
tidp = si->si_value.sival_ptr;  
  
printf(" sival_ptr = %p; ", si->si_value.sival_ptr);  
printf(" *sival_ptr = 0x%lxn", (long) *tidp);  
  
or = timer_getoverrun(*tidp);  
if (or == -1)  
errExit("timer_getoverrun");  
else  
printf(" overrun count = %dn", or);  
}  
  
static void  
handler(int sig, siginfo_t *si, void *uc)  
{  
/* Note: calling printf() from a signal handler is not  
strictly correct, since printf() is not async-signal-safe;  
see signal(7) */  
  
printf("Caught signal %dn", sig);  
print_siginfo(si);  
signal(sig, SIG_IGN);  
}  
int  
main(int argc, char *argv[])  
{  
timer_t timerid;  
struct sigevent sev;  
struct itimerspec its;  
long long freq_nanosecs;  
sigset_t mask;  
struct sigaction sa;  
  
if (argc != 3) {  
fprintf(stderr, "Usage: %s <sleep-secs> <freq-nanosecs>n",  
argv[0]);  
exit(EXIT_FAILURE);  
}  
  
/* Establish handler for timer signal */  
  
printf("Establishing handler for signal %dn", SIG);  
sa.sa_flags = SA_SIGINFO;  
sa.sa_sigaction = handler;  
sigemptyset(&sa.sa_mask);  
if (sigaction(SIG, &sa, NULL) == -1)  
errExit("sigaction");  
  
/* Block timer signal temporarily */  
  
printf("Blocking signal %dn", SIG);  
sigemptyset(&mask);  
sigaddset(&mask, SIG);  
if (sigprocmask(SIG_SETMASK, &mask, NULL) == -1)  
errExit("sigprocmask");  
  
/* Create the timer */  
  
sev.sigev_notify = SIGEV_SIGNAL;  
sev.sigev_signo = SIG;  
sev.sigev_value.sival_ptr = &timerid;  
if (timer_create(CLOCKID, &sev, &timerid) == -1)  
errExit("timer_create");  
  
printf("timer ID is 0x%lxn", (long) timerid);  
  
/* Start the timer */  
freq_nanosecs = atoll(argv[2]);  
its.it_value.tv_sec = freq_nanosecs / 1000000000;  
its.it_value.tv_nsec = freq_nanosecs % 1000000000;  
its.it_interval.tv_sec = its.it_value.tv_sec;  
its.it_interval.tv_nsec = its.it_value.tv_nsec;  
  
if (timer_settime(timerid, 0, &its, NULL) == -1)  
errExit("timer_settime");  
  
/* Sleep for a while; meanwhile, the timer may expire  
multiple times */  
  
printf("Sleeping for %d secondsn", atoi(argv[1]));  
sleep(atoi(argv[1]));  
  
/* Unlock the timer signal, so that timer notification  
can be delivered */  
  
printf("Unblocking signal %dn", SIG);  
if (sigprocmask(SIG_UNBLOCK, &mask, NULL) == -1)  
errExit("sigprocmask");  
  
exit(EXIT_SUCCESS);  
}  
新版timer支持4种响应类型，sigev_notify参数：  
SIGEV_NONE，不异步通知，采用timer_gettime来查询是否超时。  
SIGEV_SIGNAL：超时采用信号来进行通知，利用sigaction机制。但由于信号不排队，如果有多个信号，只能保证收到一个信号。  
SIGEV_THREAD：定时器到时会创建线程  
SIGEV_THREAD_ID（linux特定）：仅推荐用于多线程库  
  
_CLOCK_REALTIME_ 可以看到结果就是从1970年以来所经过的秒数.  
将示例文件保存到testtimer.c.编译：  
zhouhh@zhh64:~/sms$ gcc -o testtimer -lrt testtimer.c  
zhouhh@zhh64:~/sms$ ./testtimer   
Usage: ./testtimer <sleep-secs> <freq-nanosecs>  
zhouhh@zhh64:~/sms$ ./testtimer 10 1000000  
Establishing handler for signal 34  
Blocking signal 34  
timer ID is 0x6ea010  
Sleeping for 10 seconds  
Unblocking signal 34  
Caught signal 34  
sival_ptr = 0x7fffcf841958; *sival_ptr = 0x6ea010  
overrun count = 9999  
其中overun count表示时钟到期后延期嘀嗒数。因为时钟到期发送信号，因为种种原因延时，所以给一个计数，用于确定时间。  
  
__  
参考：  
http://www.ibm.com/developerworks/cn/linux/l-cn-timers/  
http://www.javaeye.com/topic/309744Technorati   
标签: [linux](http://technorati.com/tag/linux), [timer](http://technorati.com/tag/timer)  
  


![](http://img.zemanta.com/pixy.gif?x-id=2e1a94d0-5671-84e5-a7f5-f28b80a0101a)
