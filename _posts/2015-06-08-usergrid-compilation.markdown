---
author: abloz
comments: true
date: 2015-06-08 02:46:55+00:00
layout: post
link: http://abloz.com/index.php/2015/06/08/usergrid-compilation/
slug: usergrid-compilation
title: usergrid试用
wordpress_id: 2675
categories:
- 技术
tags:
- baas
- usergrid
---

周海汉 2015.6.8

usergrid是Ed Anuff（http://www.anuff.com) 2011年10月创立的，2012年1月被apigee收购，2012年10月，韩国电信hitel公司开发分支，2013年10月向apache提交的开源baas(backend as a service)，目前在孵化状态。韩国电信，三星等有使用该baas。实现了用户，数据，文件，安全，设备，社交，统计，电邮，自定义API等功能。数据库有抽象层，自带支持cassandra。usergrid采用maven编译。可以预先将maven环境配好，尤其是配好国内maven镜像。




官网：




[http://usergrid.incubator.apache.org/](http://usergrid.incubator.apache.org/)




github




http://github.com/apache/incubator-usergrid




下载最新版本：




https://github.com/apache/incubator-usergrid/archive/master.zip




下载最新源码




git clone https://github.com/apache/incubator-usergrid.git




环境：




jdk 1.7以上




maven




tomcat 7




cassandra




maven安装




brew install maven




编译：




下载后进到stack目录，执行：




zhh@stack % mvn clean install -DskipTests=true




编译完会生成**stack/rest/target/ROOT.war**




**将**tomcat/webapps/ROOT删除，将**ROOT.war复制到tomcat的webapps目录下。**




创建usergrid-custom.properties文件，放到tomcat的lib目录下：




```



usergrid.sysadmin.login.allowed=true




usergrid.sysadmin.login.name=superuser




usergrid.sysadmin.login.password=pw123




usergrid.sysadmin.email=me@example.com




usergrid.sysadmin.login.email=myself@example.com




usergrid.management.mailer=Myself<myself@example.com>




usergrid.test-account.admin-user.email=myself@example.com




usergrid.test-account.admin-user.password=test



```



设置用户数据库和管理数据库




[http://localhost:8080/system/database/setup](http://localhost:8080/system/database/setup)




[http://localhost:8080/system/superuser/setup](http://localhost:8080/system/superuser/setup)




用上面配置的用户名和密码登入，进行管理和设置。




编译管理界面入口




[https://github.com/apache/incubator-usergrid/blob/master/portal/README.md](https://github.com/apache/incubator-usergrid/blob/master/portal/README.md)




将_portal/build/usergrid-portal_ 复制到 _tomcat/webapps_




**测试：**




启动tomcat，http://localhost:8080/status 访问会看到json的usergrid状态数据。




也可以用portal访问。
