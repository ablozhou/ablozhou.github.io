---
author: abloz
comments: true
date: 2012-10-18 09:34:32+00:00
layout: post
link: http://abloz.com/index.php/2012/10/18/php-thrift-access-hbase-two/
slug: php-thrift-access-hbase-two
title: php通过thrift访问HBase 二
wordpress_id: 1915
categories:
- 技术
tags:
- hbase
- php
- thrift
---

作者：周海汉
日期：2012.10.18
原文地址：http://abloz.com/2012/10/18/php-thrift-access-hbase-two.html

本文实现了php通过thrift对HBase查询所有表名，查询表的所有记录，限制记录个数，对记录进行过滤，根据rowkey查询单行和多行的功能。
在HBase 0.9.4，Hadoop 1.0.3，php 5.0，thrift 0.8 apache2.1环境中测试通过。

```

[root@Hadoop48 html]# cat hbase_code.php

    
    <?php
    # author: zhouhh
    # date: 2012.10.17
    # common file
    #
    # Change this to match your thrift root
    $GLOBALS['ROOT'] = '/var/www/html';
    $GLOBALS['THRIFT_ROOT'] = '/var/www/html/src';
    $GLOBALS['TRIFTSVR']='hadoop46';
    $GLOBALS['TRIFTSVR_PORT']=9090;
    #require_once 'KLogger.php';
    #$log = new KLogger ( $GLOBALS['ROOT']."/mylog" , KLogger::DEBUG );
    $tableName="a_rule";
    
    require_once( $GLOBALS['THRIFT_ROOT'].'/Thrift.php' );
    
    require_once( $GLOBALS['THRIFT_ROOT'].'/transport/TSocket.php' );
    require_once( $GLOBALS['THRIFT_ROOT'].'/transport/TBufferedTransport.php' );
    require_once( $GLOBALS['THRIFT_ROOT'].'/protocol/TBinaryProtocol.php' );
    
    # According to the thrift documentation, compiled PHP thrift libraries should
    # reside under the THRIFT_ROOT/packages directory.  If these compiled libraries
    # are not present in this directory, move them there from gen-php/.
    require_once( $GLOBALS['THRIFT_ROOT'].'/packages/Hbase/Hbase.php' );
    
    $socket = new TSocket( $GLOBALS['TRIFTSVR'], $GLOBALS['TRIFTSVR_PORT'] );
    $socket->setSendTimeout( 10000 ); // Ten seconds (too long for production, but this is just a demo ;)
    $socket->setRecvTimeout( 20000 ); // Twenty seconds
    $transport = new TBufferedTransport( $socket );
    $protocol = new TBinaryProtocol( $transport );
    $client = new HbaseClient( $protocol );
    
    function listTable( ) {
        global $client;
        #echo( "listing tables...n" );
        $tables = $client->getTableNames();
        sort( $tables );
        printTables($tables);
        return $tables;
    
    }
    #$columnsArray = array(
    #    new ColumnDescriptor( array(
    #        'name' => 'entry:',
    #        'maxVersions' => 3
    #    ) ),
    #    new ColumnDescriptor( array(
    #        'name' => 'info:'
    #    ) )
    #);
    function createTable($tableName, $columnsArray) {
        global $client;
        echo( "creating table: {$tableName}n" );
        try {
                $client->createTable( $tableName, $columnsArray );
        } catch ( AlreadyExists $ae ) {
                echo( "WARN: {$ae->message}n" );
        }
    
    }
    function getColumnDesc($tableName) {
        global $client;
        echo( "column families in {$tableName}:n" );
        $descriptors = $client->getColumnDescriptors( $tableName );
        asort( $descriptors );
        foreach ( $descriptors as $col ) {
            echo( "column: {$col->name}, maxVer: {$col->maxVersions}n" );
        }
    
    }
    
    function getRows($tableName,$rowNames){
        global $client;
        #echo $rowNames;
        $get_arr = $client->getRows($tableName, $rowNames, null);
        if(!empty($get_arr))
        {
            #print_r($get_arr);
    
            foreach ( $get_arr as $rowresult ){
                printRow($rowresult);
            }
        }
       else
       {
            echo("get nothing of $rowNames from $tableName");
       }
    }
    
    function getRow($tableName,$rowName){
        global $client;
        echo $rowName;
        $get_arr = $client->getRow($tableName, $rowName, null);
        if(!empty($get_arr))
        {
            #print_r($get_arr);
    
            foreach ( $get_arr as $rowresult ){
                printRow($rowresult);
            }
        }
       else
       {
            echo("get nothing of $rowName from $tableName");
       }
    }
    
    function printTables($tables){
    
        foreach ( $tables as $name ) {
                echo( "t{$name}n" );
        }
    
    }
    
    function printRow( $rowresult ) {
      echo( "{$rowresult->row}n" );
      $values = $rowresult->columns;
      asort( $values );
      foreach ( $values as $k=>$v ) {
        #echo ("column=$k,");
        echo( "t{$k}=>{$v->value}," );
        echo ("ttimestamp={$v->timestamp}n");
      }
    }
    function scanTable($tableName,$startRow,$columnArray,$count=1000) {
    
        global $client;
    
        echo( "Starting scanner of $tableName...n" );
        $scanner = $client->scannerOpen( $tableName, $startRow, $columnArray, null);
        try {
            $c=0;
          while ($c < $count){           $get_arr = $client->scannerGetList($scanner,1);
              // get_arr is an array
              if($get_arr == null) break;
    
              $c+=1;
              foreach ( $get_arr as $rowresult ){
                  printRow($rowresult);
              }
          }
    
          $client->scannerClose( $scanner );
          echo( "Scanner finished of $tableNamen" );
        } catch ( NotFound $nf ) {
          $client->scannerClose( $scanner );
          echo( "Scanner finishedn" );
        }
    }
    # $filter="RowFilter(=, 'regexstring:00[1-3]00')";
    # $filter="PrefixFilter('aaa')";
    # $scan = new TScan(array("filterString" => $filter));
    function scanTableWithFilter($tableName,$filter,$count=1000) {
    
        global $client;
    
        echo( "Starting scanner of $tableName...n" );
        $scan = new TScan();
        $scan->filterString=$filter;
        $scanner = $client->scannerOpenWithScan( $tableName, $scan, null);
        try {
            $c=0;
          while ($c < $count){           $get_arr = $client->scannerGetList($scanner,1);
              // get_arr is an array
              if($get_arr == null) break;
    
              $c+=1;
              foreach ( $get_arr as $rowresult ){
                  printRow($rowresult);
              }
          }
    
          $client->scannerClose( $scanner );
          echo( "Scanner finished of $tableNamen" );
        } catch ( NotFound $nf ) {
          $client->scannerClose( $scanner );
          echo( "Scanner finishedn" );
        }
    }
    
    ?>
```

扫描所有表名。然后输入一个表名和返回记录条数来查询。
```
[root@Hadoop48 html]# cat list.php

    
    <html>
    <head>
    <title>list tables demo of zhouhh</title>
    </head>
    <body>
    <pre>
    <?php
    require_once('hbase_code.php');
    $transport->open();
    
    #list table
    listTable();
    
    $transport->close();
    
    ?>
    </pre>
    输入要扫描的表名：
    <br />
    <form action="scan.php" method="get">
    表名: <input type="text" name="tablename" value="award_1210_reserve"/><br/>
    前缀：<input type="text" name="filter" value=""/><br/>
    返回记录条数: <input type="text" name="count" value="10"/><br/>
    <input type="submit" value="提交扫描"/>
    </form>
    </body>
    </html>


[root@Hadoop48 html]# cat scan.php

    
    
    <html>
    <head>
    <title>scan demo of zhouhh</title>
    </head>
    <body>
    <pre>
    <?php
    
     
    require_once('hbase_code.php');
    if(isset($_REQUEST["tablename"]))
    {
        $t = $_REQUEST["tablename"];
    }
    else
    {
        $t=$tableName;
    }
    
    if(isset($_REQUEST["count"]))
    {
        $c = $_REQUEST["count"];
    }
    else
    {
        $c=5;
    }
    if(isset($_REQUEST["column"]))
    {
        $column=$_REQUEST["column"];
    }
    else
    {
        $column="info:";
    }
    
    $columns=explode("|", $column);
    
    if(isset($_REQUEST["filter"]))
    {
        $filter="PrefixFilter('".$_REQUEST["filter"]."')";
    }
    else
    {
        $filter="";
    }
    $transport->open();
    
    #scan table
    if(empty($filter))
    {
        scanTable($t, $row, $columns, $c);
    }
    else
    {
        scanTableWithFilter($t, $filter, $c);
    }
    
    $transport->close();
    
    ?>
    </pre>
    输入要查询的表名：
    <br />
    <form action="get.php" method="get">
    表名: <input type="text" name="tablename" value="award_1210"/><br/>
    行键(每行键占一行):<br/> <textarea rows="10" cols="100" name="startrow" value="" ></textarea><br/>
    <input type="submit" value="提交查询"/>
    </form>
    
    </body>
    </html>
 ```   



输入rowkey来获取结果
```
[root@Hadoop48 html]# cat get.php

    
    <html>
    <head>
    <title>scan demo of zhouhh</title>
    </head>
    <body>
    <pre>
    <?php
    require_once('hbase_code.php');
    if(isset($_REQUEST["tablename"]))
    {
    
        $t = $_REQUEST["tablename"];
    }
    else
    {
        $t=$tableName;
    }
    
    if(isset($_REQUEST["count"]))
    {
        $c = $_REQUEST["count"];
    }
    else
    {
        $c=5;
    }
    
    if(isset($_REQUEST["startrow"]))
    {
        $row = $_REQUEST["startrow"];
        #echo $row;
    }
    else
    {
        $row="";
    }
    if(isset($_REQUEST["column"]))
    {
        $column=$_REQUEST["column"];
    }
    else
    {
        $column="info:";
    }
    #$columns=explode("|", $column);
    $columns= $column;
    $transport->open();
    
    #get row of table
    if(empty($row))
    {
        scanTable($t, $row, $columns, 1);
    }
    else
    {
        getRows($t,explode("x0dx0a",$row));
    }
    
    $transport->close();
    ?>
    </pre>
    </body>
    </html>


```
