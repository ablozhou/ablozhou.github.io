---
author: abloz
comments: true
date: 2012-11-13 02:03:25+00:00
layout: post
link: http://abloz.com/index.php/2012/11/13/django-read-mysql-chinese-garbled/
slug: django-read-mysql-chinese-garbled
title: django 读取mysql中文乱码问题
wordpress_id: 1971
categories:
- 技术
tags:
- django
- mysql
- 乱码
---


    mysql> show variables like "char%";
    +--------------------------+----------------------------+
    | Variable_name            | Value                      |
    +--------------------------+----------------------------+
    | character_set_client     | utf8                       |
    | character_set_connection | utf8                       |
    | character_set_database   | utf8                       |
    | character_set_filesystem | binary                     |
    | character_set_results    | utf8                       |
    | character_set_server     | utf8                       |
    | character_set_system     | utf8                       |
    | character_sets_dir       | /usr/share/mysql/charsets/ |
    +--------------------------+----------------------------+
    8 rows in set (0.00 sec)
    


读取mysql

    
    
    
    [zhouhh@Hadoop47 t3]$ cat product.py
    from django.shortcuts import render_to_response
    import MySQLdb
    
    def product_list(request):
        db = MySQLdb.connect(user='root', db='t3', passwd='', host='localhost')
        cursor = db.cursor()
        cursor.execute('SELECT name FROM product ORDER BY name')
        names = [row[0] for row in cursor.fetchall()]
        db.close()
        return render_to_response('product_list.html', {'names': names})
    
    


结果从数据库里取出的name字段的中文都是乱码。但模板中的中文则是正常显示。
碰到这种乱码问题，可能是多方面的原因。
1.mysql 不是utf8编码，此时需设置mysql的环境
修改/etc/my.cnf或windows下的mysql.ini
[client]
default-character-set=utf8
[mysql]
default-character-set=utf8
[mysqld]
default-character-set=utf8
重启mysql
2.模板html文件和python文件没有保存为utf8，并且设置utf8解码，则模板中的中文会显示为乱码。
3.读取时没有指定用utf8来连接。
我的情况是第三种。
将Product.py的connect改为：

    
    
    db = MySQLdb.connect(user='root', db='t3', passwd='', host='localhost',charset='utf8')
    
