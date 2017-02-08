---
author: abloz
comments: true
date: 2016-01-04 10:00:29+00:00
layout: post
link: http://abloz.com/index.php/2016/01/04/spring4-resources/
slug: spring4-resources
title: spring4 资源
wordpress_id: 2713
categories:
- 技术
tags:
- java
- spring
---

周海汉

2016.1.4


官网




[http://spring.io/](http://spring.io/)




教程：




[http://spring.io/guides/](http://spring.io/guides/)




下载：




[https://github.com/spring-projects/spring-framework](https://github.com/spring-projects/spring-framework)




[http://spring.io/guides](http://spring.io/guides) spring4.0




[http://spring.io/guides/gs/rest-service/](http://spring.io/guides/gs/rest-service/)




[https://github.com/spring-guides](https://github.com/spring-guides)




git url:




git clone git://github.com/SpringSource/spring-framework.git




[https://codeload.github.com/ablozhou/spring-framework/tar.gz/v4.1.6.RELEASE](https://codeload.github.com/ablozhou/spring-framework/tar.gz/v4.1.6.RELEASE)







[https://repo.spring.io/libs-release-local/org/springframework/spring/](https://repo.spring.io/libs-release-local/org/springframework/spring/)







[https://repo.spring.io/libs-release-local/org/springframework/spring/4.1.6.RELEASE/](https://repo.spring.io/libs-release-local/org/springframework/spring/4.1.6.RELEASE/)




[https://repo.spring.io/libs-release-local/org/springframework/spring/4.1.6.RELEASE/spring-framework-4.1.6.RELEASE-dist.zip](https://repo.spring.io/libs-release-local/org/springframework/spring/4.1.6.RELEASE/spring-framework-4.1.6.RELEASE-dist.zip)




[https://repo.spring.io/libs-release-local/org/springframework/spring/4.1.6.RELEASE/spring-framework-4.1.6.RELEASE-docs.zip](https://repo.spring.io/libs-release-local/org/springframework/spring/4.1.6.RELEASE/spring-framework-4.1.6.RELEASE-docs.zip)







例子




[https://github.com/spring-projects?utf8=%E2%9C%93&query=sample](https://github.com/spring-projects?utf8=%E2%9C%93&query=sample)







核心包




commons-collections-xx.jar




commons-logging.jar




spring-aop-xxx.jar




spring-beans-xxx.jar




spring-context-xxx.jar




spring-core-xxx.jar




spring-expression-xxx.jar







eclipse xml提示




[http://springide.org/updatesite](http://springide.org/updatesite)




安装


Core/Spring IDE




Extensions/SpringIDE




Resources/SpringIDE










(可选)有很多其它的spring插件都会依赖于这个ajdt,所以你先要安装eclipse ajdt插件，updatesite:**[http://download.eclipse.org/tools/ajdt/36/update](http://download.eclipse.org/tools/ajdt/36/update)**




zhh@spring-framework-4.1.6.RELEASE % ./gradlew




Unrecognized VM option 'MaxMetaspaceSize=1024m'




Could not create the Java virtual machine.







spring framework 4以上需安装jdk 1.8以上。




[http://www.oracle.com/technetwork/java/javase/downloads/index.html](http://www.oracle.com/technetwork/java/javase/downloads/index.html)




下载安装jdk 1.8.




如果不能安装新java环境，也可以将gradlew和build.gradle里面的MaxMetaspaceSize=1024m 去掉。










MaxMetaspaceSize为Java8中新引入的参数，我当前环境使用的是java7,改为java8后就OK了






这是因为”MaxMetaspaceSize=1024m” 这个参数配置只出现在jdk 8中，默认情况下是在master分支下，猜测是基于jdk 8开发。






所以有三个选择：
1. 切换到其他分支，如3.2.X
2. 安装jdk8


3. 编辑gradlew.bat，移去VM option MaxMetaspaceSize.






