---
author: abloz
comments: true
date: 2009-10-14 08:43:05+00:00
layout: post
link: http://abloz.com/index.php/2009/10/14/centos-5-3-install-the-new-version-subversion/
slug: centos-5-3-install-the-new-version-subversion
title: CentOS 5.3 安装新版subversion
wordpress_id: 933
categories:
- 技术
---

=====================

CentOS 5.3 安装新版subversion

=====================

 

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2009.10.14

 

由于原来的subversion服务器硬件有问题，所以需将其迁移到新服务器上。我们安装的是Centos 5.3. 大家都说CentOS 更新慢。果然，里面自带的subversion还是1.4.2。而我们原来备份的subversion库是1.5版本的。

 

1.尝试在已存在的subversion 1.4.2上恢复：

---------------------------------------------------

 

[root@svnserv ~]# svnserve -d -r /root/svn  
[root@svnserv ~]# svn ls svn://192.168.11.148  
svn: Expected FS format '2'; found format '3'  
svn: 期待文件系统(FS)格式 “2”；找到格式“3”  
这是因为待恢复的subversion版本和现在安装的subversion不一致，待恢复的较新。

[root@svnserv ~]# svnserve --version  
svnserve, version 1.4.2 (r22196)

 

2. 尝试在centos 5.3安装subversion 1.6.5

--------------------------------------------------

必须升级subversion。

  

查到最新稳定版为subversion-1.6.5。  
下载地址  
[http://subversion.tigris.org/getting.html](http://subversion.tigris.org/getting.html)

  
如果下载源码编译，会有很多依赖的库也需要下载。所以直接下redhat AS 5 对应的rpm安装。

 

[root@svnserv ~]# rpm -ivh subversion-1.6.5-1.i386.rpm  
error: Failed dependencies:  
libneon.so.27 is needed by subversion-1.6.5-1.i386  
neon >= 0.26.1 is needed by subversion-1.6.5-1.i386  
sqlite >= 3.4 is needed by subversion-1.6.5-1.i386

[root@svnserv ~]# rpm -ivh neon-0.28.4-1.i386.rpm  
Preparing... ########################################### [100%]  
1:neon ########################################### [100%]

  
需要先安装sqlite

[root@svnserv ~]# rpm -ivh subversion-1.6.5-1.i386.rpm  
error: Failed dependencies:  
sqlite >= 3.4 is needed by subversion-1.6.5-1.i386

  
安装sqlite呢？与已有版本冲突  
[root@svnserv ~]# rpm -ivh sqlite-3.5.9-2.i386.rpm  
Preparing... ########################################### [100%]  
file /usr/bin/sqlite3 from install of sqlite-3.5.9-2.i386 conflicts with file from package sqlite-3.3.6-2.i386  
file /usr/lib/libsqlite3.so.0.8.6 from install of sqlite-3.5.9-2.i386  conflicts with file from package sqlite-3.3.6-2.i386

[root@svnserv ~]# rpm -qa | grep sqlite  
python-sqlite-1.1.7-1.2.1  
sqlite-devel-3.3.6-2  
sqlite-3.3.6-2

 

卸载？有依赖  
[root@svnserv ~]# rpm -e sqlite-3.3.6-2  
error: Failed dependencies:  
libsqlite3.so.0 is needed by (installed) php-pdo-5.1.6-23.el5.i386  
libsqlite3.so.0 is needed by (installed) sqlite-devel-3.3.6-2.i386  
libsqlite3.so.0 is needed by (installed) rpm-4.4.2.3-9.el5.i386  
libsqlite3.so.0 is needed by (installed) rpm-libs-4.4.2.3-9.el5.i386  
libsqlite3.so.0 is needed by (installed) apr-util-1.2.7-7.el5.i386  
libsqlite3.so.0 is needed by (installed) python-sqlite-1.1.7-1.2.1.i386  
libsqlite3.so.0 is needed by (installed) yum-metadata-parser-1.1.2-2.el5.i386  
libsqlite3.so.0 is needed by (installed) rpm-build-4.4.2.3-9.el5.i386  
libsqlite3.so.0 is needed by (installed) rpm-devel-4.4.2.3-9.el5.i386  
libsqlite3.so.0 is needed by (installed) systemtap-0.7.2-2.el5.i386  
sqlite = 3.3.6-2 is needed by (installed) sqlite-devel-3.3.6-2.i386  
sqlite is needed by (installed) systemtap-0.7.2-2.el5.i386

  
觉不可强行卸载sqlite，前人已有经验，会死的很难看。

 

升级呢？ 有sqlite-devel-3.3.6-2.i386依赖  
[root@svnserv ~]# rpm -Uvh sqlite-3.5.9-2.i386.rpm  
error: Failed dependencies:  
sqlite = 3.3.6-2 is needed by (installed) sqlite-devel-3.3.6-2.i386

 

那升级sqlite-devel-3.3.6-2.i386到sqlite-devel-3.5.9-2.i386呢？又说需要先安装了sqlite = 3.5.9-2 才行。  
[root@svnserv ~]# rpm -Uvh sqlite-devel-3.5.9-2.i386.rpm  
error: Failed dependencies:  
sqlite = 3.5.9-2 is needed by sqlite-devel-3.5.9-2.i386

  

这就形成一个循环依赖了。想升级sqlite 3.3到3.5, 告诉我sqllite devel 3.3需要它。升级sqllite devel 3.3呢，告诉我必须先安装sqlite 3.5

 

删除sqlite-devel-3.3.6-2呢？不行  
[root@svnserv ~]# rpm -e sqlite-devel-3.3.6-2  
error: Failed dependencies:  
sqlite-devel is needed by (installed) rpm-devel-4.4.2.3-9.el5.i386

 

改安装subversion 1.5

-----------------------

 

一时无法，所以还是安装subversion 1.5吧。

由于1.65对sqlite版本的依赖，转到较老的1.57版，不需要sqlite支持。

到 [http://www.open.collab.net/downloads/subversion.html](http://www.open.collab.net/downloads/subversion.html) 下载认证的rpm release，需要在collab注册。

直接安装服务器端，提示依赖错误

  
[root@svnserv ~]# rpm -ivh CollabNetSubversion-server-1.5.7-1.i386.rpm  
warning: CollabNetSubversion-server-1.5.7-1.i386.rpm: Header V3 DSA signature: NOKEY, key ID 35bcca43  
error: Failed dependencies:  
CollabNetSubversion-client >= 1.5.7-1 is needed by CollabNetSubversion-server-1.5.7-1.i386

 

先安装1.5 client  
[root@svnserv ~]# rpm -ivh CollabNetSubversion-client-1.5.7-1.i386.rpm  
warning: CollabNetSubversion-client-1.5.7-1.i386.rpm: Header V3 DSA signature: NOKEY, key ID 35bcca43  
Preparing... ########################################### [100%]  
1:CollabNetSubversion-cli########################################### [100%]

 

再安装 1.5 server ok  
[root@svnserv ~]# rpm -ivh CollabNetSubversion-server-1.5.7-1.i386.rpm  
warning: CollabNetSubversion-server-1.5.7-1.i386.rpm: Header V3 DSA signature: NOKEY, key ID 35bcca43  
Preparing... ########################################### [100%]  
1:CollabNetSubversion-ser########################################### [100%]

成功了。

 

不过，执行

[root@svnserv ~]# svnserve --version  
svnserve，版本 1.4.2 (r22196)  
编译于 Jan 21 2009，20:11:00

还是1.4.2

[root@svnserv ~]# whereis svnserve  
svnserve: /usr/bin/svnserve /opt/CollabNet_Subversion/bin/svnserve /usr/share/man/man8/svnserve.8.gz

 

发现新版被安装与/opt目录去了。

 

执行

[root@svnserv ~]# /opt/CollabNet_Subversion/bin/svnserve --version  
svnserve，版本 1.5.7 (r36142)  
编译于 Aug 7 2009，15:28:37

可以将/opt相
应bin目录的svn*拷到/usr/bin，也可以直接执行该目录。

我的版本库放在/root/svn目录下，直接从原机器打包拷过来的。

/opt/CollabNet_Subversion/bin/svnserve -d -r /root/svn

 

需要配置一下svnserve.conf和相应的权限

执行

svn list svn://localhost/ 

就会显示相应的库，一切ok。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=2fd719d3-db4f-8693-aa7f-9737a57a972a)
