---
author: abloz
comments: true
date: 2009-02-03 08:33:18+00:00
layout: post
link: http://abloz.com/index.php/2009/02/03/compatibility-of-vim-and-vi/
slug: compatibility-of-vim-and-vi
title: vim 与vi的兼容性问题
wordpress_id: 350
categories:
- 技术
tags:
- vi
- vim
---

周海汉/文 2009.2.3
ablozhou # gmail.com
http://blog.csdn.net/ablo_zhou

1. 安装了个vim7.0，但发现编辑模式下退格键backspace和上下左右光标移动键不能用，非常不方便。

在编辑模式下，移动光标会变成A B C D等字符并换行。


    
    
       B
       C
       D
       B
       A
    


原来vim缺省是vi兼容模式，设置成不兼容模式就好了：

    
    
    :set nocp
    



可以用help查看相关的设置。

    
    
    :help cp
    :help compatible
    



2.打开一个已存在的文件后，文件中的字符，不能用backspace键删除。但是此时如果输入新的字符，却可以用backspace进行删除。这是怎么回事？

查看帮助：

    
    
    :help bs
    :help backspace
    


原来，backspace有几种工作方式，默认是vi兼容的。对新手来说很不习惯。对老vi 不那么熟悉的人也都挺困扰的。可以用

    
    
    :set backspace=indent,eol,start
    


来解决。

indent: 如果用了:set indent,:set ai 等自动缩进，想用退格键将字段缩进的删掉，必须设置这个选项。否则不响应。
eol:如果插入模式下在行开头，想通过退格键合并两行，需要设置eol。
start：要想删除此次插入前的输入，需设置这个。

3.光标在行尾按右方向键不到下一行行首，在行首按左方向键不到上一行行尾，怎么回事？
 
    
    
    :help ww
    :help whichwrap
     


想用左移键回到上一行的行尾，在行尾用右移键能够到下一行的开头，通过设置 whichwrap 我们可以对一部分按键开启这项功能。 如果想对某一个或几个按键开启到头后自动折向下一行的功能， 可以把需要开启的键的代号写到 whichwrap 的参数列表中，各个键之间使用逗号分隔。
        以下是 whichwrap 支持的按键名称列表：

        b: 在 Normal 或 Visual 模式下按删除(Backspace)键。
        s: 在 Normal 或 Visual 模式下按空格键。
        h: 在 Normal 或 Visual 模式下按 h 键。
        l: 在 Normal 或 Visual 模式下按 l 键。
        <: 在 Normal 或 Visual 模式下按左方向键。
        >: 在 Normal 或 Visual 模式下按右方向键。
        ~: 在 Normal 模式下按 ~ 键(翻转当前字母大小写)。
        [: 在 Insert 或 Replace 模式下按左方向键。
        ]: 在 Insert 或 Replace 模式下按右方向键。

4. 如何将tab键替换为空格？
编辑python文件时，按tab键不能自动替换为空格，应如何处理？

    
    
    :set ai
    :set shiftwidth=4
    :set sw=4
       自动缩进的时候， 缩进尺寸为 4 个空格。
    :set tabstop=4
    :set ts=4
        Tab 宽度为 4 个字符。
    :set expandtab
    :set et
        编辑时将所有 Tab 替换为空格。
    


    该选项只在编辑时将 Tab 替换为空格， 如果打开一个已经存在的文件， 并不会将已有的Tab 替换为空格。 如果希望进行这样的替换的话， 可以使用这条命令“:retab”。
