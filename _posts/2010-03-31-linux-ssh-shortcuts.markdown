---
author: abloz
comments: true
date: 2010-03-31 07:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/31/linux-ssh-shortcuts/
slug: linux-ssh-shortcuts
title: linux ssh 快捷方式
wordpress_id: 1191
categories:
- 技术
---

周海汉 /文   
2010.3.31   
ablozhou # gmail.com  
  
概述  
  
因为要管理数十台linux服务器，经常用ssh连接。苦恼的是每次ssh连接时都要输一半天命令，类似：  
  
ssh -p 2345 user@123.123.222.222  
  
password:  
  
能否简短快捷一点呢？  
ssh快捷配置  
  
其实可以在自己用户名下配置.ssh/config  
  
如下：  
  
1. Host centdev   
2. HostName 192.168.12.12   
3. Port 2345   
4. User zhouhh   
5. Host fc5dev   
6. HostName 192.168.12.13   
7. Port 4567   
8. User zhouhh   
9. Host svn   
10. HostName 192.168.12.23   
11. User root   
  
  
  
此时，如果想访问centdev，原来需要  
  
ssh -p 2345 zhouhh@centdev (配置hosts）  
  
或  
  
ssh -p 2345 zhouhh@192.168.12.12  
  
现在只需用ssh centdev就可以了。  
  
但是还需要输入密码。结合以前我写的《用密钥登录linux服务器 》，设置密钥，可以连密码都省了。 省略输入用户名密码  
  
先生成密钥  
  
  
zhouhh@zhh64:~$ ssh-keygen -t rsa  
Generating public/private rsa key pair.  
Enter file in which to save the key (/home/zhouhh/.ssh/id_rsa):   
/home/zhouhh/.ssh/id_rsa already exists.  
Overwrite (y/n)? y  
Enter passphrase (empty for no passphrase):   
Enter same passphrase again:   
Your identification has been saved in /home/zhouhh/.ssh/id_rsa.  
Your public key has been saved in /home/zhouhh/.ssh/id_rsa.pub.  
The key fingerprint is:  
69:97:a3:e7:f0:8c:95:99:ac:8e:eb:6f:61:d1:14:dc zhouhh@zhh64  
The key's randomart image is:  
+--[ RSA 2048]----+  
| ..o |  
| o E |  
| o |  
| .... |  
| S.+ |  
| .o+ = |  
| .o.B |  
| ..X |  
| .+== + |  
+-----------------+  
  
密钥文件的密码选择空。  
此时，可以看到.ssh里面有如下文件：  
zhouhh@zhh64:~$ ls .ssh  
config id_rsa id_rsa.pub known_hosts  
其中id_rsa是私钥，id_rsa.pub是公钥。  
配置目标机器  
在目标机器，需编辑/etc/ssh/sshd_config  
确认如下选项  
RSAAuthentication yes  
PubkeyAuthentication yes  
AuthorizedKeysFile %h/.ssh/pub_keys  
或  
AuthorizedKeysFile ~/.ssh/pub_keys  
  
如用户名下不存在.ssh目录，需创建，并修改属性为700.  
将.ssh里面的id_rsa.pub改名为pub_keys  
重启sshd  
[zhouhh@svnserv ~]$ ls .ssh  
ls: .ssh: 没有那个文件或目录  
[zhouhh@svnserv ~]$ mkdir .ssh  
[zhouhh@svnserv ~]$ cd .ssh  
[zhouhh@svnserv .ssh]$ ls  
id_rsa.pub  
[zhouhh@svnserv .ssh]$ cp id_rsa.pub pub_keys  
[zhouhh@svnserv .ssh]$ ls -l  
总计 16  
-rw-r--r-- 1 zhouhh zhouhh 394 04-01 10:13 id_rsa.pub  
-rw-r--r-- 1 zhouhh zhouhh 394 04-01 10:14 pub_keys  
[zhouhh@svnserv .ssh]$ cd ..  
[zhouhh@svnserv ~]$ chmod 700 .ssh  
[root@svnserv ~]# service sshd restart  
停止 sshd： [确定]  
启动 sshd： [确定]  
  
拷贝公钥  
需将公钥拷贝到目标机器。  
zhouhh@zhh64:~/.ssh$ scp id_rsa.pub zhouhh@svn:~/.ssh/.  
zhouhh@192.168.12.232's password:   
id_rsa.pub 100% 394 0.4KB/s 00:00   
  
此时，用如下命令无须密码即可进入：  
zhouhh@zhh64:~$ ssh zhouhh@svn  
[zhouhh@svnserv ~]$   
  
配置本地使用私钥  
再编辑本地的.ssh/config  
[zhouhh@svnserv ~]$ exit  
logout  
Connection to 192.168.12.232 closed.  
zhouhh@zhh64:~$ vi .ssh/config  
修改其配置文件：  
  
Host svn  
HostName 192.168.12.232  
User zhouhh  
PreferredAuthentications publickey  
PubkeyAuthentication yes  
IdentityFile ~/.ssh/id_rsa  
  
注意 IdentityFile，填写本地私钥文件地址。  
  
此时，只需ssh svn就可以直接访问目标地址了，无须输入用户名密码。  
zhouhh@zhh64:~$ ssh svn  
Last login: Thu Apr 1 10:16:27 2010 from 192.168.11.116  
[zhouhh@svnserv ~]$  
  
总结  
经过如上的配置，对那些维护机器量很大的或经常需要ssh登入登出的人，至少在登录这一关，一劳永逸了。  
参考：  
http://sial.org/howto/openssh/publickey-auth/  
  
http://linuxtoy.org/archives/ssh-tip-creating-shortcut.html  
用密钥登录linux服务器  
  
  
  


![](http://img.zemanta.com/pixy.gif?x-id=e4d713ca-fa71-847e-80d6-60865eac0eb7)
