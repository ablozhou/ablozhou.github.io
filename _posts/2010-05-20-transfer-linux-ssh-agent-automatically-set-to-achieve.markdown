---
author: abloz
comments: true
date: 2010-05-20 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/05/20/transfer-linux-ssh-agent-automatically-set-to-achieve/
slug: transfer-linux-ssh-agent-automatically-set-to-achieve
title: '[转]Linux下实现自动设置SSH代理'
wordpress_id: 1228
categories:
- 技术
---

作者：byvoid，他基于ibus开发了台湾注音输入法  
  
原文 : http://www.byvoid.com/blog/linux-ssh-wall/#comment-4057  
  
SSH的巨大价值体现在能够配置为代理服务器上。不像在Windows下每次还需要手动登录设置，Linux有很好的工具链能够实现自动设置SSH 代理，就是expect和ssh的联合使用，再加上proxychains，任何程序都可以享用代理了，在此我简单介绍一下。  
  
首先要安装expect和openssh，如果没有，Ubuntu下输入apt-get install expect openssh-client即可安装。接下来需要写一段脚本：  
  
#!/usr/bin/expect  
set timeout 60  
spawn / usr/ bin/  
ssh -D 本地端口 -g 用户名@ 服务器  
  
expect {  
"password:"  
{  
send "密码r "  
}  
  
}  
  
interact {  
timeout 60  
{  
send " "  
}  
  
}  
  
把上面的中文替换成对应内容，保存为一个脚本文件，例如sshproxy.sh，然后给它执行权限，chmod +x sshproxy.sh。在终端下运行./sshproxy.sh，就会发现自动登录到了服务器上，而且在本地建立了一个socks5代理。而且使用这段脚本还不用担心会被踢，因为每60秒都要发送一个空格表示还在活动。如果把sshproxy.sh放到自动启动，那么以后每次启动都可以自动建立代理了。  
  
这种方法建立的代理是socks5代理，在浏览器中很容易配置使用，但如果其他程序也想用它，而没有代理功能，该怎么办呢？在Windows下面的确不好办（需要各种付费的、不稳定的代理转换工具），而在Linux下一切很简单，只需要一个名叫proxychains的工具。Ubuntu安装方法为 apt-get install proxychains。安装完以后要设置/etc/proxychains.conf文件，删除[ProxyList]后面的内容，然后添加  
  
socks5 127.0.0.1 端口  
  
把“端口”替换为SSH代理设置的端口。然后在想要运行的程序前加上proxychains ，即可使用代理。例如输入proxychains wget http://www.youtube.com -r，即可给wget设置SSH代理去下载。  
  
正如其名，实际上proxychains是个代理链，我们可以设置多个代理，实现多级跳板连接。用在SSH代理上实在是大才小用了。  
  
  


![](http://img.zemanta.com/pixy.gif?x-id=9f2b2535-7106-8e1a-905a-aecdc50fca50)
