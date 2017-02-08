---
author: abloz
comments: true
date: 2008-03-31 01:05:43+00:00
layout: post
link: http://abloz.com/index.php/2008/03/31/change-c-program-using-the-vim-editor/
slug: change-c-program-using-the-vim-editor
title: '[转]使用vim编辑C程序'
wordpress_id: 263
categories:
- 技术
- 转载
tags:
- c
- vim
---

**使用VIM编辑C程序
**Siddharth  Heroor

译：mingleiChen

**修订历史**
修订版v1.0 Jan 14, 2001  Revised by: sh
第二版，修正了一下排版错误
修订版v0.1 Dec 04, 2000 Revised by: sh
第 一版，我很愿意听到你的反馈
本文对使用Vim进行编辑C或其他语言（如C++、JAVA）的程序做了简单的介绍。

**内容
1.介绍
2.范围内移动(Moving around)
2.1  w,e,b按键
2.2 {,},[[,]]按键
2.3 %按键
3.在C文件中任意跳转
3.1 ctags
3.2  marks
3.3 gd按键
4.自动单词完成
5.自动格式化
5.1 限制列宽
5.2 自动匹配代码
5.3  注释
6.多文件编辑
7.快速修正
8.版权
9.参考**

**1.介绍**
本文档的目的是为VIM的新手用户编辑C语言文件提供可行的编辑选项.文档介绍了一些常用的命令和按键,它们能够有效的提高程序员书写C源代码的速度.
文档主要描述了如何使用VIM编辑C语言文件.本文描述的大部分内容同样适用于vi,此外,文中谈到的关于编辑C文件的内容或多或少的适用于 C++,JAVA及其他相似的语言.

**2.Moving around
2.1 按键w,e,b
** 用户可以使用w,e,b键在文件中移动.VIM可以识别C表达式中的不同符号.
看看下面的C代码：

图1

[![](http://abloz.com/wp-content/uploads/2010/07/C1-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C1-full.jpg)

假设光标处于if语句的开始处,当按下w键,光标将跳至第一个(.再按一次w,光标将跳至NULL.再按将跳至==,接下来的按键会分别带你到 x..)... &&... y... >... z... 最后到)...
按键e的作用与w相似,只是它会带你到当前单词的末尾,而不是下个单词的开始处.
而按键b的功能与w完全相反,当你按下它,它从相反的方向开始移动光标.如上例, 将)...z...>...y...&&...)...x..最后是(...
**2.2  按键{,},[[,]]
** {和}用于在文档中的段落间移动.当编辑C程序时,这些按键表现出些许不同的含义.下面是一段程序,包含了几个空行.例如：

图2

[![](http://abloz.com/wp-content/uploads/2010/07/C2-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C2-full.jpg)

上面的片断显示了两个段落,用户通过使用｛和｝键能够很容易的从一段开始移至另一个开始。｛将带领光标至段首，而｝则把光标移至段尾。许多人喜欢这样的编 码样式，把逻辑上的一组语句组织成段，然后使用空行分割它们。例如：

图3

[![](http://abloz.com/wp-content/uploads/2010/07/C3-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C3-full.jpg)

在这样的场合，｛和｝显得非常有用。用户很轻松的就可以从‘一段’移至另一段。  另一种有用的按键是[[和]]，这一对按键将把你的光标带至｛之前或是｝之后的第一列。例如：

图4

[![](http://abloz.com/wp-content/uploads/2010/07/C4-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C4-full.jpg)

假设你正在编辑函数foo()，突然你想转去编辑bar()，这时只需按]]，光标会带你到函数bar()的第一个{处。用户可以按[[回到foo()的 开始。
其他相似的按键集是][和[]，][将把光标带至下一个位于第一列的}。例如你在编写foo()时需要转到foo()的结尾，这时只需要按][就可以做 到。类似的，在你编写bar()的时候若需要移到foo()的结尾，按[]可以帮你做到这点。
记住这些按键的使用方法可以这样做，第一个按键指示 了它将把光标向上移还是向下移。[向上移而]向下移。第二个按键则表示将匹配那个符号。类似的，[匹配{，并将光标移向它。]将光标移向}。
关于 ]]，][，[[，[]的一个警告：它们只匹配第一列上的符号。如果用户想让这些按键匹配不管是不是第一列上的符号。VIM的文档有相关的介绍。用 户可以自定义按键映射来找到那些符号。事实上，你不需要花费太多的时间在映射上。下面推荐的映射能很好的完成那些功能。
**:map  [[ ?{<CTRL−VCTRL−M>w99[{**

**:map ][  /}<CTRL−VCTRL−M>b99]}**

**:map ]]  j0[[%/{<CTRL−VCTRL−M>**

**:map []  k$][%?}<CTRL−VCTRL−M>**

**2.3 按键%
** %用来匹配光标之后的下一个项目，可以是一个圆括号，一个大括号或是一个方括号。通过按%键，光标自动跳到相应的匹配处。
此外，%也可以用来匹配#if，#ifdef，#else，#elif和#endif。
该按键在确认写好的代码时十分有用。例如：

图5

[![](http://abloz.com/wp-content/uploads/2010/07/C5-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C5-full.jpg)

检查上面的代码包括检查圆括号使用的正确与否。%用来从一个圆括号跳到它对应的另一个。因此，用户可以找到多写或少写的圆括号，并修正。
类似的，%也可以用来在{和它对应的}间跳转。

**3.在文件中任意位置跳转**
**3.1  ctags
** Tag是有序的位置保持集。Tags对于理解和编辑C十分有用。它们是C文件中的书签集。当你需要从某个被调用的函数出发跳转到它的定义并随时跳回 时，Tags十分有用。

来看看下面的例子：

图6

[![](http://abloz.com/wp-content/uploads/2010/07/C6-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C6-full.jpg)

假设你正在编辑函数foo()，而你想看看函数bar()的定义。此时就可以使用Tags。用户可以跳转到bar()的定义，然后跳回来。如果需要，甚至 可以跳转到另一个被bar()调用的函数去，接着再跳转回来。那么，要如何使用Tags呢?用户首先需要对所有源文件使用程序ctags。它将建立一个名 为tags的文件。该文件包含了VIM编写的每个函数定义的指针。通过这些指针，很轻松的就能找到所有的函数。确切的用于跳转的按键是CTRL-]和 CTRL-T，分别用于向后查找和向前返回。继续看前面的例子，当在函数foo()中bar()被调用的位置上按下CTRL-]，光标自动跳转至函数 bar()的开始处。然后你可以按CTRL-T从bar()中返回到foo()。

程序ctags按照如下方式调用：**$  ctags options file(s)**

为当前目录下所有c文件生成tags，输入命令：**$ ctags *.c**

如果某一文件夹中不同子目录中包含C文件，用户可以在主目录下调用命令：**$ ctags −R *.c**来生成各个文件 的tags。

关于ctags还有许多的选项，可以查看ctags的手册来获得更多信息。

**3.2 marks
** Marks和Tags很像，但是marks可以被设置在文件中的任意位置，而不仅仅是在函数，枚举处。此外marks必须用户手动设置。  设置一个mark没有显式的标记。mark只是VIM记着的一个文件位置。例如下面的代码：

图7

[![](http://abloz.com/wp-content/uploads/2010/07/C7-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C7-full.jpg)

假设你正编辑行:x++;你希望在你编辑完其他行后能够快速的返回到该行。这时你可以通过按键m'来为该行设置一个mark，然后按''回到该行。

VIM允许你设置多个mark，这些mark保存于寄存器a-z，A-Z以及1-0。例如，设置一个mark并保存于寄存器j，可以按mj，返回该 mark可以按'j。
设置多个mark在前进或后退到某片代码显得十分有用。来看这个例子。用户可以在x++处设置一个mark，在y=x处再设置一个，然后再这两个mark 中来回跳转。

Marks甚至可以在文件间跳转。用户可以使用寄存器A-Z来实现此功能。寄存器a-z只能在文件里不同代码块间跳转。也就是说，如果你在文件foo。c 中设置了mark，使用的是寄存器a，那么到另一个文件中按下'a并不能将光标移到foo。c中的mark位置。如果你需要一个能够带你到另一个文件的 mark，就得使用大写的寄存器A-Z。例如，用mA代替ma。在接下来的章节里我将讨论如何进行多文件编辑。

**3.3按键gd**
先来看看下面的代码：

图8

[![](http://abloz.com/wp-content/uploads/2010/07/C8-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C8-full.jpg)

假设由于某些原因你忘记了y和z是什么而想快速的找到它们的定义。一种方法是向后查找y和z。VIM提供了另一种更加简单而快捷的方案:类似于goto定 义的按键gd。当光标在y上，你按gd，这时光标将自动跳转到y
的定义：struct Y y;
另一个相似的按键是gD。它会带你到变量的全局定义处。所以如果用户想查看x的定义，按gD便可以了。

**4.自动补完单词
** 先看看下面的代码：

图9

[![](http://abloz.com/wp-content/uploads/2010/07/C9-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C9-full.jpg)

函数A_Very_Long_Function_Name()可能要一遍又一遍输入，在插入模式，用户可以通过前向或后向搜索自动补完单词。在函数 Another_Function中，用户可以输入A_Very...然后按下Ctrl-P，第一个匹配到的单词将显示。在例子中，它显示为 A_Very_Long_Variable_Name，如果匹配的不符合你的需求，可以再按Ctrl-P，继续搜索下个匹配的单词，显示为 A_Very_Long_Function_Name。一旦单词匹配正确，你就可以继续书写程序了。在整个过程中VIM保持插入状态。
和Ctrl-P类似的按键是Ctrl-N，它先向前搜索最匹配的。这两组按键相同的是到达文件顶部或底部后都将自动继续搜索。
CTRL-P和CTRL-N都是模式CTRL-X的一部分，而CTRL-X又是insert模式的子模式。所以当你再insert模式下的时候就可以进入 该模式。离开CTRL-X模式可以通过除了CTRL-P，CTRL-N，CTRL-X的按键来实现。一旦离开CTRL-X模式，你将回到insert模 式。
CTRL-X模式下你可以有多种方式来实现自动补完。你甚至可以自动补完文件名。这在你写include头文件的时候很有用。例如通过下面的方式，你可以 包含一个foo.h文件。

**#include "f CTRL−X  CTRL−F"**
是的，是CTRL-X  CTRL-F，听起来很象emacs。在CTRL-X模式下，你还可以做很多其他事情。其中之一就是字典补完(Dictionary  completion)。字典补完允许用户指定一个包含了关键字的文件，它可以用于自动补全单词。默认状态下字典选项是没有设置的。该选项可以通过命令**:set  dictionary=file**来设置。通常用户可以在字典文件里输入C关键字，typedefs，#defines。C++和 java程序员可能更喜欢添加类名。
字典文件的格式十分简单，仅仅是每行一个单词就可以了。一个C字典文件看起来就像下面的图一样。

图10

[![](http://abloz.com/wp-content/uploads/2010/07/C10-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C10-full.jpg)

使用字典补完，用户需要按CTRL-X  CTRL-K。补全单词的方式很像按键CTRL-P和CTRL-N。所以，例如要输入'typedef'，只需要按CTRL-X  CTRL-K然后选择就好了。

**5.自动格式化
5.1 格式化列宽
** 用户通常希望使用80或75的列宽。这可以通过命令**:set textwidth=80**轻松的实现。

可以将该命令写进你的.vimrc文件中，它将自动执行。
如果你需要在确定的文本宽度下自动换行，命令如下，通常该选项在终端下已经既定了。

** :set  wrapwidth=60**
上面的命令设置文本宽度为60列。
**5.2自动缩进代码
** 在C编码时，用户常常想要indent缩进内嵌代码块。若要在编码时自动完成它，VIM提供了一个叫做cindent的选项。使用下面的命令来完成:
** :set cindent
** 通过设置cindent，代码变得很漂亮。你可以把上面的命令加进你的.vimrc文件中，让它自动执行。
**5.3注释
** VIM也可以让你自动格式化注释。你可以把注释分解成3块:开始部分。中间部分和结束部分。例如，你的编码格式需求可能需要注释表示为如下样式：

**/*
* This is the  comment
*/**
在这个例子里，你可以使用下面的命令来格式化它。

**:set  comments=sl:/*,mb:**,elx:*/**
我来解释一下这个命令，命令分成三个部分。第一部分是sl:/*，这告诉VIM注释包括三块，以/*开始。下一部分告诉VIM中间的注释是*，最后一部分 告诉VIM几件事。一是注释要以*/结尾，另一是当你按下/时它会自动补完注释。
我们再来看一个例子。假设你的注释样式如下：

**/*
** This is the  comment
*/**
你可以输入这条命令：

**:set  comments=sl:/*,mb:**,elx:*/**
插入一条注释时，输入/*并按回车。下一行会自动填上**，当你写完一行注释后按回车，下一行又会自动补上**，如果你想要结束注释，不需要删除一个*再 补上一个/，只要按/，VIM会自动结束注释。怎么样，VIM聪明吧。

**6.多文件编辑
** 用户可以一次编辑多个文件。例如，你可以同时编辑一个头文件和源代码文件。若想一次编辑更多文件，按下面的命令调用VIM。

**$ vim file1 file2 ...**

现在，你就可以先编辑第一个文件，同时可以使用命令：n移至下一个文件。 你也可以使用命令：e#返回上一个文件。  当你编码时，同时可以看到两个文件而且能在它们之间切换应该很有用。换句话说，如果屏幕被分成两部分，上面显示头文件，下面显示代码文件，对你的编程应该 很有用。Vim有这样一个命令可以实现该功能。输入命令：split即可。

在两个窗口中显示相同的文件，无论调用了什么命令，都只将影响处于焦点的窗口。于是用户可以使用命令：e file2来在另一个窗口中编辑另一个文件。

执行完那个命令后，你将发现有两个文件处于可视状态。一个窗口显示第一个文件，而另一个窗口显示了第二个文件。在这两个文件间切换可以使用命令 CTRL-W。

使用帮助来获取更多关于窗口分割方面的知识。

**7.快速查错
** 当你编写C程序时常常会陷入编辑-编译-编辑的循环中。典型的例子就是你在使用其他软件编辑C文件时，保存文件，编译代码，然后找到错误再重新编辑。 VIM使用了一种叫做快速查错的模式来加快这一循环过程。基
本上用户需要把编译器错误保存到一个文件。然后用下面的命令打开这个文件。

**$ vim −q  compiler_error_file**
VIM将会自动打开包含错误的文件并定位到第一个错误。
使用命令"make"，用户可以自动编译代码并跳转到第一个出错的位置。按下面的方式调用make命令。

**:make**
基本上，该命令调用了shell下的make，并转到第一个错误上。然而，如果你不是用make来编译而用例如cc之类的命令编译，那么你得为make命 令设置一个称作makeprg的变量。例如**:set makeprg=cc foo.c**
设置完makeprg之后，你就可以使用make并快速查错了。
在你改完第一个错误后，若要修改第二个错误，可以使用命令:cn
返回第一个错误用命令:cN
我将给出几个例子做示范。看看下面的代码:

图11

[![](http://abloz.com/wp-content/uploads/2010/07/C11-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C11-full.jpg)

你可以看到第5行有个错误。文件保存为test。c，makeprg也用命令::set makeprg=gcc test.c设置了。
接下来使用命令make，gcc给出了如下的错误提示

图12

[![](http://abloz.com/wp-content/uploads/2010/07/C12-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C12-full.jpg)

按下回车，光标自动移至第6行。
现在命令:cn将把光标移至第4行
用命令:cN返回上一个错误，光标会移到第6行。
改完错误后，用户再执行:make，成功了。

图13

[![](http://abloz.com/wp-content/uploads/2010/07/C13-full.jpg)](http://abloz.com/wp-content/uploads/2010/07/C13-full.jpg)

这只是一个很小的例子，你可以使用快速查错功能来解决编译时的问题。而且尽可能的减少编辑-编译-编辑的循环时间。

**8.版权**
Copyright(c)2000，2001 Siddharth Heroor 在GNU  FDL协议许可的范围内，本文可以拷贝，发布或是修改。v1。1及其后版本通过FSS出版。可以在[http://www.gnu.org/copyleft/fdl.html](http://www.gnu.org/copyleft/fdl.html)找 到一份license的拷贝。

**9.参考**
你可以从VIM上获得更多信息，请到[www.vim.org](http://www.vim.org/)上 下载。[gallery link="file"]
