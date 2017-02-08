---
author: abloz
comments: true
date: 2013-01-23 12:01:41+00:00
layout: post
link: http://abloz.com/index.php/2013/01/23/flume-shell-command-and-web-interface-to-perform-different/
slug: flume-shell-command-and-web-interface-to-perform-different
title: flume shell 和web界面执行命令的不同
wordpress_id: 2089
categories:
- 技术
tags:
- flume
- shell
---

周海汉

2013.1.23

web ui上执行，用管道符：

    
    
    agent1: tail("/home/zhouhh/cars.csv") | logicalSink("collect1");
    agent2: tail("/home/zhouhh/cars.csv") | logicalSink("collect1");
    collect1: logicalSource | collectorSink("hdfs://hadoop48:54310/user/flume/%y%m/%d","%{host}-",5000,seqfile);
    




在flume shell中执行，格式是cmd subcmd nodename 'source' 'sink'，source和sink里面的引号用双引号：


    
    
    [zhouhh@Hadoop46 ~]$ flume shell -c hadoop48
    [flume hadoop48:35873:45678] exec config co1 'collectorSource( 35853 )' 'collectorSink( "hdfs://hadoop48:54310/user/flume/%y%m/%d","test-",5000,seqfile)'
    [id: 7] Execing command : config
    Command succeeded
    
    [flume hadoop48:35873:45678] exec config 'collectorSource( 35853 )', 'collectorSink( "hdfs://hadoop48:54310/user/flume/%y%m/%d",'test-',5000)'
    Failed to run command 'exec config 'collectorSource( 35853 )', 'collectorSink( "hdfs://hadoop48:54310/user/flume/%y%m/%d",'test-',5000)'' due to null
    2013-01-23 18:46:57,811 [main] ERROR util.FlumeShell: Failed to run command 'exec config 'collectorSource( 35853 )', 'collectorSink( "hdfs://hadoop48:54310/user/flume/%y%m/%d",'test-',5000)''
    [flume hadoop48:35873:45678] exec config 'collectorSource( 35853 )' 'collectorSink( "hdfs://hadoop48:54310/user/flume/%y%m/%d","test-",5000)'
    [id: 5] Execing command : config
    Command failed
    null
    
    [flume hadoop48:35873:45678] exec config ag1 tail('/home/zhouhh/cars.csv') console
    Failed to run command 'exec config ag1 tail('/home/zhouhh/cars.csv') console' due to null
    2013-01-23 18:37:58,794 [main] ERROR util.FlumeShell: Failed to run command 'exec config ag1 tail('/home/zhouhh/cars.csv') console'
    [flume hadoop48:35873:45678] exec config co1 'collectorSource( 35853 )' 'collectorSink( "hdfs://hadoop48:54310/user/flume/%y%m/%d","test-",5000)'
    [id: 6] Execing command : config
    Command succeeded
    
    [flume hadoop48:35873:45678] help
    I know about these commands:
    
    connect host[:adminport=35873[:reportport=45678]]
    exec (requires a command and arguments)
    exec config node 'source' 'sink'
    exec decommission logicalnode
    exec map physicalnode logicalnode
    exec multiconfig 'spec'
    exec noop [delaymillis (no arg means no wait)]
    exec refresh 'spec'
    exec refreshAll
    exec setChokeLimit physicalnode chokeid limit
    exec spawn physicalnode logicalnode (synonym for exec map. deprecated.)
    exec unmap physicalnode logicalnode
    exec unmapAll
    getconfigs
    getmappings [physical node]
    getnodestatus
    getreports
    help
    quit
    source load a file and execute flume shell commands in it
    submit (requires a command and arguments)
    submit config node 'source' 'sink'
    submit decommission logicalnode
    submit map physicalnode logicalnode
    submit multiconfig 'spec'
    submit noop
    submit refresh 'spec'
    submit refreshAll
    submit spawn physicalnode logicalnode (synonym for submit map. deprecated.)
    submit unmap physicalnode logicalnode
    submit unmapAll
    wait [maxmillis (0==infinite) [, cmdid]]
    waitForNodesActive [maxmillis (0==infinite) [, node[, ...]]]
    waitForNodesDone [maxmillis (0==infinite) [, node[, ...]]]
    
