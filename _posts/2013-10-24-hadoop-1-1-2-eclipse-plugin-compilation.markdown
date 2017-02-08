---
author: abloz
comments: true
date: 2013-10-24 11:39:14+00:00
layout: post
link: http://abloz.com/index.php/2013/10/24/hadoop-1-1-2-eclipse-plugin-compilation/
slug: hadoop-1-1-2-eclipse-plugin-compilation
title: hadoop 1.1.2 eclipse plugin 编译
wordpress_id: 2252
categories:
- 技术
tags:
- eclipse
---




hadoop 1.1.2 eclipse plugin 编译







周海汉/文




2013.10.24







环境




[andy@s41 ~]$ echo $JAVA_HOME
/usr/java/jdk1.6.0_45




[andy@s41 ~]$ uname -a
Linux s41 2.6.32-358.el6.x86_64 #1 SMP Fri Feb 22 00:31:26 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
[andy@s41 ~]$ cat /etc/redhat-release
CentOS release 6.4 (Final)







下载最新 eclipse




wget http://mirror.bit.edu.cn/eclipse/technology/epp/downloads/release/kepler/SR1/eclipse-standard-kepler-SR1-linux-gtk-x86_64.tar.gz




or







 wget [http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/kepler/SR1/eclipse-java-kepler-SR1-linux-gtk-x86_64.tar.gz&mirror_id=547](http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/kepler/SR1/eclipse-java-kepler-SR1-linux-gtk-x86_64.tar.gz&mirror_id=547)










下载eclipse sdk 4.3.1




[http://www.eclipse.org/eclipse4/](http://www.eclipse.org/eclipse4/)







wget [http://mirror.bit.edu.cn/eclipse/eclipse/downloads/drops4/R-4.3.1-201309111000/eclipse-SDK-4.3.1-linux-gtk-x86_64.tar.gz](http://mirror.bit.edu.cn/eclipse/eclipse/downloads/drops4/R-4.3.1-201309111000/eclipse-SDK-4.3.1-linux-gtk-x86_64.tar.gz)







解压到/home/andy目录下。







进入插件源码目录




[andy@s41 eclipse-plugin]$ pwd


/home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin





修改build.properties,增加




eclipse.home=/home/andy/eclipse/
version=1.1.2




[andy@s41 eclipse-plugin]$ vi build.properties




output.. = bin/
bin.includes = META-INF/,
plugin.xml,
resources/,
classes/,
classes/,
lib/

eclipse.home=/home/andy/eclipse/
version=1.1.2










修改build.xml,增加fileset,复制两个jar文件到新目录




<path id="eclipse-sdk-jars">




     <fileset dir="../../../">
<include name="hadoop*.jar"/>
</fileset>




...




<target name="jar" depends="compile" unless="skip.contrib">




 <!--
<copy file="${hadoop.root}/build/hadoop-core-${version}.jar" tofile="${build.dir}/lib/hadoop-core.jar" verbose="true"/>
<copy file="${hadoop.root}/build/ivy/lib/Hadoop/common/commons-cli-${commons-cli.version}.jar"  todir="${build.dir}/lib" verbose="true"/>
-->
<copy file="${hadoop.root}/hadoop-core-${version}.jar" tofile="${build.dir}/lib/hadoop-core.jar" verbose="true"/>
<copy file="${hadoop.root}/lib/commons-cli-${commons-cli.version}.jar"  todir="${build.dir}/lib" verbose="true"/>
















[andy@s41 eclipse-plugin]$ ant




[andy@s41 hadoop-1.1.2]$ cp build/contrib/eclipse-plugin/hadoop-eclipse-plugin-1.1.2.jar ~/eclipse/plugins/







此前遇到如下错误，应是eclipse sdk和sdk版本不配套的问题。




compile:
[echo] contrib: eclipse-plugin
[javac] Compiling 45 source files to /home/andy/hadoop-1.1.2/build/contrib/eclipse-plugin/classes
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/HadoopPerspectiveFactory.java:22: package org.eclipse.jdt.ui does not exist
[javac] import org.eclipse.jdt.ui.JavaUI;
[javac]                          ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/MapReduceNature.java:35: package org.eclipse.jdt.core does not exist
[javac] import org.eclipse.jdt.core.IClasspathEntry;
[javac]                            ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/MapReduceNature.java:36: package org.eclipse.jdt.core does not exist
[javac] import org.eclipse.jdt.core.IJavaProject;
[javac]                            ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/MapReduceNature.java:37: package org.eclipse.jdt.core does not exist
[javac] import org.eclipse.jdt.core.JavaCore;
[javac]                            ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/NewDriverWizard.java:24: package org.eclipse.jdt.core does not exist
[javac] import org.eclipse.jdt.core.IJavaElement;
[javac]                            ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/NewDriverWizard.java:25: package org.eclipse.jdt.internal.ui.wizards does not exist
[javac] import org.eclipse.jdt.internal.ui.wizards.NewElementWizard;
[javac]                                           ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/NewDriverWizard.java:36: cannot find symbol
[javac] symbol: class NewElementWizard
[javac] public class NewDriverWizard extends NewElementWizard implements INewWizard,
[javac]                                      ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/NewDriverWizardPage.java:28: package org.eclipse.jdt.core does not exist
[javac] import org.eclipse.jdt.core.IType;
[javac]                            ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/NewDriverWizardPage.java:29: package org.eclipse.jdt.core does not exist
[javac] import org.eclipse.jdt.core.JavaModelException;
[javac]                            ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/NewDriverWizardPage.java:30: package org.eclipse.jdt.core.search does not exist
[javac] import org.eclipse.jdt.core.search.SearchEngine;
[javac]                                   ^
[javac] /home/andy/hadoop-1.1.2/src/contrib/eclipse-plugin/src/java/org/apache/hadoop/eclipse/NewDriverWizardPage.java:31: package org.eclipse.jdt.ui does not exist



