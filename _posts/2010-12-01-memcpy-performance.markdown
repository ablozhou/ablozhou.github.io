---
author: abloz
comments: true
date: 2010-12-01 07:53:14+00:00
layout: post
link: http://abloz.com/index.php/2010/12/01/memcpy-performance/
slug: memcpy-performance
title: memcpy性能如何?
wordpress_id: 1099
categories:
- 技术
tags:
- memcpy
---

http://abloz.com
2010.12.1<br />比较好奇memcpy对性能有多大影响。所以写了个测试程序。源码如下。
对1024个字节进行memcpy，拷贝100万次。将b放在全局区是因为如果放栈区会导致栈空间不足。

zhouhh@zhh64:~$ cat sms/test/testmemcpy.c

    
    
    //////////////////////////////////////////
    //author 	zhouhh
    //date 		2010.12.1
    //notes       http://abloz.com
    //history
    //copyright( 2010 ) allright reserved!
    /////////////////////////////////////////
    
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <time.h>
    #define BUF_LEN 1024
    char b[1000000][BUF_LEN]={0};
    void main()
    {
    char a[BUF_LEN]={"1234567890 abcdefg higklmn opq rst uvw xyz"};
    a[BUF_LEN]='\0';
    int i = 0;
    int max = 1000000;
    struct timespec ts,te;
    printf("a=%sn",a);
    clock_gettime (CLOCK_REALTIME, &ts) ;
    printf("begin:%ld s,%ld nsn",ts.tv_sec,ts.tv_nsec);
    for(i = 0; i< max; i++)
    {
    memcpy(b[i],a,BUF_LEN);
    }
    
    printf("memcpy %d times,buflen=%dn",max,BUF_LEN);
    clock_gettime (CLOCK_REALTIME, &te) ;
    printf("end:%ld s,%ld nsn",te.tv_sec,te.tv_nsec);
    long nsec = te.tv_nsec-ts.tv_nsec;
    int sec = te.tv_sec - ts.tv_sec;
    if(nsec < 0)
    {
    nsec += 1000000000;
    sec -= 1;
    }
    
    printf("spend:%.3f secn",sec+nsec/1000000000.0);
    printf("every memcpy spend:%.3f usecn",(sec*1000000000+nsec)/(max*1000.0));
    
    printf("chek b buf:%sn",b[max-1]);
    }
    



```
zhouhh@zhh64:~/sms/test$ gcc -o tm -lrt testmemcpy.c
zhouhh@zhh64:~/sms/test$ ./tm
a=1234567890 abcdefg higklmn opq rst uvw xyz
begin:1291188463 s,18960481 ns
memcpy 1000000 times,buflen=1024
end:1291188464 s,200238201 ns
spend:1.181 sec
every memcpy spend:1.181 usec
chek b buf:1234567890 abcdefg higklmn opq rst uvw xyz
```

由此可见，1024个字节，拷贝100万次，花费了1.181秒。
测试CPU：
AMD Athlon(tm) 64 X2 Dual Core Processor 5200+,1000MHZ

另一个测试服务器：
CPU ：Intel(R) Xeon(R) CPU           X5680  @ 3.33GHz
24核。

```
# ./tm
a=1234567890 abcdefg higklmn opq rst uvw xyz
begin:1291188745 s,642300000 ns
memcpy 1000000 times,buflen=1024
end:1291188746 s,904286000 ns
spend:1.262 sec
every memcpy spend:1.262 usec
chek b buf:1234567890 abcdefg higklmn opq rst uvw xyz
```

总花费1.26秒。与我工作机器用时并无太多差别。
平均大概1次memcpy 1024个字节，花费1微秒多点。

Technorati 标签: [memcpy](http://technorati.com/tag/memcpy)


![](http://img.zemanta.com/pixy.gif?x-id=fbebd134-3cf2-8358-bf3f-c349a6e35f6f)
