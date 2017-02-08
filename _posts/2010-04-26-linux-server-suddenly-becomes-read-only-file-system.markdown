---
author: abloz
comments: true
date: 2010-04-26 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/04/26/linux-server-suddenly-becomes-read-only-file-system/
slug: linux-server-suddenly-becomes-read-only-file-system
title: linux 服务器忽然变成只读文件系统
wordpress_id: 1215
categories:
- 技术
---

周海汉 /文

2010.4.26

 

以root帐号往一台服务器的/root传文件时，告诉我是只读文件系统。搞的我一头雾水。好好的系统怎么变成只读文件系统了呢？

zhouhh@zhh64:~$ scp myfile serv:.  
root@210.211.225.188's password:   
scp: ./myfile: Read-only file system  


登上去一看：

-bash-3.2# pwd  
/root  


-bash-3.2# ls  
CentOS RELEASE-NOTES-en RELEASE-NOTES-nl  
EULA RELEASE-NOTES-en.html RELEASE-NOTES-nl.html  
GPL RELEASE-NOTES-en_US RELEASE-NOTES-pt_BR  
...

-bash-3.2# cat /etc/redhat-release   
CentOS release 5.2 (Final)

-bash-3.2# rm RE* -f  
rm: 无法删除 “RELEASE-NOTES-cs”: 只读文件系统  
rm: 无法删除 “RELEASE-NOTES-cs.html”: 只读文件系统  
rm: 无法删除 “RELEASE-NOTES-de”: 只读文件系统  
...

-bash-3.2# touch a  
touch: 无法触碰 “a”: 只读文件系统

-bash-3.2# df -h  
文件系统 容量 已用 可用 已用% 挂载点  
/dev/mapper/VolGroup00-LogVol00  
65G 9.8G 52G 16% /  
/dev/sda1 99M 19M 75M 21% /boot  
tmpfs 948M 0 948M 0% /dev/shm  
CentOS_5.2_Final.iso 3.8G 3.8G 0 100% /root  
CentOS_5.2_Final.iso 3.8G 3.8G 0 100% /root

奇怪，root下怎么是两个iso?

 

-bash-3.2# mount  
/dev/mapper/VolGroup00-LogVol00 on / type ext3 (rw)  
proc on /proc type proc (rw)  
sysfs on /sys type sysfs (rw)  
devpts on /dev/pts type devpts (rw,gid=5,mode=620)  
/dev/sda1 on /boot type ext3 (rw)  
tmpfs on /dev/shm type tmpfs (rw)  
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)  
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)  
CentOS_5.2_Final.iso on /root type iso9660 (rw,loop=/dev/loop0)  
CentOS_5.2_Final.iso on /root type iso9660 (rw,loop=/dev/loop1)

看到文件系统本身倒都是rw，并不是ro.

但iso文件肯定是只读的。

 

尝试umount

-bash-3.2# umount CentOS_5.2_Final.iso  
umount: /root: device is busy  
设备忙，卸载不了。

网上找到umount -l参数可以处理这种情况。但man umount并没有该参数说明。man mount说-l参数是list label。没搞明白为何可以卸载繁忙的设备。

尝试一下：

-bash-3.2# umount -l CentOS_5.2_Final.iso

成功了！

-bash-3.2# umount -l CentOS_5.2_Final.iso  
-bash-3.2# mount  
/dev/mapper/VolGroup00-LogVol00 on / type ext3 (rw)  
proc on /proc type proc (rw)  
sysfs on /sys type sysfs (rw)  
devpts on /dev/pts type devpts (rw,gid=5,mode=620)  
/dev/sda1 on /boot type ext3 (rw)  
tmpfs on /dev/shm type tmpfs (rw)  
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)  
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)  
-bash-3.2# cd /root  
-bash-3.2# touch a

成功。

 

奇怪系统好好的怎么被mount上一个iso呢？而且用法奇特。inittab上面没有mount该文件的命令， 难道被入侵了？

看/var/log/secure并无痕迹。

后来发现系统多了一个nagios，想起密码给过某运维同事，他来安装nagios。估计是他进行这么奇怪的mount了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=0e6dc7db-e109-86aa-b81f-29d530f37122)
