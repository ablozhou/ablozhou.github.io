---
author: abloz
comments: true
date: 2016-01-29 15:54:39+00:00
layout: post
link: http://abloz.com/index.php/2016/01/29/jenkins-does-not-display-statistics/
slug: jenkins-does-not-display-statistics
title: jenkins不显示统计图
wordpress_id: 2724
categories:
- 技术
tags:
- jinkens
---

jenkins不显示统计图


java.lang.NoClassDefFoundError: _Could_ _not_ _initialize_ _class_ _org_._jfree.chart_._JFreeChart_







Somebody helped me to solve it here : https://groups.google.com/forum/#!topic/jenkinsci-users/o_Dr7Tn0i3U




It's not a bug in Jenkins but a miss-configuration. Anyway I couldn't find it in any knowledge base. Maybe adding this solution in JIRA is enough ... but let me suggest you to try to add it somewhere in plugin's documentation, for example on "Configuration" section found here https://wiki.jenkins-ci.org/display/JENKINS/Performance+Plugin




The solution is just adding




-Djava.awt.headless=true




I'm running Jenkins as a webapp on my Tomcat, so I just added this line to my /opt/tomcat/bin/catalina.sh :




CATALINA_OPTS=-Djava.awt.headless=true







Headless模式是系统的一种配置模式。在该模式下，系统缺少了显示设备、键盘或鼠标。Headless模式虽然不是我们愿意见到的，但事实上我们却常常需要在该模式下工作，尤其是服务器端程序开发者。因为服务器（如提供Web服务的主机）往往可能缺少前述设备，但又需要使用他们提供的功能，生成相应的数据，以提供给客户端（如浏览器所在的配有相关的显示设备、键盘和鼠标的主机）。
