---
author: abloz
comments: true
date: 2011-08-01 09:58:51+00:00
layout: post
link: http://abloz.com/index.php/2011/08/01/new-way-through-the-wall/
slug: new-way-through-the-wall
title: 新穿墙方式
wordpress_id: 1313
categories:
- 技术
---

据外电报道，一种新的反互联网审查方式在美国密歇根大学诞生，并取名叫telex 反互联网审查系统。与以往代理和隧道方式不同，这种穿墙方式没有代理主机IP。

代理和隧道方式，必须在墙外有一个服务器来代理。但该服务器IP容易被审查系统发现并屏蔽。而新的方式，根本没有代理IP。用户需安装一个客户端。当用户访问一个被屏蔽的网站，客户端会采用https的方式，访问一个合法没有被屏蔽的网站。审查系统看到的是访问合法网站。但协议头里面添加真正的Telex工作站公钥加密的目标地址。另一头，需部署Telex 工作站，就是路由器。这种路由器看到由其公钥加密的协议后，用私钥解密出真正的目标地址，再用境外代理获取内容。

据该实验室人员说，目前该技术还是测试阶段，已经成功从中国破墙而出，访问被屏蔽网站。

虽然这是一种聪明的方法，但困难的地方是，这些路由器需部署在大的ISP的主干路由上。而ISP并没有任何动力来做这件事。另外，如果政府审查系统也部署冒充的Telex工作站，就还是可能屏蔽访问。还有，政府可以在其路由器中禁止其不能解密的https访问。

[![](http://abloz.com/wp-content/uploads/2011/08/telex-threat.png)](http://abloz.com/wp-content/uploads/2011/08/telex-threat.png)





[![](http://abloz.com/wp-content/uploads/2011/08/telex-clients.png)](http://abloz.com/wp-content/uploads/2011/08/telex-clients.png)

[![](http://abloz.com/wp-content/uploads/2011/08/telex-station.png)](http://abloz.com/wp-content/uploads/2011/08/telex-station.png)

下载：

**源码：[telex-client-0.0.1_src.tar.gz](https://telex.cc/pub/telex-client-0.0.1_src_public.tar.gz)**

Windows二进制:
**[telex-client-0.0.1_win32.zip](https://telex.cc/pub/telex-client-0.0.1_win32_public.zip)**



代码库：[Git repository](https://github.com/ewust/telex)

参考：[https://telex.cc/](https://telex.cc/)












