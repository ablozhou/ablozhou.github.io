---
author: abloz
comments: true
date: 2007-07-10 07:03:21+00:00
layout: post
link: http://abloz.com/index.php/2007/07/10/subversion-windows-server-starts-as-a-service/
slug: subversion-windows-server-starts-as-a-service
title: subversion windows服务器作为服务启动
wordpress_id: 229
categories:
- 技术
tags:
- subversion
- svn
- windows
---

# 




[周海汉](http://blog.csdn.net/ablo_zhou) /文  2007.7.10

subversion服务器支持windows和linux。

在linux下，使用命令启动服务：

svnserve -d -r svnroot

-d 表示--daemon，即关掉执行命令的窗口，服务继续存在。 -r 表示--root，即指定库的根目录。

而在windows下，用同样的命令也可以，只是关掉cmd窗口后，服务也消失了。这个问题的解决办法，在subversion的1.4版以前，是 用svn windows service  wrapper，将其包装为服务。而svn1.4以后，是可以直接支持以服务器启动的。方法就是利用windows  xp，2000自带的工具service control，执行文件是sc.exe。在cmd窗口输入命令如下：

sc create  svnservice binpath= "D:Program FilesSubversionbinsvnserve.exe  --service -r D:mysvn"  displayname= "SVNService"  depend= Tcpip  start=  auto

binpath指定svnserve的路径和命令。注意其参数是--service,而不是--daemon.  不能用-d和-i，-t等参数。start= auto表示服务自动启动。注意，等于号的左边无空格，而右边必须有一个空格。

执行完后，系统返回

[SC] CreateService SUCCESS

表示服务创建成功。

然后执行

net start  svnservice

启动服务。系统返回

svnservice 服务正在启动 .
svnservice 服务已经启动成功。

执行

net stop svnservice

停止服务，系统返回：

svnservice 服务正在停止.
svnservice 服务已成功停止。

执行

sc delete  svnservice

删除服务。创建相同服务前必须删除。


