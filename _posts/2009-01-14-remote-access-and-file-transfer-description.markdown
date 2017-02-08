---
author: abloz
comments: true
date: 2009-01-14 02:29:13+00:00
layout: post
link: http://abloz.com/index.php/2009/01/14/remote-access-and-file-transfer-description/
slug: remote-access-and-file-transfer-description
title: 远程访问和文件传输介绍
wordpress_id: 333
categories:
- 技术
tags:
- scp
- sftp
- ssh
---

# 




[周海汉](http://blog.csdn.net/ablo_zhou)/文
ablozhou # gmail.com
[http://blog.csdn.net/ablo_zhou](http://blog.csdn.net/ablo_zhou)
2009.1.14

**1. 常用远程访问和文件传输方式**
windows远程访问linux，telnet已经基本不用了。因为telnet是明文传输，不安全。取而代之的是ssh，而且现在一般都是ssh2.
远程文件传输和共享，常用的有ftp,tftp,http,samba,rsync,scp,sftp，windows文件共享等协议和工具。

windows下向linux下传文件，如果linux下有samba，ftp，http等服务开启，并有相应上传下载权限，可以在windows 下采用文件共享，ftp和http直接上传文件。但很多linux并没有开启samba，ftp和http服务。不过ssh服务却一般都会打开。所以现在 比较方便的文件共享，一般都用scp和sftp。这两个协议都是基于ssh的。

**2.windows 下远程访问和文件共享工具**



	
  * a.)putty/pietty


进行远程访问.  pietty是台湾的林弘德（Hung-Te Lin,  piaip）对putty修改了对亚洲字符的进行修正的版本。putty有pscp和psftp客户端可以进行文件传输。但这两个程序是命令行的方式，并 没有集成到putty里面。pietty非常小巧，最新版本只有300多KB。可以放在手机中随身携带。

	
  * b.) ssh secure  shell .


这是SSH Communications  Security公司开发的共享软件。到2008年春季，该公司已经停止对非商业版本的支持。现在商业版本的名字是SSH Tectia  client。该软件集成了sftp的文件传输和sshd的远程访问。ssh secure shell非商业版到3.2为止，可以在网络上搜索到下载。

	
  * c.)winSCP


这是免费开源的windows UI的程序，其scp和sftp基于putty  ，ftp基于filezilla，是非常好用和实用的windows和linux文件交换的工具。该软件还支持在线修改文件和属性。但改软件存在的问题是 如果linux  服务器禁止了root远程访问，需要采用sudo的方式去获取root权限读取的目录的话，没有办法做到。如果有谁知道怎么做，请告诉我。

	
  * d.)SecureCRT


这款软件是 VanDyke Software公司的商业软件，支持ssh远程访问和sftp,zmodem,xmodem,ymodem等远程文件传输协议，最新版本6.1. 感觉它的市场占有率在

**3.Linux/Unix/Mac OS下的远程访问和文件共享方式
**OpenOpenSSH是 openBSD项目组开发的，基于BSD协议。一般linux发行版自带Openssh。2008年7月出了5.1版。openssh包含一套程序。 scp替换rcp,sftp替换了ftp. 包含sshd和sftp server端。
**scp: **
远程文件拷贝（scp指定了远端的非默认22端口）：

    
    scp -P 20022 src.tar.gz zhouhh@192.168.12.13:/home/zhouhh
    scp -P 20022 zhouhh@192.168.12.13:/home/zhouhh/src.tar.gz .
    scp -o port=60066 zhouhh@172.16.22.30:/home/zhouhh/src.tar.gz .
    scp  -P 60066 -r /home/zhouhh/src/.* zhouhh@172.16.22.32:/home/zhouhh/dest/
    


拷贝目录,-r是将目录下的目录递归拷贝。".*"是将隐藏文件也拷贝过去。需要先在远端创建好相应的目录。

    
    scp  -P 60066 -r zhouhh@172.16.22.30:/home/zhouhh/src/ zhouhh@172.16.22.32:/home/zhouhh/dest/
    


_**即-P  指定非缺省的ssh远程端口，P为大写。本地端口如果不缺省不用指定。**_
scp的优点是使用简单，缺点是无法列出远端目录和改变目录。复杂一点的用法是用sftp。
**sftp：**

    
    sftp -o port=60066 zhouhh@192.168.12.12:/home/zhouhh
    


其中-o port选项指定非缺省的ssh端口。

    
    Connecting to 192.168.12.12...
    zhouhh@192.168.12.12's password:
    Changing to: /home/zhouhh
    sftp> pwd
    Remote working directory: /home/zhouhh
    


在命令行模式下可以执行一系列命令
ls,cd,pwd,mkdir,rmdir,rm 等远端文件操作
lls,lcd,lpwd等本地操作。
!command 执行本地shell命令
!进入本地shell，exit再进入sftp的命令提示。
可以用help或"?"来查询所有的sftp支持的命令。
get  从远端下载文件
put 将本地文件上传到远程。

sftp配置，需要在/etc/ssh/sshd_config
配置文件增加sftp子系统：

    
    Subsystem       sftp    /usr/libexec/openssh/sftp-server
    


然后重启sshd:

    
    service sshd restart
    



