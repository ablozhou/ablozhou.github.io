---
author: abloz
comments: true
date: 2009-11-28 09:19:00+00:00
layout: post
link: http://abloz.com/index.php/2009/11/28/ubuntu-9-10-through-walls-to-install-tor/
slug: ubuntu-9-10-through-walls-to-install-tor
title: ubuntu 9.10 下安装tor穿墙
wordpress_id: 971
categories:
- 技术
---

#  					 				

				

 					  					  					 

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2009.11.28

 

ubuntu下一些编程网站，居然被封。只好安装tor来破墙。

 

1.直接执行apt-get命令失败。

sudo apt-get install tor

会得到错误提示

E: 无法找到软件包

 

2.配置tor的源

torproject的源被GFW （Greate Fucked Wall) 封了。

Tor软件源:  
deb http://deb.torproject.org/torproject.org karmic main  
deb-src http://deb.torproject.org/torproject.org karmic main  
  
导入原装Tor的签名键:  
sudo gpg --keyserver keys.gnupg.net --recv 886DDD89   
sudo gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -  
  
在完成以上命令后，更新软件源:  
sudo apt-get update

 

如不能用，可能需要别的源。163的源有可能可以用。

 

或者给gettor@torproject.org 发纯文本的邮件，

题目和内容都为help

会收到自动回复的邮件，让你选择

tor-browser-bundle  
macosx-universal-bundle  
panther-bundle  
tor-im-browser-bundle  
source-bundle

回复纯文本的tor-browser-bundle，会收到邮件附件。

  

3. 再安装libevent

sudo apt-get install tor

下列的软件包有不能满足的依赖关系：  
tor: 依赖: libevent1 (>= 1.1a) 但却无法安装它  
E: 无法安装的软件包

 

到下面的网站去找deb包下载安装。

http://packages.ubuntu.com/zh-cn/jaunty/libevent1  
http://mirror.lupaworld.com/ubuntu/pool/main/libe/libevent/libevent1_1.3e-3_i386.deb

 

4.安装tor

sudo apt-get install tor privoxy

...

将会安装下列额外的软件包：  
libreadline5 socat tor-geoipdb tsocks  
建议安装的软件包：  
mixmaster mixminion anon-proxy  
下列【新】软件包将被安装：  
libreadline5 socat tor tor-geoipdb tsocks  
共升级了 0 个软件包，新安装了 5 个软件包，要卸载 0 个软件包，有 12 个软件未被升级。  
需要下载 2,157kB/2,941kB 的软件包。  
解压缩后会消耗掉 7,447kB 的额外空间。

...

5. 配置privoxy

sudo vi /etc/privoxy/config

在最后添加

forward-socks4a / localhost:9050 .

（注意后面的点）

重启privoxy

 

6.安装tor的图形界面vidalia

sudo apt-get install vidalia

安装完成会在“应用程序->internet->vidalia”里。

但直接启动不能连上代理。

 

7. 给torproject 发邮件获取桥

给

### bridges@torproject.org

发邮件，题目和内容都为纯文本的“ get bridges".

没多久会收到一封回信，如

[This is an automated message; please do not reply.]  
  
Here are your bridge relays:  
  


bridge [119.183.58.58:443](http://119.183.58.58:443/)

bridge [87.236.26.59:443](http://87.236.26.59:443/)   


bridge [79.226.183.104:443](http://79.226.183.104:443/)

 

8. 在validia中，点"设定->网络"，选择我的ISP阻挡了对Tor的连接，然后在下面将邮件里面的数据一条条复制进去。只需IP:端口。

 

9. 在validia中，点启动tor，会成功。

 

10. 可以通过torbutton切换是否使用tor，如果不使用，则可以在firefox的代理配置中配localhost:5050. 或配成privoxy的8118端口。

 

11. 可以访问被封网站了。

					

  


  
  


![](http://img.zemanta.com/pixy.gif?x-id=83f1c506-eac7-8ba1-bb2d-d2ffadcd427b)
