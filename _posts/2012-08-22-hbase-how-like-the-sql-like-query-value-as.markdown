---
author: abloz
comments: true
date: 2012-08-22 09:12:23+00:00
layout: post
link: http://abloz.com/index.php/2012/08/22/hbase-how-like-the-sql-like-query-value-as/
slug: hbase-how-like-the-sql-like-query-value-as
title: hbase的内容查询(1)
wordpress_id: 1812
categories:
- 技术
tags:
- filter
- hbase
- scan
---

author:周海汉
2012.8.22


# 一、shell 查询


hbase 查询相当简单，提供了get和scan两种方式，也不存在多表联合查询的问题。复杂查询需通过hive创建相应外部表，用sql语句自动生成mapreduce进行。
但是这种简单，有时为了达到目的，也不是那么顺手。至少和sql查询方式相差较大。

hbase 提供了很多过滤器，可对行键，列，值进行过滤。过滤方式可以是子串，二进制，前缀，正则比较等。条件可以是AND,OR等 组合。所以通过过滤，还是能满足需求，找到正确的结果的。


## 1.1 过滤器类型


[HBase 最新官方文档中文版(http://abloz.com/hbase/book.html)](http://abloz.com/hbase/book.html#client.filter)中有对过滤器的描述。过滤器分为5种类型：



	
  1. 构造型过滤器：用于包含其他一组过滤器的过滤器。包括：FilterList

	
  2. 列值型过滤器：对每列的值进行过滤的. 相当于sql查询中的=和like 包括：

    
    SingleColumnValueFilter



    
    比较器，包括：
    <a href="http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/RegexStringComparator.html" target="_top">RegexStringComparator</a> 支持值比较的正则表达式
    <a href="http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/SubstringComparator.html" target="_top">SubstringComparator</a> 用于检测一个子串是否存在于值中。大小写不敏感。 
    <a href="http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/BinaryPrefixComparator.html" target="_top">BinaryPrefixComparator</a> 二进制前缀比较
    <a href="http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/BinaryComparator.html" target="_top">BinaryComparator</a> 二进制比较




	
  3. 键值元数据过滤器：用于对列进行过滤的。包括：

    
    <a href="http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/FamilyFilter.html" target="_top">FamilyFilter</a> 用于过滤列族。 通常，在Scan中选择ColumnFamilie优于在过滤器中做。
    <a href="http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/QualifierFilter.html" target="_top">QualifierFilter</a> 用于基于列名(即 Qualifier)过滤.
    ColumnPrefixFilter 可基于列名(即Qualifier)前缀过滤。
    MultipleColumnPrefixFilter 和 ColumnPrefixFilter 行为差不多，但可以指定多个前缀。
    <a style="font-family: 'Segoe UI', Calibri, 'Myriad Pro', Myriad, 'Trebuchet MS', Helvetica, Arial, sans-serif; font-size: 13px; line-height: 19px; white-space: normal;" href="http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/ColumnRangeFilter.html" target="_top">ColumnRangeFilter</a><span style="font-family: 'Segoe UI', Calibri, 'Myriad Pro', Myriad, 'Trebuchet MS', Helvetica, Arial, sans-serif; font-size: 13px; line-height: 19px; white-space: normal;"> 可以进行高效内部扫描。  </span>




	
  4. Rowkey：对行键进行过滤。通常认为行选择时Scan采用 startRow/stopRow 方法比较好。然而 [RowFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/RowFilter.html) 也可以用。

	
  5. 工具：如[FirstKeyOnlyFilter](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/filter/FirstKeyOnlyFilter.html)用于统计行数。




# 二、示例





## 1.FirstKeyOnlyFilter,一种方便的计算行数的过滤器



    
    hbase(main):002:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>'info',FILTER=>"(FirstKeyOnlyFilter())"}
     0000000001                       column=info:loginid, timestamp=1343625459713, value=jjm168131013
     0000000002                       column=info:loginid, timestamp=1343625459713, value=loveswh
    ...
    21 row(s) in 0.5480 seconds




## 2.列名子串进行过滤



    
    hbase(main):006:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>['info:'],FILTER=>"(QualifierFilter(=,'substring:id'))"}
    ROW COLUMN+CELL
    0000000001 column=info:loginid, timestamp=1343625459713, value=jjm168131013
    0000000001 column=info:userid, timestamp=1343625459713, value=168131013
    0000000002 column=info:loginid, timestamp=1343625459713, value=loveswh
    0000000002 column=info:userid, timestamp=1343625459713, value=100898152
    
    hbase(main):005:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>['info:loginid'],FILTER=>"(QualifierFilter(=,'substring:id'))"}
    ROW COLUMN+CELL
    0000000001 column=info:loginid, timestamp=1343625459713, value=jjm168131013
    0000000002 column=info:loginid, timestamp=1343625459713, value=loveswh
    
    hbase(main):007:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>['info:'],FILTER=>"(QualifierFilter(=,'substring:nid'))"}
    ROW COLUMN+CELL
    0000000001 column=info:loginid, timestamp=1343625459713, value=jjm168131013
    0000000002 column=info:loginid, timestamp=1343625459713, value=loveswh
    
    hbase(main):008:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>['info:'],FILTER=>"(QualifierFilter(=,'substring:nick'))"}
    ROW COLUMN+CELL
    0000000001 column=info:nick, timestamp=1343625459713, value=xE5xAExB6xE6x9Cx89xE8x99x8ExE5xAEx9
    D
    0000000002 column=info:nick, timestamp=1343625459713, value=loveswh08




## 3.Value 过滤



    
    3.1 正则过滤
    hbase(main):004:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>'info',FILTER=>"(SingleColumnValueFilter('info','nick',=,'regexstring:.*99',true,true))"}
    ROW                               COLUMN+CELL
     0000000009                       column=info:loginid, timestamp=1343625459713, value=zgh1968
     0000000009                       column=info:nick, timestamp=1343625459713, value=zwy99
     0000000009                       column=info:score, timestamp=1343625459713, value=5
     0000000009                       column=info:userid, timestamp=1343625459713, value=100366262
    1 row(s) in 0.2520 seconds
    
    3.2 子串
    需导入
    import org.apache.hadoop.hbase.filter.CompareFilter
    import org.apache.hadoop.hbase.filter.SingleColumnValueFilter
    import org.apache.hadoop.hbase.filter.SubstringComparator
    import org.apache.hadoop.hbase.util.Bytes
    
    hbase(main):028:0> scan 'toplist_ware_ios_1001_201231',{COLUMNS =>'info:nick', FILTER=>SingleColumnValueFilter.new(Bytes.toBytes('info'),Bytes.toBytes('nick'),CompareFilter::CompareOp.valueOf('EQUAL'),SubstringComparator.new('8888'))}
    ROW COLUMN+CELL
    0000000002 column=info:nick, timestamp=1343625446556, value=xE7x81x8F????xE3x81x8A??8888
    1 row(s) in 0.0330 seconds
    
    3.3 二进制
    子串等不支持多字节文字，所以用二进制来进行比较
    hbase(main):010:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>['info:'],FILTER=>"(QualifierFilter(=,'substring:nick') AND ValueFilter(=,'binary:7789xE6xB4x81') )"}
    ROW COLUMN+CELL
    0000000016 column=info:nick, timestamp=1343625459713, value=7789xE6xB4x81
    1 row(s) in 0.1710 seconds




## 4 综合列名子串和值二进制比较



    
    hbase(main):012:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>['info:'],FILTER=>"(QualifierFilter(=,'substring:nick') AND ValueFilter(=,'binary:7789xE6xB4x81') )"}
    ROW COLUMN+CELL
    0000000016 column=info:nick, timestamp=1343625459713, value=7789xE6xB4x81
    1 row(s) in 0.0120 seconds



    
    hbase(main):014:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>"info:",FILTER=>"(PrefixFilter('000000002')) AND (QualifierFilter(=,'substring:nick')"}
    ROW COLUMN+CELL
     0000000020 column=info:nick, timestamp=1343625459713, value=Denny_feng
     0000000021 column=info:nick, timestamp=1343625459713, value=xE5xB0x8FxE7xBDx97xE6x95x99xE7xBBx8
     31
    2 row(s) in 0.0440 seconds




## 5. 行查询




    
    hbase(main):005:0> get 'toplist_ware_ios_1009_201231','0000000009'
    COLUMN CELL
     info:loginid timestamp=1343625459713, value=zgh1968
     info:nick timestamp=1343625459713, value=zwy99
     info:score timestamp=1343625459713, value=5
     info:userid timestamp=1343625459713, value=100366262
    4 row(s) in 0.1000 seconds



    
    hbase(main):006:0> get 'toplist_ware_ios_1009_201231','0000000009','info:nick'
    COLUMN CELL
     info:nick timestamp=1343625459713, value=zwy99
    1 row(s) in 0.0100 seconds



    
    hbase(main):009:0> scan 'toplist_ware_ios_1009_201231',FILTER=>"PrefixFilter('000000002')"
    ROW COLUMN+CELL
     0000000020 column=info:loginid, timestamp=1343625459713, value=jjm169212318
     0000000020 column=info:nick, timestamp=1343625459713, value=Denny_feng
     0000000020 column=info:score, timestamp=1343625459713, value=1
     0000000020 column=info:userid, timestamp=1343625459713, value=169212318
     0000000021 column=info:loginid, timestamp=1343625459713, value=jjm169371841
     0000000021 column=info:nick, timestamp=1343625459713, value=xE5xB0x8FxE7xBDx97xE6x95x99xE7xBBx8
     31
     0000000021 column=info:score, timestamp=1343625459713, value=1
     0000000021 column=info:userid, timestamp=1343625459713, value=169371841
    2 row(s) in 0.0180 seconds



    
    hbase(main):010:0> scan 'toplist_ware_ios_1009_201231',FILTER=>"PrefixFilter('000000002')",LIMIT=>1
    ROW COLUMN+CELL
     0000000020 column=info:loginid, timestamp=1343625459713, value=jjm169212318
     0000000020 column=info:nick, timestamp=1343625459713, value=Denny_feng
     0000000020 column=info:score, timestamp=1343625459713, value=1
     0000000020 column=info:userid, timestamp=1343625459713, value=169212318
    1 row(s) in 0.0170 seconds



    
    hbase(main):011:0> scan 'toplist_ware_ios_1009_201231',{COLUMNS=>"info:nick",FILTER=>"PrefixFilter('000000002')",LIMIT=>1}
    ROW COLUMN+CELL
     0000000020 column=info:nick, timestamp=1343625459713, value=Denny_feng
    1 row(s) in 0.0160 seconds



查询MPID和GameID同时等于某个值的记录：

    
    
    hbase(main):014:0> scan 'award_1211',{FILTER=>"(PrefixFilter('2012-11-26')) AND (SingleColumnValueFilter('info','MPID',=,'regexstring:8639',true,true)) AND (SingleColumnValueFilter('info','gameID',=,'regexstring:1001',true,true))",LIMIT=>2}
    
