---
author: abloz
comments: true
date: 2011-09-13 08:19:36+00:00
layout: post
link: http://abloz.com/index.php/2011/09/13/css3-truncate-overflow-text/
slug: css3-truncate-overflow-text
title: css3文本溢出截断
wordpress_id: 1417
categories:
- 技术
---

作者 周海汉 abloz.com
2011-9-14
网页中有时需要对过长文本进行截断。如标题太长，又不能换行，此时可以用三个点省略号(...)进行替换不能显示的内容，或直接截断。这在手机小屏显示中尤其有用。

CSS3中有text-overflow属性。text-overflow可以分为两个属性：text-overflow-mode，控制截断显示方式，text-overflow-ellipsis：控制截断显示字符。二者合起来就是text-overflow:ellipsis|clip。

text-overflow-mode 的值：clip | ellipsis | ellipsis-word 初始值为clip,截断。对所有块级元素起作用。

text-overflow-ellipsis的值：[<ellipsis-end> | <uri> [, <ellipsis-after> | <uri>]?] ，缺省是"...",还可以指定uri，如用图形来表示。

不过，firefox一直对text-overflow没有支持。其计划是firefox 7.0支持该属性。目前只能通过js，xul等其他方式来实现。



示例：



	
  1. p {  

	
  2.   white-space: nowrap;  

	
  3.   width: 100%;                   /* IE6 needs any width */  

	
  4.   overflow: hidden;              /* "overflow" value must be different from "visible" */   

	
  5.   

	
  6.   -o-text-overflow: ellipsis;    /* Opera 9-10 */  

	
  7.   text-overflow:    ellipsis;    /* IE, WebKit (Safari, Chrome), Firefox 7, Opera 11 */  

	
  8. }  


 其中，white-space:nowrap和overflow:hiden一定需要，否则光有text-overflow并不能达到想要的效果。opera 的早期版本用-o-text-overflow来设置。

我们只好等待firefox的新版 firefox7 ，来支持该属性了。


### 浏览器对文本截断CSS3兼容性：


<table >
<tbody >
<tr >
浏览器
最低版本
支持
</tr>
<tr >

<td >Internet Explorer
</td>

<td >**6.0**
</td>

<td >`text-overflow`
</td>

<td >`ellipsis | clip`
</td>
</tr>
<tr >

<td >Firefox (Gecko)
</td>

<td >**7.0** (7.0)
</td>

<td >`text-overflow`
</td>

<td >`ellipsis | clip`
</td>
</tr>
<tr >

<td rowspan="2" >Opera (Presto)
</td>

<td >**9.0** (2.0)
</td>

<td >`-o-text-overflow`
</td>

<td >`ellipsis | clip`
</td>
</tr>
<tr >

<td >**11.0** (2.7)
</td>

<td >`text-overflow`
</td>

<td >`ellipsis | clip`
</td>
</tr>
<tr >

<td >Safari | Chrome | WebKit
</td>

<td >1.3 | 1.0 | 312.3
</td>

<td >`text-overflow`
</td>

<td >`ellipsis | clip`
</td>
</tr>
</tbody>
</table>
IE8 有个`-ms-text-overflow，因不符合标准，不推荐使用。`

参考：

[http://www.w3.org/TR/2002/WD-css3-text-20021024/#text-overflow-props](http://www.w3.org/TR/2002/WD-css3-text-20021024/#text-overflow-props)

[https://developer.mozilla.org/en/CSS/text-overflow](https://developer.mozilla.org/en/CSS/text-overflow)

[http://cssshare.com/1/css3wen-ben-jie-duan-text-overflow](http://cssshare.com/1/css3wen-ben-jie-duan-text-overflow) 如何做firefox文本截断

[http://ipmtea.net/css/201011/16_407.html](http://ipmtea.net/css/201011/16_407.html) 文本截断示例
