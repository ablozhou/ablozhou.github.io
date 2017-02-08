---
author: abloz
comments: true
date: 2016-05-21 12:23:55+00:00
layout: post
link: http://abloz.com/index.php/2016/05/21/mac-printer-uses-high-cpu/
slug: mac-printer-uses-high-cpu
title: mac 打印机占用cpu高
wordpress_id: 2737
categories:
- 未分类
---

今天mac book cpu风扇狂转。一看有一个com._hp_.devicemodel._TransportProxy_进程,占用CPU将近350% ，杀掉还会自动启动。

原来是hp打印机没有连机，添加了打印任务。从系统偏好设置中找到打印机与扫描仪，找到hp打印机，点开打印队列，将打印队列删除即可。

实在不行也可以直接删除打印机。
