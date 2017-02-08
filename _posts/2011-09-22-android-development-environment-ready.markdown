---
author: abloz
comments: true
date: 2011-09-22 16:01:10+00:00
layout: post
link: http://abloz.com/index.php/2011/09/23/android-development-environment-ready/
slug: android-development-environment-ready
title: android开发环境准备
wordpress_id: 1445
categories:
- 技术
tags:
- android
- eclipse
---

周海汉 abloz.com 2011-09-22

**1.安装eclipse j2ee最新版indigo（3.7）**

下载地址：http://www.eclipse.org/downloads/
eclipse版本必须3.5以上。可以下载安装[Eclipse IDE for Java EE Developers](http://www.eclipse.org/downloads/packages/eclipse-ide-java-ee-developers/indigor) 212MB 或者安装[Eclipse Classic 3.7](http://www.eclipse.org/downloads/packages/eclipse-classic-37/indigor) 174MB，或
[Eclipse IDE for Java Developers](http://www.eclipse.org/downloads/packages/eclipse-ide-java-developers/indigor), 122 MB
**2.下载安装android sdk**
下载地址[http://developer.android.com/sdk/index.html](http://developer.android.com/sdk/index.html)

windows下可以选择[installer_r12-windows.exe](http://dl.google.com/android/installer_r12-windows.exe)，比较方便，会帮你检测Java SE Development Kit (JDK)是否正确安装，版本是否合适，省去很多麻烦。

但是installer会选择在线下载安装 sdk platform android xx api，不要选accept all，否则会有4个多G，很难下载。可以只选择关心的版本，如从2.1开始的api，sample和document选择下载。如果有人已经下载好了，可以直接拷贝。

安装完毕，可以运行模拟器。其中android 3.0以上的模拟器是平板电脑的，如果要模拟手机，可以用2.2以上的模拟器。模拟器运行起来很慢。开发时最好有两台显示器，这样屏幕比较大。

我的sdk安装在E:zhhandroid-sdk-windows，建议将该目录及下面的tools和platform-tools加到环境变量PATH中。

**3.开发支持的操作系统**



	
  * Windows XP (32-bit), Vista (32-, 64-bit), Windows 7 (32- ， 64-bit)

	
  * Mac OS X 10.5.8 或更高 (仅x86 )

	
  * Linux 在 Ubuntu Linux, Lucid Lynx上测试过

	
    * GNU C Library (glibc) 2.7或更高.

	
    *  Ubuntu Linux, version 8.04

	
    * （64位必须支持32位软件）





**4.安装Android Development Tools (ADT) 的eclipse插件**

最新版本2011年7月的[ADT 12.0.0](http://developer.android.com/sdk/eclipse-adt.html#)，与  [SDK Tools r12](http://developer.android.com/sdk/tools-notes.html) 相配套，后者可以通过sdk installer 开始页面进行下载。



启动eclipse，进入**Help** > **Install New Software...；**点**add**，在弹出add repository对话框，名字输入adt，地址输入

    
    https://dl-ssl.google.com/android/eclipse/


确定。如果https不行，则改为http再试。

在pending过后，会显示Developer Tools，选中多选框。点next，next。同意协议。即可安装完成adt。



**5. eclipse 配置sdk路径和相关环境**。

安装完adt后，重启eclipse。菜单windows > preference, 选android，设置sdk路径为E:zhhandroid-sdk-windows，可以选择ddms视图，查看android程序在手机或模拟器中的运行信息。

重启eclipse。选java视图，即可新建android项目，进行开发。如果new 里面没看到android，选other，在弹出菜单中找到android project。设置名称和模拟器，包名，即可插上手机调试或用模拟器调试。
****

**6.参考：**

****eclipse下载地址：[http://www.eclipse.org/downloads/](http://www.eclipse.org/downloads/)
sdk下载地址：[http://developer.android.com/sdk/index.html](http://developer.android.com/sdk/index.html)

sdk安装教程：[http://developer.android.com/sdk/installing.html#Installing](http://developer.android.com/sdk/installing.html#Installing)
adt地址：[http://developer.android.com/sdk/eclipse-adt.html](http://developer.android.com/sdk/eclipse-adt.html)

系统软硬件需求：[http://developer.android.com/sdk/requirements.html](http://developer.android.com/sdk/requirements.html)










