---
layout: post
title:  "ClassNotFoundException ch.qos.logback.classic.Level"
author: "周海汉"
date:   2018-11-15 19:38:26 +0800
categories: tech
tags:
    - springboot
    - java
---

运行springboot 的demo时遇到一个奇怪的错误：
```
ClassNotFoundException ch.qos.logback.classic.Level
```
环境 spring boot 2.1.0

原来，gradle 缺省用了implementation
```
	implementation('org.springframework.boot:spring-boot-starter-web')
```
报错
```
Caused by: java.lang.ClassNotFoundException: ch.qos.logback.classic.Level
```

但是看到gradle里面有相应的库。
可以手动加入logback或者将implementation改为compile。因为前者不会跨lib调用，后者可以。

添加依赖库
```
	implementation('ch.qos.logback:logback-classic:1.2.3')
	implementation('ch.qos.logback:logback-core:1.2.3')
```

或者 改为compile
```
compile('org.springframework.boot:spring-boot-starter-web')
```
