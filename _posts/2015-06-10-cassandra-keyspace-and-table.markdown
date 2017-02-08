---
author: abloz
comments: true
date: 2015-06-10 12:08:06+00:00
layout: post
link: http://abloz.com/index.php/2015/06/10/cassandra-keyspace-and-table/
slug: cassandra-keyspace-and-table
title: cassandra 查询keyspace和表
wordpress_id: 2693
categories:
- 技术
tags:
- cassandra
---

周海汉 2015.6.10




查询keyspace，可以在系统表中查询：




cqlsh> use system;




cqlsh:system> select * from schema_keyspaces;







    
    cqlsh:system> select * from schema_keyspaces;
    
     keyspace_name         | durable_writes | strategy_class                              | strategy_options
    -----------------------+----------------+---------------------------------------------+----------------------------
     Usergrid_Applications |           True | org.apache.cassandra.locator.SimpleStrategy | {"replication_factor":"1"}
                  Usergrid |           True | org.apache.cassandra.locator.SimpleStrategy | {"replication_factor":"1"}
                    system |           True |  org.apache.cassandra.locator.LocalStrategy |                         {}
                mykeyspace |           True | org.apache.cassandra.locator.SimpleStrategy | {"replication_factor":"1"}
             system_traces |           True | org.apache.cassandra.locator.SimpleStrategy | {"replication_factor":"2"}
    
    (5 rows)
    




查询keyspace，也可以用describe




cqlsh:Usergrid> DESCRIBE KEYSPACES;




"Usergrid_Applications" mykeyspace system "Usergrid” system_traces




使用keyspace时可能需要引号。




cqlsh:mykeyspace> use Usergrid;




InvalidRequest: code=2200 [Invalid query] message="Keyspace 'usergrid' does not exist"




此处必须加双引号，才能正确切换keyspace




cqlsh:mykeyspace> use "Usergrid";




cqlsh:Usergrid>




显示表名。




cqlsh:Usergrid> DESCRIBE TABLES;




"Tokens" "Applications" "PrincipalTokens" "Properties"







cqlsh:Usergrid> DESCRIBE  SCHEMA




CREATE KEYSPACE "Usergrid_Applications" WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}  AND durable_writes = true;




CREATE TABLE "Usergrid_Applications"."Entity_Properties" (




。。。
