---
author: abloz
comments: true
date: 2012-08-28 09:02:46+00:00
layout: post
link: http://abloz.com/index.php/2012/08/28/remote-monitoring-of-the-machines-memory-and-alarm/
slug: remote-monitoring-of-the-machines-memory-and-alarm
title: 远程监测各机器内存并告警
wordpress_id: 1838
categories:
- 技术
---

hadoop系统很耗内存，虽然内存不像磁盘那样很难自动恢复，但有时内存耗尽也会引起程序崩溃。这在hadoop的mapreduce job运行时算是常见问题。
用bash脚本监控：


    
    
    #!/bin/bash
    # zhouhh 2012.8.17
    source config.sh
    
    export total=0
    used=0
    free=0
    export realused=0
    realfree=0
    usep=0
    
    for ahost in ${hosts[@]};
    do
        echo "====host:$ahost===="
        #item,total,used,free
        ssh -f $ahost 'free -m' | grep -vE 'total|^Swap' | awk '{ print $1 " " $2 " " $3 " " $4 }' | while read output;
        do
          #echo $output
          if echo $output | grep -q  "^Mem:" ; then
              total=$(echo $output | awk '{ print $2}')
              used=$(echo $output | awk '{ print $3}')
              free=$(echo $output | awk '{ print $4}')
              #echo "$ahost total mem:$total"
              echo $total>.total
          fi
          if echo $output | grep -q  "^-/+" ; then
              let realused=$(echo $output | awk '{ print $3}')
              realfree=$(echo $output | awk '{ print $4}')
              echo "$ahost  real used:$realused,real free:$realfree"
              echo $realused > .realused
          fi
        done
    
        realused=$(cat .realused)
        total=$(cat .total)
    
        #echo "readused:$realused"
        #echo "total:$total"
        let usep=($realused*100)/$total
        #echo "usep:$usep"
        if [ $usep -ge $MEMALERT ]; then
            echo "[$(date +%y-%m-%d,%T)] [$ahost] $partition ($usep%) Running out of memory. "
            echo "[$(date +%y-%m-%d,%T)] [$ahost] $partition ($usep%) Running out of memory. " >> $MEMMSG
            source failhandle.sh -m $MEMMSG -t $MTITLE -c $MFCOUNT
        fi
        echo ""
    
    done
    


由于管道导致子shell无法通知父shell变量的改变，所以变通一下，直接写到文件里。处理完后再读出文件，计算百分比。
在free命令中，第一行Mem是操作系统看到的总内存和可用内存。 第二行-buffers/cache 和+buffers/cache从应用程序角度看到的已使用内存和可用内存。
buffer和cache有细微差别。buffer指还没写到磁盘的内存数据。cache指从磁盘读出到内存中的数据，下次还可以使用。
因此我们以-/+ buffers/cache来做真实内存数据的计算。

参考
free命令详解
[http://www.cnblogs.com/coldplayerest/archive/2010/02/20/1669949.html](http://www.cnblogs.com/coldplayerest/archive/2010/02/20/1669949.html)
