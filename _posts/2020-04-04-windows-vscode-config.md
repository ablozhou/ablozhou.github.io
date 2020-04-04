---
layout: post
title:  "windows vscode java环境配置"
author: "周海汉"
date:   2020-04-04 13:48:26 +0800
categories: tech
tags:
    - win10
    - java
    - vscode
---

# 概述
最近需要用到windows开发环境，所以记录一下windows下用vscode进行java开发的环境配置。


# 环境
- Windows 10
- vscode
- jdk8
- jdk14
- maven 3.6.3

# 下载jdk
oracle 在jdk 11以后，商业化生产环境使用需要license。所以采用openjdk。最新的是14.

但jdk8以后，版本号升级太快，大的更新较少。所以可以用长期支持版本jdk8或10.

## 下载地址
http://jdk.java.net/14/

下载后解压到指定地方，我是放在home下的java目录。

在桌面“此电脑”点右键，点开属性，找到环境变量。
在系统环境变量添加
- JAVA_HOME
```
C:\Users\ablo_\java\jdk-13.0.1
```
- CLASSPATH
```
.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;
```
- Path
添加
```
%JAVA_HOME%\bin
%JAVA_HOME%\jre\bin

```

## 下载maven
http://maven.apache.org/download.cgi

最新版3.6.3

### 环境变量
- Path
添加
```
C:\Users\ablo_\java\apache-maven-3.6.3\bin
```
### 配置maven镜像
由于境外很慢，所以配置阿里云maven镜像

```
C:\Users\ablo_\.m2> notepad settings.xml
```
添加：
```
 <?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
   <mirrors>
  
    <mirror>  
      <id>alimaven</id>  
      <name>aliyun maven</name>  
      <url>https://maven.aliyun.com/repository/public</url>  
      <mirrorOf>central</mirrorOf>  
    </mirror>  
  </mirrors>
</settings> 
```
在C:/Users/ablo_/java/apache-maven-3.6.3/conf/settings.xml 里面同样添加mirror里的内容。

# 下载配置vscode
- 官网：https://code.visualstudio.com/
- 下载地址：https://code.visualstudio.com/download

Windows下最好下载专门为java开发者配置的版本：
https://aka.ms/vscode-java-installer-win
其他操作系统则需手动设置jdk等配置。

打开扩展视图(Ctrl+Shift+X),
在扩展插件里搜java，
下载微软官方java extension pack及pivotal的Spring Boot  extension pack

单独的话需要 Language Support for Java(TM) by Red Hat及Spring Initializr Java Support，Maven for Java
等相关插件。

其中，java extension pack 包含：
1. Language Support for Java(TM) by Red Hat
1. Debugger for Java
1. Java Test Runner
1. Maven for Java
1. Java Dependency Viewer
1. Visual Studio IntelliCode

Spring Boot Extension Pack 包含Spring Initializr Java Support，Spring Boot Tools，Spring Boot Dashboard，Cloud Foundry Manifest YML Support，Concourse CI Pipeline Editor等组件。


根据需要，再下载其他相关插件即可：
1. Spring Boot Tools
1. Spring Initializr Java Support
1. Spring Boot Dashboard
1. Tomcat
1. Jetty
1. CheckStyle
2. Lombok Annotations Support for VS Code


安装完插件可能需要重启vscode。

## 配置maven
打开 `File->Preferences->Settings`，搜索 maven，点击editing in settings.json

在打开的文件中填入
```
"maven.executable.path": "C:/Users/ablo_/java/apache-maven-3.6.3/bin/mvn.cmd",
    "java.configuration.maven.userSettings": "C:/Users/ablo_/java/apache-maven-3.6.3/conf/settings.xml",
    
    "java.home": "C:\\Users\\ablo_\\java\\jdk-13.0.1",

    "maven.terminal.customEnv": [
        {
            "environmentVariable": "JAVA_HOME",       
            "value": "C:\\Users\\ablo_\\java\\jdk-13.0.1"       
        }
    ],
```
不使用vs自带的maven更可控一些。

# 测试java项目
按ctrl+shift+p,键入maven
点击Maven:create maven project.
根据提示完成，即生成一个maven项目。

如要生成gradle项目，则需配置相应gradle环境。

打开目录后，已经生成缺省的项目。

## 添加调试configuration
按ctrl+shift+d，进入调试界面。
左上方点击add configuration，打开launch.json。
这个文档一般会自动生成。也可手动修改。

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "java",
            "name": "Debug (Launch) - External Console",
            "request": "launch",
           "cwd":"${workspaceRoot}",
            "mainClass": "${file}",
            "console": "externalTerminal"
            "jdkPath": "${env:JAVA_HOME}/bin",
            
        },
        {
            "type": "java",
            "name": "Debug (Launch)-Main",
            "request": "launch",
            "mainClass": "",
            "args":"",
            "console":"integratedTerminal",
            "projectName": ""
        }
    ]
}
```

至此，环境配置完成。

# 测试spring boot
确认安装spring boot extension pack 和lombok automations support for vs code

ctrl+shift+p
输入spring，选择initializr: Create a Maven Project.
根据提示选择组件。
我选择了spring boot web, jpa, lombok, h2, mybatis等组件。

创建完成。

## pom.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.2.1.RELEASE</version>
		<relativePath/> <!-- lookup parent from repository -->
	</parent>
	<groupId>com.abloz</groupId>
	<artifactId>demo1</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<name>demo</name>
	<description>Demo project for Spring Boot</description>

	<properties>
		<java.version>1.8</java.version>
	</properties>

	<dependencies>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>
		<dependency>
			<groupId>org.mybatis.spring.boot</groupId>
			<artifactId>mybatis-spring-boot-starter</artifactId>
			<version>2.1.1</version>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-devtools</artifactId>
			<scope>runtime</scope>
			<optional>true</optional>
		</dependency>
		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
			<version>1.18.10</version>
			<scope>provided</scope>
		</dependency>
		<!-- 添加 Spring Data JPA 依赖 -->  
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-jpa</artifactId>
		</dependency> 

		<dependency>
			<groupId>com.h2database</groupId>
			<artifactId>h2</artifactId>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
			<exclusions>
				<exclusion>
					<groupId>org.junit.vintage</groupId>
					<artifactId>junit-vintage-engine</artifactId>
				</exclusion>
			</exclusions>
		</dependency>
	
 </dependencies>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
		</plugins>
	</build>

</project>

```
## application.yml
```

server:
  port: 8080
spring:
  datasource:
    url: jdbc:h2:~/test
    driver-class-name: org.h2.Driver
    username: sa
    password: 123456

  jpa:
    database: h2
    hibernate:
      ddl-auto: update
    show-sql: true
  h2:
    console:
      path: /h2-console
      enabled: true
```
## DemoApplication.java
```
package com.abloz.demo1;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class DemoApplication {

    @Bean
    InitializingBean initUser(UserRepo repo){
        return ()->{
            repo.save(new User((long)1,"张三",20,1));
            repo.save(new User(2L,"李四",22,1));
            repo.save(new User(0L, "西施",18,0));
            repo.save(new User(0L, "貂蝉",15,0));
            
        };
    }
	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

}

```
## HelloController.java
```
package com.abloz.demo1;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class HelloController {

    @Autowired
    private UserRepo userRepo;

    @ResponseBody
    @RequestMapping("/hello")
    public List<User> hello(){
        return userRepo.findAll();
    }
}
```
## User.java
```
package com.abloz.demo1;

import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private Integer age;
    private Integer sex;
}
```
## UserRepo.java
```
package com.abloz.demo1;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepo extends JpaRepository<User, Long> {
    

}


```

# 执行
访问 http://localhost:8080/h2-console，数据库输入 jdbc:h2:~/test，用户sa，密码123456
登入，可以看到User表和相关数据。

访问 http://localhost:8080/hello
可以看到User的Json数据。


## error 
## Cannot find debug adapter for type 'java'
将home下的.vscode里面清空，重新安装插件
## Extension host terminated unexpectedly.

# 参考
https://code.visualstudio.com/docs/languages/java
