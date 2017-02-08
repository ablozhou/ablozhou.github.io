---
author: abloz
comments: true
date: 2015-06-01 03:27:06+00:00
layout: post
link: http://abloz.com/index.php/2015/06/01/does-not-match-the-version-of-the-java-runtime-environment-and-compiler-version/
slug: does-not-match-the-version-of-the-java-runtime-environment-and-compiler-version
title: java 运行环境版本和编译版本不匹配
wordpress_id: 2644
categories:
- 技术
tags:
- java
---

周海汉2015.6.1 儿童节快乐！










Caused by: java.lang.UnsupportedClassVersionError: com/xxx/Global : Unsupported major.minor version 52.0










根据 Java VM Spec, “A Java virtual machine implementation can support a class file format of version v if and only if v lies in some contiguous range Mi.0 v Mj.m. Only Sun can specify what range of versions a Java virtual machine implementation conforming to a certain release level of the Java platform may support.”




Java 的主版本号是:**_J2SE 8_**_ = 52, _**_J2SE_**_ 7 = 51, _J2SE 6.0 = 50, J2SE 5.0 = 49, JDK 1.4 = 48, JDK 1.3 = 47, JDK 1.2 = 46, JDK 1.1 = 45.




 “major.minor version 52.0” 就是jdk 1.8，当前环境不支持。即采用了J2SE 8来编译的类，其class文件的主版本major_version是52，最小版本minor_version是0.













**如何解决 UnsupportedClassVersionError? **




检查是否使用了较老的jdk来运行新版jdk编译的java程序。一般新版的jdk对老版的保持兼容，除非是版本相差太多。










因为我出错的原因是为了测试，将zshrc中的原jdk 1.8改成1.6了，所以报错。




zhh@~ % java -version




java version "1.6.0_65"




Java(TM) SE Runtime Environment (build 1.6.0_65-b14-466.1-11M4716)




Java HotSpot(TM) 64-Bit Server VM (build 20.65-b04-466.1, mixed mode)







在.zshrc或.bashrc,.bash_profile中改回来。




#export JAVA_HOME=`/usr/libexec/java_home -v 1.6`







export JAVA_HOME=`/usr/libexec/java_home`










zhh@~ % java -version




java version "1.8.0_45"




Java(TM) SE Runtime Environment (build 1.8.0_45-b14)




Java HotSpot(TM) 64-Bit Server VM (build 25.45-b02, mixed mode)







此时不再报上述错误，程序运行正常。







参考：




http://geekexplains.blogspot.com/2009_01_01_archive.html




http://ljhzzyx.blog.163.com/blog/static/383803122013719115332807/
