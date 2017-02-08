---
author: abloz
comments: true
date: 2007-05-11 09:31:59+00:00
layout: post
link: http://abloz.com/index.php/2007/05/11/mimic-the-focus-of-advertising-images-sina-mobile-channel-switching-code/
slug: mimic-the-focus-of-advertising-images-sina-mobile-channel-switching-code
title: 模仿新浪手机频道焦点广告图片切换的代码
wordpress_id: 210
categories:
- 技术
tags:
- javascript
- 广告
---

下面的代码,将var pics注释掉的部分去掉,然后到[http://auto.qq.com/flash/playswf.swf](http://auto.qq.com/flash/playswf.swf) 去 将flashplayer存下来,将下面的代码放到一个html文件中,和playswf.swf文件放一起,即可看到图片切换效果.

<pre lang="javascript">

<script type="text/javascript">
<!--

var focus_width=277
var focus_height=200
var text_height=20
var  swf_height = focus_height+text_height
var  pics='U1696P2T1D1495648F3647DT20070508094442.jpg|U513P2T1D1495647F3647DT20070508091630.jpg|U513P2T1D1495400F3647DT20070508095710.jpg|90024_mobile-focus.JPG'
// var   pics='http://image2.sina.com.cn/IT//mobile/n/2007-05-08/U1696P2T1D1495648F3647DT20070508094442.jpg|http://image2.sina.com.cn/IT//mobile/n/2007-05-08/U513P2T1D1495647F3647DT20070508091630.jpg|http://image2.sina.com.cn/IT//mobile/n/2007-05-08/U513P2T1D1495400F3647DT20070508095710.jpg|http://ad4.sina.com.cn/200704/25/90024_mobile-focus.JPG'
var   links='http://tech.sina.com.cn/mobile/n/2007-05-08/07261495648.shtml|http://tech.sina.com.cn/mobile/n/2007-05-08/07261495647.shtml|http://tech.sina.com.cn/mobile/n/2007-05-08/0004303887.shtml|http://sina.allyes.com/main/adfclick?db=sina^bid=79326,111821,111947^cid=0,0,0^sid=103964^advid=3843^camid=15037^show=ignore^url=http://gd.sina.com.cn/ad/gionee2007_l6/index.html'
var  texts='卖得最好的手机有着不一般的魅力……|今年的股市可谓牛气冲天……|想悄悄爱上一部智能手机吗……|超长待机超大屏幕金立L6待机王'
document.write('<object ID="focus_flash"  classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"  codebase="flash/swflash.cab#version=6,0,0,0">http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"  width="'+ focus_width +'" height="'+ swf_height +'">');
document.write('<param  name="allowScriptAccess" value="sameDomain"><param name="movie"  value="playswf.swf"><param name="quality"  value="high"><param name="bgcolor" value="#FFFFFF">');
document.write('<param  name="menu" value="false"><param name=wmode value="opaque">');
document.write('"<param  name="FlashVars"  value="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'">');
document.write('<embed  ID="focus_flash" src="playswf.swf">playswf.swf" wmode="opaque"  FlashVars="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'"  menu="false" bgcolor="#C5C5C5" quality="high" width="'+ focus_width +'"  height="'+ swf_height +'" allowScriptAccess="sameDomain"  type="application/x-shockwave-flash"  pluginspage="flashplayer">http://www.macromedia.com/go/getflashplayer"  />');  document.write('</object>');

//-->
</script>

</pre>
