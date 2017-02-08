---
author: abloz
comments: true
date: 2010-02-24 06:03:33+00:00
layout: post
link: http://abloz.com/index.php/2010/02/24/virtualbox-share-files-with-the-host/
slug: virtualbox-share-files-with-the-host
title: virtualbox 与宿主共享文件
wordpress_id: 1149
categories:
- 技术
---

# 






[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.2.22

http://blog.csdn.net/ablo_zhou

host宿主机：ubuntu9.10

guest客户机：windows 7

需要安装virtualbox的增强插件约30M。安装见《[virtualbox 与宿主交换剪贴板的问题](http://blog.csdn.net/ablo_zhou/archive/2010/01/28/5265258.aspx) 》《[virtualbox 安装windows操作系统遇到的问题](http://blog.csdn.net/ablo_zhou/archive/2010/01/25/5254612.aspx) 》。

安装完毕，在virtualbox的菜单“设备”->“分配数据空间”里，增加一个共享。目录可以选用户有读写权限的目录。共享名自己设置。

我将“/home/zhouhh/公共的”目录设为共享，共享名为share，访问权限设为“完全”，固定分配。

然后，在宿主机往/home/zhouhh/公共的 里面拷贝一个需要共享的文件。在客户机里，打开资源管理器，输入：

\vboxsvrshare

这里有个问题。如果只输入\vboxsvr, windows会提示无法访问。一定要输入全了。

这时就可以往share目录里写入读取共享文件了。

如果想方便，可以按一下alt，在显示的工具菜单里，点映射网络驱动器。驱动器缺省是Z:

文件夹填写 \vboxsvrshare

可以选上“登录时重新连接”

确定。

这时就可以像访问本地硬盘一样，进入Z:盘即进入了共享文件夹。






![](http://img.zemanta.com/pixy.gif?x-id=c144dfa6-9d59-8b5e-98fa-3505963f60a3)
