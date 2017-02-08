---
author: abloz
comments: true
date: 2012-10-18 03:12:46+00:00
layout: post
link: http://abloz.com/index.php/2012/10/18/write-a-simple-script-to-test-the-site-efficiency/
slug: write-a-simple-script-to-test-the-site-efficiency
title: 写个简单脚本来测试网站效率
wordpress_id: 1908
categories:
- 技术
tags:
- hadoop
- hbase
- php
- thrift
- 性能
---

from:http://abloz.com/2012/10/18/write-a-simple-script-to-test-the-site-efficiency.html

用time 来测试网站获取效率，for循环，curl获取网站。不是并发的。该脚本用于测试php通过thrift单个查询HBase的效率

[root@Hadoop48 html]# cat test.sh

    
    
    #!/bin/bash
    if [ $# -ge 1 ]; then
        max=$1
    else
        max=10
    fi
    #for i in {1..10}; do
    #for ((i=1;i<=max;i++)); do
    for i in $(seq 1 $max); do
        echo "$i:"
        curl -d "tablename=award_1210&startrow;=2012-10-08+20%3A58%3A52%3A144945354%0D%0A2012-10-08+20%3A55%3A52%3A144945354" http://hadoop48/get.php
    done
    


脚本执行：

    
    
    [root@Hadoop48 html]# time -p ./test.sh 1000 >log
    ...
    real 26.11
    user 0.53
    sys 0.73
    
