---
author: abloz
comments: true
date: 2010-07-12 05:15:00+00:00
layout: post
link: http://abloz.com/index.php/2010/07/12/ubuntu-10-04-installed-ruby-rails/
slug: ubuntu-10-04-installed-ruby-rails
title: ubuntu 10.04 安装ruby & rails
wordpress_id: 112
categories:
- 技术
tags:
- rails
- ror
- ruby
- ubuntu
---

#  					 				

				

 					  					  					

周海汉 2010.7.12

 

ubuntu 10.04 安装ruby & rails时遇到问题，如下：

 

`require': no such file to load -- mkmf (LoadError)

 

**安装过程：**

 

安装ruby1.9.1

zhouhh@zhh64:~$ sudo apt-get install ruby1.9.1-full

zhouhh@zhh64:~$ sudo apt-get install rubygems1.9.1  
gem 是ruby 的自动打包安装工具

 

安装mysql server和客户端

zhouhh@zhh64:~$ sudo apt-get install mysql-server-5.1 php5-mysql  libmysqlclient-dev libmysqld-dev mysql-client-5.1

 

但用gem安装mysql时一直报错

zhouhh@zhh64:~$ sudo gem install mysql  
Building native extensions. This could take a while...  
ERROR: Error installing mysql:  
ERROR: Failed to build gem native extension.  
  
/usr/bin/ruby1.9.1 extconf.rb  
extconf.rb:10:in `require': no such file to load -- mkmf (LoadError)  
from extconf.rb:10:in `<main>'  
  
  
Gem files will remain installed in /var/lib/gems/1.9.1/gems/mysql-2.8.1  for inspection.  
Results logged to  /var/lib/gems/1.9.1/gems/mysql-2.8.1/ext/mysql_api/gem_make.out  
  
找了很多资料，都说是ruby-dev没安装，但其实是安装了的。

 

后面发现是ruby安装了两个版本，引起问题

zhouhh@zhh64:~$ ruby -v  
ruby 1.8.7 (2010-01-10 patchlevel 249) [x86_64-linux]  
直接执行ruby，是系统自带的，1.8.7  
  
删除ruby1.8  
zhouhh@zhh64:~$ sudo apt-get remove ruby1.8  
再安装就好了  
zhouhh@zhh64:~$ sudo gem install mysql  
Building native extensions. This could take a while...  
Successfully installed mysql-2.8.1  
1 gem installed  
Installing ri documentation for mysql-2.8.1...  
Updating class cache with 2469 classes...  
Installing RDoc documentation for mysql-2.8.1...  
  
安装rails  
zhouhh@zhh64:~$ sudo gem install rails --include-dependencies  
INFO: `gem install -y` is now default and will be removed  
INFO: use --ignore-dependencies to install only the gems you list  
Successfully installed rake-0.8.7  
Successfully installed activesupport-2.3.8  
Successfully installed activerecord-2.3.8  
Successfully installed rack-1.1.0  
Successfully installed actionpack-2.3.8  
Successfully installed actionmailer-2.3.8  
Successfully installed activeresource-2.3.8  
Successfully installed rails-2.3.8  
8 gems installed  
Installing ri documentation for rake-0.8.7...  
Installing ri documentation for activesupport-2.3.8...  
Installing ri documentation for activerecord-2.3.8...  
Installing ri documentation for rack-1.1.0...  
Installing ri documentation for actionpack-2.3.8...  
Installing ri documentation for actionmailer-2.3.8...  
Installing ri documentation for activeresource-2.3.8...  
Installing ri documentation for rails-2.3.8...  
Updating class cache with 0 classes...  
Installing RDoc documentation for rake-0.8.7...  
Installing RDoc documentation for activesupport-2.3.8...

 

测试ruby

zhouhh@zhh64:~$ irb  
bash: /usr/bin/irb: 没有那个文件或目录  
zhouhh@zhh64:~$ irb1.9.1  
irb(main):001:0> 3+2  
=> 5

  
  


![](http://img.zemanta.com/pixy.gif?x-id=e22518eb-8255-8581-b752-83e7518e1b98)
