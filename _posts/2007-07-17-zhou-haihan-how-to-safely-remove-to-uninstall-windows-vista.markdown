---
author: abloz
comments: true
date: 2007-07-17 07:04:34+00:00
layout: post
link: http://abloz.com/index.php/2007/07/17/zhou-haihan-how-to-safely-remove-to-uninstall-windows-vista/
slug: zhou-haihan-how-to-safely-remove-to-uninstall-windows-vista
title: 周海汉：如何安全删除卸载windows vista
wordpress_id: 231
categories:
- 技术
tags:
- vista
- 删除
- 多系统
---

本文遵循CPL协议，可以免费自由使用，但不得去掉作者信息。
作者: [周海汉](http://blog.csdn.net/ablo_zhou)
主页：[http://blog.csdn.net/ablo_zhou](http://blog.csdn.net/ablo_zhou)
Email:ablozhou  at gmail.com
日期：2007.7.17

出于好奇，装了个windows  vista的beta版。但beta的用户体验很差，我的机器是奔4  2.4G，1G内存，非独立显卡。但装好后一点效果都没有，反而是看图片都模模糊糊。而且过两天居然过期了，只能用浏览器注册，什么都不能用。所以只好弃 之不用。   可是请神容易送神难。安装在E盘的vista，windows目录就有将近7G。搞得我在安装了一个ubutun后没得硬盘用了。想删除vista，还挺 难的。经过一番斗争，终于将其删除了。
看到网上很多人问，但没有很好解决的。在此共享一下。

一.关于多重启动。
1.进入 xp，运行cmd，在命令行上敲
cd c:boot
这里假设c盘安装的是XP
2.再执行
fixntfs -xp
3. 重启后，xp的bootloader就回来了。
4.格式化vista硬盘
做好备份。
在桌面的我的电脑点右键，在弹出菜单上点”管 理“，选弹出窗口下面的磁盘管理，选中安装vista的磁盘，右键格式化即可。

二.不想格式化vista安装盘，只想删除某些文件夹。
这 种比较麻烦。因为删除时会弹出对话框：”无法删除xxx，访问被拒绝。请确认磁盘未满或未被写保护，而且文件未被使用。“
这是vista的权限设 置，导致在另一个系统中无法删除其文件夹。
处理如下：
1.  进入资源管理器，点菜单”工具“-”文件夹选项“，弹出的对话框选”查看“页。在文件和文件夹下面将”使用简单文件共享（推荐）”的勾去掉，确定。这是为 了能看见“安全”属性。
2.选中要删的文件或文件夹，点右键，选属性。在弹出对话框中选安全页。
3.安全页下面有个“高级”按钮，点击进 入新对话框，选“所有者”页。如下图：

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/Image00006.jpg)

一定将“替换字容器及对象的所有者”选中。选中所有者更改为列表下面的用户或组，点应用。上面那个“目前所有者”一串不明身份的用户就会被替换。并 开始修改所有权。![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/Image00004.jpg)

这时可能会弹出如下的警告框，选是。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/%E6%9D%83%E9%99%90.PNG)

再切换到权限表，看刚刚加入所有权的用户或组存不存在。如果不存在，则添加该用户或组。然后编辑权限，将应用到选为“该文件夹，子文件夹及文件”。 权限设为“完全控制”确定。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/Image00007.jpg)

完毕后，接下来调整所有者权限，将其设为完全控制，如下图：

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/Image00005.jpg)

这样，xp用户就有了文件夹的所有权和完全控制权，就可以将其删除了。依次类推，可以将vista的program files等目录也删除。
