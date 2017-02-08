---
author: abloz
comments: true
date: 2009-12-15 05:58:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/15/ubuntu-9-10-install-virtual-box-virtual-machine-software/
slug: ubuntu-9-10-install-virtual-box-virtual-machine-software
title: ubuntu 9.10 安装virtual box 虚拟机软件
wordpress_id: 985
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou) /文  
2009.12.15  
  
linux下不能做的一些事情，必须迁就到windows。比如 网银，炒股，淘宝支付宝，比如office。  OpenOffice可以完成日常工作。但对那种重要的文件，需要迁就提供者格式的文档，不得不在windows下用MS  office来完成。因为OOO没法和MS Office做到格式完全一致。微软自身的office不同版本都做不到完全兼容。  
  
本来可以用wine来解决一些问题，但wine还真不好用。我使用的过程中，大部分windows软件到了wine下都跑不起来。因此，为了避免反复切换操作系统，需要安装虚拟机。  
  
被选的虚拟机，一是KVM(kernel virtual machine)，一是vmware个人免费版，一个是virtual box. KVM性能最高，但据说需要CPU支持。用grep '(vmx|svm)' /proc/cpuinfo查找是否支持。  
我的CPU没有支持，所以没有安装KVM。  
vmware是著名的虚拟系统商业软件，有网友评论与virtual box功能差不多，性能virtualbox还好一点。  
于是决定采用virtualbox.  
  
1.下载安装  
官网下载：http://www.virtualbox.org/wiki/Downloads  
  
但我们不直接从官网下载，采用源安装  
sudo apt-get install virtualbox-ose vboxgtk  
其中vboxgtk是其GTK+图形配置界面。  
  
2. 配置  
安装完毕，执行  
virtualbox  
即可启动图形配置界面。  
可以新建虚拟电脑，根据提示完成配置。对虚拟硬盘，可以考虑一次分配10G，至少分配4G。对自动增长的硬盘类型，安装ghost盘时会有问题。  
光驱，可以采用硬件光驱，也可以采用虚拟的，指定一个iso文件做虚拟光驱。我采用虚拟的。  
  
3.安装操作系统

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091215/Screenshot-vxp%20%5B%E6%AD%A3%E5%9C%A8%E8%BF%90%E8%A1%8C%5D%20-%20VirtualBox%20OSE-1.png)

（这是我给老婆生日定做的一个ghost安装盘，非公开发行版。）

遇到问题：  


  1. Starting MS-DOS 7.1...
  2. QCDROM V4.2,1-14-2007.
  3. DRIVER NAME IS "PATACD01".
  4. EIDE DMA CONTROLLER AT I-O address COOOh,Chip I.D 80867010h.
  5. Unit 0:Secondary-master,VBOX CD-ROM,ATA-33.
  6. GCDROM DOS Driver V2.4,2-6-2007.
  7. Driver name is "SATACD01".
  8. NO CD-ROM drive to use;GCDROM not loaded!
  9. GCDROM DOS Driver V2.4,2-6-2007.
  10. Driver name is "SATACD02".
  11. NO CD-ROM drive to use;GCDROM not loaded!
  12. GCDROM DOS Driver V2.4,2-6-2007.
  13. Driver name is "SATACD03".
  14. NO CD-ROM drive to use;GCDROM not loaded!
  15. FATAL:int13_diskette_function:read error

Starting MS-DOS 7.1... QCDROM V4.2,1-14-2007. DRIVER NAME IS "PATACD01". EIDE DMA CONTROLLER AT I-O address COOOh,Chip I.D 80867010h. Unit 0:Secondary-master,VBOX CD-ROM,ATA-33. GCDROM DOS Driver V2.4,2-6-2007. Driver name is "SATACD01". NO CD-ROM drive to use;GCDROM not loaded! GCDROM DOS Driver V2.4,2-6-2007. Driver name is "SATACD02". NO CD-ROM drive to use;GCDROM not loaded! GCDROM DOS Driver V2.4,2-6-2007. Driver name is "SATACD03". NO CD-ROM drive to use;GCDROM not loaded! FATAL:int13_diskette_function:read error   
  
原因就在于ghost的光盘制作的时候里面就已经加入了虚拟软驱，而virtualbox没有配软驱。   
root@zhhofs:/root/.VirtualBox# touch temp.img 

配置一下虚拟软驱，指向temp.img.

选virtualbox 里的设置->System。勾上Enable ACPI, Enable IO APIC  
int13_diskette_function错误消失了。  
但直接快速ghost安装还是有问题。所以我选第二项，手工ghost。![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091215/Screenshot-vxp%20%5B%E6%AD%A3%E5%9C%A8%E8%BF%90%E8%A1%8C%5D%20-%20VirtualBox%20OSE-2.png)

 

  
![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091215/Screenshot-vxp%20%5B%E6%AD%A3%E5%9C%A8%E8%BF%90%E8%A1%8C%5D%20-%20VirtualBox%20OSE.png)   
安装完毕，即可使用windows了。

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20091215/Screenshot-vxp%20%5B%E6%AD%A3%E5%9C%A8%E8%BF%90%E8%A1%8C%5D%20-%20VirtualBox%20OSE-3.png)   
还可以安装增强功能，配置一下共享。不过，如果宿主机器有ftp，这个也可以省了。  
网络什么都无须配置，直接缺省的NAT模式就可以上网。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=caf49eac-7ced-8d6e-afc6-e87c656fbc1a)
