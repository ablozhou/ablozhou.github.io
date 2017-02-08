---
author: abloz
comments: true
date: 2005-10-08 22:23:17+00:00
layout: post
link: http://abloz.com/index.php/2005/10/09/winrar_installer/
slug: winrar_installer
title: 用winrar制作安装程序【转】
wordpress_id: 522
categories:
- 转载
---

 　　利用winrar还能制作安装程序，你不相信吧？下面笔者就以program.exe为例介绍制作过程。


　　第一步：需要把程序program.exe和附加文档如readme.exe、license.txt放到一个文件夹中。 




　　第二步：右键单击该文件夹，选择“添加到压缩文件..”，在弹出的窗口中勾选“创建自解压格式压缩文件”。




　　第三步：选择“高级”标签，单击“自解压选项”按钮，在“常规”标签页中的“解压路径”中输入c:program
filesprogram，在“解压后运行”中输入主程序名“program.exe”。




　　第四步：点击“高级”标签，单击“添加快捷方式”选择一个创建目的地，如“开始菜单/程序”，在“源文件名、目标文件夹、快捷方式描述、快捷方式名”中填写必要的参数，确定退出。




　　第五步：在“模式”标签页中勾选“解包到临时文件夹”，在“可选的询问、询问标题”中填写是否要求安装之类的文字，以便创建一个询问窗口。




　　第六步：在“文本和图标”中加载readme.txt中的内容做为程序的说明，并用“浏览”按钮为程序添加一个图标。




　　第七步：在“许可”标签中加载license.txt的内容，最后一路确定退出，生成安装程序program.exe。当双击该程序，程序会自动运行，并询问你是否安装，并在安装过程中显示reame.txt和license.txt中的内容。不过，由于采用winrar制作安装程序，不能向windows目录和注册表中添加文件和信息，因此是适合于制作绿色软件。
