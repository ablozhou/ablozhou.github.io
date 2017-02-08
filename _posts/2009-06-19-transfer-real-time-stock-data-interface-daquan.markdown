---
author: abloz
comments: true
date: 2009-06-19 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/06/19/transfer-real-time-stock-data-interface-daquan/
slug: transfer-real-time-stock-data-interface-daquan
title: '[转]实时股票数据接口大全'
wordpress_id: 919
categories:
- 技术
- 转载
---

#  					 				

				

 					  					  					

**from: http://www.21andy.com/blog/20090530/1313.html**

**实时股票数据接口大全**

股票数据的获取目前有如下两种方法可以获取:  
1. http/javascript接口取数据  
2. web-service接口

## 1.http/javascript接口取数据

**1.1Sina股票数据接口**

以大秦铁路（股票代码：601006）为例，如果要获取它的最新行情，只需访问新浪的股票数据  
接口：

http://hq.sinajs.cn/list=sh601006

这个url会返回一串文本，例如：

var hq_str_sh601006="大秦铁路, 27.55, 27.25, 26.91, 27.55, 26.20, 26.91, 26.92,   
22114263, 589824680, 4695, 26.91, 57590, 26.90, 14700, 26.89, 14300,  
26.88, 15100, 26.87, 3100, 26.92, 8900, 26.93, 14230, 26.94, 25150, 26.95, 15220, 26.96, 2008-01-11, 15:05:32";

这个字符串由许多数据拼接在一起，不同含义的数据用逗号隔开了，按照程序员的思路，顺序号从0开始。


```
 

0：”大秦铁路”，股票名字；  
1：”27.55″，今日开盘价；  
2：”27.25″，昨日收盘价；  
3：”26.91″，当前价格；  
4：”27.55″，今日最高价；  
5：”26.20″，今日最低价；  
6：”26.91″，竞买价，即“买一”报价；  
7：”26.92″，竞卖价，即“卖一”报价；  
8：”22114263″，成交的股票数，由于股票交易以一百股为基本单位，所以在使用时，通常把该值除以一百；  
9：”589824680″，成交金额，单位为“元”，为了一目了然，通常以“万元”为成交金额的单位，所以通常把该值除以一万；  
10：”4695″，“买一”申请4695股，即47手；  
11：”26.91″，“买一”报价；  
12：”57590″，“买二”  
13：”26.90″，“买二”  
14：”14700″，“买三”  
15：”26.89″，“买三”  
16：”14300″，“买四”  
17：”26.88″，“买四”  
18：”15100″，“买五”  
19：”26.87″，“买五”  
20：”3100″，“卖一”申报3100股，即31手；  
21：”26.92″，“卖一”报价  
(22, 23), (24, 25), (26,27), (28, 29)分别为“卖二”至“卖四的情况”  
30：”2008-01-11″，日期；  
31：”15:05:32″，时间；


```
 

一个简单的JavaScript应用例子: 

<script type="text/javascript" src="http://hq.sinajs.cn/list=sh601006" charset="gb2312"></script>  
<script type="text/javascript">  
var elements=hq_str_sh601006.split(",");  
document.write("current price:"+elements[3]);  
</script>

这段代码输出大秦铁路（股票代码：601006）的当前股价


```
 

current price:14.20


```
 

如果你要同时查询多个股票，那么在URL最后加上一个逗号，再加上股票代码就可以了；比如你要一次查询大秦铁路（601006）和大同煤业（601001）的行情，就这样使用URL：

http://hq.sinajs.cn/list=sh601003,sh601001

查询大盘指数，比如查询上证综合指数（000001）：

http://hq.sinajs.cn/list=s_sh000001

服务器返回的数据为：


```
 

var hq_str_s_sh000001="上证指数,3094.668,-128.073,-3.97,436653,5458126";


```
 

数据含义分别为：指数名称，当前点数，当前价格，涨跌率，成交量（手），成交额（万元）；

查询深圳成指数：

http://hq.sinajs.cn/list=s_sz399001

对于股票的K线图，日线图等的获取可以通过请求http://image.sinajs.cn/…./…/*.gif此URL获取，其中*代表股票代码，详见如下：

查看日K线图：

http://image.sinajs.cn/newchart/daily/n/sh601006.gif

![查看日K线图](http://image.sinajs.cn/newchart/daily/n/sh601006.gif)

分时线的查询：

http://image.sinajs.cn/newchart/min/n/sh000001.gif

![分时线的查询](http://image.sinajs.cn/newchart/min/n/sh000001.gif)

日K线查询：

http://image.sinajs.cn/newchart/daily/n/sh000001.gif

![日K线查询](http://image.sinajs.cn/newchart/daily/n/sh000001.gif)

周K线查询：

http://image.sinajs.cn/newchart/weekly/n/sh000001.gif

![周K线查询](http://image.sinajs.cn/newchart/weekly/n/sh000001.gif)

月K线查询：

http://image.sinajs.cn/newchart/monthly/n/sh000001.gif

![月K线查询](http://image.sinajs.cn/newchart/monthly/n/sh000001.gif)

**1.2 Baidu&Google的财经数据**  
在baidu, google中搜索某只股票代码时，将会在头条显示此股票的相关信息，例如在google搜索601006时，  
第一条搜索结果如下图：  
通过点击左边的图片我们发现会将此图片链接到sina财经频道上，也就是说google股票数据的获取也是从sina获取。后经抓包分析，发现google也是采用1.1中介绍的接口。

Baidu的股票数据来自baidu的财经频道  
[http://stock.baidu.com/](http://stock.baidu.com/)

**1.3 其他方式**  
除了sina，baidu等网站提供股票信息外，其他网站也有类似的接口。我们分析了一款论坛上采用的股票插件，  
其中有关于实时股票数据获取的介绍，详见如下代码，其中可以看到有些数据来自sina。  
以下是ASP示例:

<%  
‘==========================  
‘ file: stock_getdata.asp  
‘ version: 1.0.0  
‘ copyright (c) czie.com all r
ights reserved.  
‘ web: http://www.czie.com  
‘==========================  
function gethttp(rurl)  
dim xml  
on error resume next  
set xml=server.createobject("Microsoft.XMLHTTP")  
xml.open "get",rurl,false  
xml.send  
if not xml.readystate=4 or not xml.status=200 or err then gethttp="":exit function  
gethttp=xml.responsetext  
set xml=nothing  
end function  
function getstockdata(code)  
‘0=股票名称,1=开盘价格,2=昨收盘价格,3=当前价格,4=最高价,5=最低价,30,31=更新时间  
dim checkcode,stockdata,stockdatasplit  
if len(code)<5 then stockdata="0,0,0,0,0,0,0,0,0,0,0,0":exit function  
checkcode=mid(code,len(code)-5,1)  
if int(checkcode)<=4 then  
stockdata=gethttp("http://hq.sinajs.cn/list=sz"&code&"")  
if not len(stockdata)=0 then stockdata=split(stockdata,chr(34))(1)  
end if  
if int(checkcode)>=5 then  
stockdata=gethttp("http://hq.sinajs.cn/list=sh"&code&"")  
if not len(stockdata)=0 then stockdata=split(stockdata,chr(34))(1)  
end if  
if len(stockdata)=0 then  
stockdata="0,0,0,0,0,0,0,0,0,0,0,0"  
else  
stockdatasplit=split(stockdata,",")   stockdata=""&exstock.checkstr(stockdatasplit(0))&","&stockdatasplit(1)&","&stockdatasplit(2)&","&stockdatasplit(3)&","&stockdatasplit(4)&","&stockdatasplit(5)&","&formatdatetime(""&stockdatasplit(30)&" "&stockdatasplit(31)&"",0)&""  
end if  
‘0=股票名称,1=开盘价格,2=昨收盘价格,3=当前价格,4=最高价,5=最低价,6=更新时间  
getstockdata=stockdata  
end function  
  
function getstockimg(code)  
dim rndnum,addnum,checkcode,imgsource  
if len(code)<5 then exit function  
addnum=4  
randomize:rndnum=cint(rnd*addnum)  
select case rndnum  
case 0  
getstockimg="http://www.10jqka.com.cn/curve/kline/?code="&code&""  
imgsource="http://www.10jqka.com.cn"  
case 1  
getstockimg="http://stock.jrj.com.cn/htmdata/KLINE/"&code&".png"  
imgsource="http://stock.jrj.com.cn"  
case 2  
checkcode=mid(code,len(code)-5,1)  
if int(checkcode)<=4 then  
getstockimg="http://image.sinajs.cn/newchart/daily/n/sz"&code&".gif"  
end if  
if int(checkcode)>=5 then  
getstockimg="http://image.sinajs.cn/newchart/daily/n/sh"&code&".gif"  
end if  
imgsource="http://finance.sina.com.cn"  
case 3  
 getstockimg="http://hq.gazxfe.com/stockchart/realline.chart?"&code&"&1003&SZ 500 330"  
imgsource="http://hq.gazxfe.com"  
case 4  
getstockimg="http://chartse.stockstar.com/chartserver?code="&code&""  
imgsource="http://www.stockstar.com/"  

end select  
getstockimg=split(""&getstockimg&"||"&imgsource&"","||")  
end function  
  
function getastockimg()  
dim rndnum,addnum,checkcode  
dim getastockimgb,imgsource  
addnum=6  
randomize:rndnum=cint(rnd*addnum)  
select case rndnum  
case 0  
getastockimg="http://202.109.106.1/gifchartse/gif/000001.gif"  
getastockimgb="http://202.109.106.1/gifchartse/gif/399001.gif"  
imgsource="http://www.stockstar.com/"  
case 1  
getastockimg="http://money.163.com/special/100.gif?C39"  
getastockimgb="http://money.163.com/special/101.gif?HrS"  
imgsource="http://www.163.com"  
case 2  
 getastockimg="http://www.10jqka.com.cn/curve/realtime/index2.php?code=1a0001&w=180&h=140"  
 getastockimgb="http://www.10jqka.com.cn/curve/realtime/index2.php?code=399001&w=180&h=140"  
imgsource="http://www.10jqka.com.cn"  
case 3  
 getastockimg="http://chart.cnlist.com/stockchart/realline.chart?1a0001&1002&SZ 180 140"  
 getastockimgb="http://chart.cnlist.com/stockchart/realline.chart?399001&1002&SZ 180 140"  
imgsource="http://chart.cnlist.com/"  
case 4  
getastockimg="http://image.sinajs.cn/newchart/small/ish000001.gif?1189176558328"  
getastockimgb="http://image.sinajs.cn/newchart/small/isz399001.gif?1189176558328"  
imgsource="http://www.sinajs.cn"  
case 5  
getastockimg="http://218.1.72.66/cgi/pic/sh/realtime/JA000001164143.png"  
getastockimgb="http://218.1.72.66/cgi/pic/sz/realtime/JA399001164143.png"  
imgsource="http://www.cnstock.com/"  
case 6  
getastockimg="http://222.73.29.85/img/000001.png"  
getastockimgb="http://222.73.29.85/img/399001.png"  
imgsource="http://www.eastmoney.com/"  
end select  
getastockimg=split(""&getastockimg&"||"&getastockimgb&"||"&imgsource&"","||")  
end function  
%>

## 2. web-service接口

**2.1 CHINAstock的web-service：**

http://www.webxml.com.cn/WebServices/ChinaStockWebService.asmx

中国股票行情数据 WEB 服务（支持深圳和上海股市的全部基金、债券和股票），数据即时更新。输出GIF分时走势图、日/周/月 K  线图、及时行情数据（股票名称、行情时间、最新价、昨收盘、今开盘、涨跌额、最低、最高、涨跌幅、成交量、成交额、竞买价、竞卖价、委比、买一 -  买五、卖一 - 卖五）。此WEB服务提供了如下几个接口：

2.1.1 getStockImageByCode  
GET 股票GIF分时走势图  
INput：theStockCode = 股票代号，如：sh000001

POST /WebServices/ChinaStockWebService.asmx HTTP/1.1  
Host: www.webxml.com.cn  
Content-Type: text/xml; charset=utf-8  
Content-Length: length  
SOAPAction: "http://WebXml.com.cn/getStockImageByCode"  
  
<?xml version="1.0" encoding="utf-8"?>  
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xmlns:xsd="http://www.w3.org/2001/XMLSchema"  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">  
<soap:Body>  
<getStockImageByCode xmlns="http://WebXml.com.cn/">  
<theStockCode>string</theStockCode>  
</getStockImageByCode>  
</soap:Body>  
</soap:Envelope>

Output：

2.1.2 getStockImageByteByCode  
获得中国股票GIF分时走势图字节数组

INput：theStockCode = 股票代号，如：sh000001

POST /WebServices/ChinaStockWebService.asmx  HTTP/1.1Host: www.webxml.com.cnContent-Type: text/xml;  charset=utf-8Content-Length: lengthSOAPAction:  "http://WebXml.com.cn/getStockImageByteByCode" <?xml version="1.0"  encoding="utf-8"?><soap:Envelope  xmlns:xsi="http://www.
w3.org/2001/XMLSchema-instance"  xmlns:xsd="http://www.w3.org/2001/XMLSchema"  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">  <soap:Body> <getStockImageByteByCode  xmlns="http://WebXml.com.cn/">  <theStockCode>string</theStockCode>  </getStockImageByteByCode>  </soap:Body></soap:Envelope>

返回的数据如下：


```
 

  
R0lGODlhIQIsAfcAAAAAAAwLBxkGBQ4ODhAQEBsSChUVFS4TDB8eGQkA9koPCDAAzy4mFVgAp2UYC0IqEUYuBVwiDEAsI1QnFX8AgDU1NUozFlgxD6cBWVY5FnIwEmQ4Gc0AMlhDHPEADlVJMEpKSm1IHOUBWpY3FZMyVY9IGXRWIEFmWGNYUmpdPXJgHQB8HK9EGGBgX4lXIACoAHhkMyt4m4VkJtstbv8A


```
 

2.1.3 getStockImage_kByCode  
直接获得中国股票GIF日/周/月 K 线图（545*300pixel/72dpi）  
INPUT: theStockCode = 股票代号  
theType = K 线图类型（D：日[默认]、W：周、M：月），

POST /WebServices/ChinaStockWebService.asmx  HTTP/1.1Host: www.webxml.com.cnContent-Type: text/xml;  charset=utf-8Content-Length: lengthSOAPAction:  "http://WebXml.com.cn/getStockImage_kByCode" <?xml version="1.0"  encoding="utf-8"?><soap:Envelope  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xmlns:xsd="http://www.w3.org/2001/XMLSchema"  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">  <soap:Body> <getStockImage_kByCode  xmlns="http://WebXml.com.cn/">  <theStockCode>string</theStockCode>  <theType>string</theType> </getStockImage_kByCode> </soap:Body></soap:Envelope>

比如按照下图所示输入：  
返回的结果就是周K线图：

2.1.4 getStockImage_kByteByCode  
获得中国股票GIF日/周/月 K 线图字节数组  
Input：theStockCode = 股票代号，如：sh000001

POST /WebServices/ChinaStockWebService.asmx  HTTP/1.1Host: www.webxml.com.cnContent-Type: text/xml;  charset=utf-8Content-Length: lengthSOAPAction:  "http://WebXml.com.cn/getStockImage_kByteByCode" <?xml version="1.0"  encoding="utf-8"?><soap:Envelope  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xmlns:xsd="http://www.w3.org/2001/XMLSchema"  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">  <soap:Body> <getStockImage_kByteByCode  xmlns="http://WebXml.com.cn/">  <theStockCode>string</theStockCode>  <theType>string</theType>  </getStockImage_kByteByCode>  </soap:Body></soap:Envelope>HTTP/1.1 200 OKContent-Type:  text/xml; charset=utf-8Content-Length: length <?xml version="1.0"  encoding="utf-8"?><soap:Envelope  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xmlns:xsd="http://www.w3.org/2001/XMLSchema"  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">  <soap:Body> <getStockImage_kByteByCodeResponse  xmlns="http://WebXml.com.cn/">  <getStockImage_kByteByCodeResult>base64Binary</getStockImage_kByteByCodeResult> </getStockImage_kByteByCodeResponse>  </soap:Body></soap:Envelope>

比如按照下图输入：  
返回的结果就是周K线图字节数组


```
 

  
R0lGODlhIQIsAfcAAAAAAAwLBxkGBQ4ODhAQEBsSChUVFS4TDB8eGQkA9koPCDAAzy4mFVgAp2UYC0IqEUYuBVwiDEAsI1QnFX8AgDU1NUozFlgxD6cBWVY5FnIwEmQ4Gc0AMlhDHPEADlVJMEpKSm1IHOUBWpY3FZMyVY9IGXRWIEFmWGNYUmpdPXJgHQB8HK9EGGBgX4lXIACoAHhkMyt4m4VkJtstbv8A


```
 

2.1.5 getStockInfoByCode  
获得中国股票及时行情  
input：theStockCode = 股票代号

POST /WebServices/ChinaStockWebService.asmx  HTTP/1.1Host: www.webxml.com.cnContent-Type: text/xml;  charset=utf-8Content-Length: lengthSOAPAction:  "http://WebXml.com.cn/getStockInfoByCode" <?xml version="1.0"  encoding="utf-8"?><soap:Envelope  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xmlns:xsd="http://www.w3.org/2001/XMLSchema"  xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">  <soap:Body> <getStockInfoByCode  xmlns="http://WebXml.com.cn/">  <theStockCode>string</theStockCode>  </getStockInfoByCode> </soap:Body></soap:Envelope>

返回的值一个一维字符串数组  String(24)，结构为：String(0)股票代号、String(1)股票名称、String(2)行情时间、String(3)最新价 （元）、String(4)昨收盘（元）、String(5)今开盘（元）、String(6)涨跌额（元）、String(7)最低（元）、 String(8)最高（元）、String(9)涨跌幅（%）、String(10)成交量（手）、String(11)成交额（万元）、 String(12)竞买价（元）、String(13)竞卖价（元）、String(14)委比（%）、String(15)-String(19)买 一 - 买五（元）/手、String(20)-String(24)卖一 - 卖五（元）/手。

Web service的方法类似于现在concurrent项目的DBWS数据的获取，都是通过SOAP协议向DBWS服务器获取相关的数据。

利用雅虎查中国股票

http://quote.yahoo.com/d/quotes.csv?s=MSFT&f=slc1wop

返回微软的股票价格


```
 

"MSFT","4:00pm - **30.70**",+1.04,"21.46 - 30.75",29.77,29.66


```
 

http://quote.yahoo.com/d/quotes.csv?s=000969.SZ&f=slc1wop

这个返回安泰科技的，**一般有半个小时的延迟**。

但是s=000969.sz 这个后面的sz是深圳的意思, 沪市是SS后缀

  
  


![](http://img.zemanta.com/pixy.gif?x-id=8f8b14a6-074e-87d1-bc9b-b8419703f1cd)
