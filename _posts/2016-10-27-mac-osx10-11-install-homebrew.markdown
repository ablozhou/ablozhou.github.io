---
author: abloz
comments: true
date: 2016-10-27 06:23:48+00:00
layout: post
link: http://abloz.com/index.php/2016/10/27/mac-osx10-11-install-homebrew/
slug: mac-osx10-11-install-homebrew
title: mac osx10.11 安装homebrew
wordpress_id: 2769
categories:
- 技术
tags:
- homebrew
- mac
- 镜像
---

周海汉 2016.10.27

osx 10.11后/usr/local权限变严了。所以先改目录权限

zhhmac:local zhouhh$ sudo chown zhouhh:admin .

安装
zhhmac:local zhouhh$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

添加国内镜像。
如清华homebrew
由于众所周知的原因，homebrew国外源非常慢，甚至直接失败。所以需要设置国内镜像。但目前清华镜像官方的说明已经过时。

`zhhmac:local zhouhh$ git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
fatal: Not a git repository (or any of the parent directories): .git
zhhmac:local zhouhh$ cd Homebrew/

zhhmac:Homebrew zhouhh$ pwd

/usr/local/Homebrew

zhhmac:Homebrew zhouhh$ git status

On branch stable

nothing to commit, working directory clean

zhhmac:Homebrew zhouhh$ git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

zhhmac:Homebrew zhouhh$ pwd

/usr/local/Homebrew

zhhmac:Homebrew zhouhh$ cd ..

zhhmac:local zhouhh$ ls

Cellar	bin	lib	share

Frameworks	etc	opt	var

Homebrew	include	sbin

zhhmac:local zhouhh$ cd ./Homebrew/Library/Taps/homebrew/homebrew-core/

zhhmac:homebrew-core zhouhh$ git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

zhhmac:homebrew-core zhouhh$ brew update

Already up-to-date.

zhhmac:homebrew-core zhouhh$ 
`

homebrew二进制的下载。
（homebrew-bottles镜像）
长期替换镜像：
`
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
`
如果用zsh

`
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc
`

参考 
https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/
https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
