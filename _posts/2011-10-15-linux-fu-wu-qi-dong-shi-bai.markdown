---
author: abloz
comments: true
date: 2011-10-15 04:40:56+00:00
layout: post
link: http://abloz.com/index.php/2011/10/15/linux-fu-wu-qi-dong-shi-bai/
slug: linux-fu-wu-qi-dong-shi-bai
title: linux 服务启动失败？
wordpress_id: 1465
categories:
- 技术
---

在/etc/rc.d/init.d/里面写个脚本test

执行service test start

结果提示：

    
    
    env: /etc/init.d/test: No such file or directory


可是ls一下该文件却存在。

脚本看起来也没有问题。

原来，该脚本是从windows过去的，分行有问题。

用tr -d 'r' < test >test1

将换行去掉。结果，就可以执行了。


