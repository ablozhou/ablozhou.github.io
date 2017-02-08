---
author: abloz
comments: true
date: 2009-11-06 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/11/06/instead-of-using-u-disk-to-install-ubuntu-cd/
slug: instead-of-using-u-disk-to-install-ubuntu-cd
title: 用U盘代替CD安装ubuntu
wordpress_id: 939
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

09.11.6

 

有人说未来光驱都用不着了。蓝光高清格式刚刚战胜了hddvd格式，还来不及庆祝胜利，马上就面临光驱将要被淘汰的命运。因为随着网络带宽的增加， 移动3G / 4G的普及，随着硬盘和U  盘容量的迅速增加，动辄一两百元一张高价的几十G的光盘存储越来越像鸡肋。上次参加通信展，看到一款直接连接网络的“DVD”家用播放器，那么未来家庭环 境还用得着摆一款蓝光DVD吗？ 有高速的宽带和大容量的可移动的硬盘，或直接配HDPC，还用得着费尽心思去买高价光盘？

 

光盘消失有点不可思议。就像以前软驱是电脑必备，没有了软驱系统就没法安装，没法恢复。我当时都没法想象没有软驱的日子，还以为是装机的奸商为了节 省成本，不给人配的。可是随后的日子证明，没有软驱照样活得很好。需要共享内容时，小容量拷贝可以用U 盘，大一点的可以用网络，或者直接刻录DVD。

 

如果没有DVD，操作系统怎么安装呢？软件怎么分发呢？网络什么至少都是有操作系统之后才能用的吧？

 

现在的硬件系统，大多支持了U盘启动。比如我03年的IBM thinkpad T40，居然也支持U盘启动。那时从没想到U盘可以用于安装操作系统呢。而我的DVD 光驱还老罢工，我也不愿意去刻张盘，浪费2.5元和大把时间。

 

最近买了个4G U盘，才花了65元。8G的U盘，也才100来块了。想试一下U盘安装移动的操作系统。 

 

1. U盘livecd 启动盘 

 

如果只是livecd拷贝，可以用新版的ultraiso，打开ubuntu的iso后，点启动菜单的“写入硬盘映像”。但这种方式系统会认为这是一个cd，所以是不能写的，配置都不能保存。 

 

![uiso](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091106/uiso.PNG)

刻录时选usb-hdd+, 据说usb-hdd+可以让支持usb-zip 和 usb-hdd的保持启动兼容。

![uiso1](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091106/uiso1.PNG)

 

我在T40 的bios里设置 USB-HDD启动，但奇怪的是，作为livecd和直接用U盘安装，都会一段时间后报读取错误或进入一直等待状态。

幸好ubuntu 9.10的wubi比较厉害，在windows下可以选 livecd  安装，然后选“光驱不能正确引导，需要帮助”，这样，wubi会自动用windows来引导。需要在windows的启动项里面设置一下等待时间，如5秒 钟。 重启后将U盘拔出，进入windows的启动菜单，选ubuntu项，再将U盘插入。

这种安装和CD/DVD安装一样，也需要分配空间，选择安装区。

![i](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091109/Screenshot-%E5%AE%89%E8%A3%85.png)

ubuntu安装也很人性化，可以以所见即所得的方式来看到硬盘分区，看到/dev/sdax对应哪个分区。

![i](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091109/Screenshot-%E5%AE%89%E8%A3%85-1.png)

如果windows系统不被删除，还可以选windows系统的用户进行导入，用户的“我的文档”，outlook的配置，浏览器的收藏都会被导入到linux下，的确省了很多事情。

![3](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091109/Screenshot-%E5%AE%89%E8%A3%85-2.png)

安装后，如《[ubuntu9.10试用](http://blog.csdn.net/ablo_zhou/archive/2009/11/04/4767824.aspx) 》一文一样，需要汉化。但如虚拟磁盘文件系统不一样，安装过程是中文的。

 

2. 移动硬盘安装   
  
如果是移动硬盘，也可以分区，然后先在一个分区复制livecd，进入livecd后安装系统到另一个分区。 

 

3. 将系统安装到U盘   
如果想安装一个真正的系统到U盘，需要用livecd引导进入，再install到U盘。   
  
对于普通U盘，没有livecd光驱的话，如果用U盘的livecd进入，是安装不了系统到U盘的。 还不知道有没有别的办法。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=59f3cf92-9fac-89d4-9647-a3d553a10731)
