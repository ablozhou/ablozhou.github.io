---
author: abloz
comments: true
date: 2012-07-05 05:28:31+00:00
layout: post
link: http://abloz.com/index.php/2012/07/05/qperf-measured-network-bandwidth-and-latency/
slug: qperf-measured-network-bandwidth-and-latency
title: 用qperf测网络带宽和延迟
wordpress_id: 1757
categories:
- 技术
tags:
- linux
- qperf
---

http://abloz.com
date:2012.7.5

[yufeng的blog](http://blog.yufeng.info/archives/2234)谈到qperf来测试网络带宽和延迟，试用了一下，感觉不错。

Hadoop47当服务器

    
    
    [zhouhh@Hadoop47 ~]$ sudo yum install qperf
    [zhouhh@Hadoop47 ~]$ qperf
    



Hadoop48当客户端

    
    
    [zhouhh@Hadoop48 ~]$ sudo yum install qperf
    
    [zhouhh@Hadoop48 ~]$ qperf Hadoop47 tcp_bw tcp_lat
    tcp_bw:
        bw  =  115 MB/sec
    tcp_lat:
        latency  =  93.3 us
    


内网虚拟机，带宽115MB和延迟93us，正常范围。

再测试一下发包从1个字节到64k个字节，每次翻倍的数据。--loop表示循环：

    
    
    [zhouhh@Hadoop48 ~]$ qperf Hadoop47 --loop msg_size:1:64K:*2 tcp_bw tcp_lat
    tcp_bw:
        bw  =  5.38 MB/sec
    tcp_bw:
        bw  =  10.5 MB/sec
    tcp_bw:
        bw  =  20.1 MB/sec
    tcp_bw:
        bw  =  40.4 MB/sec
    tcp_bw:
        bw  =  76.8 MB/sec
    tcp_bw:
        bw  =  115 MB/sec
    tcp_bw:
        bw  =  116 MB/sec
    tcp_bw:
        bw  =  116 MB/sec
    tcp_bw:
        bw  =  115 MB/sec
    tcp_bw:
        bw  =  116 MB/sec
    tcp_bw:
        bw  =  115 MB/sec
    tcp_bw:
        bw  =  115 MB/sec
    tcp_bw:
        bw  =  115 MB/sec
    tcp_bw:
        bw  =  115 MB/sec
    tcp_bw:
        bw  =  115 MB/sec
    tcp_bw:
        bw  =  115 MB/sec
    tcp_bw:
        bw  =  116 MB/sec
    
    tcp_lat:
        latency  =  94 us
    tcp_lat:
        latency  =  96 us
    tcp_lat:
        latency  =  96.1 us
    tcp_lat:
        latency  =  93.5 us
    tcp_lat:
        latency  =  95.1 us
    tcp_lat:
        latency  =  98.7 us
    tcp_lat:
        latency  =  97.7 us
    tcp_lat:
        latency  =  95 us
    tcp_lat:
        latency  =  99.2 us
    tcp_lat:
        latency  =  106 us
    tcp_lat:
        latency  =  120 us
    tcp_lat:
        latency  =  146 us
    tcp_lat:
        latency  =  157 us
    tcp_lat:
        latency  =  204 us
    tcp_lat:
        latency  =  299 us
    tcp_lat:
        latency  =  436 us
    tcp_lat:
        latency  =  724 us
    


可见每个包32字节基本带宽趋近最大，延迟数据在包达到8k以上，延迟变得较大，达204us。

该工具还可以测试udp，指定端口，设置mtu大小等，功能强大。下面是其自带示例：

    
    
    [zhouhh@Hadoop47 ~]$ qperf --help examples
    In these examples, we first run qperf on a node called myserver in server
    mode by invoking it with no arguments.  In all the subsequent examples, we
    run qperf on another node and connect to the server which we assume has a
    hostname of myserver.
        * To run a TCP bandwidth and latency test:
            qperf myserver tcp_bw tcp_lat
        * To run a SDP bandwidth test for 10 seconds:
            qperf myserver -t 10 sdp_bw
        * To run a UDP latency test and then cause the server to terminate:
            qperf myserver udp_lat quit
        * To measure the RDMA UD latency and bandwidth:
            qperf myserver ud_lat ud_bw
        * To measure RDMA UC bi-directional bandwidth:
            qperf myserver rc_bi_bw
        * To get a range of TCP latencies with a message size from 1 to 64K
            qperf myserver -oo msg_size:1:64K:*2 -vu tcp_lat
    
    



