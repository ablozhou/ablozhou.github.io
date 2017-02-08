---
author: abloz
comments: true
date: 2010-03-18 06:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/18/ubuntu-annoying-how-to-solve-the-chinese-folder/
slug: ubuntu-annoying-how-to-solve-the-chinese-folder
title: ubuntu 恼人的中文文件夹如何解决
wordpress_id: 1165
categories:
- 技术
---

周海汉 /文  
http://blog.csdn.net/ablo_zhou  
2010.3.18  
  
其实我已经忍了很久。  
ubuntu在中文界面下面，自动创建了“桌面”，“文档”，图片 、公共的 、下载、 音乐、 视频等中文目录。  
在命令行下操作的时候，要么切换到中文输入法，要么粘贴。如果在没有输入法的环境，可能操作这些目录都存在困难。  
总觉得很别扭。我用Linux是为了提高效率，可是总是为了操作这些目录多按几个键甚至中断操作，得不偿失嘛。  
windows操作系统虽然也有桌面，文档，图片，音乐之类的文件夹。但windows体贴的地方是，看到的是中文，而目录其实是英文。这样在没有中文环境下也可以进入。这就是所说的虚拟目录。  
忍无可忍，无须再忍。放狗一找，原来这东西还有些来历，此前也并不是这样的。并且有很多人为此而苦恼，甚至干脆用英文系统，眼不见心不烦。  
原来这是freedesktop.org为了方便群众搞的xgd-users-dirs ，在不同的语言下自动创建一些经常用到的目录。  
xdg-user-dirs-update 这个工具会在系统登录阶段运行，它读取配置文件和用户目录信息，并创建用户本地语言版本的常用目录。设置到$(XDG_CONFIG_HOME)/user-dirs.dirs (XDG_CONFIG_HOME defaults to ~/.config)，以便应用程序读取和使用这些目录。  
  
1. 我们可以先将目录都改成英文的。  
export LANG=en_US  
执行  
xdg-user-dirs-gtk-update  
这时会弹出一个配置界面，将所有中文的用户目录切换到英文。选中不再提示，确定。  
这时，会删除没有内容的用户目录，但有内容的用户目录会保持。并创建相应的英文目录：  
Desktop/Download/Templates/Public/Documents/Music/Pictures/Videos  
此时，在位置里看到的常用中文目录已经换成英文目录。只需将原中文目录的内容拷贝到相应英文目录，并删除中文目录即可。  
然后再执行  
export LANG=zh_CN.UTF-8  
以显示中文。  
如果记不住该命令，很简单。注销。在登录界面选英语，进来后该对话框就会弹出来提示你是否切换用户目录了。切换完了注销，再切换成中文界面，但这时不要切换用户目录了。  
  
2.显示中文，但实际是英文目录  
这时，桌面也对应/home/zhouhh/Desktop，但“位置”里面，“主文件夹”，“桌面”点开都对应英文目录。  
理想化的解决方案，是看到的目录是中文，但打开的目录是英文。和Windows操作系统一致。这样免得中英夹杂，影响视觉和心情。  
其实这也是可以办到的。  
点“位置”->"主文件夹"，打开文件浏览器（Nautilus),  
在书签菜单，选编辑书签  
这时，可以将各英文用户目录的显示改成中文对应的“桌面”，“文档”，图片 、公共的 、下载、 音乐、 视频等。  
改完，在任务栏的“位置”，看到也变成了中文。而打开的目录，却是英文。  
这样，终于舒坦了。  
  
3.相关配置  
cd /etc/xdg  
zhouhh@zhh64:/etc/xdg$ ls user*  
user-dirs.conf user-dirs.defaults  
zhouhh@zhh64:/etc/xdg$ vi user-dirs.defaults  
# Default settings for user directories  
#  
# The values are relative pathnames from the home directory and  
# will be translated on a per-path-element basis into the users locale  
DESKTOP=Desktop  
DOWNLOAD=Downloads  
TEMPLATES=Templates  
PUBLICSHARE=Public  
DOCUMENTS=Documents  
MUSIC=Music  
PICTURES=Pictures  
VIDEOS=Videos  
# Another alternative is:  
#MUSIC=Documents/Music  
#PICTURES=Documents/Pictures  
#VIDEOS=Documents/Videos  
该文件是xdg-user-dirs-update工具在用户登录时需要读取的目录配置。并根据user-dirs.conf决定如何翻译。  
zhouhh@zhh64:/etc/xdg$ vi user-dirs.conf  
# This controls the behaviour of xdg-user-dirs-update which is run on user login  
# You can also have per-user config in ~/.config/user-dirs.conf, or specify  
# the XDG_CONFIG_HOME and/or XDG_CONFIG_DIRS to override this  
#  
enabled=True  
# This sets the filename encoding to use. You can specify an explicit  
# encoding, or "locale" which means the encoding of the users locale  
# will be used  
filename_encoding=UTF-8  
这是系统的缺省编码设置和是否启用设置。用户的在/home/zhouhh/.config下面。  
可以由XDG_CONFIG_HOME XDG_CONFIG_DIRS 指定路径来读取配置。  
zhouhh@zhh64:~$ vi .config/user-dirs.dirs  
# This file is written by xdg-user-dirs-update  
# If you want to change or add directories, just edit the line you're  
# interested in. All local changes will be retained on the next run  
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped  
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an  
# absolute path. No other format is supported.  
#   
XDG_DESKTOP_DIR="$HOME/Desktop"  
XDG_DOWNLOAD_DIR="$HOME/Downloads"  
XDG_TEMPLATES_DIR="$HOME/Templates"  
XDG_PUBLICSHARE_DIR="$HOME/Public"  
XDG_DOCUMENTS_DIR="$HOME/Documents"  
XDG_MUSIC_DIR="$HOME/Music"  
XDG_PICTURES_DIR="$HOME/Pictures"  
XDG_VIDEOS_DIR="$HOME/Videos"  
可以看到我的配置都已经是英文了。  
  
4.参考  
http://my.oschina.net/myriads/blog/2867  
http://forum.ubuntu.org.cn/viewtopic.php?f=77&t=219138  
http://blog.cathayan.org/item/1943  
  
  


![](http://img.zemanta.com/pixy.gif?x-id=d723dd1c-4fcc-8638-90ca-abc82e944707)
