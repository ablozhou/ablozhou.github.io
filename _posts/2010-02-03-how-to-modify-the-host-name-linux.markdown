---
author: abloz
comments: true
date: 2010-02-03 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/02/03/how-to-modify-the-host-name-linux/
slug: how-to-modify-the-host-name-linux
title: 如何修改linux的主机名
wordpress_id: 1038
categories:
- 技术
---

#  					 				

				

 					  					  					

# 如何修改linux的主机名  


[周海汉](http://blog.csdn.net/ablo_zhou) /文

http://blog.csdn.net/ablo_zhou

2010.2.3

 

我维护两三个机房的数十台机器，开发用机器，运营用机器，自己工作机器也是ubuntu，有时开很多ssh，干的还是同样的事情，很容易搞混。所以需要一目了然的知道某台机器的情况，避免犯晕。这就需要修改主机名。缺省安装系统的主机名都是Localhost，无法区分。

 

## 1.临时修改主机名

 

显示主机名：

zhouhh@zzhh64:~$ hostname  
zhh64

 

修改主机名：

zhouhh@zzhh64:~$ sudo hostname zzofs  
zhouhh@zzhh64:~$ hostname  
zzofs

 

看一下$PS1

zhouhh@zzhh64:~$ echo $PS1  
[e]0;u@h: wa]${debian_chroot:+($debian_chroot)}u@h:w$  
@符号后面跟h即主机名。

命令行前的提示符主机名怎么没有更新呢？

 

重新打开一个终端，就看到更新了。

zhouhh@zzofs:~$ 

 

## 2.永久修改主机名

以上的修改只是临时修改，重启后就恢复原样了。

 

**redhat/centos上永久修改**

[root@localhost ~]# cat /etc/sysconfig/network  
NETWORKING=yes  
HOSTNAME=localhost.localdomain  
GATEWAY=192.168.10.1

 

修改network的HOSTNAME项。点前面是主机名，点后面是域名。没有点就是主机名。

[root@localhost ~]# vi /etc/sysconfig/network

NETWORKING=yes  
NETWORKING_IPV6=no  
HOSTNAME=gdbk

 

这个是永久修改，重启后生效。目前不知道怎么立即生效。

想立即生效，可以同时采用第一种方法。

 

**deb/ubuntu上修改** ：

hostname  
localhost.localdomain

 

sudo vi /etc/hostname

在/etc/hostname里面直接填上hostname

zhouhh@localhost:~$ cat /etc/hostname  
zhh64

 

重启后，提示符变成了。

zhouhh@zhh64:~$ 

如果不想重启，则用hostname名令。

 

## 3. 其他修改方式

用sysctl 修改kernel.hostname

查看：

zhouhh@zhh64:~$ sysctl kernel.hostname  
kernel.hostname = zhh64

 

修改：

zhouhh@zhh64:~$ sudo sysctl kernel.hostname=zzh  
kernel.hostname = zzh

重新打开shell就变成如下hostname了zhh

zhouhh@zzh:~$

 

## 4. hosts文件与主机名修改无关

一些网络文章中提出修改主机名还需修改Hosts文件，其实hosts文件和主机名修改无关。但是，如果本机想访问别的主机的别名，则应修改hosts。

cat /etc/hosts

 

127.0.0.1 localhost  
192.168.11.116 zhh64  
192.168.12.14 centdev  
  
# The following lines are desirable for IPv6 capable hosts  
::1 localhost ip6-localhost ip6-loopback  
fe00::0 ip6-localnet  
ff00::0 ip6-mcastprefix  
ff02::1 ip6-allnodes  
ff02::2 ip6-allrouters  
ff02::3 ip6-allhosts

 

hosts文件是配本地主机名/域名解析的。

如我本机ip是192.168.11.116名字是zhh64.就可以直接访问主机名。

zhouhh@zhh64:~$ ping zhh64  
PING zhh64 (192.168.11.116) 56(84) bytes of data.  
64 bytes from zhh64 (192.168.11.116): icmp_seq=1 ttl=64 time=0.077 ms

 

zhouhh@zhh64:~$ ping centdev  
PING centdev (192.168.12.14) 56(84) bytes of data.  
64 bytes from centdev (192.168.12.14): icmp_seq=1 ttl=63 time=0.726 ms  


如果是小型局域网，就可以将hosts文件机器配全了，拷贝到每个机器，然后在ssh访问时用主机名直接访问。

zhouhh@zhh64:~$ ssh centdev  
zhouhh@centdev's password:   
Last login: Wed Feb 3 10:03:09 2010 from 192.168.11.116  
[zhouhh@centdev ~]$   
[zhouhh@centdev ~]$ ifconfig eth0 | grep inet  
inet addr:192.168.12.14 Bcast:192.168.12.255 Mask:255.255.255.0  
inet6 addr: fe80::21e:c9ff:fe57:2575/64 Scope:Link  


 

## 4.参考

http://www.ducea.com/2006/08/07/how-to-change-the-hostname-of-a-linux-system/

  
  


![](http://img.zemanta.com/pixy.gif?x-id=8b3be9c0-345d-8fe1-ade7-e2197d7ac17f)
