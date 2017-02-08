---
author: abloz
comments: true
date: 2008-04-01 09:15:06+00:00
layout: post
link: http://abloz.com/index.php/2008/04/01/my-vimrc-configuration/
slug: my-vimrc-configuration
title: 我的 .vimrc 配置
wordpress_id: 305
categories:
- 技术
tags:
- linux
- vim
---

1. 支持中文编辑，不会导致删除半个字符和光标移动半个中文字符的问题
2.支持C/C++的自动缩进
3.解决在自动缩进状态下，用鼠标粘贴时引起的格式错乱

    
    
    " author: zhouhh
    " blog  : http://blog.csdn.net/ablo_zhou
    " email : ablozhou@gmail.com
    " date  : 2008.4.1
    
    set nocompatible " Use Vim defaults (much better!)
    set bs=indent,eol,start " Allow backspacing over everything in insert mode
    set ai " Always set auto-indenting on
    set cindent " for c editor
    set paste " for paste may format text disorder
    
    "set backup " Keep a backup file
    set viminfo='20,"500 " read/write a .viminfo file -- limit regs to 500 lines
    set history=100 " keep 50 lines of command history
    set ruler " Show the cursor position all the time
    
    " colorscheme elflord " Make the colors brighter for transparent terminals
    set ts=4 " Set TAB Stop
    set shiftwidth=4 " Set shift width in programming when using >>
    set textwidth=0 " Don't wrap words by default
    set ignorecase " Ignore case in searching
    set smartcase " Search case-sensitively when capitalized letter found in pattern
    set nobackup " Don't keep a backup file
    set showcmd " Show (partial) command in status line
    set showmatch " Show matching brackets
    set incsearch " Incremental Search
    "set autowrite " Automatically save file before :next and : prev
    "set nowrap " Do not wrap text
    "set textwidth=80 " Place automatic text breaks
    
    " Enable Chinese encoding support
    set encoding=euc-cn
    if v:lang =~ "^zh_CN"
    set fileencodings=gb2312
    set guifontset=*-r-* " You may change the font to your like
    endif
    
    " Switch syntax highlighting on, when the terminal has colors
    " Also switch on highlighting the last used search pattern.
    if &t;_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
    endif
    
    "set nohlsearch "If you do not like highlighting search pattern
    



