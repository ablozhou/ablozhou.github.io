---
author: abloz
comments: true
date: 2010-02-16 05:13:00+00:00
layout: post
link: http://abloz.com/index.php/2010/02/16/translation-windows-secluded-ancient-chinese-character-input-method/
slug: translation-windows-secluded-ancient-chinese-character-input-method
title: ［译］Windows 古僻汉字输入方法
wordpress_id: 1137
categories:
- 技术
---

周海汉按：原文作者好南儿，采用上海话（吴语）写的blog，有点看不懂吴语。
    但他的知识和资料很到位，图文并茂，是篇很好的文章，应该花了不少心血。
    本人也不懂吴语，连蒙带猜翻译一下。方便普通话读者。误会之处，请原作者和读者海涵。
    原文地址：http://shanghaian.72pines.com/how-to-input-difficult-han-characters-in-windows/




## Windows  生僻汉字输入方法


2010/01/21 —  好南儿 


## 要点指南





	
  1. **0.2.4 Unifonts**

	
  2. 0.3.1 txt

	
  3. 1.4.2 BabelPad

	
  4. **2.1 紫光华宇拼音输入法**

	
  5. **2.3 海峰五笔**

	
  6. 2.7 逍遥笔

	
  7. **3.2 叶典**

	
  8. 4.1 表意描述序列




### 0.0  汉字与 Unicode


处理古僻汉字，就用 Unicode 字集里的汉字—— [目前收录的统一汉字已经有了 74394 ](http://shanghaian.72pines.com/unicode-5-2-and-babelmap-5-2/) [个 ](http://shanghaian.72pines.com/unicode-5-2-and-babelmap-5-2/) 。如果这里还找不到你要的字，那么就用 IDS 表示，文章不打印的话尽量不要自己造字。

Unicode 里汉字字块包括汉日朝统一表意字（ CJK 、汉统， 20940 个）、汉日朝统一表意字扩充甲（ Ext-A 、扩甲， 6582  个）、汉日朝统一表意字扩充乙（ Ext-B 、扩乙， 42711 个）、汉日朝统一表意字扩充丙（ Ext-C 、扩丙， 4149 个）、汉日朝部首增补、汉日朝笔 划、汉日朝兼容表意字、汉日朝兼容表意字增补等。下面我主要讨论汉日朝统一表意字四个字块七万五千个汉字。至于一般性的繁体字、异体字，任何支 持 GBK 个输入法（如微软、紫光、 Google ）全好解决，本文不再赘叙。


#### 0.0.1 Unicode 里的四块汉日朝统一表意字


<table cellpadding="0" cellspacing="0" align="center" border="1" >
<tbody >
<tr >
字面
字块
字数
汉字方面相当个国家标准
</tr>
<tr >

<td align="center" rowspan="3" valign="middle" >多语基本面（BMP）
</td>

<td align="center" rowspan="2" valign="middle" >汉统（CJK）
</td>

<td align="center" valign="middle" >后首增收38
</td>

<td align="center" valign="middle" >
</td>

<td align="center" valign="middle" >
</td>

<td align="center" valign="middle" >
</td>
</tr>
<tr >

<td align="center" valign="middle" >初建20902
</td>

<td align="center" valign="middle" >GBK
</td>

<td align="center" rowspan="2" valign="middle" >GB 18030:2000
</td>

<td align="center" rowspan="3" valign="middle" >GB 18030:2005
</td>
</tr>
<tr >

<td align="center" valign="middle" >扩甲（Ext-A）
</td>

<td align="center" valign="middle" >6582
</td>

<td align="center" valign="middle" >
</td>
</tr>
<tr >

<td align="center" rowspan="2" valign="middle" >表意增补面（SIP）
</td>

<td align="center" valign="middle" >扩乙（Ext-B）
</td>

<td align="center" valign="middle" >42711
</td>

<td align="center" valign="middle" >
</td>

<td align="center" valign="middle" >
</td>
</tr>
<tr >

<td align="center" valign="middle" >扩丙（Ext-C）
</td>

<td align="center" valign="middle" >4149
</td>

<td align="center" valign="middle" >
</td>

<td align="center" valign="middle" >
</td>

<td align="center" valign="middle" >
</td>
</tr>
</tbody>
</table>
Unicode 1.0.1 初建“汉日朝统一表意字”时，收字 20902 个， Unicode 4.1  增加 22 个字符， Unicode 5.2 又增加 16 个。 20902 个字符 GBK 全收入了， 22 个字符 GB 18030 收了 8 个部首。汉统（ Unihan) 里的 38 个字符一般的字库顶多显示 8 个，

![cjk-20902-8](http://shanghaian.72pines.com/files/2010/01/cjk-20902-8.png) <br />Unifonts 5.4 可以显示 22 个。


![cjk-20902-22](http://shanghaian.72pines.com/files/2010/01/cjk-20902-22.png) 

目前还没哪个字库、输入法完整支持汉统 20940 个字符，下面提到哪个字库、输入法，如没特别说明，“汉统”基本上指 20940 个字符的汉统。至于 GBK 、 GB 18030 里的私用区的字符这里不考虑。

尽管扩甲与扩乙里的字 GB 18030 全收录了，但是市面上支持扩甲的字库要比支持扩乙、扩丙的多（详见 0.1 节）。这个我想主要是因为前者位于 Unicode 多语基本面 （ BMP ），而位于表意增补面（ SIP ）的后者处理起来比较复杂，外加字库文件一般只容纳六万多个字符——而汉统加扩甲再加扩乙就要超过七万个了。


#### 0.0.2 Windows 对扩充汉字的支持


Windows 系统从 2000 版开始以 UTF-16 为机内码，也就是讲从这个版本开始支持位于表意增补面的扩乙、扩丙汉字。不过支持归支持，要正常显示出来还要另外找字库—— Win2k 发布的时候扩乙、扩丙还没有建立啊。

至于 2000 版之前的 Windows ，只好支持位于多语基本面的汉统与扩甲。


### 0.1  字库


上面讲过，有操作系统对 Unicode 编码的支持，还要靠相应的字库来显示。下载好字库，除了 exe 文件好自动安装之外，字库文件要你自己拖到 Windows ＼ Fonts 文件夹里。


#### 0.1.1  宋体 -18030


微软针对 Windows 2000 提供“ GB18030 Support Package” ，用来支持 GB 18030:2000 字集（汉统＋扩甲）。


#### 0.1.2  宋体 - 方正超大字符集


MS Office XP 、 2003“ 简体中文版”里，收字包括汉统＋扩甲＋部分扩乙（因为它是单个的字库文件，扩乙只好放一部分）。


#### 0.1.3 Windows Vista 、 7 里的宋体、细明体、黑体、楷体、仿宋


Windows Vista 与 7 里的黑体、楷体、仿宋全是支持 GB 18030:2000 的（汉统＋扩甲），宋体、细明体除了汉统、扩甲，还支持扩乙。


#### 0.1.4 Unifonts


海峰做的 Unifonts 5.4 （中日韩汉字超大字符集通用字体支持包）支持汉统 + 扩甲 + 扩乙 + 扩丙，包括宋体与细明体两套。

[直接下载 ](http://okuc.net/software/UniFonts.exe)

Vista 以后的宋体字库汉统与扩甲放到了 SimSun 里，扩乙放到 SimSun-ExtB 里；而 Uniconts 扩甲放在 Sun-ExtA 里，扩乙与扩丙放在 Sun-ExtB 里。


#### 0.1.5  楷体 - 方正超大字符集


文渊阁四库全书电子版 3.0 里，汉统＋扩甲＋扩乙。我也没用过，估计分两个文件的。

[下载页面 ](http://tw.subscriptionv3.skqs.com/skqs/download/) 


#### 0.1.6  宋体 - 全汉字集


采采卷耳做的字库，汉统 + 扩甲 + 扩乙。

[直接下载 ](ftp://ftp.cuhk.edu.hk/pub/cpatch/patchutil/unisong/unisonggbk1.01.exe)


#### 0.1.7 BabelStone Han


Andrew WEST 做的字库，对于汉日朝统一表意字没有完全支持，但是汉统最后的 38 个字符它全能显示。 
![cjk-20902-38](http://shanghaian.72pines.com/files/2010/01/cjk-20902-38.png) 

[直接下载 ](http://www.babelstone.co.uk/Fonts/BabelStoneHan.zip)


### 0.2  储存文档注意事项


讲如何输入古僻汉字之前，再啰嗦两句 GBK 外汉字如何储存的问题。![txt-unicode](http://shanghaian.72pines.com/files/2010/01/txt-unicode.png) 


#### 0.2.1 txt


储存的时候要选“ Unicode” ，你选“ ANSI” 只能储存 GBK 范围的汉字。


#### 0.2.2 html


储存时候 charset 要设为“ utf-8” ，你写“ charset=GB2312” 只能储存 GBK 范围的汉字。 
![charset-utf-8](http://shanghaian.72pines.com/files/2010/01/charset-utf-8.png) 


#### 0.2.3 sql


由于 [MySQL ](http://shanghaian.72pines.com/ten-lectures-on-unicode-ii/) [本身的失误 ](http://shanghaian.72pines.com/ten-lectures-on-unicode-ii/) ，用它做数据库的论坛（如 Discuz! ）、博客（如 WordPress ）通常不支持位于 SIP 的扩充汉字。好南儿博客对于扩充汉字 [全用 IDS ](http://shanghaian.72pines.com/standardized-chinese-characters-table-for-universal-use/) [表示 ](http://shanghaian.72pines.com/standardized-chinese-characters-table-for-universal-use/) ，尽管 MySQL 支持扩甲。


#### 0.2.4  余论


现在除了汉语言文字专题论坛、在线汉语辞典、基于 Wiki 的网站，基本上没有网站支持扩充汉字。搜索引擎里， Google 支持扩充汉字，“更懂中文”的百度不支持。 
![du-in-google-baidu](http://shanghaian.72pines.com/files/2010/01/du-in-google-baidu.png) 


### 1.0  找字


现在正式介绍如何输入了。这节是写给 不常打古僻汉字的同好看的 。


### 1.1 “ 字符映射表”


来到“附件＼系统工具”里。选好“字体”，选中“高级查看”，再选“字符集”、“分组”。双击需要的字符再点“复制”就能拷到你需要的地方。不过只好找找 GBK 范围内的汉字。 
![charmap](http://shanghaian.72pines.com/files/2010/01/charmap.png) 


### 1.2 MS Word


插入＼符号，选“字体”、“子集”，双击字符就能插入。支持汉统＋扩甲＋扩乙＋扩丙，子集可选的取决于字体， Unifonts 扩乙与扩丙全放在 Sun-ExtB 里。 
![insert-characters-in-word](http://shanghaian.72pines.com/files/2010/01/insert-characters-in-word.png) 


### 1.3  其他 Office


2009 版的 OpenOffice.org Writer“ 插入＼特殊字符”、永中集成 Office“ 插入＼符号”、 WPS  文字“插入＼符号”用法类似 MS Word ，不过永中与 WPS 不支持 SIP 的扩充汉字。


#### 1.4.1 BabelMap


[BabelMap 5.2 ](http://shanghaian.72pines.com/unicode-5-2-and-babelmap-5-2/) 汉统（完整的 20902+38 ）＋扩甲＋扩乙＋扩丙全支持，在菜单里可以用部首、拼音（普通话、粤语）查汉字。

部首查字要小心，只有简化字是用大陆现在的标准数笔划，繁体字与没有简化的传承字全要按传统字形数。部首一律是康熙部首。如“骚”是马部九划，“騷”与“搔”分别是馬部十划、手部十划（传统字形“叉”左边还有一点）。 
![babelmap-5-2-ii](http://shanghaian.72pines.com/files/2010/01/babelmap-5-2-ii.png) 

[下载页面 ](http://shanghaian.ys168.com/)


#### 1.4.2 BabelPad


[BabelPad 5.2 ](http://shanghaian.72pines.com/shanghainese-version-of-babelpad-5-2-0-1/) 是包括 BabelMap 的文字编辑器（唯独不包括临时装载字库的功能），当然支持汉统（完整的 20902+38 ）＋扩甲＋扩乙＋扩丙。 
![unispim-6-51](http://shanghaian.72pines.com/files/2009/07/unispim-6-51.png) 

[下载页面 ](http://shanghaian.ys168.com/)


### 2.0  打字


上面的办法你偶然输入个把字还可以，但不能用于大量输入。这节就不讲找字了，讲如何打字。


### 2.1  紫光华宇拼音输入法


[紫光 6.6 ](http://shanghaian.72pines.com/unispim-6-6-0-31/) [版支持汉统＋扩甲＋扩乙＋扩丙，是汉拼输入法里唯一的。 ](http://shanghaian.72pines.com/unispim-6-6-0-31/) 拼音模式、笔划模式，全能输入。不过拼音模式收字不全，因为汉日朝统一表意字四个字块里有日语、朝鲜语、越南语、壮语、白语的造字，普通话读音是很困难的，也没有必要。而笔划模式不受影响，横竖楷书体系的字都可以用“ B ＋ h 横 s 竖 p 撇 n 捺 d 点 z 折”输入。 ![unispim-6-6-0-38](http://shanghaian.72pines.com/files/2010/01/unispim-6-6-0-38.png) 

记得早期的紫光 2.01 也是很早支持 GBK 的输入法之一，当时 Windows 系统输入法只有全拼输入法支持 GBK ，但是全拼的效率大家全有数。后来紫光以5.0版重出江湖的时候，居然不支持“大字符集”模式 ，好南儿也只好放弃了，直到两年 6.0 出现。

[下载页面 ](http://www.unispim.com/software/) 


### 2.2  其他拼音输入法


其他拼音输入法也只有吴语输入法（如 [上海话输入法 ](http://www.longdang.com/shanghaihua.aspx) ）能输入扩充汉字，不过仅限于扩甲、括乙里的吴语常用字。而基于汉拼的输入法顶多通过自己需要的扩充汉字放在“自定义短语”里这个方式来曲线救国，就像 [好南儿推荐紫光 6.5 ](http://shanghaian.72pines.com/unispim-6-5-0-10/) [时代所做的尝试 ](http://shanghaian.72pines.com/unispim-6-5-0-10/) 。这种方式要求输入法支持 Unicode ， [“谷歌”拼音输入法 ](http://tools.google.com/pinyin) 、 [加加输入法 ](http://dir.jjol.cn/Pyjj/) 可以做到。


### 2.3  海峰五笔


海峰五笔 9.5 支持汉统 + 扩甲 + 扩乙 + 扩丙，可选 86 或 98 的五笔规则。

[直接下载 ](http://okuc.net/software/SunWb.exe)


### 2.4  其他五笔输入法


[菩提五笔 ](http://www.fodian.net/tools/) 支持汉统 + 扩甲 + 扩乙 + 扩丙； [小鸭五笔 ](http://duckling.etext.cn/) 支持汉统 + 扩甲 + 扩乙。


### 2.5  文渊郑码


支持汉统 + 扩甲 + 扩乙 + 扩丙，扩丙可能有问题。

[下载页面 ](http://d.namipan.com/d/e0aab6207879ed9a22155ee35be3c8b1732f0d7c8caa1000) 


### 2.6  山人通用输入法


估计支持汉统 + 扩甲 + 扩乙 + 扩丙，估计汉统是完整的 20902+38 。输入码是山人全息编码。

[下载页面 ](http://freeeman.ys168.com/)


### 2.7  逍遥笔![xiaoyaobi-6-5](http://shanghaian.72pines.com/files/2010/01/xiaoyaobi-6-5.png)


逍遥笔 6.5 支持汉统 + 扩甲 + 扩乙，手写输入（用鼠标就可以了）。左下角的数字要选好—— 4 是 GB 2312 ， 5 是 GBK ， 6 是汉统＋扩甲， 7 再是汉统 + 扩甲 + 扩乙。

[直接下载 ](http://www.xiaoyaobi.com/xybi65.rar)


### 2.8  五代仓颉


第五代仓颉输入法 2008 年版支持汉统 + 扩甲 + 扩乙。

[下载页面 ](http://www.chinesecj.com/forum/viewthread.php?tid=462)


### 3.0  网上字典


介绍两个网站，主要是查字派用场。


### 3.1 Unihan


Unicode 官网，当然支持最新版的 Unicode ，支持汉统（完整的 20902+38 ） + 扩甲 + 扩乙 + 扩丙。

你好用罗马字查（粤语、北语、日语音读与训读、朝鲜语等），网址我不写——汉字同音字多得吓死人，用罗马字查字容易死机的。

也可以 [用部首查 ](http://www.unicode.org/charts/unihanrsindex.html) ，注意事项同 1.4.1 。


### 3.2  叶典


[叶典 ](http://www.yedict.com/) 上面你好用“两分法”寻古僻字。如要寻“⿱勿好”，你也用不着想部首是“丿”、“勹”、“女”还是“子”，就打“勿好”查。 
![yedict-com](http://shanghaian.72pines.com/files/2010/01/yedict-com.png) 
自称支持汉统＋扩甲＋扩乙＋扩丙＋扩丁＋扩戊。扩丁、扩戊两个字块 Unicode 还没有定呢，让它去。


### 4.0 Unicode 里没的字


遇到 Unicode 里没有的字，网友大概一般会需要这样描述：““牙合””、“ { 牙合 }” 、“左牙右合”……


### 4.1 IDS


我还是用 IDS （ Ideographic Description Sequence ，表意描述序列）比较好，看上去清爽。

先写个表示结构的表意描述符，如“⿰”，再写这个结构里用到的部件“牙合”，并拢来就是“⿰牙合”。

上面这个字还算简单，碰着复杂点的结构，要表意描述符（⿰⿱⿲⿳⿴⿵⿶⿷⿸⿹⿺⿻）嵌套组合。如“渠”是“⿱⿰氵巨木”——先讲它是上下结构，再 讲它上面是个左右结构的部件，左边是“氵”，右边是“巨”，左右结构描述完成，再讲上下结构下面是“木”。而“渠”加著“亻”的后起本字就好描述成“⿰亻 ⿱⿰氵巨木”。再复杂点，山西有种面的名字（“ biangbiang 面”）就是“⿺辶⿳穴⿲月⿱⿲幺言幺⿲長馬長刂心”。


### 4.2  造字


文章要打印出来，那没办法。如果在网络上面传来传去、电脑上面看看就可以了，那么还是不要去造字。因为造出来的字你的电脑上面可以看，传给人家，人家看不出。举个例子，比较啰嗦，可以不要看——因为好南儿例子举好也不会讲解造字。

09 年 7 月 27 号的《新民周刊》有篇王悦阳的《寻觅上海记忆》，在 [“谁是张承裕？”一节 ](http://xmzk.xinmin.cn/xmzk/html/2009-07/27/content_388203.htm) 里提到“张 聋⿱彭耳”。“⿱彭耳”是个上“彭”下“耳”的字，其实这个字扩充乙块里有了，但排印的时候是另外造字的，网上登出来个是“张聋■”。虽然讲他们造的字我看不到，但是凭吴语语感猜得出那缺字是“⿱彭耳”。 [凤凰网转载 ](http://finance.ifeng.com/news/history/jjsh/20090728/1003294.shtml) ，把“■”当垃圾全部去掉，那么读者就不晓得缺少的字。 [人民网转载 ](http://sh.people.com.cn/GB/134816/134818/9701267.html) 还要过分，将所有“张聋■”改成了“张承裕”、“张”。文中一句“张聋■这个古怪的名字的由来本身就充满着传奇色彩”变成了“张承裕这个古怪的名字……”，也不晓得“张承裕”这个名字怪在啥地方。


## 5.0  参考


白云深处人家 [《計算機漢字處理基本知識  漢字字體下載》](http://www.byscrj.cn/jmm/indexComputing.htm)[ ](http://www.byscrj.cn/jmm/indexComputing.htm)


![](http://img.zemanta.com/pixy.gif?x-id=934d681b-f524-88d9-8e68-3586be680cc1)
