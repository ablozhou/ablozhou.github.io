---
author: abloz
comments: true
date: 2016-01-04 09:57:04+00:00
layout: post
link: http://abloz.com/index.php/2016/01/04/maven-build-spring4-mvc-web-site-services/
slug: maven-build-spring4-mvc-web-site-services
title: maven构建spring4 mvc网站服务
wordpress_id: 2710
categories:
- 技术
tags:
- java
- spring
---

周海汉

2016.1.4


eclipse 新建maven项目







pom.xml：




<project xmlns="[http://maven.apache.org/POM/4.0.0](http://maven.apache.org/POM/4.0.0)" xmlns:xsi="[http://www.w3.org/2001/XMLSchema-instance](http://www.w3.org/2001/XMLSchema-instance)"
xsi:schemaLocation="[http://maven.apache.org/POM/4.0.0](http://maven.apache.org/POM/4.0.0) [http://maven.apache.org/maven-v4_0_0.xsd](http://maven.apache.org/maven-v4_0_0.xsd)">
<modelVersion>4.0.0</modelVersion>
<groupId>com.zc</groupId>
<artifactId>server</artifactId>
<packaging>war</packaging>
<version>0.0.1-SNAPSHOT</version>
<name>server _Maven_ _Webapp_</name>
<url>[http://maven.apache.org](http://maven.apache.org)</url>
<properties>
<spring.version>4.2.2.RELEASE</spring.version>
</properties>
<dependencies>
<dependency>
<groupId>_junit_</groupId>
<artifactId>_junit_</artifactId>
<version>4.12</version>
<scope>test</scope>
</dependency>
<!-- Spring dependencies -->
<dependency>
<groupId>org.springframework</groupId>
<artifactId>spring-core</artifactId>
<version>${spring.version}</version>
<exclusions>
<exclusion>
<groupId>commons-logging</groupId>
<artifactId>commons-logging</artifactId>
</exclusion>
</exclusions>
</dependency><dependency>
<groupId>org.springframework</groupId>
<artifactId>spring-web</artifactId>
<version>${spring.version}</version>
</dependency>

<dependency>
<groupId>org.springframework</groupId>
<artifactId>spring-_webmvc_</artifactId>
<version>${spring.version}</version>
</dependency>

<dependency>
<groupId>org.springframework</groupId>
<artifactId>spring-_aop_</artifactId>
<version>${spring.version}</version>
</dependency>
<dependency>
<groupId>javax.servlet</groupId>
<artifactId>javax.servlet-_api_</artifactId>
<version>3.1-b08</version>
</dependency>
<dependency>
<groupId>log4j</groupId>
<artifactId>log4j</artifactId>
<version>1.2.16</version>
</dependency>

<dependency>
<groupId>org.slf4j</groupId>
<artifactId>_jcl_-over-slf4j</artifactId>
<version>1.5.8</version>
</dependency>
<dependency>
<groupId>org.slf4j</groupId>
<artifactId>slf4j-_api_</artifactId>
<version>1.5.8</version>
</dependency>
<dependency>
<groupId>org.slf4j</groupId>
<artifactId>slf4j-log4j12</artifactId>
<version>1.5.8</version>
</dependency>
<dependency>
<groupId>_jstl_</groupId>
<artifactId>_jstl_</artifactId>
<version>1.2</version>
</dependency>
<dependency>
<groupId>_taglibs_</groupId>
<artifactId>standard</artifactId>
<version>1.1.2</version>
</dependency>
</dependencies>

<build>
<finalName>server</finalName>
</build>
<organization>
<name>_zc_</name>
</organization>






</project>







==




在WEB-INF中新建 dispatcher-servlet.xml




<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="[http://www.springframework.org/schema/beans](http://www.springframework.org/schema/beans)"
xmlns:context="[http://www.springframework.org/schema/context](http://www.springframework.org/schema/context)"
xmlns:xsi="[http://www.w3.org/2001/XMLSchema-instance](http://www.w3.org/2001/XMLSchema-instance)"
xsi:schemaLocation="
[http://www.springframework.org/schema/beans](http://www.springframework.org/schema/beans)
[http://www.springframework.org/schema/beans/spring-beans-4.0.xsd](http://www.springframework.org/schema/beans/spring-beans-4.0.xsd)
[http://www.springframework.org/schema/context](http://www.springframework.org/schema/context)
[http://www.springframework.org/schema/context/spring-context-4.0.xsd](http://www.springframework.org/schema/context/spring-context-4.0.xsd)"><context:component-scan base-package="com.zc" />

<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
<property name="prefix">
<value>/WEB-INF/views/</value>
</property>
<property name="suffix">
<value>._jsp_</value>
</property>
</bean>






</beans>














* * *








在web.xml




<?xml version="1.0" encoding="UTF-8"?>
<web-app id="WebApp_ID" version="2.4"
xmlns="[http://java.sun.com/xml/ns/j2ee](http://java.sun.com/xml/ns/j2ee)"
xmlns:xsi="[http://www.w3.org/2001/XMLSchema-instance](http://www.w3.org/2001/XMLSchema-instance)"
xsi:schemaLocation="[http://java.sun.com/xml/ns/j2ee](http://java.sun.com/xml/ns/j2ee)
[http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd](http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd)"><display-name>_server_</display-name>
<servlet>
<servlet-name>dispatcher</servlet-name>
<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
<load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
<servlet-name>dispatcher</servlet-name>
<url-pattern>/</url-pattern>
</servlet-mapping>

<context-param>
<param-name>contextConfigLocation</param-name>
<param-value>/WEB-INF/dispatcher-servlet.xml</param-value>
</context-param>

<filter>
<filter-name>encodingFilter</filter-name>
<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
<init-param>
<param-name>encoding</param-name>
<param-value>UTF-8</param-value>
</init-param>
</filter>
<filter-mapping>
<filter-name>encodingFilter</filter-name>
<url-pattern>/*</url-pattern>
</filter-mapping>
<listener>
<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
<!-- 防止spring内存溢出监听器 -->
<listener>
<listener-class>org.springframework.web.util.IntrospectorCleanupListener</listener-class>
</listener>
<welcome-file-list>
<welcome-file>index.html</welcome-file>
<welcome-file>index.htm</welcome-file>
<welcome-file>/WEB-INF/index.jsp</welcome-file>
</welcome-file-list>






</web-app>







==




新建controller类：






package com.zc;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import _javax.servlet.Servlet_;
@Controller
public class MyController {

@RequestMapping("/getdata")
public String getData(@RequestParam(value="data", required=false, defaultValue="my data") String data, Model model) {

model.addAttribute("data", data);
//returns the view name
return "index";

}












}







==




在WEB-INF/views中新建index.jsp




<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "[http://www.w3.org/TR/html4/loose.dtd](http://www.w3.org/TR/html4/loose.dtd)">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h2>数据： ${data}</h2>
</body>




</html>











* * *








配置好tomcat




可以在eclipse的library中添加Library. 将tomcat，jre 1.8等添加进去。




并在order中选中。







执行run Server或者maven install，并将生成的war文件放到tomcat的webapps目录中。




访问




http://localhost/server/getdata/?data=mydata




显示




数据：mydata







问题：404 页面不存在




注意页面是否放在所在的地方。




如放在/WEB-INF/下，配置文件必须带该目录，而不是根目录。
