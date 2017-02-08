---
author: abloz
comments: true
date: 2012-09-27 08:16:37+00:00
layout: post
link: http://abloz.com/index.php/2012/09/27/centos-5-5-nfs-installation/
slug: centos-5-5-nfs-installation
title: centos 5.5 NFS 安装
wordpress_id: 1894
categories:
- 技术
tags:
- hadoop
- nfs
---

作者：周海汉
网址：http://abloz.com
日期：2012.9.27

Hadoop 1.0.3以前版本服务器由于namenode的单点问题，namenode备份成为重要问题。second namenode由于并非完全实时，只能做次要方案。
我们也可以将namenode存放目录放在本地和网络硬盘上，这样达到metainfo备份的目的。

配置nfs

**1.软件环境准备**
服务器
nfsserver: Hadoop47
nfsclient: Hadoop48

Hadoop48是Namenode，nfs client，mount 位于Hadoop47的网络硬盘
Hadoop47是 second namenode，nfs server

[root@Hadoop47 ~]# cat /etc/redhat-release
CentOS release 5.5 (Final)

CentOS 6以前的版本，用portmap rpc调用来发现端口。6及以后用rpcbind。
nfs原理请参看鸟哥的文档：http://linux.vbird.org/linux_server/0330nfs.php

portmap和nfs-utils系统应该有自带，如果没有，用yum安装。
[root@Hadoop47 ~]# yum install portmap
[root@Hadoop47 ~]# yum install nfs-utils

**2.用户准备**

我们用zhouhh用户来做nfs缺省用户。nfs server和client的用户名和用户id，组id必须一致。否则会有权限问题，导致无法读写。
[root@Hadoop47 ~]# id zhouhh
uid=505(zhouhh) gid=505(zhouhh) groups=505(zhouhh)
[root@Hadoop48 ~]# id zhouhh
uid=505(zhouhh) gid=505(zhouhh) groups=505(zhouhh)
如果用户的id或组id不一致，用usermod和groupmod来修改。
groupmod [-g ][-n ][群组名称]
如
usermod -u 505 zhouhh
groupmod -g 505 zhouhh
用id命令和查看配置文件来检查是否成功
cat /etc/group
cat /etc/passwd

如果没有报错，但/etc/passwd里面还有不一致，可以手工修改一致
对于原来用zhouhh创建的文件和目录，也必须将其权限改成新的uid和gid
[zhouhh@Hadoop47 data]$ ls -l
total 28
drwxr-xr-x 4 668 668 4096 Sep 25 19:11 zhouhh
[zhouhh@Hadoop47 data]$ sudo chown zhouhh:zhouhh zhouhh -R
[zhouhh@Hadoop47 data]$ ls -l
total 28
drwxr-xr-x 4 zhouhh zhouhh 4096 Sep 25 19:11 zhouhh

**3.配置nfs server**
编辑/etc/exports，如下所示
[root@Hadoop47 ~]# cat /etc/exports
/data/zhouhh/myhadoop/name_bak 192.168.10.48(rw,sync,all_squash,anonuid=505,anongid=505)

格式在网上可以找到说明：
服务器端的设定都是在/etc/exports这个文件中进行设定的,设定格式如下:
欲分享出去的目录 主机名称1或者IP1(参数1,参数2) 主机名称2或者IP2(参数3,参数4)
上面这个格式表示,同一个目录分享给两个不同的主机,但提供给这两台主机的权限和参数是不同的,所以分别设定两个主机得到的权限.

可以设定的参数主要有以下这些:
rw:可读写的权限;
ro:只读的权限;
no_root_squash:登入到NFS 主机的用户如果是ROOT用户,他就拥有ROOT的权限,此参数很不安全,建议不要使用.
root_squash:在登入 NFS协议主机使用分享之目的使用者如果是使用者的都成 nobody 身份;
all_squash:不管登陆NFS主机的用户是什么都会被重新设定为nobody.
anonuid:将登入NFS主机的用户都设定成指定的user id,此ID必须存在于/etc/passwd中.
anongid:同 anonuid ,但是?成 group ID 就是了!
sync:资料同步写入存储器中.
async:资料会先暂时存放在内存中,不会直接写入硬盘.
insecure 允许从这台机器过来的非授权访问.

相对于我的设置而言：
/data/zhouhh/myhadoop/name_bak 是nfs服务器要共享的目录，192.168.10.48是服务器IP地址。后面紧跟单括号和共享的一些属性设置，不要有空格。rw表示客户端有可读写权限。sync表示立即同步到硬盘。all_squash 所有读写都用指定用户身份，不指定就是nobody。我刚开始没有指定身份，即没有设置anonuid和anongid。在客户端写时结果报如下错误：
[zhouhh@Hadoop48 name_bak]$ mkdir a
mkdir: cannot create directory `a': Permission denied
[root@Hadoop48 name_bak]# mkdir a
mkdir: cannot create directory `a': Permission denied
客户端用户无论是root还是zhouhh普通用户，都没有权限写。因为他会用nobody来写zhouhh才能写的目录，所以会失败。

但对某些只读应用，则正应该这么设置，用nobody身份，可读不可写。如网络文件共享的应用。

配置hosts安全
测试时可以将/etc/hosts.deny全部注释
/etc/hosts.allow添加ALL:192.168.10.0/24 即允许所有位于192.168.10.1-192.168.10.254的程序访问。
实际运营环境需根据实际情况配置好安全设置。
测试时可将iptables和seLinux关闭

配置自启动
[root@Hadoop47 ~]# chkconfig nfs on
[root@Hadoop47 ~]# chkconfig portmap on
启动服务
[root@Hadoop47 ~]# service portmap restart
Stopping portmap: [ OK ]
Starting portmap: [ OK ]
[root@Hadoop47 ~]# service nfs restart
Shutting down NFS mountd: [ OK ]
Shutting down NFS daemon: [ OK ]
Shutting down NFS quotas: [ OK ]
Shutting down NFS services: [ OK ]
Starting NFS services: [ OK ]
Starting NFS quotas: [ OK ]
Starting NFS daemon: [ OK ]
Starting NFS mountd: [ OK ]

**4.配置nfs客户端**
也应安装nfs和portmap
[root@Hadoop48 ~]# showmount -e 192.168.10.47
Export list for 192.168.10.47:
/data/zhouhh/myhadoop/name_bak 192.168.10.48
可以看到192.168.10.47上面有哪些共享
df命令查看，没有mount任何网络硬盘。
[root@Hadoop48 ~]# df
Filesystem 1K-blocks Used Available Use% Mounted on
/dev/sda3 28337624 13920272 12954636 52% /
/dev/sda1 101086 15257 80610 16% /boot
/dev/sdb1 51605436 9343812 39640220 20% /data
tmpfs 1029756 0 1029756 0% /dev/shm
[root@Hadoop48 ~]# mount -t nfs Hadoop47:/data/zhouhh/myhadoop/name_bak /data/zhouhh/myhadoop/name_bak
mount.nfs: mount point /data/zhouhh/myhadoop/name_bak does not exist
目录不存在，需创建目录。注意，不能用root创建，否则又会有权限问题。
nfs服务器端：
[zhouhh@Hadoop47 myhadoop]$ ls -l
total 4
drwxrwxr-x 4 zhouhh zhouhh 4096 Sep 26 14:17 dfs
[zhouhh@Hadoop47 myhadoop]$ mkdir name_bak
[zhouhh@Hadoop47 myhadoop]$ ls -l
total 8
drwxrwxr-x 4 zhouhh zhouhh 4096 Sep 26 14:17 dfs
drwxrwxr-x 2 zhouhh zhouhh 4096 Sep 27 14:24 name_bak
nfs客户端：
[zhouhh@Hadoop48 ~]$ mkdir /data/zhouhh/myhadoop/name_bak

[root@Hadoop48 ~]# mount -t nfs Hadoop47:/data/zhouhh/myhadoop/name_bak /data/zhouhh/myhadoop/name_bak
Hadoop47:/data/zhouhh/myhadoop/name_bak是nfs服务器端目录
后一个/data/zhouhh/myhadoop/name_bak是本地映射的目录。

[root@Hadoop48 ~]# df
Filesystem 1K-blocks Used Available Use% Mounted on
/dev/sda3 28337624 13920276 12954632 52% /
/dev/sda1 101086 15257 80610 16% /boot
/dev/sdb1 51605436 9343816 39640216 20% /data
tmpfs 1029756 0 1029756 0% /dev/shm
Hadoop47:/data/zhouhh/myhadoop/name_bak
51605440 9350336 39633696 20% /data/zhouhh/myhadoop/name_bak

可以看到mount成功。

**5.测试**

nfs服务器端创建，客户端读
服务器写：
[zhouhh@Hadoop47 name_bak]$ mkdir b
[zhouhh@Hadoop47 name_bak]$ cd b
[zhouhh@Hadoop47 b]$ ls
[zhouhh@Hadoop47 b]$ vi asdf.txt

客户端读
[zhouhh@Hadoop48 name_bak]$ ls
b
[zhouhh@Hadoop48 name_bak]$ cd b
[zhouhh@Hadoop48 b]$ ls
asdf.txt
[zhouhh@Hadoop48 b]$ ls -al
total 12
drwxrwxr-x 2 zhouhh zhouhh 4096 Sep 27 14:30 .
drwxrwxr-x 3 zhouhh zhouhh 4096 Sep 27 14:29 ..
-rw-rw-r-- 1 zhouhh zhouhh 7 Sep 27 14:30 asdf.txt
正确

nfs客户端写，服务器端读

客户端写：
[root@Hadoop48 name_bak]# mkdir a
[root@Hadoop48 name_bak]# cd a
[root@Hadoop48 a]# ls
[root@Hadoop48 a]# vi test.txt
[root@Hadoop48 a]# cat test.txt
test1
服务器读：
[root@Hadoop47 name_bak]# ls
a b
[root@Hadoop47 name_bak]# cd a
[root@Hadoop47 a]# ls
test.txt
[root@Hadoop47 a]# cat test.txt
test1
[root@Hadoop47 a]# ls -l
total 4
-rw-r--r-- 1 zhouhh zhouhh 6 Sep 27 14:46 test.txt

nfs配置完成。

**6.参考：**
http://www.cnblogs.com/yuepeng/archive/2010/12/08/1900604.html
