---
author: abloz
comments: true
date: 2009-06-10 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/06/10/php-use-mssql-server-problems-encountered-by-chinese-encoding/
slug: php-use-mssql-server-problems-encountered-by-chinese-encoding
title: php使用 MsSql server时遇到的中文编码问题
wordpress_id: 915
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文

 

朋友要用sugarcrm的php读取Ms sql server的中文资料，因为其原始资料是Access  数据库，导到mysql不太方便。但导到sqlserver 2005后，发现其中文编码只支持GB 和 UCS-2（unicode  16），所以直接在数据库中查询显示正确，但使用php的utf9编码显示时则全是乱码。

 

找了大量资料，什么使用mssql，freetds，odbc，ado或直接每次查询和写入都进行转码等建议都有。不过实际测试中，发现Ado这种方法是好用的。

代码如下：

[](http://blog.csdn.net/ablo_zhou/archive/2009/06/10/4258206.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/06/10/4258206.aspx#)

  1. <html>
  2. <head>
  3. <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  4. </head>
  5. <body>
  6. <?php
  7. //print("The next line generates an error.<br>");
  8. //printaline("PLEASE?");
  9. //print("This will not be displayed due to the above error.");
  10. ?>
  11.   12. <?php
  13.   14. $conn = new COM("ADODB.Connection", NULL, CP_UTF8) or die("Cannot start ADO");
  15. //access 数据库的打开方式
  16. //$conn->Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=$db");
  17. //$conn->Open("DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=$db");
  18. $conn->Open("Driver={SQL Server};Server={192.168.22.40};Database=sugarcrm_db;UID=sa;PWD=123456;") ;
  19. // 执行查询并输出数据
  20. $rs = $conn->Execute('SELECT * FROM accounts') or die ("error query");
  21. ?>
  22. <table border="1">
  23. <tr><th>ID</th><th>Title</th>
  24. </tr>
  25. <?php
  26. while (!$rs->EOF) {
  27. echo '<tr>';
  28. echo '<td>'. $rs->Fields['id']->Value .'</td>';
  29. echo '<td>'. $rs->Fields['name']->Value .'</td>';
  30. echo '</tr>';
  31. $rs->MoveNext();
  32. }
  33. ?>
  34. </table>
  35. <?php
  36. // 释放资源
  37. $rs->Close();
  38. $conn->Close();
  39. $rs = null;
  40. $conn = null;
  41.   42. ?>
  43. </body>
  44. </html>

<html> <head> <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> </head> <body> <?php //print("The next line generates an error.<br>"); //printaline("PLEASE?"); //print("This will not be displayed due to the above error."); ?>  <?php  $conn = new COM("ADODB.Connection", NULL, CP_UTF8) or die("Cannot start ADO");  //access 数据库的打开方式 //$conn->Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=$db"); //$conn->Open("DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=$db"); $conn->Open("Driver={SQL Server};Server={192.168.22.40};Database=sugarcrm_db;UID=sa;PWD=123456;") ;  // 执行查询并输出数据 $rs = $conn->Execute('SELECT * FROM accounts') or die ("error query"); ?> <table border="1"> <tr><th>ID</th><th>Title</th> </tr> <?php while (!$rs->EOF) {  echo '<tr>';  echo '<td>'. $rs->Fields['id']->Value .'</td>';  echo '<td>'. $rs->Fields['name']->Value .'</td>';  echo '</tr>';  $rs->MoveNext(); } ?> </table> <?php // 释放资源 $rs->Close(); $conn->Close(); $rs = null; $conn = null;  ?> </body> </html>  

查询结果（与使用sql server managment studio效果一样）：

 

<table border="1" > <tbody > <tr > IDTitle </tr> <tr >
<td >114b0775-d9b2-db90-fcda-4a2f2cd7cdbd
</td>
<td >鏍紡浼氱ぞ鏈潵鍟嗕簨 629487
</td> </tr> <tr >
<td >1d270085-a588-9ea7-584c-4a2f2c8d1a5b
</td>
<td >Fabriqu茅 Interation氓l 79436
</td> </tr> <tr >
<td >23
</td>
<td >中文
</td> </tr> <tr >
<td >36ea2575-fe34-61b0-e5ae-4a2f2c791d22
</td>
<td >Berufskolleg f眉r Elektrotechnik 65790
</td> </tr> <tr >
<td >3834261a-
fd48-9d4a-be40-4a2f2c5fc256
</td>
<td >Berufskolleg f眉r Elektrotechnik 529523
</td> </tr> <tr >
<td >52c9652c-82c8-ec2b-72ae-4a2f2c3a58d6
</td>
<td >鏍紡浼氱ぞ鏈潵鍟嗕簨 42138
</td> </tr> <tr >
<td >78931a0e-f582-f406-8a56-4a2f2c3741b0
</td>
<td >But茅e Torique 700010
</td> </tr> <tr >
<td >989473f7-6b7b-fed3-12a1-4a2f2c320645
</td>
<td >A.B.銈便偄銉栥儸銈ゃ兂銈?181212
</td> </tr> <tr >
<td >b4579151-55cb-5ae4-a5f1-4a2f2c173b18
</td>
<td >B眉nde-Mitte 203765
</td> </tr> <tr >
<td >d72c42c9-9e1d-b926-d931-4a2f2c2a3100
</td>
<td >Berufskolleg f眉r Elektrotechnik 27682
</td> </tr> <tr >
<td >e97002f1-035f-91d3-4592-4a2f2f780e01
</td>
<td >zhh
</td> </tr> </tbody> </table>  

其中，23 ID的编码是GB2312的，其余是utf-8的。

而使用odbc则跟使用mssql_connect效果一样。

[](http://blog.csdn.net/ablo_zhou/archive/2009/06/10/4258206.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/06/10/4258206.aspx#)

  1. <html>
  2. <head>
  3. <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  4. </head>
  5. <body>
  6. <?php
  7. //print("The next line generates an error.<br>");
  8. //printaline("PLEASE?");
  9. //print("This will not be displayed due to the above error.");
  10. ?>
  11.   12. <?php
  13. //$conn = odbc_pconnect("myodbc", "sa", "cvttdev", 0);
  14. //$connstr="DRIVER=Microsoft Access Driver (*.mdb);DBQ=".realpath("mydb.mdb");
  15. $connstr="Driver={SQL Server};Server={192.168.22.40};Database=sugarcrm_db;UID=sa;PWD=123456;";
  16. $connid=odbc_connect($connstr,"sa","cvttdev",SQL_CUR_USE_ODBC );
  17.   18.   19. $query=odbc_do($connid,"select id,name from accounts");
  20. ?>
  21. <table border="1">
  22. <tr><th>ID</th><th>Title</th>
  23. </tr>
  24. <?php
  25. while(odbc_fetch_row($query))
  26. { echo '<tr>';
  27. $name = odbc_result($query,2);
  28. $id=odbc_result($query,1);
  29. echo '<td>'. $id .'</td>';
  30. echo '<td>'. $name .'</td>';
  31. echo '</tr>';
  32. }
  33. ?>
  34. </table>

<html> <head> <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> </head> <body> <?php //print("The next line generates an error.<br>"); //printaline("PLEASE?"); //print("This will not be displayed due to the above error."); ?>  <?php //$conn = odbc_pconnect("myodbc", "sa", "cvttdev", 0); //$connstr="DRIVER=Microsoft Access Driver (*.mdb);DBQ=".realpath("mydb.mdb");  $connstr="Driver={SQL Server};Server={192.168.22.40};Database=sugarcrm_db;UID=sa;PWD=123456;"; $connid=odbc_connect($connstr,"sa","cvttdev",SQL_CUR_USE_ODBC );    $query=odbc_do($connid,"select id,name from accounts");  ?> <table border="1"> <tr><th>ID</th><th>Title</th> </tr> <?php while(odbc_fetch_row($query)) {  echo '<tr>';    $name = odbc_result($query,2);    $id=odbc_result($query,1);  echo '<td>'. $id .'</td>';  echo '<td>'. $name .'</td>';  echo '</tr>'; } ?> </table>  

查询结果：

<table border="1" > <tbody > <tr > IDTitle </tr> <tr >
<td >114b0775-d9b2-db90-fcda-4a2f2cd7cdbd
</td>
<td >株式会社未来商事 629487
</td> </tr> <tr >
<td >1d270085-a588-9ea7-584c-4a2f2c8d1a5b
</td>
<td >Fabriqué Interationål 79436
</td> </tr> <tr >
<td >23
</td>
<td >����
</td> </tr> <tr >
<td >36ea2575-fe34-61b0-e5ae-4a2f2c791d22
</td>
<td >Berufskolleg für Elektrotechnik 65790
</td> </tr> <tr >
<td >3834261a-fd48-9d4a-be40-4a2f2c5fc256
</td>
<td >Berufskolleg für Elektrotechnik 529523
</td> </tr> <tr >
<td >52c9652c-82c8-ec2b-72ae-4a2f2c3a58d6
</td>
<td >株式会社未来商事 42138
</td> </tr> <tr >
<td >78931a0e-f582-f406-8a56-4a2f2c3741b0
</td>
<td >Butée Torique 700010
</td> </tr> <tr >
<td >989473f7-6b7b-fed3-12a1-4a2f2c320645
</td>
<td >A.B.ケアブレイン��?181212
</td> </tr> <tr >
<td >b4579151-55cb-5ae4-a5f1-4a2f2c173b18
</td>
<td >Bünde-Mitte 203765
</td> </tr> <tr >
<td >d72c42c9-9e1d-b926-d931-4a2f2c2a3100
</td>
<td >Berufskolleg für Elektrotechnik 27682
</td> </tr> <tr >
<td >e97002f1-035f-91d3-4592-4a2f2f780e01
</td>
<td >zhh
</td> </tr> </tbody> </table>   

因为odbc 也没有设置内码页的地方。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=5007f796-34a1-82c5-9852-802381399bc9)
