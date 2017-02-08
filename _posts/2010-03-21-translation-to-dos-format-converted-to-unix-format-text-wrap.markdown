---
author: abloz
comments: true
date: 2010-03-21 06:48:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/21/translation-to-dos-format-converted-to-unix-format-text-wrap/
slug: translation-to-dos-format-converted-to-unix-format-text-wrap
title: '[译]将dos格式换行文本转为Unix格式'
wordpress_id: 1174
categories:
- 技术
---

原文：http://blogmag.net/blog/read/136/Convert_text_files_from_DOS_to_UNIX_and_vice_versa
周海汉 /译
注：本文是简译。

dos/windows的纯文本回车换行，即rn，记为CRLF，16进制为0d0a，Unix/Linux是n，16进制为0a, 记为LF, mac为r, 0a。

下面主要讲将rn 转为unix的n的方法。

$ file dosfile.txt
dosfile.txt: ASCII text, with CRLF line terminators

$ file unixfile.txt
unixfile.txt: ASCII text

使用tr

$ tr -d 'r' < dosfile.txt > unixfile.txt

使用vim

$ vim dosfile.txt
...
:set FileFormat = unix

 可以用:set FileFormat=dos
来转为dos格式。简写为FF。可以：help Fileformat来查看帮助。

使用emacs

 set-buffer-file-encoding-system
 函数设置coding-system。

M-x set-buffer-file-coding-system Unix

使用sed

$ sed 's/.$//' dosfile.txt  > new_unixfile.txt

将unix转dos格式

$ sed 's/$' "/`echo -e " r "`/" unixfile.txt > new_dosfile.txt

新版gnu sed：

$ sed 's/$/r/' unixfile.txt > new_dosfile.txt

使用perl

$ perl -p -e 's/r$//' < dosfile.txt > new_unixfile.txt

$ perl -p -e 's/$/r/' < unixfile.txt > new_dosfile.txt

使用awk

$ awk '{sub("r$", "", $0);print $0}' dosfile.txt > new_unixfile.txt

$ awk '{sub("$", "r", $0);print $0}' unixfile.txt > new_dosfile.txt

使用python

$ python -c "import sys; map(sys.stdout.write, (l[:-2] + 'n' for l in sys.stdin.readlines()))" < dosfile.txt  > new_unixfile.txt

还有其他的方法。对大文件，建议用sed,awk,perl,python，不建议用vi,emacs.

