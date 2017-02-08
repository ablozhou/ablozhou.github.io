---
author: abloz
comments: true
date: 2009-12-25 06:41:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/25/ssh-connection-is-very-slow-solution/
slug: ssh-connection-is-very-slow-solution
title: ssh 连接很慢的解决办法
wordpress_id: 999
categories:
- 技术
---

# 






[周海汉](http://blog.csdn.net/ablo_zhou) /文

ablozhou # gmail.com

http://blog.csdn.net/ablo_zhou

2009.12.25 圣诞快乐！

=============

现象：

在局域网内，能ping通目标机器，并且时延是微秒级。

用ssh连局域网内其他linux机器，会等待10-30秒才有提示输入密码。严重影响工作效率。

========================

客户端操作系统版本：

zhouhh@zhhofs:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=9.10
DISTRIB_CODENAME=karmic
DISTRIB_DESCRIPTION="Ubuntu 9.10"

========================

调试信息：

    
    
    <span><span>zhouhh@zhhofs:~$ ssh -v </span><span class="value">192.168</span><span>.</span><span class="value">12.16</span><span>  </span></span>
    <span>OpenSSH_<span class="value">5.1</span><span>p</span><span class="value">1</span><span> Debian</span><span class="value">-6</span><span>ubuntu</span><span class="value">2</span><span>, OpenSSL </span><span class="value">0.9</span><span>.</span><span class="value">8</span><span>g </span><span class="value">19</span><span> Oct </span><span class="value">2007</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> Reading configuration data /etc/ssh/ssh_config  </span></span>
    <span>debug<span class="value">1:</span><span> Applying options for *  </span></span>
    <span>debug<span class="value">1:</span><span> Connecting to </span><span class="value">192.168</span><span>.</span><span class="value">12.16</span><span> [</span><span class="value">192.168</span><span>.</span><span class="value">12.16</span><span>] port </span><span class="value">22</span><span>.  </span></span>
    <span>debug<span class="value">1:</span><span> Connection established.  </span></span>
    <span>debug<span class="value">1:</span><span> identity file /home/zhouhh/.ssh/identity type </span><span class="value">-1</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> identity file /home/zhouhh/.ssh/id_rsa type </span><span class="value">-1</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> identity file /home/zhouhh/.ssh/id_dsa type </span><span class="value">-1</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> Remote protocol version </span><span class="value">2.0</span><span>, remote software version OpenSSH_</span><span class="value">4.3</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> match: OpenSSH_</span><span class="value">4.3</span><span> pat OpenSSH_</span><span class="value">4</span><span>*  </span></span>
    <span>debug<span class="value">1:</span><span> Enabling compatibility mode for protocol </span><span class="value">2.0</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> Local version string SSH</span><span class="value">-2.0</span><span>-OpenSSH_</span><span class="value">5.1</span><span>p</span><span class="value">1</span><span> Debian</span><span class="value">-6</span><span>ubuntu</span><span class="value">2</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> SSH</span><span class="value">2</span><span>_MSG_KEXINIT sent  </span></span>
    <span>debug<span class="value">1:</span><span> SSH</span><span class="value">2</span><span>_MSG_KEXINIT received  </span></span>
    <span>debug<span class="value">1:</span><span> kex: server->client aes</span><span class="value">128</span><span>-cbc hmac-md</span><span class="value">5</span><span> </span><span class="value">none</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> kex: client->server aes</span><span class="value">128</span><span>-cbc hmac-md</span><span class="value">5</span><span> </span><span class="value">none</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> SSH</span><span class="value">2</span><span>_MSG_KEX_DH_GEX_REQUEST(</span><span class="value">1024</span><span><</span><span class="value">1024</span><span><</span><span class="value">8192</span><span>) sent  </span></span>
    <span>debug<span class="value">1:</span><span> expecting SSH</span><span class="value">2</span><span>_MSG_KEX_DH_GEX_GROUP  </span></span>
    <span>debug<span class="value">1:</span><span> SSH</span><span class="value">2</span><span>_MSG_KEX_DH_GEX_INIT sent  </span></span>
    <span>debug<span class="value">1:</span><span> expecting SSH</span><span class="value">2</span><span>_MSG_KEX_DH_GEX_REPLY  </span></span>
    <span>debug<span class="value">1:</span><span> Host </span><span class="string">'192.168.12.16'</span><span> is known and matches the RSA host key.  </span></span>
    <span>debug<span class="value">1:</span><span> Found key in /home/zhouhh/.ssh/known_hosts:</span><span class="value">1</span><span>  </span></span>
    <span>debug<span class="value">1:</span><span> ssh_rsa_verify: signature correct  </span></span>
    <span>debug<span class="value">1:</span><span> SSH</span><span class="value">2</span><span>_MSG_NEWKEYS sent  </span></span>
    <span>debug<span class="value">1:</span><span> expecting SSH</span><span class="value">2</span><span>_MSG_NEWKEYS  </span></span>
    <span>debug<span class="value">1:</span><span> SSH</span><span class="value">2</span><span>_MSG_NEWKEYS received  </span></span>
    <span>debug<span class="value">1:</span><span> SSH</span><span class="value">2</span><span>_MSG_SERVICE_REQUEST sent  </span></span>
    <span>debug<span class="value">1:</span><span> SSH</span><span class="value">2</span><span>_MSG_SERVICE_ACCEPT received  </span></span>
    <span>debug<span class="value">1:</span><span> Authentications that can continue: publickey,gssapi-with-mic,password  </span></span>
    <span>debug<span class="value">1:</span><span> Next authentication method: gssapi-with-mic  </span></span>
    <span>debug<span class="value">1:</span><span> An invalid name was supplied  </span></span>
    <span>Cannot determine realm for numeric host address  </span>
    <span>debug<span class="value">1:</span><span> An invalid name was supplied  </span></span>
    <span>Cannot determine realm for numeric host address  </span>
    <span>debug<span class="value">1:</span><span> An invalid name was supplied  </span></span>
    <span>debug<span class="value">1:</span><span> Next authentication method: publickey  </span></span>
    <span>debug<span class="value">1:</span><span> Trying private key: /home/zhouhh/.ssh/identity  </span></span>
    <span>debug<span class="value">1:</span><span> Trying private key: /home/zhouhh/.ssh/id_rsa  </span></span>
    <span>debug<span class="value">1:</span><span> Trying private key: /home/zhouhh/.ssh/id_dsa  </span></span>
    <span>debug<span class="value">1:</span><span> Next authentication method: password  </span></span>
    <span>zhouhh@<span class="value">192.168</span><span>.</span><span class="value">12.16</span><span>'s password:   </span></span>
    <span>debug<span class="value">1:</span><span> Authentication succeeded (password).  </span></span>
    <span>debug<span class="value">1:</span><span> channel </span><span class="value">0:</span><span> new [client-session]  </span></span>
    <span>debug<span class="value">1:</span><span> Entering interactive session.  </span></span>
    <span>debug<span class="value">1:</span><span> Sending environment.  </span></span>
    <span>debug<span class="value">1:</span><span> Sending env LANG = zh_CN.UTF</span><span class="value">-8</span><span>  </span></span>
    <span>Last login: Fri Dec <span class="value">25 13:</span><span class="value">35:04</span><span> </span><span class="value">2009</span><span> from </span><span class="value">192.168</span><span>.</span><span class="value">11.146</span><span>  </span></span>
    <ol class="dp-css"></ol>
    


zhouhh@zhhofs:~$ ssh -v 192.168.12.16 OpenSSH_5.1p1 Debian-6ubuntu2, OpenSSL 0.9.8g 19 Oct 2007 debug1: Reading configuration data /etc/ssh/ssh_config debug1: Applying options for * debug1: Connecting to 192.168.12.16 [192.168.12.16] port 22. debug1: Connection established. debug1: identity file /home/zhouhh/.ssh/identity type -1 debug1: identity file /home/zhouhh/.ssh/id_rsa type -1 debug1: identity file /home/zhouhh/.ssh/id_dsa type -1 debug1: Remote protocol version 2.0, remote software version OpenSSH_4.3 debug1: match: OpenSSH_4.3 pat OpenSSH_4* debug1: Enabling compatibility mode for protocol 2.0 debug1: Local version string SSH-2.0-OpenSSH_5.1p1 Debian-6ubuntu2 debug1: SSH2_MSG_KEXINIT sent debug1: SSH2_MSG_KEXINIT received debug1: kex: server->client aes128-cbc hmac-md5 none debug1: kex: client->server aes128-cbc hmac-md5 none debug1: SSH2_MSG_KEX_DH_GEX_REQUEST(1024<1024<8192) sent debug1: expecting SSH2_MSG_KEX_DH_GEX_GROUP debug1: SSH2_MSG_KEX_DH_GEX_INIT sent debug1: expecting SSH2_MSG_KEX_DH_GEX_REPLY debug1: Host '192.168.12.16' is known and matches the RSA host key. debug1: Found key in /home/zhouhh/.ssh/known_hosts:1 debug1: ssh_rsa_verify: signature correct debug1: SSH2_MSG_NEWKEYS sent debug1: expecting SSH2_MSG_NEWKEYS debug1: SSH2_MSG_NEWKEYS received debug1: SSH2_MSG_SERVICE_REQUEST sent debug1: SSH2_MSG_SERVICE_ACCEPT received debug1: Authentications that can continue: publickey,gssapi-with-mic,password debug1: Next authentication method: gssapi-with-mic debug1: An invalid name was supplied Cannot determine realm for numeric host address debug1: An invalid name was supplied Cannot determine realm for numeric host address debug1: An invalid name was supplied debug1: Next authentication method: publickey debug1: Trying private key: /home/zhouhh/.ssh/identity debug1: Trying private key: /home/zhouhh/.ssh/id_rsa debug1: Trying private key: /home/zhouhh/.ssh/id_dsa debug1: Next authentication method: password zhouhh@192.168.12.16's password:  debug1: Authentication succeeded (password). debug1: channel 0: new [client-session] debug1: Entering interactive session. debug1: Sending environment. debug1: Sending env LANG = zh_CN.UTF-8 Last login: Fri Dec 25 13:35:04 2009 from 192.168.11.146 

可以看到如下的错误信息：

debug1: Next authentication method: gssapi-with-mic
debug1: An invalid name was supplied
Cannot determine realm for numeric host address

事实上，正是从gssapi-with-mic这一行开始，开始耗时间。

====================

失败的尝试：

有人说是在目标机器中修改/etc/ssh/sshd_conf文件

将UseDNS 的缺省值由yes修改为no，并重启sshd。我试了，对这种情况不管用。但不排除对别的延迟情况管用。

====================

有效的解决办法：

1. 修改本地机器的hosts文件，将目标机器的IP和域名加上去。或者让本机的DNS 服务器能解析目标地址。

vi /etc/hosts

192.168.12.16  ourdev

其格式是“目标机器IP 目标机器名称”这种方法促效。没有延迟就连上了。不过如果给每台都加一个域名解析，挺辛苦的。但在windows下用putty或secure-crt时可以采用这种方法。

2.修改本机的客户端配置文件ssh_conf，注意，不是sshd_conf

vi /etc/ssh/ssh_conf

找到

GSSAPIAuthentication yes

改为

GSSAPIAuthentication no

保存。

再连目标机器，速度就飞快了。

_GSSAPI (_ Generic Security Services Application Programming Interface_)_ 是一套类似Kerberos 5 的通用网络安全系统接口。该接口是对各种不同的客户端服务器安全机制的封装，以消除安全接口的不同，降低编程难度。但该接口在目标机器无域名解析时会有问题。我看到有人给ubuntu提交了[相关bug，](https://bugs.launchpad.net/ubuntu/+source/openssh/+bug/96472) 说要将GSSAPIAuthentication的缺省值设为no，不知为何，ubuntu9.10的缺省值还是yes。

修改完毕，此时的连接调试数据变为了：

    
    <span><span>zhouhh@zhhofs:~$ ssh -v 192.168.12.16  </span></span>
    <span>OpenSSH_5.1p1 Debian-6ubuntu2, OpenSSL 0.9.8g 19 Oct 2007  </span>
    <span>debug1: Reading configuration data /etc/ssh/ssh_config  </span>
    <span>debug1: Applying options <span class="keyword">for</span><span> *  </span></span>
    <span>debug1: Connecting to 192.168.12.16 [192.168.12.16] port 22.  </span>
    <span>debug1: Connection established.  </span>
    <span>debug1: identity file /home/zhouhh/.ssh/identity type -1  </span>
    <span>debug1: identity file /home/zhouhh/.ssh/id_rsa type -1  </span>
    <span>debug1: identity file /home/zhouhh/.ssh/id_dsa type -1  </span>
    <span>debug1: Remote protocol version 2.0, remote software version OpenSSH_4.3  </span>
    <span>debug1: match: OpenSSH_4.3 pat OpenSSH_4*  </span>
    <span>debug1: Enabling compatibility mode <span class="keyword">for</span><span> protocol 2.0  </span></span>
    <span>debug1: Local version <span class="keyword">string</span><span> SSH-2.0-OpenSSH_5.1p1 Debian-6ubuntu2  </span></span>
    <span>debug1: SSH2_MSG_KEXINIT sent  </span>
    <span>debug1: SSH2_MSG_KEXINIT received  </span>
    <span>debug1: kex: server->client aes128-cbc hmac-md5 none  </span>
    <span>debug1: kex: client->server aes128-cbc hmac-md5 none  </span>
    <span>debug1: SSH2_MSG_KEX_DH_GEX_REQUEST(1024<1024<8192) sent  </span>
    <span>debug1: expecting SSH2_MSG_KEX_DH_GEX_GROUP  </span>
    <span>debug1: SSH2_MSG_KEX_DH_GEX_INIT sent  </span>
    <span>debug1: expecting SSH2_MSG_KEX_DH_GEX_REPLY  </span>
    <span>debug1: Host <span class="string">'192.168.12.16'</span><span> </span><span class="keyword">is</span><span> known and matches the RSA host key.  </span></span>
    <span>debug1: Found key <span class="keyword">in</span><span> /home/zhouhh/.ssh/known_hosts:1  </span></span>
    <span>debug1: ssh_rsa_verify: signature correct  </span>
    <span>debug1: SSH2_MSG_NEWKEYS sent  </span>
    <span>debug1: expecting SSH2_MSG_NEWKEYS  </span>
    <span>debug1: SSH2_MSG_NEWKEYS received  </span>
    <span>debug1: SSH2_MSG_SERVICE_REQUEST sent  </span>
    <span>debug1: SSH2_MSG_SERVICE_ACCEPT received  </span>
    <span>debug1: Authentications that can <span class="keyword">continue</span><span>: publickey,gssapi-with-mic,password  </span></span>
    <span>debug1: Next authentication method: publickey  </span>
    <span>debug1: Trying <span class="keyword">private</span><span> key: /home/zhouhh/.ssh/identity  </span></span>
    <span>debug1: Trying <span class="keyword">private</span><span> key: /home/zhouhh/.ssh/id_rsa  </span></span>
    <span>debug1: Trying <span class="keyword">private</span><span> key: /home/zhouhh/.ssh/id_dsa  </span></span>
    <span>debug1: Next authentication method: password  </span>
    <span>zhouhh@192.168.12.16's password:   </span>
    







![](http://img.zemanta.com/pixy.gif?x-id=129c08ff-92f3-8fa9-86f9-87974abd24a0)

    
    如果在发起机器的ssh_config将GSAPIAuthentication设为no后，到下面这一行花很多时间： debug1: Offering public key: /home/zhouhh/.ssh/id_rsa  那么，将目标机器的sshd_config的 UseDNS no 设置后，速度就快了。
    <ol>
    
    </ol>
    



