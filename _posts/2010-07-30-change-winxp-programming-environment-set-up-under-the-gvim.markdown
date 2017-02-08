---
author: abloz
comments: true
date: 2010-07-30 08:53:23+00:00
layout: post
link: http://abloz.com/index.php/2010/07/30/change-winxp-programming-environment-set-up-under-the-gvim/
slug: change-winxp-programming-environment-set-up-under-the-gvim
title: '[转]Winxp下 gvim 编程环境搭建'
wordpress_id: 352
categories:
- 技术
- 转载
tags:
- vim
- windows
---

from：[http://blog.csdn.net/minico/archive/2007/12/15/1938050.aspx](http://blog.csdn.net/minico/archive/2007/12/15/1938050.aspx)


### Winxp下 gvim 编程环境搭建


1.官方网站下载最新的gvim7.1 win32,然后选择完全安装；我是安装在d:vim目录下面，安装后的目录结构如下：
**D:VIM
├─vim71
**│ ├─autoload
│ ├─colors
│ ├─compiler
│ ├─doc
│ ├─ftplugin
│ ├─indent
│ ├─keymap
│ ├─lang
│ ├─macros
│ ├─plugin
│ ├─spell
│ ├─syntax
│ ├─tools
│ └─tutor
**└─vimfiles
**├─after
├─autoload
├─colors
├─compiler
├─doc
├─ftdetect
├─ftplugin
├─indent
├─keymap
├─plugin
└─syntax

2.安装常用插件：
<table cellpadding="0" cellspacing="0" border="1" >
<tbody >
<tr >

<td width="11%" bgcolor="#ffffff" >vimdoc
</td>

<td width="89%" bgcolor="#ffffff" >http://vcd.gro.clinux.org    (中文)
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >安装
</td>

<td width="89%" bgcolor="#ffffff" >直接安装即可，安装时会自动搜索到vim的安装位置，然后安装到相应的目录
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >使用
</td>

<td width="89%" bgcolor="#ffffff" >:h
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >说明
</td>

<td width="89%" bgcolor="#ffffff" >中文帮助文档
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" >
<tbody >
<tr >

<td width="11%" bgcolor="#c0c0c0" >taglist
</td>

<td width="89%" bgcolor="#c0c0c0" >http://www.vim.org/scripts/script.php?script_id=273
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >安装
</td>

<td width="89%" bgcolor="#c0c0c0" >解压到vim71目录下面
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >使用
</td>

<td width="89%" bgcolor="#c0c0c0" >:Tlist
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >说明
</td>

<td width="89%" bgcolor="#c0c0c0" >需要Ctags产生的tags文件配合
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" >
<tbody >
<tr >

<td width="11%" bgcolor="#ffffff" >WinManager
</td>

<td width="89%" bgcolor="#ffffff" >http://www.vim.org/scripts/script.php?script_id=95
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >安装
</td>

<td width="89%" bgcolor="#ffffff" >解压到vim71目录下面
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >使用
</td>

<td width="89%" bgcolor="#ffffff" >wm,这个命令是通过在_vimrc中配置后才能有，具体配置见后面的_vimrc文件
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >说明
</td>

<td width="89%" bgcolor="#ffffff" >此插件的作用是将TagList窗口和netrw窗口整合起来
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" bgcolor="#c0c0c0" >
<tbody >
<tr >

<td width="11%" bgcolor="#c0c0c0" >Ctags
</td>

<td width="89%" bgcolor="#c0c0c0" >http://ctags.sourceforge.net
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >安装
</td>

<td width="89%" bgcolor="#c0c0c0" >解压到vim71目录下面
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >使用
</td>

<td width="89%" bgcolor="#c0c0c0" >ctags -R --c++-kinds=+p --fields=+iaS --extra=+q src
在对C++文件进行补全时，OmniCppComplete插件需要在标签文件中包含C++的额外信息，因此上面的ctags命令不同于以前我们所使用的，它专门为C++语言生成一些额外的信息.
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >说明
</td>

<td width="89%" bgcolor="#c0c0c0" >其实只是一个ctags.exe文件，用来产生tags文件供其它插件使用
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" >
<tbody >
<tr >

<td width="11%" bgcolor="#ffffff" >MiniBufExplorer
</td>

<td width="89%" bgcolor="#ffffff" >http://www.vim.org/scripts/script.php?script_id=159
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >安装
</td>

<td width="89%" bgcolor="#ffffff" >将minibufexpl.vim放 到vim71/plugin 文件夹中即可；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >使用
</td>

<td width="89%" bgcolor="#ffffff" >打开多个文件后，自动在顶端出现文件标签，双击鼠标或者Ctrl+tab键可以切换文件；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >说明
</td>

<td width="89%" bgcolor="#ffffff" >
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" bgcolor="#c0c0c0" >
<tbody >
<tr >

<td width="11%" bgcolor="#c0c0c0" >grep
</td>

<td width="89%" bgcolor="#c0c0c0" >http://www.vim.org/scripts/script.php?script_id=311
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >安装
</td>

<td width="89%" bgcolor="#c0c0c0" >将grep.vim放 到vim71/plugin 文件夹中即可；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >使用
</td>

<td width="89%" bgcolor="#c0c0c0" >安装后会在菜单=》工具中增加search子菜单，也可以用命令:grep或者按照后面给出的_vimrc文件映射快捷键F3
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >说明
</td>

<td width="89%" bgcolor="#c0c0c0" >需要windows版本的grep.exe程序配合；
到http://unxutils.sourceforge.net/下载unxutils工具包里面包含grep.exe，把grep.exe放到系统c:windowssystem32下面即可。
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" >
<tbody >
<tr >

<td width="11%" bgcolor="#ffffff" height="11" >omnicppcomplete
</td>

<td width="89%" bgcolor="#ffffff" height="11" >http://www.vim.org/scripts/script.php?script_id=1520
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" height="16" >安装
</td>

<td width="89%" bgcolor="#ffffff" height="16" >解压到vimfiles目录下面；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" height="16" >使用
</td>

<td width="89%" bgcolor="#ffffff" height="16" >配合后面的supertab插件，使用Tab键进行自动完成；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" height="16" >说明
</td>

<td width="89%" bgcolor="#ffffff" height="16" >如果要对c++文件进行自动完成，需要生成tag文件时用特殊的选项，见后面的_vimrc配置文件
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" bgcolor="#c0c0c0" >
<tbody >
<tr >

<td width="11%" bgcolor="#c0c0c0" >a
</td>

<td width="89%" bgcolor="#c0c0c0" >http://www.vim.org/scripts/script.php?script_id=31
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >安装
</td>

<td width="89%" bgcolor="#c0c0c0" >将a.vim放 到vim71/plugin 文件夹中即可；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >使用
</td>

<td width="89%" bgcolor="#c0c0c0" >:A
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >说明
</td>

<td width="89%" bgcolor="#c0c0c0" >在源文件和头文件之间进行切换
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" >
<tbody >
<tr >

<td width="11%" bgcolor="#ffffff" >Supertab
</td>

<td width="89%" bgcolor="#ffffff" >http://www.vim.org/scripts/script.php?script_id=1643
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >安装
</td>

<td width="89%" bgcolor="#ffffff" >将supertab.vim放 到vim71/plugin 文件夹中即可；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >使用
</td>

<td width="89%" bgcolor="#ffffff" >配合前面的omnicppcomplete插件，使用Tab键进行自动完成；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >说明
</td>

<td width="89%" bgcolor="#ffffff" >
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" bgcolor="#c0c0c0" >
<tbody >
<tr >

<td width="11%" bgcolor="#c0c0c0" >NERD_commenter
</td>

<td width="89%" bgcolor="#c0c0c0" >http://www.vim.org/scripts/script.php?script_id=1218
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >安装
</td>

<td width="89%" bgcolor="#c0c0c0" >解压到vim71目录下面
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >使用
</td>

<td width="89%" bgcolor="#c0c0c0" >http://xiaobo.spaces.live.com/blog/cns!5ec21dee9b73c1a8!814.entry
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >说明
</td>

<td width="89%" bgcolor="#c0c0c0" >
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" >
<tbody >
<tr >

<td width="11%" bgcolor="#ffffff" >lookupfile
</td>

<td width="89%" bgcolor="#ffffff" >http://www.vim.org/scripts/script.php?script_id=1581
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >安装
</td>

<td width="89%" bgcolor="#ffffff" >解压到vimfiles目录下面；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >使用
</td>

<td width="89%" bgcolor="#ffffff" >根据后面的_vimrc配置文件，使用F5键打开搜索窗口；Tab键进行选择
</td>
</tr>
<tr >

<td width="11%" bgcolor="#ffffff" >说明
</td>

<td width="89%" bgcolor="#ffffff" >依赖于插件genutils
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" bgcolor="#c0c0c0" >
<tbody >
<tr >

<td width="11%" bgcolor="#c0c0c0" >genutils
</td>

<td width="89%" bgcolor="#c0c0c0" >http://www.vim.org/scripts/script.php?script_id=197
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >安装
</td>

<td width="89%" bgcolor="#c0c0c0" >解压到vimfiles目录下面；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >使用
</td>

<td width="89%" bgcolor="#c0c0c0" >这个插件提供了一些通用的函数，可供其它的脚本使用
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >说明
</td>

<td width="89%" bgcolor="#c0c0c0" >供lookupfile插件使用
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="1" bgcolor="#c0c0c0" >
<tbody >
<tr >

<td width="11%" bgcolor="#c0c0c0" >clearcase
</td>

<td width="89%" bgcolor="#c0c0c0" >[http://p.blog.csdn.net/images/p_blog_csdn_net/minico/EntryImages/20081123/gvim.JPG](http://p.blog.csdn.net/images/p_blog_csdn_net/minico/EntryImages/20081123/gvim.JPG)
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >安装
</td>

<td width="89%" bgcolor="#c0c0c0" >解压到vimfiles目录下面；
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >使用
</td>

<td width="89%" bgcolor="#c0c0c0" >这个插件提供一些常用的clearcase命令
</td>
</tr>
<tr >

<td width="11%" bgcolor="#c0c0c0" >说明
</td>

<td width="89%" bgcolor="#c0c0c0" >无
</td>
</tr>
</tbody>
</table>
3._vimrc配置文件
<table cellpadding="0" cellspacing="0" border="1" >
<tbody >
<tr >

<td width="100%" bgcolor="#c0c0c0" >set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
let opt = '-a --binary '
if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
let arg1 = v:fname_in
if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
let arg2 = v:fname_new
if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
let arg3 = v:fname_out
if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
let eq = ''
if $VIMRUNTIME =~ ' '
if &sh =~ '<cmd'
let cmd = '""' . $VIMRUNTIME . 'diff"'
let eq = '"'
else
let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . 'diff"'
endif
else
let cmd = $VIMRUNTIME . 'diff'
endif
silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Add by minico---begin
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"设置帮助语言
set helplang=cn,en

"把gui的工具栏去掉(要去掉，把等号前面的加号变成一个减号即可)
set guioptions+=T

"把gui的右边的滑动条去掉
set guioptions+=r

"把gui的左边的滑动条去掉
set guioptions-=L

"把gui的菜单去掉
set guioptions+=m
filetype on
let Tlist_Show_Menu = 1

" 这项必须设定，否则出错,配置taglist的ctags路径
"let Tlist_Ctags_Cmd = 'D:Vimvim71ctags.exe'
"设置Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

" 使用F8打开Taglist
nnoremap <silent> <F8> :TlistToggle<CR>

"设置窗口大小和位置
set lines=80
set columns=200
winpos 0 0

"设置tags文件路径
set tags=G:lwiptags

"设置文件浏览器窗口显示方式
"通过WinManager插件来将TagList窗口和netrw窗口整合起来
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>

"设置SuperTab，用tab键打开cppcomplet的自动补全功能。
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"显示行号
set number

"打开语法高亮显示功能
syntax enable
syntax on

"设置主题颜色
colorscheme desert

"则可以用<C-h,j,k,l>切换到上下左右的窗口中去
let g:miniBufExplMapWindowNavVim = 1

"按F12时在一个新的buffer中打开ch文件
nnoremap <silent> <F12> :A<CR>

"用F3调用grep查找当前光标所在处的字符串
nnoremap <silent> <F3> :Grep<CR>

"为了使用智能补全，打开文件类型检测,关闭VI兼容模式
filetype plugin indent on
set nocp

"关掉智能补全时的预览窗口，这样可以防止闪屏现象
set completeopt=longest,menu

"====================Lookupfile 相关设置========================================

let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
let g:LookupFile_TagExpr = '"./filenametags"'
endif
"nmap <silent> <leader>lk <Plug>LookupFile<cr>   "映射LookupFile为,lk
"nmap <silent> <leader>ll :LUBufs<cr>            "映射LUBufs为,ll
"nmap <silent> <leader>lw :LUWalk<cr>            "映射LUWalk为,lw

"有了上面的定义，当我输入”,lk”时，就会在tag文件中查找指定的文件名；
"当输入”,ll”时，就会在当前已打开的buffer中查找指定名字的buffer；
"当输入”,lw”时，就会在指定目录结构中查找。

"在用lookupfile插件查找文件时，是区分文件名的大小写的，
"如果想进行忽略大小写的匹配，把下面这段代码加入你的vimrc中，
"就可以每次在查找文件时都忽略大小写查找了：

" lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
let _tags = &tags
try
let &tags = eval(g:LookupFile_TagExpr)
let newpattern = 'c' . a:pattern
let tags = taglist(newpattern)
catch
echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
return ""
finally
let &tags = _tags
endtry

" Show the matches for what is typed so far.
let files = map(tags, 'v:val["filename"]')
return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'

"====================Lookupfile 相关设置 end========================================

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Add by minico---end
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
</td>
</tr>
</tbody>
</table>
4.实际效果：

![](http://p.blog.csdn.net/images/p_blog_csdn_net/minico/EntryImages/20081123/gvim.JPG)

![](http://p.blog.csdn.net/images/p_blog_csdn_net/minico/2.JPG)

5.参考文档：

(1)http://blog.csdn.net/wooin/archive/2007/10/31/1858917.aspx

(2)http://blog.csdn.net/easwy/category/234641.aspx
