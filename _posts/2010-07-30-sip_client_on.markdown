---
author: abloz
comments: true
date: 2010-07-30 02:17:00+00:00
layout: post
link: http://abloz.com/index.php/2010/07/30/sip_client_on/
slug: sip_client_on
title: linux下的sip客户端
wordpress_id: 323
categories:
- 技术
tags:
- ekiga
- linphone
- linux
- sip client
- ubuntu
- voip
- xlite
- zoiper
---

linux下可以使用商业的免费软件xlite,zoiper，但我在ubuntu使用他们的安装包都没有成功。而ekiga和linphone则可以用。
我首先在ubuntu里安装了asterisk的包，并通过sudo asterisk -vvvvvc启动，作为sip服务器。用sip客户端来注册并通话。
服务器和客户端都在本地，asterisk地址192.168.11.116:5060. 开通了帐号2000,2001，密码都是1234.

**安装zoiper失败：**

    
    
    zhouhh@zhh64:~/Downloads$ sudo dpkg -i zoiper-communicator-free-alsa_1.0-1ubuntu12_amd64.deb
    dpkg：依赖关系问题使得 zoiper-communicator-free-alsa 的配置工作不能继续：
     zoiper-communicator-free-alsa 依赖于 libavcodec1d (>= 0.cvs20070307)；然而：
      未曾安装软件包“libavcodec1d”。
     zoiper-communicator-free-alsa 依赖于 libavutil1d (>= 0.cvs20070307)；然而：
      未曾安装软件包“libavutil1d”。
    dpkg：处理 zoiper-communicator-free-alsa (--install)时出错：
     依赖关系问题 - 仍未被配置
    


**安装xlite2.0失败：**

    
    
    zhouhh@zhh64:~/Downloads$ ls X*
    X-Lite_Install.tar.gz
    zhouhh@zhh64:~/Downloads$ tar -zxvf X-Lite_Install.tar.gz
    xten-xlite/README
    xten-xlite/xtensoftphone
    zhouhh@zhh64:~/Downloads$ cd xten-xlite/
    zhouhh@zhh64:~/Downloads/xten-xlite$ ./xtensoftphone
    ./xtensoftphone: error while loading shared libraries: libstdc++.so.5: cannot open shared object file: No such file or directory
    zhouhh@zhh64:~/Downloads/xten-xlite$ whereis libstdc++.so.5
    libstdc++.so: /usr/lib/libstdc++.so.6 /usr/lib64/libstdc++.so.6
    


而ekiga和linphone直接通过apt-get就可以安装。
**Linphone：**
Linphone配置相当简单（界面语言可以配置选中文，但我选了英文），如图：
[caption id="attachment_327" align="alignnone" width="719" caption="linphone sip配置"][![linphone sip配置](http://abloz.com/wp-content/uploads/2010/07/Screenshot-7.png)](http://abloz.com/wp-content/uploads/2010/07/Screenshot-7.png)[/caption]
菜单linphone->preference,弹出对话框，在network setting将本地端口设为5070以防止和服务器也装在本地的asterisk占用的5060冲突。manager sip accounts的页，proxy accounts点选add， your sip identify输入sip:2001@192.168.11.116，sip proxy address输入：sip:2001@192.168.11.116:5060，点OK即可注册成功。

**Ekiga:**
Ekiga配置稍费事。ekiga支持sip和H323.并且ekiga 开发公司自身也提供 voip服务，所以缺省是申请ekiga的帐号。这些可以忽略。可我无论怎么配置sip帐号都注册不成功，有时提示不允许的注册。后面发现ekiga和asterisk都用了缺省的5060，这样冲突了。可是ekiga并没有提高修改本地端口的界面。必须用gconf-editor来配置。
zhouhh@zhh64:~$ sudo gconf-editor
在弹出界面中找到apps->ekiga->protocols->sip,修改listhen-ports为5080（防止和asterisk冲突）。

然后在ekiga菜单的编辑->帐户，增加一个sip帐户，如图。
[caption id="attachment_328" align="alignnone" width="483" caption="ekiga sip 配置"][![ekiga sip 配置](http://abloz.com/wp-content/uploads/2010/07/Screenshot-9.png)](http://abloz.com/wp-content/uploads/2010/07/Screenshot-9.png)[/caption]
姓名：2000，注册商：192.168.11.116:5060,用户：2000，验证用户2000，注册成功。
此时可以用二者互拨电话。
