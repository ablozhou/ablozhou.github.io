---
author: abloz
comments: true
date: 2015-08-17 17:40:44+00:00
layout: post
link: http://abloz.com/index.php/2015/08/18/iterm2-and-zsh-install-on-mac/
slug: iterm2-and-zsh-install-on-mac
title: iterm2和zsh 在mac上安装
wordpress_id: 2700
categories:
- 技术
tags:
- iterm2
- mac
- oh-my-zsh
---

下载iterm2：




[_http://iterm2.com/_](http://iterm2.com/)







oh-my-zsh地址：




[_https://github.com/robbyrussell/oh-my-zsh_](https://github.com/robbyrussell/oh-my-zsh)




_ _




下载安装oh-my-zsh









    
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    


或 wget

    
    
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    










如果chsh失败，可以调用命令chsh,将shell=/bin/bash改为/bin/zsh







修改提示符






原始zsh提示符过于简单，就是一个~，不方便复制输出内容。所以将其修改一下：

编辑.zshrc

输入如下

    
    export PROMPT="%{$fg_bold[green]%}%n@%{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}%# % %{$reset_color%}"


保存退出shell，再进入，会看到提示符变成了目录和相应权限的分隔符。

andy@~ % ls

andy@Hello %


