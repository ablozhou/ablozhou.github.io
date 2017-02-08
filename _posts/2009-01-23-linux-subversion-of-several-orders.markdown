---
author: abloz
comments: true
date: 2009-01-23 03:55:19+00:00
layout: post
link: http://abloz.com/index.php/2009/01/23/linux-subversion-of-several-orders/
slug: linux-subversion-of-several-orders
title: linux subversion 的几个命令
wordpress_id: 347
categories:
- 技术
tags:
- linux
- subversion
- svn
---


svn add * --force 自动添加没在库的文件，包括在子目录下的文件。
svn status 查看本地文件状态，是M（modify）A（added）?（未在库的文件）
svn log 文件名 可以查看谁提交了文件，提交的日期
svn list svn://xx.xx.xx/repos/ 可以查看有哪些库（协议，地址和路径都只是示例，请根据subversion服务器的实际情况定）
svn list svn://xx.xx.xx/repos/abc/tags 可以用于查看有哪些标签。
svn copy svn://xx.xx.xx/repos/trunk svn://xx.xx.xx/repos/tags/release_10 -m "comment" 用于创建标签。
