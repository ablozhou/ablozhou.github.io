---
author: abloz
comments: true
date: 2011-09-19 03:01:14+00:00
layout: post
link: http://abloz.com/index.php/2011/09/19/android-phone-input-on-the-chinese-response-to-input-events/
slug: android-phone-input-on-the-chinese-response-to-input-events
title: android 手机输入对中文输入事件的响应
wordpress_id: 1420
categories:
- 技术
tags:
- android
- input
- js
---

周海汉 abloz.com

2011-09-19

用javascript脚本写了个input的textarea和text输入文字时统计字数的脚本，但发现在android和iphone手机中，输入中文事件计数不响应。但英文数字和标点符号则没有问题。

于是写了个记录输入事件的脚本：

    
    <html>
    <head>
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.3.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    $(document).ready(function() {
    
      var logA = $("#Log");
    
      $("#txtTest")
      .bind("keypress", function (e) {
          logA.val(logA.val()+" KeyPress: " + e.which );
      }).bind("keydown", function (e) {
          logA.val(logA.val()+" KeyDown: " + e.which );
     }).bind("keyup", function (e) {
          logA.val(logA.val()+" Keyup: " + e.which );
      }).bind("input", function (e) {
          logA.val(logA.val()+" Input!n");
      });
      $("#btnClear").click(function() { logA.val(""); });
    });
    </script>
    </head><body>
    <form action="#" method="get">
    <textarea style=" height: 100px; width:100%;" id="txtTest"></textarea>
    <input type="button" id="btnClear" value="clear"></input>
    </form>
    <textarea style="border: 1px solid red; font-size: 9pt; height: 100px; width:100%" id="Log"></textarea>
    </body>
    </html>


运行该html页面，发现如果输入英文数字和符号，会有

    
    KeyDown: 83 KeyPress: 115 Input!
     Keyup: 83 KeyDown: 70 KeyPress: 102 Input!


而如果粘贴文本或输入中文，则只有input事件。原来，用keydown，keypress，keyup已经不是输入事件的全集了，input代表了输入事件。

于是，对于字数的统计，js脚本可以这样写：

    
    <html>
    <head>
    <style type="text/css">
    .counter
    {
    	font-size:18px;
    	color:#D40D12;
    	float:right;
    }
    </style>
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.3.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    function recount(){
       var maxlen=140;
       var current = maxlen-$('#content').val().length;
       $('.counter').html(current);
    
       if(current<0 || current>=maxlen){
           $('.counter').css('color','#D40D12');
           $('input#submit').attr('disabled','disabled');
       }
       else
          $('input#submit').removeAttr('disabled');
       if(current<10)
          $('.counter').css('color','#D40D12');
       else if(current<20)
          $('.counter').css('color','#5C0002');
       else if(current>(maxlen-2))
       	 $('.counter').css('color','#D40D12');
       else
          $('.counter').css('color','#cccccc');
    }
    
    $(document).ready(function(){
      $('#content').bind("blur focus input", function(){
           recount();
       });
    })
    </script>
    </head><body>
    <form action="#" method="get">
    <span class="counter">140</span>
    <textarea style="border: 1px solid red; height: 100px; width:100%;" id="content"></textarea>
    <input disabled="disabled" type="submit" name="submit" value="submit" id="submit"></input>
    </form>
    
    </body>
    </html>


以上脚本可以在chrome，firefox，ie，safari 浏览器中测试通过，并在htc手机android 2.3和iphone 中测试中英文输入通过。
