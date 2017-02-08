---
author: abloz
comments: true
date: 2008-03-31 09:09:20+00:00
layout: post
link: http://abloz.com/index.php/2008/03/31/n-copies-of-the-file-copy-bash-script/
slug: n-copies-of-the-file-copy-bash-script
title: 将文件拷贝n份的bash脚本
wordpress_id: 303
categories:
- 技术
tags:
- bash
- linux
---

测试时需要大量文件，所以写了脚本进行拷贝。有规律的文件名利于引用。

    
    
    #!/bin/sh
    # file name : batchcp.sh
    # author: zhouhh
    # blog: http://blog.csdn.net/ablo_zhou
    # Email: ablozhou@gmail.com
    # Date : 2008.3.31
    
    echo "input your file name"
    
    read  FILENAME
    
    echo "how many times you want copy?"
    
    read TIMES
    
    echo "your file name is ${FILENAME}, you want to copy ${TIMES} times."
    
    BASE=`echo ${FILENAME}|cut -d "." -f 1`
    EXT=`echo ${FILENAME}|cut -d "." -f 2`
    
    for(( i=0;i<${TIMES};i++))
    do
    echo "copy ${BASE}.${EXT} to ${BASE}$i.${EXT} ..."
    cp "${BASE}.${EXT}" "${BASE}$i.${EXT}"
    done
    


另一个版本

    
    
    #!/bin/sh
    # file name : batchcp.sh
    # author: zhouhh
    # blog: http://blog.csdn.net/ablo_zhou
    # Email: ablozhou@gmail.com
    # Date : 2008.3.31
    
    echo "input your file name"
    
    read  FILENAME
    
    echo "how many times you want copy?"
    
    read TIMES
    
    echo "your file name is ${FILENAME}, you want to copy ${TIMES} times."
    #find . and cut the left part of the file name using ##
    EXT=${FILENAME##*.}
    #find . and cut the right part of the file name using %
    BASE=${FILENAME%.*}
    echo "base:$BASE"
    echo "ext:$EXT"
    
    for(( i=0;i<${TIMES};i++))
    do
    echo "copy ${BASE}.${EXT} to ${BASE}$i.${EXT} ..."
    cp "${BASE}.${EXT}" "${BASE}$i.${EXT}"
    done
    
