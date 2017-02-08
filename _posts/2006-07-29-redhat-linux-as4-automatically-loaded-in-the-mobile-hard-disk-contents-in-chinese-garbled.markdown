---
author: abloz
comments: true
date: 2006-07-29 06:00:45+00:00
layout: post
link: http://abloz.com/index.php/2006/07/29/redhat-linux-as4-automatically-loaded-in-the-mobile-hard-disk-contents-in-chinese-garbled/
slug: redhat-linux-as4-automatically-loaded-in-the-mobile-hard-disk-contents-in-chinese-garbled
title: Redhat Linux AS4中移动硬盘自动加载后中文内容为乱码？
wordpress_id: 171
categories:
- 技术
tags:
- hal
- linux
- 乱码
- 移动硬盘
---

这个挺伤脑筋， 因为大容量的东西通过网络传输比较慢，而在Linux下却不知里面是什么。
先确定locale：

    
    
    ># locale
    
    LANG=zh_CN.UTF-8
    LC_CTYPE="zh_CN.UTF-8"
    LC_NUMERIC="zh_CN.UTF-8"
    LC_TIME="zh_CN.UTF-8"
    LC_COLLATE="zh_CN.UTF-8"
    LC_MONETARY="zh_CN.UTF-8"
    LC_MESSAGES="zh_CN.UTF-8"
    LC_PAPER="zh_CN.UTF-8"
    LC_NAME="zh_CN.UTF-8"
    LC_ADDRESS="zh_CN.UTF-8"
    LC_TELEPHONE="zh_CN.UTF-8"
    LC_MEASUREMENT="zh_CN.UTF-8"
    LC_IDENTIFICATION="zh_CN.UTF-8"
    LC_ALL=
    


通过查资料，原来RH Linux AS4是通过HAL（硬件抽象层）来管理移动硬盘自动加载的。在目录
/usr/share/hal/fdi/ 里面有HAL加载的配置文件。并且冲突时后加载的配置文件会覆盖前面加载的。该目录下有这些内容：

    
    
    ># ll
    total 72
    drwxr-xr-x  2 root root 4096 Dec 22  2005 10generic
    drwxr-xr-x  2 root root 4096 Jul 29 13:58 20freedesktop
    drwxr-xr-x  2 root root 4096 Dec 22  2005 30osvendor
    drwxr-xr-x  2 root root 4096 Dec 22  2005 40oem
    drwxr-xr-x  2 root root 4096 Dec 22  2005 50user
    drwxr-xr-x  2 root root 4096 Jul 29 14:01 90defaultpolicy
    drwxr-xr-x  2 root root 4096 Jul 29 14:05 95userpolicy
    -rw-r--r--  1 root root  603 Dec 22  2005 fdi.dtd
    -rw-r--r--  1 root root 1631 Dec 22  2005 fdi.rng
    



根据数字来看，95userpolicy比 90defaultpolicy后加载。但该目录下什么都没有。因此编辑一个policy文件，放在95目录下：

vi  storage-policy.fdi

填入：

    
    
     
    
    <deviceinfo version="0.2">
      <device>
        <match bool="true" key="block.is_volume">
          <match string="filesystem" key="volume.fsusage">
            <match string="vfat" key="volume.fstype">
              <merge type="bool" key="volume.policy.mount_option.fmask=111">true</merge>
              <merge type="bool" key="volume.policy.mount_option.dmask=0">true</merge>
              <merge type="bool" key="volume.policy.mount_option.users">true</merge>
              <merge type="bool" key="volume.policy.mount_option.utf8">true</merge>
            </match>
          </match>
        </match>
      </device>
    </deviceinfo>
    


保存。

重启HAL：

    
    
    ># /etc/init.d/haldemon restart
    


再插入U盘或移动硬盘，就可以看到中文了。
