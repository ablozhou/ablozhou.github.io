---
author: abloz
comments: true
date: 2010-05-06 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/05/06/new-installation-of-ubuntu-10-04-u-disk/
slug: new-installation-of-ubuntu-10-04-u-disk
title: ubuntu 10.04 U盘全新安装
wordpress_id: 1222
categories:
- 技术
---

#  					 				

				

 					  					  					

周海汉 /文

 

2010.5.6

 

新版ubuntu 10.04正式推出后，怀着期待进行了升级和重新安装。从使用感觉上来说，utuntu10.04并没有9.10多少提升，反而有些地方倒退了。

 

1.重新安装

1.1下载

http://www.ubuntu.com/getubuntu/download 可以下载想要的utuntu 10.04版本。桌面一般根据cpu位长，下载32位或64位的桌面版。国内也可以直接到sohu或163上去下载

sohu:

http://mirrors.sohu.com/ubuntu-releases/10.04/

163:

http://mirrors.163.com/ubuntu-releases/10.04/

 

下载后check md5或sha值是否一致，大概600多MB,然后进行刻盘。

 

下载时做好现有系统重要资源的备份。

 

1.2 用U盘安装

CD/DVD刻盘安装应该很简单。一些老旧的电脑常常光驱不能用，而一些上网轻便本甚至连光驱都没有。那可以采用U盘安装。我笔记本IBM  T40比较旧，连USB启动配了都没有生效。原来上面安装的是windows xp和utuntu  9.10双系统。我在windows下用ultraISO将下载下来的iso文件刻到U盘中。在尝试几次用U盘起不来后，用虚拟光驱加载iso，执行 wubi.exe，或直接执行U盘中wubi.exe，选CD启动有困难，需要安装帮助。wubi会将系统复制到硬盘，启动时添加到windows的启动 菜单。

 

1.3 看不到启动菜单

由于我的系统此前是双系统，由grub引导。现在决定全格式化，重新安装。但每次进入grub，并没有看到新的启动选项。而进windows也是直接就进去了。

尝试几次后，发现是windows的引导程序里面，并没有选择显示启动菜单。在桌面上“我的电脑”点右键，进入属性，在启动选项中选择启动菜单，30秒时间。

重启后，进入windows时看到ubuntu了。此时可以将刻录了ubuntu10.04的U盘插入，进入到live 桌面，再进行安装即可。

 

1.4 中文问题

安装时系统还从网上下载语言包，花了不少时间。但这些都是自动的。安装过程大概1个小时不到。没有遇到其他的困难。无线网卡，显卡，声卡都自动驱动 正确。但进入界面后，发现汉字发虚，还没有9.10舒服。传说中的汉仪字库也不知在哪里。赶紧进入“外观”，修改字体，将原来缺省的英文字体改为“文泉驿 正黑，才显得锐利了。但控制台上面的字体还是没有解决。

 

1.5 性能优化

启动速度并没有感觉有什么进步。相反，在使用过程中，总感觉资源不足。我的系统是512M内存，快被吃完了。于是进/etc/rc5.d/，将 S50saned S50cups S20speech-dispatcher  S25bluetooth等S改为K。再到“首选项->启动应用程序”将不相干的应用程序都关掉。重启后才稍微好一些。但ext4好像效率还是没有 ext3高，硬盘动不动就转个不停。

 

1.6 [修改窗口关闭按钮位置到窗口右上角](http://blog.csdn.net/ablo_zhou/archive/2010/05/05/5560511.aspx)

专门写了一篇[改进窗口关闭按钮位置](http://blog.csdn.net/ablo_zhou/archive/2010/05/05/5560511.aspx) 的，因为关闭按钮在窗口左上角实在别扭，很难适应。很多人都是windows,linux混用的。长期在窗口两个位置找最大化，最小化和关闭，会精神崩溃的。

就是用gconf-editor,修改/apps/metacity/general button_layout的值，将close,minimize,maxmize:改为menu:minimize,maxmize,close

 

1.6修改中文源：

将/etc/apt/sources.list 备份

sudo vi /etc/apt/sources.list

清空，增加163和sohu的源：

[view plain](http://blog.csdn.net/ablo_zhou/archive/2010/05/06/5563538.aspx#)[copy to clipboard](http://blog.csdn.net/ablo_zhou/archive/2010/05/06/5563538.aspx#)[print](http://blog.csdn.net/ablo_zhou/archive/2010/05/06/5563538.aspx#)[?](http://blog.csdn.net/ablo_zhou/archive/2010/05/06/5563538.aspx#)

  1. deb http://mirrors.sohu.com/ubuntu/ lucid main restricted
  2. deb-src http://mirrors.sohu.com/ubuntu/ lucid main restricted
  3. deb http://mirrors.sohu.com/ubuntu/ lucid-updates main restricted
  4. deb-src http://mirrors.sohu.com/ubuntu/ lucid-updates main restricted
  5. deb http://mirrors.sohu.com/ubuntu/ lucid universe
  6. deb-src http://mirrors.sohu.com/ubuntu/ lucid universe
  7. deb http://mirrors.sohu.com/ubuntu/ lucid-updates universe
  8. deb-src http://mirrors.sohu.com/ubuntu/ lucid-updates universe
  9. deb http://mirrors.sohu.com/ubuntu/ lucid multiverse
  10. deb-src http://mirrors.sohu.com/ubuntu/ lucid multiverse
  11. deb http://mirrors.sohu.com/ubuntu/ lucid-updates multiverse
  12. deb-src http://mirrors.sohu.com/ubuntu/ lucid-updates multiverse
  13. deb http://mirrors.163.com/ubuntu/ lucid main restricted universe multiverse
  14. deb http://mirrors.163.com/ubuntu/ lucid-security main restricted universe multiverse
  15. deb http://mirrors.163.com/ubuntu/ lucid-updates main restricted universe multiverse
  16. deb http://mirrors.163.com/ubuntu/ lucid-proposed main restricted universe multiverse
  17. deb http://mirrors.163.com/ubuntu/ lucid-backports main restricted universe multiverse
  18. deb-src http://mirrors.163.com/ubuntu/ lucid main restricted universe multiverse
  19. deb-src http://mirrors.163.com/ubuntu/ lucid-security main restricted universe multiverse
  20. deb-src http://mirrors.163.com/ubuntu/ lucid-updates main restricted universe multiverse
  21. deb-src http://mirrors.163.com/ubuntu/ lucid-proposed main restricted universe multiverse
  22. deb http://archive.ubuntu.com/ubuntu/ lucid multiverse universe
  23. deb-src http://mirrors.163.com/ubuntu/ lucid-backports main restricted universe multiverse

deb http://mirrors.sohu.com/ubuntu/ lucid main restricted deb-src http://mirrors.sohu.com/ubuntu/ lucid main restricted deb http://mirrors.sohu.com/ubuntu/ lucid-updates main restricted deb-src http://mirrors.sohu.com/ubuntu/ lucid-updates main restricted deb http://mirrors.sohu.com/ubuntu/ lucid universe deb-src http://mirrors.sohu.com/ubuntu/ lucid universe deb http://mirrors.sohu.com/ubuntu/ lucid-updates universe deb-src http://mirrors.sohu.com/ubuntu/ lucid-updates universe deb http://mirrors.sohu.com/ubuntu/ lucid multiverse deb-src http://mirrors.sohu.com/ubuntu/ l
ucid multiverse deb http://mirrors.sohu.com/ubuntu/ lucid-updates multiverse deb-src http://mirrors.sohu.com/ubuntu/ lucid-updates multiverse deb http://mirrors.163.com/ubuntu/ lucid main restricted universe multiverse deb http://mirrors.163.com/ubuntu/ lucid-security main restricted universe multiverse deb http://mirrors.163.com/ubuntu/ lucid-updates main restricted universe multiverse deb http://mirrors.163.com/ubuntu/ lucid-proposed main restricted universe multiverse deb http://mirrors.163.com/ubuntu/ lucid-backports main restricted universe multiverse deb-src http://mirrors.163.com/ubuntu/ lucid main restricted universe multiverse deb-src http://mirrors.163.com/ubuntu/ lucid-security main restricted universe multiverse deb-src http://mirrors.163.com/ubuntu/ lucid-updates main restricted universe multiverse deb-src http://mirrors.163.com/ubuntu/ lucid-proposed main restricted universe multiverse deb http://archive.ubuntu.com/ubuntu/ lucid multiverse universe deb-src http://mirrors.163.com/ubuntu/ lucid-backports main restricted universe multiverse   

2.效果展示：

下面是在ubuntu 10.04上配置了compiz后的一些效果，其实ubuntu 9.10也都有了。

2.1环形切换

![](http://hi.csdn.net/attachment/201005/6/0_12731371550iCO.gif)

 

2.2 3D桌面

![](http://hi.csdn.net/attachment/201005/6/0_1273137186kkl9.gif)

 

2.3 立体切换

![](http://hi.csdn.net/attachment/201005/6/0_12731372103dMp.gif)

 

2.4 切换桌面

![](http://hi.csdn.net/attachment/201005/6/0_12731372418I32.gif)

 

5.环形3D桌面

![](http://hi.csdn.net/attachment/201005/6/0_127313727340m0.gif)

  
  


![](http://img.zemanta.com/pixy.gif?x-id=2dd27c68-20b1-88eb-9bde-7376f4026188)
