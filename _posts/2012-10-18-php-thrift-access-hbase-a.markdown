---
author: abloz
comments: true
date: 2012-10-18 05:11:27+00:00
layout: post
link: http://abloz.com/index.php/2012/10/18/php-thrift-access-hbase-a/
slug: php-thrift-access-hbase-a
title: php通过thrift访问HBase一
wordpress_id: 1910
categories:
- 技术
tags:
- hbase
- php
- thrift
---

原文地址：http://abloz.com/2012/10/18/php-thrift-access-hbase-a.html
作者：周海汉
日期：2012.10.18

HBase原生支持Java，因此可以通过用Java完成Jetty Servlet，通过HBase stargate提供的REST API提供数据访问。PHP可以用CURL来访问。如 http:/localhost:8080/tablename/rowkey获取数据。
Thrift虽然绕了一下，不过支持多种语言。此前我写列一遍文章《[python通过thrift来操作hbase](http://abloz.com/2012/06/01/python-operating-hbase-thrift-to.html)》，本篇主要讲php 通过thrift来操作HBase。
thrift安装可以参考我此前写的《[thrift 安装测试示例](http://abloz.com/2012/05/31/example-thrift-installation.html)》

**1.thrift所需基本环境**
最新版thrift 0.8，所需环境如下：

POSIX-兼容 *NIX 系统
Cygwin 或 MinGW 用于 Windows
g++ 4.2
boost 1.40.0
Runtime libraries for lex and yacc might be needed for the compiler.

从 SVN 编译所需
GNU build tools:
autoconf 2.65
automake 1.9
libtool 1.5.24
pkg-config autoconf macros (pkg.m4)
lex and yacc (developed primarily with flex and bison)
libssl-dev

各语言编译所需组件
C++
Boost 1.40.0
libevent (optional, to build the nonblocking server)
zlib (optional)

Java
Java 1.5
Apache Ant

C#: Mono 1.2.4 (and pkg-config to detect it) or Visual Studio 2005+

Python 2.6 (including header files for extension modules)

PHP 5.0 (optionally including header files for extension modules)

Ruby 1.8
bundler gem

Erlang R12 (R11 works but not recommended)

Perl 5
Bit::Vector
Class::Accessor

centos安装所需组件：
sudo yum install automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel python-devel ruby-devel

**2.编译安装thrift**
[zhouhh@Hadoop48 thrift-0.8.0]$ ./configure --without-erlang --without-ruby

...
thrift 0.8.0

Building code generators ..... :

Building C++ Library ......... : yes
Building C (GLib) Library .... : no
Building Java Library ........ : yes
Building C# Library .......... : no
Building Python Library ...... : yes
Building Ruby Library ........ : no
Building Haskell Library ..... : no
Building Perl Library ........ : no
Building PHP Library ......... : yes
Building Erlang Library ...... : no
Building Go Library .......... : no

Building TZlibTransport ...... : yes
Building TNonblockingServer .. : no

Using javac .................. : javac
Using java ................... : java
Using ant .................... : /etc/ant/bin/ant

Using Python ................. : /usr/local/bin/python

Using php-config ............. : /usr/bin/php-config


[zhouhh@Hadoop48 thrift-0.8.0]$ make
[zhouhh@Hadoop48 thrift-0.8.0]$ sudo make install
install:
     [copy] Copying 12 files to /usr/local/lib

**3.php网站如何支持php**
Thrift 需要 PHP 5
我apache网站放在/var/www/html下。
#1) 复制 thrift/lib/php/src 到 /var/www/html
#2) 设置 $GLOBALS['THRIFT_ROOT']  Thrift 安装目录
#3) include_once $GLOBALS['THRIFT_ROOT'].'/Thrift.php';
 #3 必须在其他 Thrift 包含文件之前.
 对MyPackage.thrift,生成的文件要安装到下面目录：
 $GLOBALS['THRIFT_ROOT'].'/packages/MyPackage/'

php环境：
PHP_INT_SIZE
用于决定是32位还是64位系统，用于TBinaryProtocol 正确 pack() 和 unpack()

apc_fetch(), apc_store()
TSocketPool用了apc cache。

[root@Hadoop48 html]# pwd
/var/www/html
[root@Hadoop48 html]# ls
favicon.ico  get.php  hbase_code.php  hbase.php  hive.php  index.html  index.php  insert.php  KLogger.php  list.php  log  mylog  scan.php  src  test.sh

**4.配置HBase，支持Thrift**

将Hbase.thrift编译成php文件
thrift --gen php [hbase-root]/src/java/org/apache/hadoop/hbase/thrift/Hbase.thrift
[zhouhh@Hadoop48 thrift]$ pwd
/home/zhouhh/hbase-0.94.0/src/main/resources/org/apache/hadoop/hbase/thrift
[zhouhh@Hadoop48 thrift]$ ls
Hbase.thrift
[zhouhh@Hadoop48 thrift]$ thrift --gen php Hbase.thrift
[zhouhh@Hadoop48 thrift]$ ls
gen-php  Hbase.thrift
[zhouhh@Hadoop48 thrift]$ find .
.
./Hbase.thrift
./gen-php
./gen-php/Hbase
./gen-php/Hbase/Hbase.php
./gen-php/Hbase/Hbase_types.php

启动hbase thrift server
[hbase-root]/bin/hbase thrift start
...
Read an invalid frame size of -2147418111. Are you using TFramedTransport on the client side?

要想提高传输效率，必须使用TFramedTransport或TBufferedTransport.但对-hsha，-nonblocking两种服务器模式，必须使用TFramedTransport。将其改为线程方式试试。
[zhouhh@Hadoop48 ~]$ hbase thrift start -threadpool -p 9090
-p 参数可以修改thrift server的监听端口，防止端口冲突。

**5.准备HBase数据**
hbase shell
hbase(main):001:0> list
TABLE
0 row(s) in 0.5140 seconds

hbase(main):002:0> create 't1','info'
0 row(s) in 2.1100 seconds
hbase(main):005:0> put 't1','no1','info:name','zhouhh'
0 row(s) in 0.0720 seconds

hbase(main):007:0> put 't1','no2','info:name','zhouhh2'
0 row(s) in 0.0050 seconds

hbase(main):008:0> scan 't1'
ROW                                         COLUMN+CELL
 no1                                        column=info:name, timestamp=1350370179806, value=zhouhh
 no2                                        column=info:name, timestamp=1350370213338, value=zhouhh2
2 row(s) in 0.0370 seconds

**6.配置网站支持hbase thrift**
将hbase thrift生成的文件复制到网站下。
[root@Hadoop48 packages]# pwd
/var/www/html/src/packages
[root@Hadoop48 packages]# cp -r $HBASE_HOME/src/main/resources/org/apache/hadoop/hbase/thrift/gen-php/* .
[root@Hadoop48 packages]# find .
.
./Hbase
./Hbase/Hbase.php
./Hbase/Hbase_types.php

复制hbase的thrift demo到网站
[zhouhh@Hadoop48 hbase-0.94.0]$ sudo cp ./src/examples/thrift/DemoClient.php /var/www/html/hbase.php

修改hbase.php的下列两行
$GLOBALS['THRIFT_ROOT'] = '/var/www/html/src';
require_once( $GLOBALS['THRIFT_ROOT'].'/packages/Hbase/Hbase.php' );

[root@Hadoop48 html]# vi hbase.php

row}, cols: n" );
  $values = $rowresult->columns;
  asort( $values );
  foreach ( $values as $k=>$v ) {
    echo( "  {$k} => {$v->value}n" );
  }
}

$socket = new TSocket( 'localhost', 9090 );
$socket->setSendTimeout( 10000 ); // Ten seconds (too long for production, but this is just a demo ;)
$socket->setRecvTimeout( 20000 ); // Twenty seconds
$transport = new TBufferedTransport( $socket );
$protocol = new TBinaryProtocol( $transport );
$client = new HbaseClient( $protocol );

$transport->open();

$t = 't1';

?>



    
    
    getTableNames();
    sort( $tables );
    foreach ( $tables as $name ) {
      echo( "  found: {$name}n" );
      if ( $name == $t ) {
        if ($client->isTableEnabled( $name )) {
          echo( "    disabling table: {$name}n");
          $client->disableTable( $name );
        }
        echo( "    deleting table: {$name}n" );
        $client->deleteTable( $name );
      }
    }
    
    #
    # Create the demo table with two column families, entry: and unused:
    #
    $columns = array(
      new ColumnDescriptor( array(
        'name' => 'entry:',
        'maxVersions' => 10
      ) ),
      new ColumnDescriptor( array(
        'name' => 'unused:'
      ) )
    );
    
    echo( "creating table: {$t}n" );
    try {
      $client->createTable( $t, $columns );
    } catch ( AlreadyExists $ae ) {
      echo( "WARN: {$ae->message}n" );
    }
    
    echo( "column families in {$t}:n" );
    $descriptors = $client->getColumnDescriptors( $t );
    asort( $descriptors );
    foreach ( $descriptors as $col ) {
      echo( "  column: {$col->name}, maxVer: {$col->maxVersions}n" );
    }
    
    #
    # Test UTF-8 handling
    #
    $invalid = "foo-xfcxa1xa1xa1xa1xa1";
    $valid = "foo-xE7x94x9FxE3x83x93xE3x83xBCxE3x83xAB";
    
    # non-utf8 is fine for data
    $mutations = array(
      new Mutation( array(
        'column' => 'entry:foo',
        'value' => $invalid
      ) ),
    );
    $client->mutateRow( $t, "foo", $mutations );
    
    # try empty strings
    $mutations = array(
      new Mutation( array(
        'column' => 'entry:',
        'value' => ""
      ) ),
    );
    $client->mutateRow( $t, "", $mutations );
    
    # this row name is valid utf8
    $mutations = array(
      new Mutation( array(
        'column' => 'entry:foo',
        'value' => $valid
      ) ),
    );
    $client->mutateRow( $t, $valid, $mutations );
    
    # non-utf8 is not allowed in row names
    try {
      $mutations = array(
        new Mutation( array(
          'column' => 'entry:foo',
          'value' => $invalid
        ) ),
      );
      $client->mutateRow( $t, $invalid, $mutations );
      throw new Exception( "shouldn't get here!" );
    } catch ( IOError $e ) {
      echo( "expected error: {$e->message}n" );
    }
    
    # Run a scanner on the rows we just created
    echo( "Starting scanner...n" );
    $scanner = $client->scannerOpen( $t, "", array( "entry:" ) );
    try {
      while (true) printRow( $client->scannerGet( $scanner ) );
    } catch ( NotFound $nf ) {
      $client->scannerClose( $scanner );
      echo( "Scanner finishedn" );
    }
    
    #
    # Run some operations on a bunch of rows.
    #
    for ($e=100; $e>=0; $e--) {
      # format row keys as "00000" to "00100"
      $row = str_pad( $e, 5, '0', STR_PAD_LEFT );
    
      $mutations = array(
        new Mutation( array(
          'column' => 'unused:',
          'value' => "DELETE_ME"
        ) ),
      );
      $client->mutateRow( $t, $row, $mutations);
      printRow( $client->getRow( $t, $row ));
      $client->deleteAllRow( $t, $row );
    
      $mutations = array(
        new Mutation( array(
          'column' => 'entry:num',
          'value' => "0"
        ) ),
        new Mutation( array(
          'column' => 'entry:foo',
          'value' => "FOO"
        ) ),
      );
      $client->mutateRow( $t, $row, $mutations );
      printRow( $client->getRow( $t, $row ));
    
      $mutations = array(
        new Mutation( array(
          'column' => 'entry:foo',
          'isDelete' => 1
        ) ),
        new Mutation( array(
          'column' => 'entry:num',
          'value' => '-1'
        ) ),
      );
      $client->mutateRow( $t, $row, $mutations );
      printRow( $client->getRow( $t, $row ) );
    
      $mutations = array(
        new Mutation( array(
          'column' => "entry:num",
          'value' => $e
        ) ),
        new Mutation( array(
          'column' => "entry:sqr",
          'value' => $e * $e
        ) ),
      );
      $client->mutateRow( $t, $row, $mutations );
      printRow( $client->getRow( $t, $row ));
    
      $mutations = array(
        new Mutation( array(
          'column' => 'entry:num',
          'value' => '-999'
        ) ),
        new Mutation( array(
          'column' => 'entry:sqr',
          'isDelete' => 1
        ) ),
      );
      $client->mutateRowTs( $t, $row, $mutations, 1 ); # shouldn't override latest
      printRow( $client->getRow( $t, $row ) );
    
      $versions = $client->getVer( $t, $row, "entry:num", 10 );
      echo( "row: {$row}, values: n" );
      foreach ( $versions as $v ) echo( "  {$v->value};n" );
    
      try {
        $client->get( $t, $row, "entry:foo");
        throw new Exception ( "shouldn't get here! " );
      } catch ( NotFound $nf ) {
        # blank
      }
    
    }
    
    $columns = array();
    foreach ( $client->getColumnDescriptors($t) as $col=>$desc ) {
      echo("column with name: {$desc->name}n");
      $columns[] = $desc->name.":";
    }
    
    echo( "Starting scanner...n" );
    $scanner = $client->scannerOpenWithStop( $t, "00020", "00040", $columns );
    try {
      while (true) printRow( $client->scannerGet( $scanner ) );
    } catch ( NotFound $nf ) {
      $client->scannerClose( $scanner );
      echo( "Scanner finishedn" );
    }
    
    $transport->close();
    
    ?>
    





**7.检验**
通过浏览器访问
http://hadoop48/hbase.php
排除一些错误后，检查是否有数据插入：
[zhouhh@Hadoop48 ~]$ hbase shell
HBase Shell; enter 'help' for list of supported commands.
Type "exit" to leave the HBase Shell
Version 0.94.0, r1332822, Tue May  1 21:43:54 UTC 2012

hbase(main):001:0> scan 't1'
ROW                                         COLUMN+CELL
                                            column=info:, timestamp=1350387336446, value=
 foo                                        column=info:foo, timestamp=1350387336443, value=foo-xFCxA1xA1xA1xA1xA1
 foo-xE7x94x9FxE3x83x93xE3x83xBCx column=info:foo, timestamp=1350387336448, value=foo-xE7x94x9FxE3x83x93xE3x83xBCxE3x83xAB
 E3x83xAB
 foo-xFCxA1xA1xA1xA1xA1               column=info:foo, timestamp=1350387336476, value=foo-xFCxA1xA1xA1xA1xA1
 no1                                        column=info:name, timestamp=1350370179806, value=zhouhh
 no2                                        column=info:name, timestamp=1350370213338, value=zhouhh2
6 row(s) in 3.4320 seconds

**8.参考**
thrift官方网站：http://thrift.apache.org/
安装文档：http://thrift.apache.org/docs/install/
下载地址：http://labs.renren.com/apache-mirror/thrift/0.8.0/thrift-0.8.0.tar.gz
使用C++（通过Thrift）访问/操作/读写Hbase http://www.codelast.com/?p=3303
http://thrift.apache.org/docs/BuildingFromSource/
http://yannramin.com/2008/07/19/using-facebook-thrift-with-python-and-hbase/
