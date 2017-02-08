---
author: abloz
comments: true
date: 2012-09-11 08:43:35+00:00
layout: post
link: http://abloz.com/index.php/2012/09/11/mysql-user-score-ranking/
slug: mysql-user-score-ranking
title: mysql 中对用户分数排名
wordpress_id: 1860
categories:
- 技术
tags:
- mysql
- procedure
---

周海汉/文
2012.9.11

mysql 不提供排名函数，所以需自己去实现。
排序先用mapreduce进行，但对于相同成绩的，其排名应该一样。而mapreduce由于没有先后关系的数据，所以没法做这工作。可以在应用程序中将数据循环读出，再判断是否分数相等，如果相等，则其名次相等。也可以在mysql 5.0以后的版本中，采用存储过程来实现。

需求中还需要单独取一个用户资料时，也得到其正确的排名数据。所以客户端临时排名不合适。服务器端临时排名也不合适。必须将排好名的数据写在数据库里。

**准备**
先创建表：
mysql> desc mysort;
+---------+-------------+------+-----+---------+----------------+
| Field   | Type        | Null | Key | Default | Extra          |
+---------+-------------+------+-----+---------+----------------+
| id      | int(11)     | NO   | PRI | NULL    | auto_increment |
| name    | varchar(20) | YES  |     | NULL    |                |
| score   | int(11)     | YES  |     | NULL    |                |
| rank    | int(11)     | YES  |     | NULL    |                |
| caldate | varchar(20) | YES  |     | NULL    |                |
| userid  | int(11)     | YES  |     | NULL    |                |
+---------+-------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)

    
    
     CREATE TABLE `mysort` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `name` varchar(20) DEFAULT NULL,
      `score` int(11) DEFAULT NULL,
      `rank` int(11) DEFAULT NULL,
      `caldate` varchar(20) DEFAULT NULL,
      `userid` int(11) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1
    



插入数据
mysql> select * from mysort;
+----+------+-------+------+---------------+--------+
| id | name | score | rank | caldate       | userid |
+----+------+-------+------+---------------+--------+
|  1 | a1   |    10 |    1 | 2012-09-10_24 |    151 |
|  2 | a2   |     8 |    2 | 2012-09-10_24 |    131 |
|  3 | a3   |     8 |    3 | 2012-09-10_24 |     12 |
|  4 | a4   |     1 |    6 | 2012-09-10_24 |     11 |
|  5 | a5   |     2 |    4 | 2012-09-10_24 |    211 |
|  6 | a6   |     2 |    5 | 2012-09-10_24 |    212 |
+----+------+-------+------+---------------+--------+
可见其排名是正确的，唯一有问题的地方是相同分数排名不一样，用户会觉得不公平。

目标要排名后成为：
+----+------+-------+------+---------------+--------+
| id | name | score | rank | caldate       | userid |
+----+------+-------+------+---------------+--------+
|  1 | a1   |    10 |    1 | 2012-09-10_24 |    151 |
|  2 | a2   |     8 |    2 | 2012-09-10_24 |    131 |
|  3 | a3   |     8 |    2 | 2012-09-10_24 |     12 |
|  5 | a5   |     2 |    4 | 2012-09-10_24 |    211 |
|  6 | a6   |     2 |    4 | 2012-09-10_24 |    212 |
|  4 | a4   |     1 |    6 | 2012-09-10_24 |     11 |
+----+------+-------+------+---------------+--------+

rank 的排名是一致的。这样保证相同分数score的人排名是一个。

**单纯排名，可以有重复**
对于不用更新数据库的方式，或者更新到临时表中的方式，最简单：

    
    
    mysql> set @rank:=0;
    mysql> select @rank:=@rank+1 as rank,id,name,score from mysort order by score desc;
    +------+----+------+-------+
    | rank | id | name | score |
    +------+----+------+-------+
    |    1 |  1 | a1   |    10 |
    |    2 |  2 | a2   |     8 |
    |    3 |  3 | a3   |     8 |
    |    4 |  5 | a5   |     2 |
    |    5 |  6 | a6   |     2 |
    |    6 |  4 | a4   |     1 |
    +------+----+------+-------+
    rank是排过名后的，只是对分数相同的排名有先后，而且没有更新到表中。这对数据量少，只是显示，是一种最简便的排名方法。
    



**另外一种排名，有select子句，所以效率较差**

    
    
    mysql> select * from (select (select count(id)+1 from mysort where score>a.score) as arank,a.name, a.score from mysort a) b  order by b.arank;
    +-------+------+-------+
    | arank | name | score |
    +-------+------+-------+
    |     1 | a1   |    10 |
    |     2 | a2   |     8 |
    |     2 | a3   |     8 |
    |     4 | a5   |     2 |
    |     4 | a6   |     2 |
    |     6 | a4   |     1 |
    +-------+------+-------+
    6 rows in set (0.00 sec)
    
    


但这个排名是满足要求的，只是没有写到表中，如果可以将整个数据导到另一个表，也是一种可行的办法。

**第三种，用存储过程。**
在mysql 5.0以上的版本，支持存储过程。
本代码是mysql存储过程实例，将表和时间做成了参数。

    
    
    CREATE PROCEDURE p(in tname varchar(100),in cdate varchar(20))
    BEGIN
    
      DECLARE done BOOLEAN DEFAULT FALSE;
    
      DECLARE auid INT;
      DECLARE ascore,arank INT;
    
      DECLARE cur1 CURSOR  FOR SELECT rank,userid,score FROM myview;
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
      drop view if exists myview;
    
      SET @last_score =0;
      SET @last_rank =0;
      SET @last_uid =0;
      SET @myuid=0;
      SET @myrank=0;
    
      SET  @cmdc=concat("create view myview as SELECT rank,userid,score FROM  ", tname,"  WHERE caldate='",cdate, "' ORDER BY rank" );
      PREPARE pcursor FROM @cmdc;
      EXECUTE pcursor;
      DEALLOCATE PREPARE pcursor;
    
      SET @cmdu = concat("update ",tname," set rank=? where userid=? ");
      PREPARE pupdate FROM @cmdu;
    
      OPEN cur1;
    
      read_loop: LOOP
        FETCH cur1 INTO arank,auid,ascore;
    
        IF done THEN
          LEAVE read_loop;
        END IF;
    
        IF ascore = @last_score THEN
          select auid,@last_rank;
          IF @myrank=0 THEN
              set  @myrank:=@last_rank;
          END IF;
    
          set @myuid:=auid;
    
          EXECUTE pupdate USING @myrank,@myuid;
        ELSE
          set   @myrank:=0;
        END IF;
        SELECT arank,auid,ascore INTO @last_rank,@last_uid,@last_score;
      END LOOP;
    
      DEALLOCATE PREPARE pupdate;
      CLOSE cur1;
    
    END;
    


这里要注意一个陷阱，就是更新数据后，游标并不能得到新数据。

本存储过程用到如下几个知识点：
1.存储过程参数
2.表名做为存储过程的参数传入
3.游标使用，因为返回多行数据，需要针对每一行进行处理，所以用游标。
4.视图。游标不支持表名做为参数，所以创建了一个视图view
5.语句组建，采用prepare和execute及字符串处理concat函数。
6.局部变量和session变量使用，赋值和判断。set 赋值可以用=或:=;select 赋值必须用:=;@变量是session变量，不需声明。局部变量需声明。
7.if 语句
8.循环
9.如何判断数据读取结束，也可以用这句：DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET bOVER=TRUE;SQLSTATE '02000'就是结束。

**调用**
在mysql命令行下，先设置结束符：
mysql> delimiter //
再输入edit
在vi中输入以上存储过程，保存。
调用：

    
    
    mysql> delimiter //
    mysql> edit
        -> //
    Query OK, 0 rows affected (0.00 sec)
    
    mysql> call p('mysort','2012-09-10_24');
        -> //
    Query OK, 0 rows affected (0.05 sec)
    
    mysql> select * from mysort order by rank;
        -> //
    +----+------+-------+------+---------------+--------+
    | id | name | score | rank | caldate       | userid |
    +----+------+-------+------+---------------+--------+
    |  1 | a1   |    10 |    1 | 2012-09-10_24 |    151 |
    |  2 | a2   |     8 |    2 | 2012-09-10_24 |    131 |
    |  3 | a3   |     8 |    2 | 2012-09-10_24 |     12 |
    |  5 | a5   |     2 |    4 | 2012-09-10_24 |    211 |
    |  6 | a6   |     2 |    4 | 2012-09-10_24 |    212 |
    |  4 | a4   |     1 |    6 | 2012-09-10_24 |     11 |
    +----+------+-------+------+---------------+--------+
    6 rows in set (0.00 sec)
    
    



**存储过程操作**
最后，如果要查看有哪些存储过程列表：

    
    
    mysql> show procedure status;
    


如果要查看存储过程内容：

    
    
    mysql> show create procedure p;
    


如果要更新存储过程，可以先删除，再创建。

    
    
    mysql> drop procedure p;
    


p是我的存储过程名字。

**mysql存储过程调试**
我没用什么客户端ide，我直接select相关变量输出。

**参考**
排名方法讨论：
http://www.ericyue.info/archive/mysql-seek-rankings

mysql变量使用总结
http://www.cnblogs.com/wangtao_20/archive/2011/02/21/1959734.html
