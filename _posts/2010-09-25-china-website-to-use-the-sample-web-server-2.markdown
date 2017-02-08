---
author: abloz
comments: true
date: 2010-09-25 09:55:45+00:00
layout: post
link: http://abloz.com/index.php/2010/09/25/china-website-to-use-the-sample-web-server-2/
slug: china-website-to-use-the-sample-web-server-2
title: 中国网站使用web server抽样统计
wordpress_id: 407
categories:
- 技术
tags:
- web服务器
---

周海汉 2010.9.25
http://abloz.com
本文对中国网站所使用的web服务器软件进行抽样调查。以得出当前apache,Microsoft iis, nginx和其他web服务器的市场占有率。
抽样代码如下，将python代码保存为testserver.py：


    
    
    #!/usr/bin/env  python
    #--coding:utf8--
    #author: zhouhh
    #date: 2010.9.25
    #python to test http server type
    
    import httplib
    
    servers=open("slist.txt").read().splitlines()
    stdict = {}
    
    for s in servers:
    	c = httplib.HTTPConnection(s)
    	c.request('HEAD','/')
    	res = c.getresponse()
    	hs = res.getheaders()
    	try:
    		stype = [h[1] for h in hs if h[0]=='server']
    		stdict[s]=str(stype[0])
    		print '%st%s' % (s,stdict[s])
    	except IndexError:
    		print '%s index error' % s
    
    
    


服务器样本，slist.txt

    
    
    www.abloz.com
    www.126.com
    www.13139.com
    www.155.com
    mail.163.com
    www.163.com
    www.17173.com
    www.21cn.com
    www.263.com
    www.3158.cn
    www.3533.com
    www.3839.com
    www.39.net
    www.4399.net
    www.51.com
    www.51job.com
    www.5460.net
    www.56.com
    www.91.cn
    www.abchina.com
    www.autohome.com.cn
    www.avl.com.cn
    baike.baidu.com
    dict.baidu.com
    file.baidu.com
    geci.baidu.com
    hi.baidu.com
    image.baidu.com
    mp3.baidu.com
    news.baidu.com
    post.baidu.com
    video.baidu.com
    www.baidu.com
    zhidao.baidu.com
    www.bankcomm.com
    www.bbc.co.uk
    www.boc.cn
    www.bokee.com
    www.bullogger.com
    www.cca.org.cn
    www.ccb.com
    sports.cctv.com
    www.cctv.com
    www.cheshi.com.cn
    military.china.com
    www.china.com
    www.chinagames.net
    www.chinamobile.com
    www.chinanews.com.cn
    www.chinaren.com
    www.chinaunix.net
    www.cjol.com
    www.cmbchina.com
    www.cmfu.com
    www.cnfol.com
    www.cntv.cn
    www.crsky.com
    www.csdn.net
    www.ctrip.com
    www.cyol.net
    www.dianping.com
    www.digg.com
    www.dopod.com
    www.douban.com
    www.duba.net
    www.eastmoney.com
    www.espnstar.com.cn
    www.f130.net
    www.facebook.com
    www.flash8.net
    house.focus.cn
    www.gdb.com.cn
    sz.gd.vnet.cn
    www.google.cn
    www.google.com.hk
    ditu.google.com
    gmail.google.com
    www.google.com
    www.gznet.com
    www.hao123.com
    www.hexun.com
    www.hongxiu.com
    www.hotmail.com
    www.hunantv.com
    www.icbc.com.cn
    www.ifeng.com
    www.imobile.com.cn
    www.jrj.com.cn
    www.kaixin001.com
    www.kdnet.net
    www.ku6.com
    www.lenovomobile.com
    spaces.live.com
    www.love21cn.com
    cn.mail.yahoo.com
    www.matesay.cn
    www.mop.com
    www.motorola.com.cn
    cartoon.msn.com.cn
    love21cn.msn.com.cn
    cn.msn.com
    www.myspace.com
    china.nba.com
    jczs.news.sina.com.cn
    www.no5.com.cn
    www.onlinedown.net
    www.online.sh.cn
    www.openv.tv
    www.ourgame.com
    www.pcauto.com.cn
    www.pcgames.com.cn
    www.pconline.com.cn
    pop.pcpop.com
    www.people.com.cn
    www.pumch.ac.cn
    www.python.org
    mil.qianlong.com
    www.qq163.com
    qzone.qq.com
    www.qq.com
    www.qunar.com
    www.readnovel.com
    www.renren.com
    www.rising.com.cn
    www.rongshuxia.com
    www.samsung.com.cn
    www.sg.com.cn
    auto.sina.com.cn
    blog.sina.com.cn
    finance.sina.com.cn
    games.sina.com.cn
    mail.sina.com.cn
    news.sina.com.cn
    sports.sina.com.cn
    tech.sina.com.cn
    www.sina.com.cn
    www.sina.com
    www.skycn.com
    www.sogou.com
    business.sohu.com
    club.sohu.com
    health.sohu.com
    news.sohu.com
    sports.sohu.com
    www.sohu.com
    www.sonyericsson.com.cn
    www.stockstar.com
    www.taobao.com
    www.tianya.cn
    www.tiexue.net
    hjsm.tom.com
    mail.tom.com
    sports.tom.com
    www.tom.com
    www.tudou.com
    www.u688.com
    www.virtualshoemuseum.com
    www.wuhan.net.cn
    www.xcar.com.cn
    www.xiaoyouxi.com
    www.xici.net
    www.xinhuanet.com
    www.xxsy.net
    www.xyxy.net
    www.yahoo.cn
    www.yahoo.com
    www.younet.com
    www.yymp3.com
    www.zaobao.com
    www.zhaopin.com
    www.zhcw.com
    download.zol.com.cn
    mobile.zol.com.cn
    


执行./testserver.py
排除超时等错误，执行完的结果如下：

    
    
    www.yahoo.cn	4EWS
    baike.baidu.com	Apache
    business.sohu.com	Apache
    china.nba.com	Apache
    dict.baidu.com	Apache
    download.zol.com.cn	Apache
    health.sohu.com	Apache
    image.baidu.com	Apache
    mail.163.com	Apache
    mobile.zol.com.cn	Apache
    news.baidu.com	Apache
    news.sohu.com	Apache
    qzone.qq.com	Apache
    sports.sohu.com	Apache
    sports.tom.com	Apache
    www.126.com	Apache
    www.17173.com	Apache
    www.51.com	Apache
    www.abloz.com	Apache
    www.bbc.co.uk	Apache
    www.ccb.com	Apache
    www.chinamobile.com	Apache
    www.chinaren.com	Apache
    www.chinaunix.net	Apache
    www.digg.com	Apache
    www.kaixin001.com	Apache
    www.ku6.com	Apache
    www.skycn.com	Apache
    www.sogou.com	Apache
    www.sohu.com	Apache
    www.taobao.com	Apache
    www.tom.com	Apache
    www.tudou.com	Apache
    www.xcar.com.cn	Apache
    www.xinhuanet.com	Apache
    www.zaobao.com	Apache
    www.zhaopin.com	Apache
    zhidao.baidu.com	Apache
    hi.baidu.com	apache 1.1.26.0
    house.focus.cn	Apache/1.3.31 (Fedora)
    www.bokee.com	Apache/1.3.31 (Unix) mod_gzip/1.3.26.1a
    geci.baidu.com	apache 1.6.14.0
    mp3.baidu.com	apache 1.6.14.0
    www.avl.com.cn	Apache/2.0.53 (Unix)
    games.sina.com.cn	Apache/2.0.54 (Unix)
    www.sina.com.cn	Apache/2.0.54 (Unix)
    club.sohu.com	Apache/2.0.55 (Unix)
    www.online.sh.cn	Apache/2.0.55 (Unix)
    www.duba.net	Apache/2.0.55 (Unix) DAV/2 PHP/5.2.4
    finance.sina.com.cn	Apache/2.0.59 (Unix)
    hjsm.tom.com	Apache/2.2.10 (Unix) PHP/5.2.9
    www.zhcw.com	Apache/2.2.11 (Unix) DAV/2
    www.xyxy.net	Apache/2.2.11 (Unix) DAV/2 PHP/5.2.9
    www.cyol.net	Apache/2.2.13 (Unix)
    auto.sina.com.cn	Apache/2.2.15 (Unix)
    jczs.news.sina.com.cn	Apache/2.2.15 (Unix)
    news.sina.com.cn	Apache/2.2.15 (Unix)
    sports.sina.com.cn	Apache/2.2.15 (Unix)
    tech.sina.com.cn	Apache/2.2.15 (Unix)
    www.gznet.com	Apache/2.2.15 (Unix) DAV/2
    mail.tom.com	Apache/2.2.15 (Unix) mod_ssl/2.2.15 OpenSSL/0.9.7e DAV/2
    www.younet.com	Apache/2.2.4 (Unix) DAV/2 PHP/4.4.7
    www.cnfol.com	Apache/2.2.6 (Unix)
    www.51job.com	Apache/2.2.8 (Unix) PHP/5.2.5
    www.python.org	Apache/2.2.9 (Debian) DAV/2 SVN/1.5.1 mod_ssl/2.2.9 OpenSSL/0.9.8g mod_wsgi/2.5 Python/2.5.2
    mail.sina.com.cn	Apache/2.2.9 (FreeBSD) mod_ssl/2.2.9 OpenSSL/0.9.7e-p1 PHP/5.2.6 with Suhosin-Patch
    sz.gd.vnet.cn	Apache/2.2.9 (Unix)
    post.baidu.com	apache 2.7.18.0
    www.5460.net	Apache-Coyote/1.1
    www.cca.org.cn	Apache-Coyote/1.1
    www.sonyericsson.com.cn	Apache-Coyote/1.1
    cartoon.msn.com.cn	BigIP
    file.baidu.com	BWS/1.0
    www.baidu.com	BWS/1.0
    sports.cctv.com	CCTV.com_webserver/1.0
    www.cctv.com	CCTV.com_webserver/1.0
    www.cntv.cn	CCTV.com_webserver/1.0
    www.chinanews.com.cn	CWS/1.0
    www.espnstar.com.cn	DnionOS/1.0
    www.readnovel.com	DnionOS/1.0
    www.mop.com	dx136
    gmail.google.com	GSE
    www.google.com	gws
    www.google.com.hk	gws
    www.bankcomm.com	IBM_HTTP_SERVER
    video.baidu.com	lighttpd
    www.hao123.com	lighttpd
    ditu.google.com	mfe
    www.virtualshoemuseum.com	Microsoft-IIS/5.0
    cn.msn.com	Microsoft-IIS/6.0
    mil.qianlong.com	Microsoft-IIS/6.0
    pop.pcpop.com	Microsoft-IIS/6.0
    www.13139.com	Microsoft-IIS/6.0
    www.263.com	Microsoft-IIS/6.0
    www.3533.com	Microsoft-IIS/6.0
    www.4399.net	Microsoft-IIS/6.0
    www.91.cn	Microsoft-IIS/6.0
    www.bullogger.com	Microsoft-IIS/6.0
    www.chinagames.net	Microsoft-IIS/6.0
    www.cjol.com	Microsoft-IIS/6.0
    www.cmfu.com	Microsoft-IIS/6.0
    www.crsky.com	Microsoft-IIS/6.0
    www.ctrip.com	Microsoft-IIS/6.0
    www.dopod.com	Microsoft-IIS/6.0
    www.eastmoney.com	Microsoft-IIS/6.0
    www.f130.net	Microsoft-IIS/6.0
    www.flash8.net	Microsoft-IIS/6.0
    www.hongxiu.com	Microsoft-IIS/6.0
    www.hotmail.com	Microsoft-IIS/6.0
    www.icbc.com.cn	Microsoft-IIS/6.0
    www.lenovomobile.com	Microsoft-IIS/6.0
    www.matesay.cn	Microsoft-IIS/6.0
    www.motorola.com.cn	Microsoft-IIS/6.0
    www.no5.com.cn	Microsoft-IIS/6.0
    www.onlinedown.net	Microsoft-IIS/6.0
    www.ourgame.com	Microsoft-IIS/6.0
    www.pumch.ac.cn	Microsoft-IIS/6.0
    www.qq163.com	Microsoft-IIS/6.0
    www.rising.com.cn	Microsoft-IIS/6.0
    www.sg.com.cn	Microsoft-IIS/6.0
    www.tianya.cn	Microsoft-IIS/6.0
    www.tiexue.net	Microsoft-IIS/6.0
    www.xici.net	Microsoft-IIS/6.0
    www.xxsy.net	Microsoft-IIS/6.0
    spaces.live.com	Microsoft-IIS/7.0
    www.boc.cn	Microsoft-IIS/7.0
    www.kdnet.net	Microsoft-IIS/7.0
    www.yymp3.com	Microsoft-IIS/7.0
    www.autohome.com.cn	Microsoft-IIS/7.5
    www.myspace.com	Microsoft-IIS/7.5
    www.abchina.com	Microsoft-IIS/7.5, M2
    www.wuhan.net.cn	Netscape-Enterprise/4.0
    love21cn.msn.com.cn	nginx
    www.163.com	nginx
    www.56.com	nginx
    www.cheshi.com.cn	nginx
    www.dianping.com	nginx
    www.douban.com	nginx
    www.hexun.com	nginx
    www.love21cn.com	nginx
    www.pcauto.com.cn	nginx
    www.pcgames.com.cn	nginx
    www.pconline.com.cn	nginx
    www.people.com.cn	nginx
    www.hunantv.com	nginx/0.6.36
    www.qq.com	nginx/0.6.39
    www.rongshuxia.com	nginx/0.7.30
    www.21cn.com	nginx/0.7.59
    www.stockstar.com	nginx/0.7.59
    blog.sina.com.cn	nginx/0.7.62
    www.155.com	nginx/0.7.62
    military.china.com	nginx/0.7.63
    www.china.com	nginx/0.7.63
    www.qunar.com	nginx/0.7.64
    www.3839.com	nginx/0.7.65
    www.csdn.net	nginx/0.7.65
    www.openv.tv	nginx/0.7.67
    www.ifeng.com	nginx/0.8.32
    www.renren.com	nginx/0.8.44
    www.imobile.com.cn	nginx/0.8.49
    www.sina.com	nginx/0.8.50
    www.u688.com	Oversee Turing v1.0.0
    www.3158.cn	PowerCDN/2.0
    www.google.cn	sffe
    www.39.net	squid
    cn.mail.yahoo.com	unknown
    www.cmbchina.com	unknown
    www.facebook.com	unknown
    www.gdb.com.cn	unknown
    www.jrj.com.cn	unknown
    www.samsung.com.cn	unknown
    www.xiaoyouxi.com	unknown
    www.yahoo.com	YTS/1.18.5
    



从以上结果可以看出，一共173个服务器（剔除了twitter.com,youtube.com等访问失败的）。apache占70个，占百分比40.5%， Microsoft IIS占43个，约占24.9%, nginx 29个，占16.8%。
相较[2007年的一个统计](http://www.cnblogs.com/midea0978/archive/2007/03/17/678322.html)，apache和IIS的市场占有率都下降了。而nginx有较大的提升。lighthttpd只有两个。百度用自己的webserver，BWS——baidu web server.据研究是基于thttpd的。谷歌是GWS,Google web server.
