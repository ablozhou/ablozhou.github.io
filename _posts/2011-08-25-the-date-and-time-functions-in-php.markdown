---
author: abloz
comments: true
date: 2011-08-25 08:42:21+00:00
layout: post
link: http://abloz.com/index.php/2011/08/25/the-date-and-time-functions-in-php/
slug: the-date-and-time-functions-in-php
title: php中的日期时间函数
wordpress_id: 1368
categories:
- 技术
---

php5.0后支持时区，如果不配置可能会有警告。
1.在php.ini中配置：


    
    
    [Date]
    ; Defines the default timezone used by the date functions
    date.timezone = 'Asia/Shanghai'
    


这样在代码中可以用date_default_timezone_get获取时区。

    
    
    echo date_default_timezone_get();
    echo date('H:i:s');
    date_default_timezone_set('GMT');
    echo date_default_timezone_get();
    echo date('H:i:s');
    


2.在代码中设置

    
    
    date_default_timezone_set("Asia/Shanghai");
    date("D");
    #或
    $dateTime = new DateTime("now", new DateTimeZone('Asia/Shanghai'));
    echo $dateTime->format("Y-m-d H:i:s");
    
    $dateTimeZone = new DateTimeZone('GMT');
    $dateTime->setTimezone($dateTimeZone);
    
    echo $dateTime->format("Y-m-d H:i:s");
    



3.计算时间差
有了时区后，计算时间差麻烦些了

    
    
    function dateDiff($dt1, $dt2, $timeZone = 'GMT')
    {
        $tZone = new DateTimeZone($timeZone);
        $dt1 = new DateTime($dt1, $tZone);
        $dt2 = new DateTime($dt2, $tZone);
    
        $ts1 = $dt1->format('Y-m-d');
        $ts2 = $dt2->format('Y-m-d');
    
        $diff = abs(strtotime($ts1)-strtotime($ts2));
    
        $diff/= 3600*24;
    
        return $diff;
    }
    
    echo dateDiff('20011-08-25', '2008-05-20');
    



4.实现格式化时间类

    
    
    class DTime extends DateTime
    {
        public static $Format = 'Y-m-d H:i;s';
    
        public function __construct($date = null, DateTimeZone $dtz = null)
        {
            if($dtz === null)
            {
                $dtz = new DateTimeZone(date_default_timezone_get());
            }
            parent::__construct($date, $dtz);
        }
    
        public function __toString()
        {
            return (string)parent::format(self::$Format);
        }
    }
    $dTime = new DTime();
    echo $dTime;
    



参考：
http://ditio.net/2008/06/03/php-datetime-and-datetimezone-tutorial/
