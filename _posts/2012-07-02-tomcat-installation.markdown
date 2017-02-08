---
author: abloz
comments: true
date: 2012-07-02 09:34:29+00:00
layout: post
link: http://abloz.com/index.php/2012/07/02/tomcat-installation/
slug: tomcat-installation
title: tomcat安装
wordpress_id: 1735
categories:
- 技术
---

来源：http://abloz.com  
author:ablozhou  
date: 2012-07-02

  


[zhouhh@Hadoop48 ~]$ wget http://labs.renren.com/apache-mirror/tomcat/tomcat-7/v7.0.28/bin/apache-tomcat-7.0.28.tar.gz

Length: 7674156 (7.3M) [application/x-gzip]

[zhouhh@Hadoop48 ~]$ tar zxvf apache-tomcat-7.0.28.tar.gz

[zhouhh@Hadoop48 bin]$ ./startup.sh

浏览http://192.168.10.48:8080/或http://hadoop48:8080/

If you're seeing this, you've successfully installed Tomcat. Congratulations!

web jsp源码在/home/zhouhh/apache-tomcat-7.0.28/webapps/ROOT

其他项目可以放在webapps目录下，通过子目录进行访问。

  


  

