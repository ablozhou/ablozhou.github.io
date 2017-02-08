---
author: abloz
comments: true
date: 2006-10-09 09:22:51+00:00
layout: post
link: http://abloz.com/index.php/2006/10/09/transparent-flash-source/
slug: transparent-flash-source
title: 透明flash源码
wordpress_id: 189
categories:
- 技术
tags:
- flash
- 透明
---

本实例用于实现flash和图片的一体。
如鱼在大海里游，大海可以是一张背景。又如星星在天空闪烁，天空可以是一张背景。


    
    
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td background="aaa.gif" height="210">
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0" width="750" height="210">
    <param name="movie" value="aaa.swf">
    <param name="quality" value="high">
    <param name="wmode" value="transparent">
    <embed src="aaa.swf" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" wmode="transparent" type="application/x-shockwave-flash" height="210" width="750" quality="high">
    </embed>
    </object>
    </td>
    </tr>
    </table>
    
