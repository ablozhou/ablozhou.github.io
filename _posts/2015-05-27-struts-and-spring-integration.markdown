---
author: abloz
comments: true
date: 2015-05-27 11:09:38+00:00
layout: post
link: http://abloz.com/index.php/2015/05/27/struts-and-spring-integration/
slug: struts-and-spring-integration
title: spring和struts整合
wordpress_id: 2302
categories:
- 技术
tags:
- java
---

周海汉 2015.5.27


**目录结构：**






    
    zhh@bbj % ls
    WebContent src
    zhh@bbj % find .
    .
    ./.classpath
    ./.DS_Store
    ./.project
    ./.settings
    ./.settings/.jsdtscope
    ./.settings/org.eclipse.jdt.core.prefs
    ./.settings/org.eclipse.wst.common.component
    ./.settings/org.eclipse.wst.common.project.facet.core.xml
    ./.settings/org.eclipse.wst.jsdt.ui.superType.container
    ./.settings/org.eclipse.wst.jsdt.ui.superType.name
    ./.springBeans
    ./src
    ./src/applicationContext.xml
    ./src/com
    ./src/com/bbj
    ./src/com/bbj/action
    ./src/com/bbj/action/GetMediaList.java
    ./src/com/bbj/action/Media.java
    ./src/com/bbj/action/MediaMgr.java
    ./src/com/bbj/action/TestGet.java
    ./src/com/bbj/model
    ./src/com/bbj/model/SampleData.java
    ./src/struts.xml
    ./WebContent
    ./WebContent/.DS_Store
    ./WebContent/index.jsp
    ./WebContent/META-INF
    ./WebContent/META-INF/MANIFEST.MF
    ./WebContent/WEB-INF
    ./WebContent/WEB-INF/.DS_Store
    ./WebContent/WEB-INF/classes
    ./WebContent/WEB-INF/classes/.DS_Store
    ./WebContent/WEB-INF/classes/applicationContext.xml
    ./WebContent/WEB-INF/classes/com
    ./WebContent/WEB-INF/classes/com/.DS_Store
    ./WebContent/WEB-INF/classes/com/bbj
    ./WebContent/WEB-INF/classes/com/bbj/.DS_Store
    ./WebContent/WEB-INF/classes/com/bbj/action
    ./WebContent/WEB-INF/classes/com/bbj/action/GetMediaList.class
    ./WebContent/WEB-INF/classes/com/bbj/action/Media.class
    ./WebContent/WEB-INF/classes/com/bbj/action/MediaMgr.class
    ./WebContent/WEB-INF/classes/com/bbj/action/TestGet.class
    ./WebContent/WEB-INF/classes/com/bbj/model
    ./WebContent/WEB-INF/classes/com/bbj/model/SampleData.class
    ./WebContent/WEB-INF/classes/struts.xml
    ./WebContent/WEB-INF/jsp
    ./WebContent/WEB-INF/jsp/getlist.jsp
    ./WebContent/WEB-INF/lib
    ./WebContent/WEB-INF/lib/asm-3.3.jar
    ./WebContent/WEB-INF/lib/asm-commons-3.3.jar
    ./WebContent/WEB-INF/lib/asm-tree-3.3.jar
    ./WebContent/WEB-INF/lib/commons-chain-1.2.jar
    ./WebContent/WEB-INF/lib/commons-collections-3.1.jar
    ./WebContent/WEB-INF/lib/commons-fileupload-1.3.1.jar
    ./WebContent/WEB-INF/lib/commons-io-2.2.jar
    ./WebContent/WEB-INF/lib/commons-jci-core-1.1.jar
    ./WebContent/WEB-INF/lib/commons-jci-fam-1.1.jar
    ./WebContent/WEB-INF/lib/commons-lang3-3.2.jar
    ./WebContent/WEB-INF/lib/commons-logging-1.1.3.jar
    ./WebContent/WEB-INF/lib/freemarker-2.3.22.jar
    ./WebContent/WEB-INF/lib/google-collections-1.0.jar
    ./WebContent/WEB-INF/lib/javassist-3.11.0.GA.jar
    ./WebContent/WEB-INF/lib/log4j-api-2.2.jar
    ./WebContent/WEB-INF/lib/log4j-core-2.2.jar
    ./WebContent/WEB-INF/lib/ognl-3.0.6.jar
    ./WebContent/WEB-INF/lib/spring-aop-4.1.6.RELEASE.jar
    ./WebContent/WEB-INF/lib/spring-beans-4.1.6.RELEASE.jar
    ./WebContent/WEB-INF/lib/spring-context-4.1.6.RELEASE.jar
    ./WebContent/WEB-INF/lib/spring-core-4.1.6.RELEASE.jar
    ./WebContent/WEB-INF/lib/spring-expression-4.1.6.RELEASE.jar
    ./WebContent/WEB-INF/lib/spring-web-4.1.6.RELEASE.jar
    ./WebContent/WEB-INF/lib/struts2-core-2.3.24.jar
    ./WebContent/WEB-INF/lib/struts2-json-plugin-2.3.24.jar
    ./WebContent/WEB-INF/lib/struts2-spring-plugin-2.3.24.jar
    ./WebContent/WEB-INF/lib/velocity-1.6.4.jar
    ./WebContent/WEB-INF/lib/xwork-core-2.3.24.jar
    ./WebContent/WEB-INF/web.xml



    
    applicationContext.xml
    <?xml version="1.0" encoding="UTF-8"?>
    <beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd"
    >
    
    <bean id="getlist" class="com.bbj.action.GetMediaList" scope="prototype"></bean>
    <bean id="media" class="com.bbj.action.Media" scope="prototype"></bean>
    <bean id="mediamgr" class="com.bbj.action.MediaMgr" scope="prototype"></bean>
    <bean id="sampledata" class="com.bbj.model.SampleData" scope="prototype"></bean>
    
    <bean id="testget" class="com.bbj.action.TestGet" scope="prototype"></bean>
    
    </beans>


struts.xml

    
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE struts PUBLIC
    "-//Apache Software Foundation//DTD Struts Configuration 2.3//EN"
    "http://struts.apache.org/dtds/struts-2.3.dtd">
    
    <struts>
    <constant name="struts.objectFactory" value="org.apache.struts2.spring.StrutsSpringObjectFactory" />
        <constant name="struts.enable.DynamicMethodInvocation" value="false" />
        <constant name="struts.devMode" value="true" />
    
    <package name="default" namespace="/" extends="json-default">
    <action name="getlist" class="com.bbj.action.GetMediaList" method="execute">
    <result type="json">
    <param name="root">mediaLists</param>
    </result>
    </action>
    <action name="audiolist" class="com.bbj.action.GetMediaList" method="getAudioList">
    <result type="json">
    <param name="root">mediaLists</param>
    </result>
    </action>
    <action name="videolist" class="com.bbj.action.GetMediaList" method="getVideoList">
    <result type="json">
    <param name="root">mediaLists</param>
    </result>
    </action>
    <action name="testget" class="com.bbj.action.TestGet" method="execute">
    <result type="json">
    <param name="root">message</param>
    </result>
    </action>
    <!-- action name="getmgr" class="com.bbj.GetMediaList" method="getMgr">
    <result type="json"> <param name="root">mgrList</param> </result> </action> -->
    </package>
    </struts>
    


web.xml

    
    <?xml version="1.0" encoding="UTF-8"?>
    <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd" id="WebApp_ID" version="3.0">
      <display-name>bbj</display-name>
      <welcome-file-list>
    
        <welcome-file>index.jsp</welcome-file>
    
      </welcome-file-list>
      <filter>
        <filter-name>struts2</filter-name>
        <filter-class>org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter</filter-class>
      </filter>
      <filter-mapping>
        <filter-name>struts2</filter-name>
        <url-pattern>/*</url-pattern>
      </filter-mapping>
     
      <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>
    
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:applicationContext.xml</param-value>
    </context-param>
    <context-param>
        <param-name>contextClass</param-name>
        <param-value>org.apache.struts2.spring.ClassReloadingXMLWebApplicationContext</param-value>
    </context-param>
    </web-app>
    


问题：


1. java.lang.NoClassDefFoundError: org/apache/commons/jci/monitor/FilesystemAlterationListener




_使用到了ClassReloadingXMLWebApplicationContext这个类，这个类的父类中会实现FilesystemAlterationListener接口，这个接口在struts和spring提供的jar包中是找不到的，其包含在apache的commons的jci库中，具体到jar包为commons-jci-fam-1.1.jar 下载地址：[http://commons.apache.org/proper/commons-jci/](http://commons.apache.org/proper/commons-jci/) _







commons-jci-fam-1.1.jar







2.整合完毕时浏览器中找不到action







### Stacktraces




**Unable to instantiate Action, com.bbj.GetMediaList, defined for 'videolist' in namespace '/'com.bbj.GetMediaList - action - file:/Users/zhh/Documents/workspace1/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/bbj/WEB-INF/classes/struts.xml:22:79**




    
        com.opensymphony.xwork2.DefaultActionInvocation.createAction(DefaultActionInvocation.java:314)
        com.opensymphony.xwork2.DefaultActionInvocation.init(DefaultActionInvocation.java:395)
    
    













**java.lang.ClassNotFoundException: com.bbj.GetMediaList**




** **




console没有报任何错误。但浏览http://localhost:8189/bbj/getlist时报上述错误。




刚开始以为spring配置有问题，因为我action中使用了容器，bean中并没有配置。后面写了一个简单的bean来测试也是上述错误，发现原来这是struts中配置的action的class的路径配置错误，实际包是com.bbj.action.GetMediaList.















