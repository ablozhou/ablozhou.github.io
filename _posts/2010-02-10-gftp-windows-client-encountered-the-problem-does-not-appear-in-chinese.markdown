---
author: abloz
comments: true
date: 2010-02-10 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/02/10/gftp-windows-client-encountered-the-problem-does-not-appear-in-chinese/
slug: gftp-windows-client-encountered-the-problem-does-not-appear-in-chinese
title: gftp 客户端使用遇到windows中文不显示问题
wordpress_id: 1048
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.2.10

 

gftp是图形用户ftp客户端，支持ftp,http,ssh2,fsp等协议。最新稳定版2.0.19，于2008年11月30日更新。在使用中遇到中文问题，网上没有找到详尽说明解决办法。

 

## 安装  


ubuntu9.10下安装：

sudo apt-get install gftp

 

安装完毕在应用程序的Internet里面有一个gFTP，点击即可执行。

##   


## 中文显示问题  


gFTP界面自动根据locale设置变化。我的LANG是zh_CN.UTF-8，访问中文windows ftp不能显示中文。

在将字符串“!!!�ϴ�ר��”从字符集 (null) 转换成字符集 UTF-8 时出错：转换输入中出现无效字符序列
    
    Error converting string '... ' to UTF-8 from current locale:(null)
    <big><big><big><b>解决</b></big></big></big>
    
    sudo vi /usr/bin/gftp<br />在第二行添加：<br />export LC_ALL="zh_CN.GBK"<br />保存。<br />重新执行gftp，这时GBK服务器端中文还是不能显示。<br />在菜单“FTP”，选“属性”（preference），在弹出的设置对话框中，客户端字符集写zh_CN.GBK.<br />或者在用户的根目录下，执行<br /><br />zhouhh@zhh64:~$ vi .gftp/gftprc# 这是用逗号分隔的字符集列表，gFTP<br />

# 会使用这些字符集将远程信息转换为当前语系。  
remote_charsets=zh_CN.GBK

 

修改remote_charsets，保存。

 

这时刷新即可看到服务器端中文。服务器是ServU架设的。

 

http://www.gftp.org在大陆内被墙，需翻墙而过。

 

## filezilla ftp客户端  


另，filezilla在linux下也有版本，最新版本3.1.1，中文支持不错。与gftp不同，其字符集的设置是每个服务器站点可以不一样 的。缺省情况下访问ServerU Ftp 中文站点，也不能显示中文。需到站点管理器里，将字符集设置，由自动改为自定义“GBK”  或“GB2312”即可。

由于filezilla支持ftp，sftp,ftps,ftpes协议，目前大有统一windows和linux下ftp客户端之势。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=e1092c96-0d10-8754-beb5-dd1c3d174059)
