---
author: abloz
comments: true
date: 2007-04-24 09:07:33+00:00
layout: post
link: http://abloz.com/index.php/2007/04/24/imitation-alexa-toolbar/
slug: imitation-alexa-toolbar
title: 模仿 alexa 工具条
wordpress_id: 207
categories:
- 技术
tags:
- alex
---

alexa的统计越来越受到国内网站的重视,这也成为广告投放和投资的重要依据.  alexa统计是通过工具条来获取样本的.根据每百万安装有工具条的人中访问该网站的一个比率，结合其内部的算法，得到一个网站的流量排名。但是由于中国 人安装该工具条的人少，而外国人访问中文网站的也少，所以其流量统计对中国网站是不公平的，不能真实反映中国网站的流量。因此，一些网站为了提高 alexa排名，不得不采用舞弊的手段。

下面就是模仿 alexa 工具条  (但不知该工具条是不是有认证)的代码。这是我从网上找到的，并非原创，也没有验证，但其原理还是很清晰的。只要抓取所有工具条发送的包，然后模拟一下， 做到以假乱真的程度，alexa又如何去区分呢？

看来我也可以去开一家专门舞弊alexa排名的公司了。^V^






alexa 工具条 向 data.alexa.com 80   发送请求,并获取返回的xml文件.下面是两个模拟.










#!/usr/bin/expect

spawn telnet data.alexa.com 80 

expect -re "Escape"
sleep 1
send "GET   /data/TCaX/0+qO000fV?cli=10&dat=snba&ver=7.0&cdt=alx_vw%3D20%26wid%3D31472%26act%3D00000000000%26ss%3D1024x768%26bw
%3D639%26t%3D0%26ttl%3D4907%26vis%3D1%26rq%3D23&url=http://blog.wespoke.com/   HTTP/1.1n"
send "Accept: */*n "
send "Accept-Encoding: gzip,  deflate  n"
send "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0;  Windows NT 5.0; .NET  CLR 1.0.3705; Alexa Toolbar) n"
send "Host:  data.alexa.com n"
send  "n"
send "n"



















======================








php








<?








$domain_name= data.alexa.com;








{








fputs($fp, "GET   /data/TCaX/0+qO000fV?cli=10&dat=snba&ver=7.0&cdt=alx_vw%3D20%26wid%3D31472%26act%3D00000000000%26ss%3D1024x768%26bw%3D639%26t%3D0%26ttl%3D4907%26vis%3D1%26rq%3D23&url=".$my_url."   HTTP/1.0rnAccept: */*rnAccept-Encoding: gzip, deflate  rnUser-Agent:  Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET  CLR 1.0.3705; Alexa  Toolbar) rnHost: ".$domain_name." rnrn");

while  (!feof($fp)) { 

$buffer .= fgets ($fp,1024); 

} 

fclose  ($fp); 

echo  $buffer;


?>


