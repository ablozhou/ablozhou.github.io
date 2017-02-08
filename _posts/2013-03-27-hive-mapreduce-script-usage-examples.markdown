---
author: abloz
comments: true
date: 2013-03-27 10:42:44+00:00
layout: post
link: http://abloz.com/index.php/2013/03/27/hive-mapreduce-script-usage-examples/
slug: hive-mapreduce-script-usage-examples
title: hive mapreduce script用法示例
wordpress_id: 2165
categories:
- 技术
tags:
- hadoop
- hive
---

周海汉/文
2013.3.27


对于一些hql语句特殊处理，hive本身没有提供相应功能，可以有两种方式，一是mapreduce script，二是写UDF，UDAF，UDTF等。后者需要调用hive提供的api。前者则类似mapreduce的stream模式，只需正确处理输入输出即可。
所以mapreduce脚本进行一些简单处理还是很方便的。

本例想计算德州扑克玩家是否赢牌，算法是：如果弃牌或所赢筹码为NULL，则输。如果有赢边池或底池的筹码，也不一定赢。要用底池+边池筹码-所投注数，如果大于0，则一定赢了。
现在底池边池筹码是不固定的，格式如下：
0:筹码|1:筹码|2:筹码|...
0表示底池，1,2等index表示不同的边池，最多8个边池。
用python来分析

cat calcwin.py

    
    
    #!/usr/bin/env python
    # coding:utf8
    # author zhouhh
    # date :2013-03-27
    
    import sys
    import datetime
    
    def calcwin():
        for line in sys.stdin:
    
            (ldate,userid,roundbet,fold,allin,chipwon)=line.strip().split()
            win = '0'
            if fold=='1':
    
                print 't'.join(["%s:%s"%(ldate,userid),win,fold,allin])
                continue
            cw = []
            if chipwon == "NULL":
                print 't'.join(["%s:%s"%(ldate,userid),win,fold,allin])
                continue
            #print "userid win ",userid
            cw=chipwon.split('|')
            chipwonv=0
            roundbetv=int(roundbet)
            for v in cw:
                chipwonv += int(v.split(':')[1])
    
    
            if chipwonv > roundbetv:
                win = '1'
    
            print 't'.join(["%s:%s"%(ldate,userid),win,fold,allin])
    calcwin()
    


原始数据格式：

    
    
    hive> !hadoop fs -cat /flume/test/testpoker;
    03/13/13 14:59:51 00000ab4 1009 185690475 8639 240 1 0 -1 NULL NULL
    03/13/13 14:59:51 00000cb4 1009 187270278 92030 600 1 0 -1 NULL NULL
    03/13/13 14:59:52 000003d8 1009 184151687 8639 600 1 0 -1 NULL NULL
    03/13/13 14:59:52 00000ba8 1009 186012530 8593 154135 0 1 7 8|21|16|42|39 0:73250|1:60500|2:100135
    03/13/13 14:59:52 00000a88 1009 180286243 92041 100 1 0 -1 NULL NULL
    03/13/13 14:59:52 00000ad8 1009 163003653 2829 40 1 0 -1 NULL NULL
    03/13/13 14:59:54 000002ac 1009 183824880 8639 1200 0 0 -1 NULL 0:1900
    03/13/13 14:59:55 0000091c 1009 173274868 92030 600 0 0 -1 NULL 0:1150
    
    


然后，在hive命名行添加calcwin.py

    
    
    hive> add file calcwin.py
    hive> from testpoker select transform(ldate,userid,roundbet,fold,allin,chipwon) using 'calcpoker.py' as (key,win,fold,allin) ;
    ...
    OK
    03/13/13:185690475      0       1       0
    03/13/13:187270278      0       1       0
    03/13/13:184151687      0       1       0
    03/13/13:186012530      1       0       1
    
