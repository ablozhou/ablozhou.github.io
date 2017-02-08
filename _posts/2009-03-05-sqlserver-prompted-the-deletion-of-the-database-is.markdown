---
author: abloz
comments: true
date: 2009-03-05 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/03/05/sqlserver-prompted-the-deletion-of-the-database-is/
slug: sqlserver-prompted-the-deletion-of-the-database-is
title: Sqlserver在删数据库时提示正在使用
wordpress_id: 899
categories:
- 技术
---

Sqlserver2005，在删除一个数据库的时候显示：数据库正在被使用，无法删除。

这是因为有连接在上面，可以

 

可以新建一个查询，输入：

use master   
go 

declare @d varchar(8000)   
set @d= ' '   
select @d=@d+ ' kill '+cast(spid as varchar)+char(13)   
from master..sysprocesses where dbid=db_id( '库名 ')   
exec(@d) 

 

执行，就将数据库分离了。再删除就可以了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=2f700b26-f732-886a-9fb3-df9f9470ef5f)
