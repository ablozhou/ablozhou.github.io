---
author: abloz
comments: true
date: 2012-07-19 07:59:44+00:00
layout: post
link: http://abloz.com/index.php/2012/07/19/create-the-hbase-an-external-table-in-the-hive/
slug: create-the-hbase-an-external-table-in-the-hive
title: 在hive中创建HBase外部表
wordpress_id: 1763
categories:
- 技术
tags:
- hbase
- hive
---

http://abloz.com

author:周海汉

date:2012.7.19



**HBase查询award表**



    
    hbase(main):003:0> scan 'award' ,LIMIT=>2
     ROW COLUMN+CELL
     2012-04-27 06:55:00:102713629 column=info:MPID, timestamp=1341890254281, value=2947
     2012-04-27 06:55:00:102713629 column=info:MatchID, timestamp=1341890254281, value=433203828
     2012-04-27 06:55:00:102713629 column=info:MatchName, timestamp=1341890254281, value=xxx
     2012-04-27 06:55:00:102713629 column=info:Rank, timestamp=1341890254281, value=2
     2012-04-27 06:55:00:102713629 column=info:TourneyID, timestamp=1341890254281, value=1027102
     2012-04-27 06:55:00:102713629 column=info:UserId, timestamp=1341890254281, value=102713629
     2012-04-27 06:55:00:102713629 column=info:gameID, timestamp=1341890254281, value=1001
     2012-04-27 06:55:00:102713629 column=info:loginId, timestamp=1341890254281, value=715878221
     2012-04-27 06:55:00:102713629 column=info:nickName, timestamp=1341890254281, value=xxx
     2012-04-27 06:55:00:102713629 column=info:platform, timestamp=1341890254281, value=ios
     2012-04-27 06:55:00:102713629 column=info:ware, timestamp=1341890254281, value=1984:1 2082:1
     2012-04-27 06:55:00:106788559 column=info:MPID, timestamp=1341890254281, value=478
     2012-04-27 06:55:00:106788559 column=info:MatchID, timestamp=1341890254281, value=433203930
     2012-04-27 06:55:00:106788559 column=info:MatchName, timestamp=1341890254281, value=xxx
     2012-04-27 06:55:00:106788559 column=info:Rank, timestamp=1341890254281, value=19
     2012-04-27 06:55:00:106788559 column=info:TourneyID, timestamp=1341890254281, value=1014780
     2012-04-27 06:55:00:106788559 column=info:UserId, timestamp=1341890254281, value=106788559
     2012-04-27 06:55:00:106788559 column=info:gameID, timestamp=1341890254281, value=1001
     2012-04-27 06:55:00:106788559 column=info:gold, timestamp=1341890254281, value=1
     2012-04-27 06:55:00:106788559 column=info:loginId, timestamp=1341890254281, value=13835155880
     2012-04-27 06:55:00:106788559 column=info:nickName, timestamp=1341890254281, value=xxx
     2012-04-27 06:55:00:106788559 column=info:platform, timestamp=1341890254281, value=android
     2 row(s) in 0.0420 seconds




**hive中创建外部表**



    
    hive> CREATE EXTERNAL TABLE hive_award(key string, productid int,matchid string, rank string, tourneyid string, userid bigint,gameid int,gold int,loginid string,nick string,plat string) STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler' WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,info:MPID,info:MatchID,info:Rank,info:TourneyID,info:UserId,info:gameID,info:gold,info:loginId,info:nickName,info:platform") TBLPROPERTIES("hbase.table.name" = "award");




此命令可以看到HBase的列族如何和hive的列对应，表名如何对应。SERDEPROPERTIES表示serializer properties, 序列化属性。deserializer 表示反序列化。TBLPROPERTIES表示table 表属性。



    
    hive> desc hive_award;
     key string from deserializer
     productid int from deserializer
     matchid string from deserializer
     rank string from deserializer
     tourneyid string from deserializer
     userid bigint from deserializer
     gameid int from deserializer
     gold int from deserializer
     loginid string from deserializer
     nick string from deserializer
     plat string from deserializer




**hive查询**



    
    hive> select * from hive_award limit 3;
     OK
     2012-04-27 06:55:00:102713629 2947 433203828 2 1027102 102713629 1001 NULL 715878221 xxx ios
     2012-04-27 06:55:00:106788559 478 433203930 19 1014780 106788559 1001 1 13835155880 xxx android
     2012-04-27 06:55:00:114298440 478 433203930 20 1014780 114298440 1001 1 1131024406 xxx android
     Time taken: 0.104 seconds
