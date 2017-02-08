---
author: abloz
comments: true
date: 2008-04-01 09:16:48+00:00
layout: post
link: http://abloz.com/index.php/2008/04/01/batch-modify-bash-script-suffix-names/
slug: batch-modify-bash-script-suffix-names
title: 批量修改后缀名的bash 脚本
wordpress_id: 307
categories:
- 技术
tags:
- bash
---


    #!/bin/sh
    # file name : rename_suffix.sh
    # author: zhouhh
    # blog: http://blog.csdn.net/ablo_zhou
    # Email: ablozhou@gmail.com
    # Date : 2008.4.1
    
    echo "input what suffix will be replaced :"
    read SUFFIX_SRC
    echo "input what suffix of file to rename to:"
    read SUFFIX_DST
    
    
    for i in *.$SUFFIX_SRC
    do
        if [ -e $i ]; then
            echo "mv $i to `basename $i .$SUFFIX_SRC`.$SUFFIX_DST"
            mv $i `basename $i .$SUFFIX_SRC`.$SUFFIX_DST
        else
            echo "file does not exist."
            exit -1
        fi
    
    done
    
