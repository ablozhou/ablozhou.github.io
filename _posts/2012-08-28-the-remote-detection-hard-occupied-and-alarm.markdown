---
author: abloz
comments: true
date: 2012-08-28 08:42:27+00:00
layout: post
link: http://abloz.com/index.php/2012/08/28/the-remote-detection-hard-occupied-and-alarm/
slug: the-remote-detection-hard-occupied-and-alarm
title: 远程检测硬盘占用并告警
wordpress_id: 1836
categories:
- 技术
tags:
- cacti
- disk
- nagios
---

hadoop系统对硬盘消耗很大。所以需要一种远程监控的方法。当然可以用一些现成的工具，如cacti,nagios等工具。也可以自己写脚本，方便管理。


    
    
    #!/bin/bash
    # zhouhh 2012.7.23
    
    source config.sh
    
    for ahost in ${hosts[@]};
    do
    
        echo "===host:$ahost==="
        ssh -f $ahost 'df -H' | grep -vE '^文件系统|^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
        do
          #echo $output
          usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1 )
          partition=$(echo $output | awk '{ print $2 }' )
          if [ $usep -ge $DISALERT ]; then
            echo "[$(date +%y-%m-%d,%T)] [$ahost] $partition ($usep%) Running out of space. " >> $DISKMSG
            echo "-m ${DISKMSG} -t ${DTITLE} -c ${DFCOUNT}"
            source failhandle.sh -m ${DISKMSG} -t ${DTITLE} -c ${DFCOUNT}
          fi
        done
    done
    


在config.sh里面配置hosts变量，指定哪些服务器和告警的百分比$DISALERT。 在failhandle.sh里面决定如何告警。
用ssh 远程执行命令获取结果。-f参数是必须的，否则远程执行后不会返回。
在循环里处理每一个分区的硬盘占用情况，计算百分比。
