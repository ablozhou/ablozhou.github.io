---
author: abloz
comments: true
date: 2015-06-05 10:03:59+00:00
layout: post
link: http://abloz.com/index.php/2015/06/05/getting-started-with-cassandra-five-minutes/
slug: getting-started-with-cassandra-five-minutes
title: cassandra五分钟入门
wordpress_id: 2660
categories:
- 技术
tags:
- cassandra
---

周海汉 2015.6.5


cassandra是apache开源的著名NoSQL数据库，使用起来非常简单，支持多台扩展，提供swift接口，类sql查询。开发方[用285个node，测试达到每秒100万次写](http://planetcassandra.org/blog/revisiting-1-million-writes-per-second/)。性能还是挺可观的。




**官网**




[http://cassandra.apache.org/download/](http://cassandra.apache.org/download/)




**下载：**




http://mirrors.cnnic.cn/apache/cassandra/2.1.5/apache-cassandra-2.1.5-bin.tar.gz




**安装**




下载的二进制直接解压。如果是deb或rpm安装的，配置文件在/etc/cassandra里。




在conf里配置log目录。




cassandra 2.1以上版本采用backlog记日志




zhh@apache-cassandra-2.1.5 % vi conf/logback.xml




修改下述目录为自己需要的目录，保证目录的可写。2.1以前的版本是写到/var/log或/var/lib目录的，可能没权限。




<file>${cassandra.logdir}/system.log</file>




缺省不修改则log存放当前安装目录的logs下面。




**启动**




启动cassandra，-f选项表示前台运行。如果没有-f，则用pkill -f cassandraDaemon




    
    zhh@apache-cassandra-2.1.5 % ./bin/cassandra -f
    …
    INFO  08:31:37 Starting listening for CQL clients on localhost/127.0.0.1:9042...
    INFO  08:31:37 Binding thrift service to localhost/127.0.0.1:9160
    INFO  08:31:37 Listening for thrift clients...





客户端cqlsh:




    
    zhh@apache-cassandra-2.1.5 % ./bin/cqlsh
    Connected to Test Cluster at 127.0.0.1:9042.
    [cqlsh 5.0.1 | Cassandra 2.1.5 | CQL spec 3.2.0 | Native protocol v3]
    Use HELP for help.
    cqlsh> help
    
    Documented shell commands:
    ===========================
    CAPTURE      COPY  DESCRIBE  EXPAND  PAGING  SOURCE
    CONSISTENCY  DESC  EXIT      HELP    SHOW    TRACING
    
    CQL help topics:
    ================
    ALTER                        CREATE_TABLE_OPTIONS  SELECT
    ALTER_ADD                    CREATE_TABLE_TYPES    SELECT_COLUMNFAMILY
    ALTER_ALTER                  CREATE_USER           SELECT_EXPR
    ALTER_DROP                   DELETE                SELECT_LIMIT
    ALTER_RENAME                 DELETE_COLUMNS        SELECT_TABLE
    ALTER_USER                   DELETE_USING          SELECT_WHERE
    ALTER_WITH                   DELETE_WHERE          TEXT_OUTPUT
    APPLY                        DROP                  TIMESTAMP_INPUT
    ASCII_OUTPUT                 DROP_COLUMNFAMILY     TIMESTAMP_OUTPUT
    BEGIN                        DROP_INDEX            TRUNCATE
    BLOB_INPUT                   DROP_KEYSPACE         TYPES
    BOOLEAN_INPUT                DROP_TABLE            UPDATE
    COMPOUND_PRIMARY_KEYS        DROP_USER             UPDATE_COUNTERS
    CREATE                       GRANT                 UPDATE_SET
    CREATE_COLUMNFAMILY          INSERT                UPDATE_USING
    CREATE_COLUMNFAMILY_OPTIONS  LIST                  UPDATE_WHERE
    CREATE_COLUMNFAMILY_TYPES    LIST_PERMISSIONS      USE
    CREATE_INDEX                 LIST_USERS            UUID_INPUT
    CREATE_KEYSPACE              PERMISSIONS
    CREATE_TABLE                 REVOKE
    
    cqlsh>
    创建keyspace，相当于rds的database，用于存放table
    cqlsh> create keyspace mykeyspace with replication={'class':'SimpleStrategy','replication_factor':1}
       ... ;
    cqlsh> use mykeyspace;





创建表




    
    cqlsh:mykeyspace> create table users(
    
                  ... user_id int primary key,
    
                  ... fname text,
    
                  ... lname text
    
                  ... );
    
    





插入数据




    
    cqlsh:mykeyspace> insert into users (user_id,fname,lname) values(1,'john','smith');
    
    cqlsh:mykeyspace> insert into users (user_id,fname,lname) values(2,'三','张');
    
    cqlsh:mykeyspace> insert into users (user_id,fname,lname) values(1,'john','smith');
    
    cqlsh:mykeyspace> insert into users (user_id,fname,lname) values(3,'john','smith');
    
    cqlsh:mykeyspace> select * from users;
    
     user_id | fname | lname
    
    ---------+-------+-------
    
           1 |  john | smith
    
           2 |    三 |    张
    
           3 |  john | smith
    
    (3 rows)
    
    cqlsh:mykeyspace>





直接用没有索引的字段查询报错：




    
    cqlsh:mykeyspace> select * from users where lname='smith';
    
    InvalidRequest: code=2200 [Invalid query] message="No secondary indexes on the restricted columns support the provided operators: "
    
    cqlsh:mykeyspace> select * from users where user_id='2';
    
    InvalidRequest: code=2200 [Invalid query] message="Invalid STRING constant (2) for "user_id" of type int"
    
    cqlsh:mykeyspace> select * from users where user_id=2;
    
     user_id | fname | lname
    
    ---------+-------+-------
    
           2 |    三 |    张
    
    (1 rows)





在姓氏上建索引，再查询不再报错




    
    cqlsh:mykeyspace> create index on users(lname);
    
    cqlsh:mykeyspace> select * from users where lname='张';
    
     user_id | fname | lname
    
    ---------+-------+-------
    
           2 |    三 |    张
    
    (1 rows)
    
    cqlsh:mykeyspace> select * from users where lname='smith';
    
     user_id | fname | lname
    
    ---------+-------+-------
    
           1 |  john | smith
    
           3 |  john | smith
    
    (2 rows)
    
    cqlsh:mykeyspace> ^D





ctrl+D 结束
