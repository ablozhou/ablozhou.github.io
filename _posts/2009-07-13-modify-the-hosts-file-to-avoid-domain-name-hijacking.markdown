---
author: abloz
comments: true
date: 2009-07-13 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/07/13/modify-the-hosts-file-to-avoid-domain-name-hijacking/
slug: modify-the-hosts-file-to-avoid-domain-name-hijacking
title: 修改hosts文件规避域名劫持
wordpress_id: 921
categories:
- 技术
---

将下列代码保存为hosts.bat,双击执行。可访问twitter,google,youtube等网站。

    
    
    attrib %windir%SYSTEM32driversetchosts -r
    
    echo #Twitter
    echo 128.121.146.228 twitter.com   >> %windir%SYSTEM32driversetchosts
    echo 128.121.146.228 www.twitter.com   >> %windir%SYSTEM32driversetchosts
    echo 128.121.146.101 assets0.twitter.com  >> %windir%SYSTEM32driversetchosts
    echo 128.121.146.101 assets1.twitter.com  >> %windir%SYSTEM32driversetchosts
    echo 128.121.146.101 static.twitter.com   >> %windir%SYSTEM32driversetchosts
    echo 128.121.146.229 assets2.twitter.com  >> %windir%SYSTEM32driversetchosts
    echo 128.121.146.229 assets3.twitter.com  >> %windir%SYSTEM32driversetchosts
    echo 65.74.185.41 twitter.zendesk.com    >> %windir%SYSTEM32driversetchosts
    echo 65.74.185.41 help.twitter.com>> %windir%SYSTEM32driversetchosts
    
    echo #Google >> %windir%SYSTEM32driversetchosts
    echo 74.125.45.100 google.com>> %windir%SYSTEM32driversetchosts
    echo 64.233.161.147 www.google.c >> %windir%SYSTEM32driversetchostsom
    echo 66.102.1.103 www.l.google.co >> %windir%SYSTEM32driversetchostsm
    echo 66.102.1.83 mail.google.com >> %windir%SYSTEM32driversetchosts
    echo 72.14.247.111 pop.gmail.com>> %windir%SYSTEM32driversetchosts
    echo 74.125.93.111 smtp.gmail.co>> %windir%SYSTEM32driversetchostsm
    echo 64.233.169.17 googlemail.l.go >> %windir%SYSTEM32driversetchostsogle.com
    echo 74.125.93.101 books.google.c >> %windir%SYSTEM32driversetchostsom
    echo 74.125.113.101 docs.google.c>> %windir%SYSTEM32driversetchostsom
    echo 74.125.113.101 spreadsheets >> %windir%SYSTEM32driversetchosts.google.com
    echo 74.125.93.99 news.google.co >> %windir%SYSTEM32driversetchostsm
    echo 74.125.91.136 picasaweb.goo >> %windir%SYSTEM32driversetchostsgle.com
    echo 64.233.161.147 map.google.com>> %windir%SYSTEM32driversetchosts
    echo 74.125.93.136 khm.google.com>> %windir%SYSTEM32driversetchosts
    echo 64.233.161.190 mt0.google.com >> %windir%SYSTEM32driversetchosts
    echo 64.233.161.136 mt1.google.com >> %windir%SYSTEM32driversetchosts
    echo 209.85.225.136 mt2.google.com>> %windir%SYSTEM32driversetchosts
    echo 64.233.161.93 mt.l.google.com >> %windir%SYSTEM32driversetchosts
    echo 64.233.161.104 maps.l.google.co >> %windir%SYSTEM32driversetchostsm
    echo 74.125.113.147 scholar.google.c >> %windir%SYSTEM32driversetchostsom
    echo 74.125.93.102 groups.google.com>> %windir%SYSTEM32driversetchosts
    echo 74.125.91.113 groups.l.google.co>> %windir%SYSTEM32driversetchostsm
    echo 74.125.93.102 id.google.com >> %windir%SYSTEM32driversetchosts
    echo 74.125.93.102 id.l.google.com >> %windir%SYSTEM32driversetchosts
    
    echo #Wiki >> %windir%SYSTEM32driversetchosts
    echo 208.80.152.2 wikipedia.org >> %windir%SYSTEM32driversetchosts
    echo 208.80.152.2 www.wikipedia.org>> %windir%SYSTEM32driversetchosts
    echo 208.80.152.2 en.wikipedia.org>> %windir%SYSTEM32driversetchosts
    echo 208.80.152.2 zh.wikipedia.org >> %windir%SYSTEM32driversetchosts
    
    echo #YouTube >> %windir%SYSTEM32driversetchosts
    echo 203.208.39.104 www.youtube.co >> %windir%SYSTEM32driversetchostsm
    echo 203.208.33.100 gdata.youtube.c >> %windir%SYSTEM32driversetchostsom
    echo 203.208.39.99 upload.youtube.com>> %windir%SYSTEM32driversetchosts
    echo 203.208.39.99 insight.youtube.com>> %windir%SYSTEM32driversetchosts
    echo 203.208.39.160 help.youtube.com >> %windir%SYSTEM32driversetchosts
    echo 203.208.39.104 youtube.com >> %windir%SYSTEM32driversetchosts
    
    echo #Facebook >> %windir%SYSTEM32driversetchosts
    echo 124.40.42.105 www.facebook.com >> %windir%SYSTEM32driversetchosts
    echo 69.63.180.173 login.facebook.com >> %windir%SYSTEM32driversetchosts
    echo 69.192.34.110 s-static.ak.facebook.com >> %windir%SYSTEM32driversetchosts
    echo 69.63.176.69 secure-profile.facebook.com >> %windir%SYSTEM32driversetchosts
    echo 69.63.176.59 secure-media-sf2p.facebook.com>> %windir%SYSTEM32driversetchosts
    echo 69.63.178.13 ssl.facebook.com>> %windir%SYSTEM32driversetchosts
    echo 96.6.122.57 profile.ak.facebook.com >> %windir%SYSTEM32driversetchosts
    echo 64.211.21.152 b.static.ak.facebook.com >> %windir%SYSTEM32driversetchosts
    
    

  
  


![](http://img.zemanta.com/pixy.gif?x-id=2f7b959d-4d42-8f2d-9986-0c9e37117272)
