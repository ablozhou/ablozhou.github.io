---
author: abloz
comments: true
date: 2009-12-16 06:25:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/16/ubuntu-9-10-gnome-terminal-vi-the-esc-key-to-failure/
slug: ubuntu-9-10-gnome-terminal-vi-the-esc-key-to-failure
title: ubuntu 9.10 gnome 终端vi 的esc键失效？
wordpress_id: 987
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou) /文

 

ubuntu使用中发现gnome终端vi的esc键有时失效。如果是插入模式，再也回不到命令模式，非常为难。只好直接关闭终端，留一下一个在编辑的垃圾文件。而CTRL+ALT+F1切换到字符界面，vi没有该问题。

 

后面有人提示，说是QQ的问题。

 

我从腾讯官网下载了QQ beta1的deb包安装的。一打字就导致QQ退出。而使用  Empathy则经常登不上QQ，修改client版本为qq2008也不行，以致引起QQ被锁死。采用编辑/usr/bin/qq，添加export  GDK_NATIVE_WINDOWS=true才解决QQ死的问题，如下。

 

zhouhh@zhhofs:~$ cat /usr/bin/qq  
#!/bin/sh  
export GDK_NATIVE_WINDOWS=true  
cd /usr/share/tencent/qq/  
./qq

 

QQ问题解决了，又引起Vi的问题。编辑文件后ESC不起作用。

 

因此，只好安装一个虚拟机或采用远程桌面的方式来使用QQ。

 

而ubuntu9.10缺省安装的vim-tiny非常不好用，缺省是与vi兼容模式，没有色彩。方向键会变成A B C D。直接安装vim增强版

sudo apt-get install vim即可解决该问题。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=f8940450-576d-86d6-a31c-2f23a0f56ef9)
