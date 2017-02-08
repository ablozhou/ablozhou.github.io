---
author: abloz
comments: true
date: 2010-11-18 07:05:59+00:00
layout: post
link: http://abloz.com/index.php/2010/11/18/posix-message-queue-test/
slug: posix-message-queue-test
title: posix message queue测试
wordpress_id: 1073
categories:
- 技术
tags:
- mqueue
---

周海汉 2010.11.18

源代码：

    
    //////////////////////////////////////////
    //author 	zhouhh
    //date 		2010.11.18
    //notes
    //history
    //copyright( 2010 ) allright reserved!
    /////////////////////////////////////////
    
    #include
    #include
    #include
    #include
    #include
    #include
     #include
    //       mqd_t mq_open(const char *name, int oflag);
    //       mqd_t mq_open(const char *name, int oflag, mode_t mode,
    //                     struct mq_attr *attr);
    #define _XOPEN_SOURCE 600
    #define FILE_MODE (S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
    void main(void)
    {
        mqd_t mqdes = mq_open("testmymq",O_RDWR|O_CREAT, FILE_MODE,NULL);
        if( mqdes == (mqd_t) -1)
        {
            perror("mq_open error");
        }
    
        struct sigevent se;
        //se.sigev_notify = SIGEV_SIGNAL;
        //se.sigev_signo =
        char buf[1024];
        size_t msg_len = 1024;
        const struct timespec abs_timeout = {1000,0};//* seconds *//* nanoseconds */
        int i = 0;
        for( i = 0; i < 10; i++)
        {
            //ssize_t mqsize =  mq_timedreceive( mqdes, buf,  msg_len, NULL, &abs_timeout);
            ssize_t mqsize =  mq_receive( mqdes, buf,  msg_len, NULL);
            if( mqsize < 0 )
            {
                if(errno == EAGAIN)
                {
                    printf("the mq is empty and nonblockn");
                //printf("timeout n");
                }
    
                printf("timeout n");
                continue;
            }
            printf("received msg:%sn",buf);
        }
    }


编译，注意-lrt参数：
$gcc -o testmsg -lrt testmqs.c
执行：

    
    zhouhh@zhh64:~/sms$ ./testmsg
    mq_open error: Invalid argument


修改mq_open行为

mqd_t mqdes = mq_open("/home/zhouhh/testmymq",O_RDWR|O_CREAT, FILE_MODE,NULL);

编译执行：
zhouhh@zhh64:~/sms$ ./testmsg
mq_open error: No such file or directory

man 7 mq_review
说要在前面加“/”，但mq的名字不要再有其他的“/”。
修改mq_open行为

mqd_t mqdes = mq_open("/testmymq",O_RDWR|O_CREAT, FILE_MODE,NULL);

编译执行：

zhouhh@zhh64:~/sms$ ./testmsg
mq_open error: Permission denied

mqueue的大多数错误都被我碰到了。

根据高人指点，新建/dev/mqueue目录，将mqueue类型的none mount到/dev/mqueue：

```
zhouhh@zhh64:/dev$ sudo mkdir mqueue
zhouhh@zhh64:/dev$ sudo mount -t mqueue none /dev/mqueue
```

执行：
zhouhh@zhh64:~/sms$ ./testmsg
成功（但mq_receive并没有阻塞）。
zhouhh@zhh64:/dev/mqueue$ ls
testmymq
