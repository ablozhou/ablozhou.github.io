---
author: abloz
comments: true
date: 2012-04-13 02:58:04+00:00
layout: post
link: http://abloz.com/index.php/2012/04/13/ssh-yong-key-deng-lu-shi-yu-dao-di-wen-ti-not-a-rsa1-key-file/
slug: ssh-yong-key-deng-lu-shi-yu-dao-di-wen-ti-not-a-rsa1-key-file
title: ssh用key登录时遇到的问题：Not a RSA1 key file
wordpress_id: 1547
categories:
- 技术
tags:
- rsa1
- ssh
---

http://abloz.com
date:2012.4.12
因为.ssh里面用ssh-keygen产生了一个id_rsa密钥对，但这是用于登录另一台服务器的。登录本服务器，我想用zhouhh_rsa密钥对。


```

[zhouhh@Hadoop48 ~]$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/zhouhh/.ssh/id_rsa):/home/zhouhh/.ssh/zhouhh_rsa

```


然后将zhouhh_rsa.pub 缀到authorized_keys后面，结果，登录时遇到如下问题：


```

[zhouhh@Hadoop48 .ssh]$ ssh zhouhh@192.168.10.48 -i .ssh/zhouhh_rsa -vvv
Warning: Identity file .ssh/zhouhh_rsa not accessible: No such file or directory.
OpenSSH_4.3p2, OpenSSL 0.9.8e-fips-rhel5 01 Jul 2008
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: Applying options for *
debug2: ssh_connect: needpriv 0
debug1: Connecting to 192.168.10.48 [192.168.10.48] port 22.
debug1: Connection established.
debug1: identity file /home/zhouhh/.ssh/identity type -1
debug3: Not a RSA1 key file /home/zhouhh/.ssh/id_rsa.
debug2: key_type_from_name: unknown key type '-----BEGIN'
debug3: key_read: missing keytype
debug3: key_read: missing whitespace

```


网上有一些人遇到同样的问题，但基本没有解决办法。可能key文件权限问题，ssh_config,sshd_config配置问题，都不存在。
后面发现，将zhouhh_rsa改名为id_rsa,并将id_rsa.pub移除，则可以正常登录。或者将zhouhh_rsa.pub同样改名为id_rsa.pub，形成配对，也可以登录。
说明.ssh下面的多个key可能会不正常工作，只有id_rsa配对为key，工作正常。所以用id_rsa私钥登录，并不是只读authorized_keys这个文件，其配对的pub key文件也会影响登录。

