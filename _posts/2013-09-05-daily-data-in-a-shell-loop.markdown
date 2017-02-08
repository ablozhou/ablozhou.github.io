---
author: abloz
comments: true
date: 2013-09-05 03:46:32+00:00
layout: post
link: http://abloz.com/index.php/2013/09/05/daily-data-in-a-shell-loop/
slug: daily-data-in-a-shell-loop
title: 在 shell 循环处理每天数据
wordpress_id: 2217
categories:
- 技术
tags:
- bash
---

周海汉/文  2013.9.5
日期循环，在处理某些按日期存放的数据中很有用。尤其是测试和补录，删除，重新处理数据。但是如果遇到跨月等情况，单纯用数值循环是不行的。
本shell即可用于处理多日数据情况。


    
    
    #!/usr/bin/env bash
    #author: Andy Zhou
    #Date:2013.8.6
    
    source dateutil.sh
    begin=20130701
    end=20130904
    
    for (( d=$begin; d<=$end; d=`getnextday $d `)); do
    echo "date:"$d
    #. myshell.sh $d
    



日期工具 dateutil.sh：

    
    
    #/usr/bin/env bash
    #author:Andy Zhou
    #date:2013.8.2
    getnextday()
    {
        #date -d "2013-09-10 +1 day " +%Y-%m-%d
        date -d "$1 +1 day " +%Y%m%d
    }
    getyearmonth()
    {
        date +%Y%m --date=$1 #shortdate
    }
    getday()
    {
        date +%d --date=$1 #shortdate
    }
    
    long_date()
    {
        date +%Y-%m-%d --date=$1 #shortdate
    }
    short_date()
    {
        date +%Y%m%d --date=$1 #longdate
    }
    long_yesterday()
    {
         date --date='1 day ago' +%Y-%m-%d
    }
    yesterday()
    {
         date --date='1 day ago' +%Y%m%d
    }
    long_today()
    {
        date +%Y-%m-%d
    }
    today()
    {
        date +%Y%m%d
    }
    now()
    {
        date '+%Y-%m-%d %H:%M:%S'
    }
    last_month()
    {
        date --date='1 month ago' '+%Y%m'
    }
    year()
    {
         date +%Y
    }
    month()
    {
        date +%m
    }
    sec2date()
    {
         date -d "1970-01-01 UTC $1 seconds" "+%Y%m%d"
    }
    sec2datetime()
    {
         date -d "1970-01-01 UTC $1 seconds" "+%Y%m%d %H:%M:%S"
    }
    
    
