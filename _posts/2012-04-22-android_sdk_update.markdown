---
author: abloz
comments: true
date: 2012-04-22 14:31:25+00:00
layout: post
link: http://abloz.com/index.php/2012/04/22/android_sdk_update/
slug: android_sdk_update
title: 更新android sdk时遇到的问题
wordpress_id: 1551
categories:
- 技术
tags:
- android
- sdk
- update
---

http://abloz.com
date:2012.4.22

windows7 操作系统，android-sdk-windows安装在e:zhh下面。用E:zhhandroid-sdk-windowsSDK Manager.exe 更新最新android 4.0的sdk时，遇到如下的错误。在eclipse中调用SDK Manager.exe也遇到该错误。(稍早期SDK Manager看不见Android 4.0 （API 14），Android 4.0.3 （API 15）这样的目录，需更新Android SDK Tools后，重启SDK Manager才能看见。）



```
-= warning! =-
A folder failed to be renamed or moved. On Windows this typically means that a program Is using that Folder (for example Windows Explorer or your anti-virus software.) Please momentarily deactivate your anti-virus software. Please also close any running programs that may be accessing the directory 'E:zhhandroid-sdk-windowstoo!s'. When ready, press YES to try again.

Downloading Android SDK Tools, revision 19 Installing Android SDK Tools, revision 19

Failed to rename directory E:zhhandroid-sdk-windowstools to E:zhhandroid-sdk-windowstempToolPackage.old01.
```


用任务管理器的性能栏下的资源管理器，CPU下搜索tools，发现tools下面java.exe打开了很多程序。搞不明白为何既要重命名tools目录，还打开里面的文件。[网络](http://stackoverflow.com/questions/4360894/android-trouble-updating-to-android-sdk-tools-revision-7)上有一些解决办法。其中之一，是复制一份tools目录，我复制出名字叫tools-copy,然后在tools-copy下，执行android.bat.更新果然成功。
