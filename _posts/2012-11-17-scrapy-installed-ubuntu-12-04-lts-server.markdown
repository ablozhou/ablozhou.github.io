---
author: abloz
comments: true
date: 2012-11-17 16:27:41+00:00
layout: post
link: http://abloz.com/index.php/2012/11/18/scrapy-installed-ubuntu-12-04-lts-server/
slug: scrapy-installed-ubuntu-12-04-lts-server
title: 在ubuntu 12.04 lts server上安装scrapy
wordpress_id: 1975
categories:
- 技术
tags:
- scrapy
- ubuntu
---

vi /etc/apt/sources.list
将cdrom的注释去掉。并将iso放虚拟光驱中。ubuntu-12.04.1-server-i386.iso
apt-get install build-essential
安装编译工具

安装python setuptools
wget http://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg#md5=fe1f997bc722265116870bc7919059ea
sudo bash setuptools-0.6c11-py2.7.egg
安装pip
sudo apt-get install python-pip
sudo pip install beautifulsoup4


sudo pip install --upgrade Scrapy
因为GFW墙封锁python.org,经常导致下载失败。也可以直接下载scrapy-scrapy-0.17.0-26-g0a00e0f.tar.gz
https://github.com/scrapy/scrapy/tarball/master
编译时需要twisted，如果因为墙下载失败，也可直接下载编译
http://pypi.python.org/packages/source/T/Twisted/Twisted-12.2.0.tar.bz2#md5=9a321b904d01efd695079f8484b37861
twisted编译时找不到python.h需要
sudo apt-get install python-dev

用下列两个命令分别编译twisted和scrapy
python setup.py build
sudo python setup.py install

执行scrapy --version,显示
Scrapy 0.17.0
安装成功

