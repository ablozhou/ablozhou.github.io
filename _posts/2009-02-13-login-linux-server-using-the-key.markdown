---
author: abloz
comments: true
date: 2009-02-13 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/02/13/login-linux-server-using-the-key/
slug: login-linux-server-using-the-key
title: 用密钥登录linux服务器
wordpress_id: 895
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文 2009.2.13

登录linux时省去输入用户名和密码，这样可以“偷懒”。最偷懒的方式是将sshd_config里面配置允许空密码。  
但这样就好像“北京欢迎你”所唱的“我家大门常打开”，这可不是好事。尤其某些人，喜欢用root账号，兼职相当于把客厅摆在大

街上。  
为什么putty/pietty没有保存密码，自动输入的功能呢？那样本来可以偷一下懒的。不过，putty还是可以不用输密码，那就是采用

rsa/dsa公私钥。而且还能保证安全。当然，本地私钥要保护好，不要被人拷走。也可以将私钥输入密码保护。不过那样达不到偷懒

的目的了。每次登录还得输入打开私钥的密码。当然，其安全性已经与密码交互不可同日而语了。因为私钥是1024位的随机字符串，

破解起来怕得几百年。而我们人能记住的密码，一般就8位以内，还不能包含太多各种无意义字符。  
公钥私钥还有别的好处，比如大家使用统一账户登录，但我又不想泄露密码，那么可以分发私钥，用不同的密码保护。

1.生成公钥私钥  
$ ssh-keygen -t rsa  
Generating public/private rsa key pair.  
Enter file in which to save the key (/home/zhouhh/.ssh/id_rsa): testa  
Enter passphrase (empty for no passphrase):  
Enter same passphrase again:  
Your identification has been saved in testa.  
Your public key has been saved in testa.pub.  
The key fingerprint is:  
85:97:91:94:4a:21:00:d5:08:e3:cc:b0:63:0b:0f:cf [zhouhh@xxxx](mailto:zhouhh@xxxx)

将testa拷入/home/zhouhh/.ssh/id_rsa  
将testa.pub拷入/home/zhouhh/.ssh/authorized_keys

这两个文件同时可以拷给其他linux机器相应的.ssh目录下。  
这时用scp等拷贝文件时也不必输密码了。

2.

用超级用户权限修改/etc/ssh/sshd_config

RSAAuthentication yes  
PubkeyAuthentication yes  
AuthorizedKeysFile .ssh/authorized_keys

如果同时修改：  
ChallengeResponseAuthentication no  
PasswordAuthentication no  
UsePAM no  
则会禁止采用password登录

重启sshd  
service sshd restart

如果不修改.ssh为0700，将打印  
Server refused our key

这是为了防止私钥被人拷走设的权限保护。

3.将testa的私钥传到windows下  
用putty的puttygen导入该文件，再保存私钥为zhh.ppk,公钥为zhh.pub  
因为putty的rsa的私钥和openssh的不兼容，所以要导一下。

4.putty配置ssh的auth的key文件为刚生成的zhh.ppk。  
ssh的data也可以将用户名配为登录用户zhouhh，否则putty登录时会提示用户名。

5.连接服务器，不用输入密码直接登录了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=126218f0-c206-85cd-9abc-1d9fdd7294bf)
