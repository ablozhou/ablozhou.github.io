---
author: abloz
comments: true
date: 2010-09-03 09:02:02+00:00
layout: post
link: http://abloz.com/index.php/2010/09/03/openoffice-writer-template-production-tutorial/
slug: openoffice-writer-template-production-tutorial
title: OpenOffice Writer模板制作教程
wordpress_id: 378
categories:
- 技术
tags:
- openoffice
- 教程
- 模板
---

周海汉 2010.9.3

http://abloz.com

转载请包含原作者信息。

操作系统：ubuntu 10.04, openoffice版本，3.2. 在ubuntu下办公，免不了要用openoffice。MS word有很好的模板，OpenOffice有吗？如果公司需要统一的文档格式，或者写的文档较多，称手的文档模板是很必要的。所以摸索了一下openoffice文档模板制作方法，并应用到工作中。

不过我也发现openoffice文档格式在ms word2007中并不完全兼容。

附送小窍门：OpenOffice 按F9刷新字段。

步骤：


## 1.新建一个空白文档


[![](http://abloz.com/wp-content/uploads/2010/09/Screenshot-10-300x228.png)](http://abloz.com/wp-content/uploads/2010/09/Screenshot-10.png)


## 2.设置缺省字体为“文泉驿正黑”


工具->选项，Openoffice.org Writer基本字体（中日韩），所有字体设置为“文泉驿正黑”。如果有“宋体”，建议都选为宋体，以方便与MS Office显示兼容。一些字体可能在MS Office中引起大小正斜黑体等不一致的毛病。 设置如图：

[![](http://abloz.com/wp-content/uploads/2010/09/Screenshot-选项-OpenOffice.org-Writer-基本字体（中日韩）.png)](http://abloz.com/wp-content/uploads/2010/09/Screenshot-选项-OpenOffice.org-Writer-基本字体（中日韩）.png)


## 3.增加标题


插入->字段->标题。将标题样式调整为“标题”，居中，字体大小选一号。总之调整到你需要的标题的样子。


## 4.设置标题


在 文件->属性 中设置标题为“我的文档”，然后按F9刷新，以看到效果。

[![](http://abloz.com/wp-content/uploads/2010/09/Screenshot-未命名-2-OpenOffice.org-Writer-3.png)](http://abloz.com/wp-content/uploads/2010/09/Screenshot-未命名-2-OpenOffice.org-Writer-3.png)


## 5.插入页眉和页脚


插入->页眉，插入->字段->标题；靠右排版。此时页眉已经插入标题。

插入->页脚，插入->字段->页码；靠右排版。此时页脚已经插入页码。

可以根据需要编辑。


## 6.增加目录


光标放在标题后面。插入->手动分隔符->换页。进入下一页。

插入->目录->目录。缺省确认即可。

[![](http://abloz.com/wp-content/uploads/2010/09/Screenshot-插入目录.png)](http://abloz.com/wp-content/uploads/2010/09/Screenshot-插入目录.png)


## 7.增加修改历史


光标放在目录后面。插入->手动分隔符->换页。进入下一页。

标题取“修订历史”或“修改记录”，居中。

增加一个表格，记录版本号，日期，修改内容，修改作者。可以插入字段，以自动填充。


## [![](http://abloz.com/wp-content/uploads/2010/09/Screenshot-未命名-2-OpenOffice.org-Writer-2.png)](http://abloz.com/wp-content/uploads/2010/09/Screenshot-未命名-2-OpenOffice.org-Writer-2.png)8.增加正文页


光标放在修改记录的表格后面。插入->手动分隔符->换页。进入下一页。

输入“概述”。样式选标题1. 在“概述”上点右键，弹出菜单点“项目符号和编号”，点大纲页，选数字按章节编号的(第二个）。字体选二号。

换行，再输入“参考文档”，样式选“标题2”，字体选三号。


## 9.刷新目录


在目录列表上点右键，刷新目录。最终的样子：

[![](http://abloz.com/wp-content/uploads/2010/09/Screenshot-未命名-2-3-OpenOffice.org-Writer.png)](http://abloz.com/wp-content/uploads/2010/09/Screenshot-未命名-2-3-OpenOffice.org-Writer.png)


## 10.保存模板


文件->模板-保存，在弹出的对话框中取个模板名称如“mydoc”，即保存完毕。


## 11.测试模板


文件->新建->模板和文档，左边栏选模板，选刚才保存的模板路径中的模板，确认即可。[![](http://abloz.com/wp-content/uploads/2010/09/Screenshot-模板和文档-我的模板.png)](http://abloz.com/wp-content/uploads/2010/09/Screenshot-模板和文档-我的模板.png)
