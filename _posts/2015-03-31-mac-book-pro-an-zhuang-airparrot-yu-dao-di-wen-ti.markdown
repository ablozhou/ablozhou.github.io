---
author: abloz
comments: true
date: 2015-03-31 14:29:12+00:00
layout: post
link: http://abloz.com/index.php/2015/03/31/mac-book-pro-an-zhuang-airparrot-yu-dao-di-wen-ti/
slug: mac-book-pro-an-zhuang-airparrot-yu-dao-di-wen-ti
title: mac book pro 安装airparrot遇到的问题
wordpress_id: 2267
categories:
- 技术
---

周海汉 2015.3.31 前两天升级到100MB宽带，运营商送个大麦盒子。看到它还支持airplay，就想测试一下。结果证明airplay支持的格式非常有限，只测试成功mov和jpg图片，其余rmvb和mkv格式都不支持，还不如直接插hdmi线方便。 测试时安装了air Parrot，装了该程序后又自动为我安装了airplay的驱动，并且告诉我重启。我重启后操作系统直接黑屏起不来，提示：


no bootable device




—insert boot disk and press any key







按alt+电源键几秒钟，让选启动方式，选了ssd启动，才重新进入操作系统。







但后面发现mac book没声音了，重启系统也没声音，插耳机也没有。 网上说air parrot的驱动有问题，导致mac book没有声音。







进入~  cd /System/Library/Extensions/




找到刚安装的驱动：




➜ Extensions ls -alt total 0




drwxr-xr-x 236 root wheel 8024 3 28 08:01 . drwxr-xr-x@ 3 root wheel 102 3 28 08:01 APExtFramebuffer.kext drwxr-xr-x@ 3 root wheel 102 3 28 08:01 AirParrotDriver.kext drwxr-xr-x 79 root wheel 2686 3 25 17:42 .. drwxr-xr-x 6 root wheel 204 3 25 17:42 System.kext drwxr-xr-x 6 root wheel 204 3 8 23:02 AppleBacklightExpert.kext drwxr-xr-x 6 root wheel 204 3 8 23:02 AudioAUUC.kext




3月28日就两个文件：APExtFramebuffer.kext  AirParrotDriver.kext




将其删除重启




➜  Extensions




sudo rm -rf APExtFramebuffer.kext AirParrotDriver.kext




清除驱动缓存




rm -rf /System/Library/Extensions.mkext




rm -rf /System/Library/Extensions.kextcache




sudo rm -R /System/Library/Caches/com.apple.kext.caches







重启




如声音没恢复，在系统偏好设置里，声音，选“内置扬声器”，不要选airparrot，并确认没有选静音即可。




如重启还是出现黑屏，则alt+电源进入系统后，在系统偏好设置里，选“启动磁盘”，点选“macintosh HD”，再重启。




参考：




http://gotoanswer.com/?q=AirParrot+audio+problems
