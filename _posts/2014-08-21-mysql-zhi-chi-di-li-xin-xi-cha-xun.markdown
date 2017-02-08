---
author: abloz
comments: true
date: 2014-08-21 10:24:21+00:00
layout: post
link: http://abloz.com/index.php/2014/08/21/mysql-zhi-chi-di-li-xin-xi-cha-xun/
slug: mysql-zhi-chi-di-li-xin-xi-cha-xun
title: mysql 支持地理信息查询
wordpress_id: 2262
categories:
- 技术
---

周海汉 2014.8.21
mysql> create table geom(g geometry);
mysql> desc geom;
+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| g     | geometry | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+
1 row in set (0.01 sec)
mysql> insert into geom set g=geomfromtext('point(1 1)');
Query OK, 1 row affected (0.00 sec)
mysql> insert into geom set g=geomfromtext('point(1000 1000)');
Query OK, 1 row affected (0.00 sec)
mysql> select * from geom;
+---------------------------+
| g                         |
+---------------------------+
|              ??      ??   |
|             @?@     @?@   |
+---------------------------+
5 rows in set (0.00 sec)
mysql> select astext(g) from geom;
+------------------+
| astext(g)        |
+------------------+
| POINT(1 1)       |
| POINT(1000 1000) |
+------------------+
5 rows in set (0.00 sec)

ALTER TABLE geom ADD pt POINT;ALTER TABLE geom DROP pt;

mysql> select g from geom where g= point(1,1);
+---------------------------+
| g                         |
+---------------------------+
|              ??      ??   |
+---------------------------+
1 row in set (0.00 sec)

mysql> help geometry;
Name: 'GEOMETRY'
Description:
MySQL provides a standard way of creating spatial columns for geometry
types, for example, with CREATE TABLE or ALTER TABLE. Currently,
spatial columns are supported for MyISAM, InnoDB, NDB, and ARCHIVE
tables. See also the annotations about spatial indexes under [HELP
SPATIAL].

URL: http://dev.mysql.com/doc/refman/5.6/en/creating-spatial-columns.html

Examples:
CREATE TABLE geom (g GEOMETRY);



mysql> select astext(g) from geom where g= point(1,1);
+------------+
| astext(g)  |
+------------+
| POINT(1 1) |
+------------+
1 row in set (0.00 sec)

UPDATE myTable
SET Coord = PointFromText(CONCAT('POINT(',myTable.DLong,' ',myTable.DLat,')'));


创建表并填入数据的方式，可以直接通过经纬度来导入数据：
CREATE TABLE `table_with_a_point` (
`id` bigint(20) not null,
`location` point not NULL,
`latitude` float default NULL,
`longitude` float default NULL,
`value` int(11) not null,
PRIMARY KEY (`id`)
);
create spatial index table_with_a_point_index on table_with_a_point(location);


LOAD DATA LOCAL INFILE 'somedata.txt'
INTO TABLE table_with_a_point
COLUMNS TERMINATED BY ' ' LINES TERMINATED BY 'rn'
(id, latitude, longitude, value)
set location = PointFromText(CONCAT('POINT(',latitude,' ',longitude,')'));

CREATE TABLE geom (g GEOMETRY NOT NULL, SPATIAL INDEX(g)) ENGINE=MyISAM;
ALTER TABLE geom ADD SPATIAL INDEX(g);
CREATE SPATIAL INDEX sp_index ON geom (g);



查找矩形中是否包含相应的点:

mysql> set @poly='polygon((0 0,0 1001,1001 1001,1001 0,0 0))';
Query OK, 0 rows affected (0.00 sec)
注意polygon后的两层括号，否则会出错。

mysql> select astext(g) from geom where mbrcontains(geomfromtext(@poly),g);
+------------------+
| astext(g)        |
+------------------+
| POINT(1 1)       |
| POINT(1000 1000) |
+------------------+
2 rows in set (0.00 sec)

mysql> set @poly='polygon((0 0,0 1000,1000 1000,1000 0,0 0))';
Query OK, 0 rows affected (0.00 sec)

mysql> select astext(g) from geom where mbrcontains(geomfromtext(@poly),g);
+------------------+
| astext(g)        |
+------------------+
| POINT(1 1)       |
| POINT(1000 1000) |
+------------------+
2 rows in set (0.00 sec)

mysql> set @poly='polygon((0 0,0 100,100 100,100 0,0 0))';
Query OK, 0 rows affected (0.00 sec)

mysql> select astext(g) from geom where mbrcontains(geomfromtext(@poly),g);
+------------+
| astext(g)  |
+------------+
| POINT(1 1) |
+------------+
1 row in set (0.00 sec)



参考：

http://dev.mysql.com/doc/refman/5.6/en/using-spatial-data.html
