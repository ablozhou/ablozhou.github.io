---
author: abloz
comments: true
date: 2013-08-30 05:22:34+00:00
layout: post
link: http://abloz.com/index.php/2013/08/30/r-language-installed-on-the-centos6-4/
slug: r-language-installed-on-the-centos6-4
title: R 语言在centos6.4上的安装
wordpress_id: 2210
categories:
- 技术
tags:
- R
---

周海汉 2013.8.30





CentOS 6.4 64位上安装。官方下载地址：




[http://cran.r-project.org](http://cran.r-project.org/)







官方下载比较老。





<table >
<tbody >
<tr >

<td valign="top" >
</td>

<td >[R-2.10.0-2.el5.x86_64.rpm](http://ftp.ctex.org/mirrors/CRAN/bin/linux/redhat/el5/x86_64/R-2.10.0-2.el5.x86_64.rpm)
</td>

<td align="right" >09-Nov-2009 16:45
</td>

<td align="right" >14K
</td>

<td >
</td>
</tr>
<tr >

<td valign="top" >
</td>

<td >[R-core-2.10.0-2.el5.x86_64.rpm](http://ftp.ctex.org/mirrors/CRAN/bin/linux/redhat/el5/x86_64/R-core-2.10.0-2.el5.x86_64.rpm)
</td>

<td align="right" >09-Nov-2009 16:45
</td>

<td align="right" >31M
</td>

<td >
</td>
</tr>
<tr >

<td valign="top" >
</td>

<td >[R-devel-2.10.0-2.el5.x86_64.rpm](http://ftp.ctex.org/mirrors/CRAN/bin/linux/redhat/el5/x86_64/R-devel-2.10.0-2.el5.x86_64.rpm)
</td>

<td align="right" >09-Nov-2009 16:45
</td>

<td align="right" >87K
</td>

<td >
</td>
</tr>
<tr >

<td valign="top" >
</td>

<td >[ReadMe](http://ftp.ctex.org/mirrors/CRAN/bin/linux/redhat/el5/x86_64/ReadMe)
</td>

<td align="right" >31-Aug-2009 15:30
</td>

<td align="right" >262
</td>

<td >
</td>
</tr>
<tr >

<td valign="top" >
</td>

<td >[libRmath-2.10.0-2.el5.x86_64.rpm](http://ftp.ctex.org/mirrors/CRAN/bin/linux/redhat/el5/x86_64/libRmath-2.10.0-2.el5.x86_64.rpm)
</td>

<td align="right" >09-Nov-2009 16:45
</td>

<td align="right" >102K
</td>

<td >
</td>
</tr>
<tr >

<td valign="top" >
</td>

<td >[libRmath-devel-2.10.0-2.el5.x86_64.rpm](http://ftp.ctex.org/mirrors/CRAN/bin/linux/redhat/el5/x86_64/libRmath-devel-2.10.0-2.el5.x86_64.rpm)
</td>

<td align="right" >09-Nov-2009 16:45
</td>

<td align="right" >148K
</td>

<td >
</td>
</tr>
</tbody>
</table>





官方比较旧，rpm还安装失败：




[andy@s1 ~]$ sudo rpm -ivh R-core-2.10.0-2.el5.x86_64.rpm
warning: R-core-2.10.0-2.el5.x86_64.rpm: Header V3 DSA/SHA1 Signature, key ID 97d3544e: NOKEY
error: Failed dependencies:
libtcl8.4.so()(64bit) is needed by R-core-2.10.0-2.el5.x86_64
libtk8.4.so()(64bit) is needed by R-core-2.10.0-2.el5.x86_64
perl(File::Copy::Recursive) is needed by R-core-2.10.0-2.el5.x86_64







[andy@s1 ~]$ sudo yum install R




No package R available.
Error: Nothing to do







更新源到fedoraproject




[andy@s1 ~]$ sudo rpm -Uvh [http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm](http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm)







[andy@s1 ~]$ sudo yum install R




Downloading Packages:
(1/13): R-3.0.1-2.el6.x86_64.rpm                         |  19 kB     00:00
(2/13): R-core-3.0.1-2.el6.x86_64.rpm                                                                                                                                                                                 |  46 MB     02:59
(3/13): R-core-devel-3.0.1-2.el6.x86_64.rpm                                                                                                                                                                           |  90 kB     00:00
(4/13): R-devel-3.0.1-2.el6.x86_64.rpm                                                                                                                                                                                |  19 kB     00:00
(5/13): R-java-3.0.1-2.el6.x86_64.rpm                                                                                                                                                                                 |  20 kB     00:00
(6/13): R-java-devel-3.0.1-2.el6.x86_64.rpm                                                                                                                                                                           |  19 kB     00:00
(7/13): libRmath-3.0.1-2.el6.x86_64.rpm                                                                                                                                                                               | 115 kB     00:00
(8/13): libRmath-devel-3.0.1-2.el6.x86_64.rpm                                                                                                                                                                         |  24 kB     00:00
(9/13): pcre-devel-7.8-6.el6.x86_64.rpm                                                                                                                                                                               | 318 kB     00:00
(10/13): tcl-devel-8.5.7-6.el6.x86_64.rpm                                                                                                                                                                             | 162 kB     00:00
(11/13): texinfo-4.13a-8.el6.x86_64.rpm                                                                                                                                                                               | 668 kB     00:00
(12/13): texinfo-tex-4.13a-8.el6.x86_64.rpm                                                                                                                                                                           | 132 kB     00:00
(13/13): tk-devel-8.5.7-5.el6.x86_64.rpm










[andy@s1 ~]$ R

R version 3.0.1 (2013-05-16) -- "Good Sport"
Copyright (C) 2013 The R Foundation for Statistical Computing
Platform: x86_64-redhat-linux-gnu (64-bit)

R是自由软件，不带任何担保。
在某些条件下你可以将其自由散布。
用'license()'或'licence()'来看散布的详细条件。

R是个合作计划，有许多人为之做出了贡献.
用'contributors()'来看合作者的详细情况
用'citation()'会告诉你如何在出版物中正确地引用R或R程序包。

用'demo()'来看一些示范程序，用'help()'来阅读在线帮助文件，或
用'help.start()'通过HTML浏览器来看帮助文件。
用'q()'退出R.

> demo(graphics)




可以查看R能画哪些类型的图。







 




各种字符展示




> demo(Hershey)










退出




> q()
Save workspace image? [y/n/c]: n






