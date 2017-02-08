---
author: abloz
comments: true
date: 2006-01-11 02:27:24+00:00
layout: post
link: http://abloz.com/index.php/2006/01/11/css-div-make-frame/
slug: css-div-make-frame
title: 用CSS 而不是Table来制作圆角框
wordpress_id: 125
categories:
- 技术
tags:
- css
- div
- frame
- table
---


	


	


	


	  

	


	


	


	


	


	


	周海汉：用CSS而不是表格Table来做圆角的框   

	CSS的[
	箱子模式](http://www.htmldog.com/guides/cssbeginner/margins/)
	： 


	作者：[
	周海汉](http://abloz.com/)
	  

	msn: ablo_zhou@hotmail.com   

	QQ: 7268188 


	


	在网页制作中，为了美观，需将边框制作成圆角。以往都是采用表格来定位。而表格嵌套有许多缺陷。能不能不用表格直接用CSS制作漂亮的圆角边框？这是我自己用CSS制作的一个例子。查看原文件就可以看到，这个框架没有一处用到Table。


	


	margin:加边，设置后会导致元素的框移动，页边空白增加   

	padding:填料，框内部的空白会增加   

	border：元素的框 


	


	也可直接设置元素的这几个属性的四边。  

	margin-top, margin-right, margin-bottom, margin-left, padding-top, padding-right, padding-bottom , padding-left 


		


		Margin box 


		Border box 


		Padding box 


	Element box 


	


	





  

	


	


	


	


	


	


	


		  



	


	


	










源码：

    
    
    <div style="BACKGROUND: #ccff66">
    	<div style="BACKGROUND: url(/imgs/pic_01.gif) no-repeat left top; WIDTH: 45%">
    	<div style="BACKGROUND: url(/imgs/pic_02.gif) repeat-x right top; MARGIN-LEFT: 20px; MARGIN-RIGHT: 20px">
    	<div style="BACKGROUND: url(/imgs/pic_03.gif) no-repeat right top; MARGIN-RIGHT: -20px">
    	<br style="BACKGROUND: #ffffcc"></br>
    	  </div>
    	</div>
    	<div style="MARGIN-TOP: -45px; BACKGROUND: url(/imgs/pic_04.gif) repeat-y left top">
    	<div style="MARGIN-TOP: 30px; BACKGROUND: #ffffff; MARGIN-LEFT: 20px">
    	<div style="BACKGROUND: url(/imgs/pic_06.gif) repeat-y right top; MARGIN: -2em 0px 20px; PADDING-TOP: 25px">
    	<div style="BACKGROUND: #ffffcc; MARGIN-LEFT: 20px; MARGIN-RIGHT: 20px">
    	周海汉：用CSS而不是表格Table来做圆角的框 <br></br>
    	CSS的<a href="http://www.htmldog.com/guides/cssbeginner/margins/">
    	箱子模式</a>
    	： <p>
    	作者：<a href="http://abloz.com/">
    	周海汉</a>
    	<br></br>
    	msn: ablo_zhou@hotmail.com <br></br>
    	QQ: 7268188 </p>
    	<p>
    	在网页制作中，为了美观，需将边框制作成圆角。以往都是采用表格来定位。而表格嵌套有许多缺陷。能不能不用表格直接用CSS制作漂亮的圆角边框？这是我自己用CSS制作的一个例子。查看原文件就可以看到，这个框架没有一处用到Table。</p>
    	<p>
    	margin:加边，设置后会导致元素的框移动，页边空白增加 <br></br>
    	padding:填料，框内部的空白会增加 <br></br>
    	border：元素的框 </p>
    	<p>
    	也可直接设置元素的这几个属性的四边。<br></br>
    	margin-top, margin-right, margin-bottom, margin-left, padding-top, padding-right, padding-bottom , padding-left </p>
    		<div style="PADDING-RIGHT: 1em; PADDING-LEFT: 1em; PADDING-BOTTOM: 1em; MARGIN: 0px 2em 1em; PADDING-TOP: 0px; BACKGROUND-COLOR: #ccf">
    		Margin box <div style="PADDING-RIGHT: 1em; PADDING-LEFT: 1em; PADDING-BOTTOM: 1em; PADDING-TOP: 0px; BACKGROUND-COLOR: #66f">
    		Border box <div style="PADDING-RIGHT: 1em; PADDING-LEFT: 1em; PADDING-BOTTOM: 1em; PADDING-TOP: 0px; BACKGROUND-COLOR: #99f">
    		Padding box <div style="BACKGROUND-COLOR: white">
    	Element box </div>
    	</div>
    	</div>
    </div>
    <br></br> 
    	</div>
    	</div>
    	</div>
    	</div>
    	<div style="BACKGROUND: url(/imgs/pic_07.gif) no-repeat left bottom;margin-top: -40px ">
    	<div style="BACKGROUND: url(/imgs/pic_08.gif) repeat-x right bottom; MARGIN-LEFT: 15px">
    	<div style="PADDING-LEFT: 25px; BACKGROUND: url(/imgs/pic_09.gif) no-repeat right bottom; MARGIN-LEFT: 20px">
    		<br></br> </div>
    	</div>
    	</div>
    	</div>
    </div>
    
    
    
    
    
    
    
    
    
