---
author: abloz
comments: true
date: 2009-06-12 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/06/12/php-adodb-connection-mssql-using-open-source-to-solve-garbage-problem/
slug: php-adodb-connection-mssql-using-open-source-to-solve-garbage-problem
title: php使用开源的adodb连接mssql解决乱码问题
wordpress_id: 917
categories:
- 技术
---

周海汉/文

php程序是utf-8的，sqlserver是2005中文，内码是gb18030.  普通的mssql_connect无法设置内码转换，读出来的数据在utf-8页面显示乱码。ADO可以用 new  COM("ADODB.Connection", NULL, CP_UTF8)//65001  这样的语句来实现正确转换。但ADO对php的支持缺乏文档。而有个开源的adodb，文档较为丰富。

其中对不同数据库驱动，设置UTF-8的方法还不一样，如下：

 

[](http://blog.csdn.net/ablo_zhou/archive/2009/06/12/4264526.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/06/12/4264526.aspx#)

  1. For all drivers
  2. 'persist', 'persistent', 'debug', 'fetchmode', 'new'
  3.   4. Interbase/Firebird
  5. 'dialect','charset','buffers','role'
  6.   7. M'soft ADO
  8. 'charpage'
  9.   10. MySQL
  11. 'clientflags'
  12.   13. MySQLi
  14. 'port', 'socket', 'clientflags'
  15.   16. Oci8
  17. 'nls_date_format','charset'
  18. For all drivers 'persist', 'persistent', 'debug', 'fetchmode', 'new'   Interbase/Firebird  'dialect','charset','buffers','role'   M'soft ADO 'charpage'   MySQL 'clientflags'   MySQLi 'port', 'socket', 'clientflags'   Oci8 'nls_date_format','charset'      

其中，Ado可以使用charPage这个属性来设置uft-8，类似new  COM的方式。但发现当将AdoNewConnection($dbdriver)的$dbdriver设为'ado'或'ado_mssql'时，其传 进去的database被替换为provider。那database的名字如何设置呢？一直没找到办法。

$dbdriver='ado://sa:cvttdev@172.16.22.40/sqloledb?charpage=65001';

其格式是'driver://user:passwd@host/database?options[=value]

但没解决设置数据库名字的地方。

痛苦了很久，只能找到如下的办法解决：

 

[](http://blog.csdn.net/ablo_zhou/archive/2009/06/12/4264526.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/06/12/4264526.aspx#)

  1. <html>
  2. <head>
  3. <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
  4. </head>
  5. <body>
  6. <?php
  7. $dbdriver='ado_mssql';
  8. $server='192.168.22.40';
  9. $user='sa';
  10. $password='passwd';
  11. $DATABASE='sugarcrm_db';
  12. $database='sqloledb';
  13. //$dbdriver='ado://sa:cvttdev@172.16.22.40/sqloledb?charpage=65001';
  14. $myDSN="PROVIDER=MSDASQL;DRIVER={SQL Server};SERVER={172.16.22.40};DATABASE=sugarcrm_db;UID=sa;PWD=cvttdev;";
  15.   16. include('adodb5/adodb.inc.php');
  17. $db = ADONewConnection($dbdriver); # eg 'mysql' or 'postgres'
  18. $db->debug = true;
  19. $db->charPage =65001;
  20. //$db->Connect($server, $user, $password, $database);
  21. $db->Connect($myDSN);
  22.   23. //error:mssql server not support codes below
  24. //$db->Execute("set names 'utf8'");
  25. echo "before query";
  26. $rs = $db->Execute('select * from accounts');
  27. print "<pre>";
  28. print_r($rs->GetRows());
  29. print "</pre>";
  30. ?>
  31. </body>
  32. </html>

  


  
  


![](http://img.zemanta.com/pixy.gif?x-id=8b3be561-9613-8b41-83c6-a21bb80a1cf1)
