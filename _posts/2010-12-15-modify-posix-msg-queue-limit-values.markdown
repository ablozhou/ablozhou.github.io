---
author: abloz
comments: true
date: 2010-12-15 05:55:14+00:00
layout: post
link: http://abloz.com/index.php/2010/12/15/modify-posix-msg-queue-limit-values/
slug: modify-posix-msg-queue-limit-values
title: 修改posix msg queue的限制值
wordpress_id: 1111
categories:
- 技术
tags:
- mqueue
- posix
---

周海汉 2010.12.15
http://abloz.com

mqueue系列限制，限制msg条数，msg大小，queue个数。其中msg条数太小，对于有大量消息的系统，很容易导致queue满。
如何修改呢？

几个限制的缺省值：
zhouhh@zhh64:~$ cat /proc/sys/fs/mqueue/msg_max
10
zhouhh@zhh64:~$ cat /proc/sys/fs/mqueue/msgsize_max
8192
zhouhh@zhh64:~$ cat /proc/sys/fs/mqueue/queues_max
256

此时，struct mq_attr 的mq_maxmsg成员变量如果超过msg_max，在mq_open时会报错。
mq_open error:Invalid argument

zhouhh@zhh64:~$ sudo cat 1000 >/proc/sys/fs/mqueue/msg_max
bash: /proc/sys/fs/mqueue/msg_max: 权限不够
zhouhh@zhh64:~$ sudo vi /proc/sys/fs/mqueue/msg_max
保存
"/proc/sys/fs/mqueue/msg_max" E667: 同步失败

所以不能直接修改/proc下面这些文件。
应该修改/etc/sysctl.conf
zhouhh@zhh64:~$ sudo vi /etc/sysctl.conf
增加：

#mqueue max
fs.mqueue.msg_max=1000
fs.mqueue.msgsize_max=8192
fs.mqueue.queues_max=255

保存，重启系统就已经修改过了。
zhouhh@zhh64:~$ cat /proc/sys/fs/mqueue/msg_max
1000
zhouhh@zhh64:~$ cat /proc/sys/fs/mqueue/msgsize_max
8192
zhouhh@zhh64:~$ cat /proc/sys/fs/mqueue/queues_max
255


