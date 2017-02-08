---
author: abloz
comments: true
date: 2012-05-18 03:37:24+00:00
layout: post
link: http://abloz.com/index.php/2012/05/18/samsung-galaxy-s2-hd-lte-brick-in-mind/
slug: samsung-galaxy-s2-hd-lte-brick-in-mind
title: 三星galaxy s2 HD LTE变砖记
wordpress_id: 1574
categories:
- 技术
---

来源：abloz.com
作者：ablo zhou
日期：2012.5.16

到手一部三星galaxy s2 HD LTE，原系统是android 2.3。因为手机是三星韩国版，型号是E120L，里面的界面有中文，有英文，有韩文，用起来感觉很不好，想将其直接升级成中文的android 4.0. 开始没了解galaxy SII(i9100)和galaxy SII HD LTE的区别，下了个i9100的ICS android 4.0 rom包QUENS_I9100_XXLPQ_CHS，用Odin3 v1.85往手机中刷pda，结果刷了一点就报failed。
我的做法是标准做法，关闭手机，用音量减+home+电源键3键组合，进入一个韩文的警告页面，下面是一个黄色叹号三角图标。再按音量加键，进入到一个绿色的android机器人界面，这就是传说中的挖煤界面(不过这个没有挖煤)，download模式。不过，机器人下面的字写的是韩语，大概是"下载中"。左上角写着odin mode....
然后用odin 程序启动，发现了com 连接，点start，一会儿报失败。再刷，一直失败。

机器重启，进入不了机器人界面了。只能进odin mode，显示“手机，黄色叹号，电脑”，如图：
[![自动重启出错界面](http://abloz.com/wp-content/uploads/2012/05/IMG_20120515_151509.jpg)](http://abloz.com/wp-content/uploads/2012/05/IMG_20120515_151509.jpg)

用挖煤神器重启，进入factory mode，图形还是“手机，黄色叹号，电脑”，无法进入机器人download模式。
在电脑中用adb，连接不上，不能发现设备。odin能连上，但刷还是会失败。eclipse ddms 显示  DeviceMonitor
Adb connection Error:远程主机强迫关闭了一个现有的连接。
系统关机后会自动重启进入odin mode，显示“手机，黄色叹号，电脑”。kies连接则一直在连接中。

找到购买的地方，人家说，你这已经变砖，自己刷机刷坏的不保。如果要维修，需要邮寄手机，费用300元。具体方法保密，但不用返厂。其实就是用JTAG方法，重置设备启动。

淘宝上也有专门教人刷机的，有贵的有便宜的。贵的四五百元，需邮寄。便宜的数十元，远程操作。找了一家，写着E120L，结果一问，说E120L变砖解决不了。

让人束手无策啊。
不过，唯一的信心是，前人说了，只要没有黑屏，就还不是砖。翻了http://www.xda-developers.com/上很多帖子，E120L也没有专区，所以问题和表现，解决办法也不完全一样。安智论坛，机锋论坛等看了很多帖子，好像都不解决问题。用了oneclick (https://code.google.com/p/heimdall-one-click/)刷机，开始执行不起来，经解决执行后也报错。
http://techie-blog.blogspot.com/2010/11/how-i-unbricked-my-samsung-galaxy-s.html 这是一位用三星i9100 kies升级失败变砖的国外用户，解决变砖过程的文章，很有参考意义。他还自制挖煤神器，什么用301k电阻，连接扁口usb线4，5脚。其实我买的时候已经送了一个挖煤器。只是使用的方式不是很清楚。为什么用挖煤器没有进入机器人界面呢？

后面，试着下载了E120L的rom，http://dl.dbank.com/c0ha2bfjqc，GFAN_Quenz_E120L_CHS.rar。用挖煤神器进入factory mode模式，尽管没有显示机器人和download，而是显示“手机 叹号 PC”，还是用odin 1.8.5刷了一下，结果居然成功了(该压缩包的短信发送功能不能用)!

所以最大的误会就是factory mode 就是所谓的挖煤界面，可以刷机的。当然，手上得有可用的刷机rom，目前E120L 还没有ICS的版本支持，所以只能刷android 2.3的中文汉化版本。
