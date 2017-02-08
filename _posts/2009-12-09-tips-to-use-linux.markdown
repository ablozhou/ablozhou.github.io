---
author: abloz
comments: true
date: 2009-12-09 05:58:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/09/tips-to-use-linux/
slug: tips-to-use-linux
title: linux使用小窍门
wordpress_id: 979
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

实用小窍门实在太多了，慢慢探索吧。想起刚用电脑时，天天在《电脑爱好者》中找小窍门。找到了就如获至宝。又看到我blog中有人回复不习惯ubuntu，还是投奔win7。心想，应该某些人也挺需要一点使用小窍门的交流的。信手写了些，供参考。

本文适合初级用户阅读。

 

1.终端复制粘贴

用gnome终端时，对字符的复制粘贴感觉没有win下的putty方便。其实，选中后，用鼠标中键点击即可粘贴，也很方便。双击选中一句，三击选中一行。中键点击粘贴。

千万不要按Ctrl+C,会导致正在执行的命令行程序退出。

2.滚屏

字符模式下，用shift+pageup/pagedown 来滚屏查看历史记录。

3.gnome终端的历史回滚

可以在gnome终端的配置文件的滚动tab页，将回滚值设为4000左右。 4000行足以查看几次操作的滚屏了。

4.windows远程桌面

linux下使用windows远程桌面，可以用tsclient+rdesktop

5.如何使用上一个命令的参数

gnome终端和字符界面，都可以用 alt+. 获取上次命令的最后一个参数。多按几次会变成次前一个命令的最后一个参数。

比如将log 备份一下到/var/log/xxx/yyy/zzz/myfile

cp /var/log/myfile /var/log/xxx/yyy/zzz/myfile.1

结果发现xxx/yyy/zzz目录根本不存在。建好这些目录再执行该命令，就可以用alt+.来节省输入了。

6.对输了半天的命令，如何放弃？

shift+alt+#可以注释命令，这样可以在命令历史中找回。如果用ctrl+C放弃，则不会有记录。

7.如何在命令行移动已输入一长串命令光标

ctrl+a 移到行首，ctrl+e 移到行尾。 ctrl+左/右，移动一个word

8.编辑命令行

移动到位后，需要修改命令

ctrl+k 将光标到末尾的参数都删除

9. 获取上一命令的参数

alt+n 再alt+. , 其中n是上一个命令的第几个参数。从命令开始，以0开始计数。alt+0,alt+.为命令本身，依此类推。

10. 历史和自动完成

!+命令 为最近执行的“命令+参数”

上下方向键可以滚动历史命令

history可以查看以前的命令

命令行中tab可以自动完成，这个相信大家都知道了。

 

记不住命令操作快捷键怎么办？

可以用info readline和bind -p来查看。

其中M表示alt, 意思是Meta

C表示Ctrl.

e表示ESC.

比如C-c 表示ctrl+c.

M-. 表示Alt+.

有的键盘没有Meta，所以用esc可代替Meta.

  
  


![](http://img.zemanta.com/pixy.gif?x-id=57c6862d-811b-850b-a9cd-b2f6d38553d6)
