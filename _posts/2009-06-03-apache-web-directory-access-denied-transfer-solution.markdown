---
author: abloz
comments: true
date: 2009-06-03 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/06/03/apache-web-directory-access-denied-transfer-solution/
slug: apache-web-directory-access-denied-transfer-solution
title: apache移web目录后拒绝访问解决办法
wordpress_id: 909
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文

 

将apache的web目录由/var/www/html移到/home/zhouhh/php,结果出现下面的问题：

 

# Forbidden

You don't have permission to access /install/index.php on this server.

* * *

Apache/2.2.3 (CentOS) Server at 192.168.12.12 Port 80  

查找apache说明，如下：

[](http://blog.csdn.net/ablo_zhou/archive/2009/06/03/4239305.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/06/03/4239305.aspx#)

  1. 14.Why do I get a "Forbidden" message whenever I try to access a particular directory?
  2. This message is generally caused because either
  3.   4. ◦The underlying file system permissions do not allow the User/Group under which Apache is running to access the necessary files; or
  5. ◦The Apache configuration has some access restrictions in place which forbid access to the files.
  6. You can determine which case applies to your situation by checking the error log.
  7.   8. In the case where file system permission are at fault, remember that not only must the directory and files in question be readable, but also all parent directories must be at least searchable (i.e., chmod +x /directory/path) by the web server in order for the content to be accessible.
  9.   10.   11. --------------------------------------------------------------------------------
  12.   13. 15.Why do I get a "Forbidden/You don't have permission to access / on this server" message whenever I try to access my server?
  14. Search your conf/httpd.conf file for this exact string: <Files ~>. If you find it, that's your problem -- that particular <Files> container is malformed. Delete it or replace it with <Files ~ "^.ht"> and restart your server and things should work as expected.
  15.   16. This error appears to be caused by a problem with the version of linuxconf distributed with Redhat 6.x. It may reappear if you use linuxconf again.
  17.   18. If you don't find this string, check out the previous question.

14.Why do I get a "Forbidden" message whenever I try to access a particular  directory?  This message is generally caused because either  ◦The underlying file system permissions do not allow the User/Group  under which Apache is running to access the necessary files; or ◦The Apache configuration has some access restrictions in place which  forbid access to the files. You can determine which case applies to your situation by checking the  error log.  In the case where file system permission are at fault, remember that not only must the directory and files in question be readable, but also all parent directories must be at least searchable (i.e., chmod +x  /directory/path) by the web server in order for the content to be  accessible.   --------------------------------------------------------------------------------  15.Why do I get a "Forbidden/You don't have permission to access / on this  server" message whenever I try to access my server?  Search your conf/httpd.conf file for this exact string: <Files ~>. If you find it, that's your problem -- that particular <Files>  container is malformed. Delete it or replace it with <Files ~  "^.ht"> and restart your server and things should work as expected.  This error appears to be caused by a problem with the version of  linuxconf distributed with Redhat 6.x. It may reappear if you use  linuxconf again.  If you don't find this string, check out the previous question.    

检查配置文件，将其改为如下：

[](http://blog.csdn.net/ablo_zhou/archive/2009/06/03/4239305.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/06/03/4239305.aspx#)

  1. DocumentRoot "/home/zhouhh/php"
  2.   3. <Directory "/home/zhouhh/php">
  4.   5. #
  6. # Possible values for the Options directive are "None", "All",
  7. # or any combination of:
  8. # Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
  9. #
  10. # Note that "MultiViews" must be named *explicitly* --- "Options All"
  11. # doesn't give it to yo
u.
  12. #
  13. # The Options directive is both complicated and important. Please see
  14. # http://httpd.apache.org/docs/2.2/mod/core.html#options
  15. # for more information.
  16. #
  17. Options Indexes FollowSymLinks
  18.   19. #
  20. # AllowOverride controls what directives may be placed in .htaccess files.
  21. # It can be "All", "None", or any combination of the keywords:
  22. # Options FileInfo AuthConfig Limit
  23. #
  24. AllowOverride None
  25.   26. #
  27. # Controls who can get stuff from this server.
  28. #
  29. Order allow,deny
  30. Allow from all
  31.   32. </Directory>
  33. <Files ~ "^.ht">
  34. Order allow,deny
  35. Deny from all
  36. </Files>

DocumentRoot "/home/zhouhh/php"  <Directory "/home/zhouhh/php">  # # Possible values for the Options directive are "None", "All", # or any combination of: #   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews # # Note that "MultiViews" must be named *explicitly* --- "Options All" # doesn't give it to you. # # The Options directive is both complicated and important.  Please see # http://httpd.apache.org/docs/2.2/mod/core.html#options # for more information. #    Options Indexes FollowSymLinks  # # AllowOverride controls what directives may be placed in .htaccess files. # It can be "All", "None", or any combination of the keywords: #   Options FileInfo AuthConfig Limit #    AllowOverride None  # # Controls who can get stuff from this server. #    Order allow,deny    Allow from all  </Directory> <Files ~ "^.ht">    Order allow,deny    Deny from all </Files>  

问题依旧

 

后面发现

[zhouhh@cvttssw ~]$ ll -a  
总计 22200  
drwxr--r-- 14 zhouhh zhouhh 4096 06-03 15:25 .  
drwxr-xr-x 9 root root 4096 04-15 16:41 ..  
原来是所有网页父目录都必须有可读和可执行权限的问题

[zhouhh@cvttssw ~]$ chmod +x .  
一切ok，问题解决。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=7a9a6f1f-52ae-8ca3-a8c3-41d6b8a0ee34)
