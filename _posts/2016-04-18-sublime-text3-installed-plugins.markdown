---
author: abloz
comments: true
date: 2016-04-18 09:58:52+00:00
layout: post
link: http://abloz.com/index.php/2016/04/18/sublime-text3-installed-plugins/
slug: sublime-text3-installed-plugins
title: sublime text3 安装插件
wordpress_id: 2734
categories:
- 技术
tags:
- sublime
---

abloz.com

2016.4.14



	
  1. 安装package control：






    
    import urllib.request,os;pf = 'Package Control.sublime-package';ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) );open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())


2. 安装emmet

package control:install 会报错：

Package Control:There are no packages available for installation

下载我提供的channel_v3.json

https://yunpan.cn/cqaewkZEkAj6N （提取码：5fd2）

在sublime>preferences>package settings>package control >settings user

添加：

    
    "channels":
    	[
    		"/Users/zhh/Downloads/channel_v3.json"
    	],


将路径改成该文件channel_v3.json的实际存放路径。

再点sublime>preferences>package control: install

既可以下载emmet等插件。




