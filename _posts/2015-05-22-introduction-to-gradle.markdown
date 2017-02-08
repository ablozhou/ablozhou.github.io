---
author: abloz
comments: true
date: 2015-05-22 04:03:58+00:00
layout: post
link: http://abloz.com/index.php/2015/05/22/introduction-to-gradle/
slug: introduction-to-gradle
title: gradle入门
wordpress_id: 2292
categories:
- 技术
tags:
- gradle
- java
---

周海汉 2015.5.22




Gradle用于java自动化编译，相比ant和maven的xml配置来说，强大很多。Gradle采用Groovy脚本语言，可以引用java的包。gradle代表了未来java编译的趋势。本文描述gradle安装和基本示例。







一、准备gradle







环境JDK 1.6以上










1.下载gradle




 [http://www.gradle.org/downloads](http://www.gradle.org/downloads)




下载二进制文件，最新的是2.4，将近44MB ：[https://services.gradle.org/distributions/gradle-2.4-bin.zip](https://services.gradle.org/distributions/gradle-2.4-bin.zip)







2.设置环境变量，并生效




解压，我将其移到我指定目录，并修改环境变量




export GRADLE_HOME=$HOME/java/gradle-2.4




export export PATH=$PATH:$GRADLE_HOME/bin







3.测试




zhh@~ % gradle -v







------------------------------------------------------------




Gradle 2.4




------------------------------------------------------------







Build time: 2015-05-05 08:09:24 UTC




Build number: none




Revision: 5c9c3bc20ca1c281ac7972643f1e2d190f2c943c







Groovy: 2.3.10




Ant: Apache Ant(TM) version 1.9.4 compiled on April 29 2014




JVM: 1.6.0_65 (Apple Inc. 20.65-b04-466.1)




OS: Mac OS X 10.10.3 x86_64







二、Gradle脚本




zhh@test % cat build.gradle




task hello {




doLast {




println 'Hello world!'




}




}




zhh@test % gradle hello




:hello




Hello world!







BUILD SUCCESSFUL







Total time: 1.95 secs







This build could be faster, please consider using the Gradle Daemon: http://gradle.org/docs/2.4/userguide/gradle_daemon.html




zhh@test % gradle -q hello




Hello world!







gradle采用Groovy脚本语言完成，task是gradle的执行任务，类似于ant的target。但Groovy语言强大许多。










添加快捷任务task,包含一个闭包：




task count << {




4.times { print "$it " }




}







zhh@test % gradle -q count




0 1 2 3 %







添加：




task intro(dependsOn: hello) << {




println "I'm Abloz"




}




zhh@test % gradle -q intro




Hello world!




I'm Abloz







添加动态任务




4.times { counter ->




task "task$counter" << {




println "I'm task number $counter"




}




}




zhh@test % gradle -q task1




I'm task number 1







使用ant




task loadfile << {




def files = file('../antLoadfileResources').listFiles().sort()




files.each { File file ->




if (file.isFile()) {




ant.loadfile(srcFile: file, property: file.name)




println " *** $file.name ***"




println "${ant.properties[file.name]}"




}




}




}







缺省任务：




defaultTasks 'clean', 'run'







task clean << {




println 'Default Cleaning!'




}







task run << {




println 'Default Running!'




}




zhh@test % gradle -q




Default Cleaning!




Default Running!







依赖任务编译的脚本




task distribution << {




println "We build the zip with version=$version"




}







task release(dependsOn: 'distribution') << {




println 'We release now'




}







gradle.taskGraph.whenReady {taskGraph ->




if (taskGraph.hasTask(release)) {




version = '1.0'




} else {




version = '1.0-SNAPSHOT'




}




}







zhh@test % gradle -q distribution




We build the zip with version=1.0-SNAPSHOT




zhh@test % gradle -q release




We build the zip with version=1.0




We release now







三、参考




https://docs.gradle.org/current/userguide/tutorials
