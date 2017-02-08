---
author: abloz
comments: true
date: 2011-08-25 11:07:59+00:00
layout: post
link: http://abloz.com/index.php/2011/08/25/html-background-using-the-xmlhttprequest-object-to-read-and-write/
slug: html-background-using-the-xmlhttprequest-object-to-read-and-write
title: 用XMLHttpRequest 对象进行后台html读写
wordpress_id: 1375
categories:
- 技术
---

XMLHttpRequest 对象用于在后台与服务器交换数据。

XMLHttpRequest 对象是开发者的梦想，因为您能够：

•在不重新加载页面的情况下更新网页
•在页面已加载后从服务器请求数据
•在页面已加载后从服务器接收数据
•在后台向服务器发送数据
所有现代的浏览器都支持 XMLHttpRequest 对象。

s.html

    
    
    
    <html><head>
    <title>XMLHttpRequest sample</title>
    <script type="text/javascript" language="JavaScript">
    var xmlhttp = null;
    
    
    function newXMLHttpRequest() {
       if (window.XMLHttpRequest) {
    	// Firefox, Opera 8.0+, Safari
            xmlhttp = new XMLHttpRequest();
        }
       else if (window.ActiveXObject)
      {
      // Internet Explorer
      try
        {
        xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
      catch (e)
        {
    	//ie5 ie6
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      }
    
       return xmlhttp;
    
    }
    
    function GetData( url) {
    	//'http://localhost/books.xml'
        xmlhttp = newXMLHttpRequest();
        if( xmlhttp) {
            xmlhttp.open('GET', url, false);
            xmlhttp.send(null);
            document.getElementById('result').innerHTML = xmlhttp.responseText;
            document.getElementById('httpcode').innerHTML = xmlhttp.status;
            document.getElementById('httpstatus').innerHTML = xmlhttp.statusText;
            document.getElementById('result').innerHTML = xmlhttp.responseText;
    	document.getElementById('xmlresult').innerHTML = xmlhttp.responseXML;
    	//分析responseXML，它是个DOM对象
    		xmlDoc = xmlhttp.responseXML;
    		if(xmlDoc)
    		{
    		document.write("<table border='2'>");
    		var x=xmlDoc.getElementsByTagName("Book");
    		for (i=0;i<x.length;i++)
    		  {
    		  document.write("<tr><td>");
    		  document.write(x[i].getElementsByTagName("ISBN")[0].childNodes[0].nodeValue);
    		  document.write("</td><td>");
    		  document.write(x[i].getElementsByTagName("Title")[0].childNodes[0].nodeValue);
    		  document.write("</td><td>");
    		  document.write(x[i].getElementsByTagName("Author")[0].childNodes[0].nodeValue);
    		  document.write("</td></tr>");
    		  }
    		document.write("</table>");
    		}
    
        }
    }
    </script>
    </head>
    <body>
    <button onclick="GetData('http://localhost/books.xml')">Get a document</button>
    <p>
    <table border="1">
        <tr><td>Document</td><td><span id="result">No Result</span></td></tr>
        <tr><td>httpcode</td><td><span id="httpcode"> httpcode</span></td></tr>
        <tr><td>httpstatus</td><td><span id="httpstatus"> httpstatus</span></td<>
        <tr><td>xmlresult</td><td><span id="xmlresult"> xmlresult</span></td<>
    </table>
    </p>
    </body>
    </html>
    



books.xml

    
    
    
    
    <user>
        <book>
            <isbn>1-59059-540-8</isbn>
           <title>Foundations of Object Oriented
             Programming Using .NET 2.0 Patterns</title>
           <author>Christian Gross</author>
        </book>
        <book>
            <isbn>0-55357-340-3</isbn>
            <title>A Game of Thrones</title>
            <author>George R.R. Martin</author>
        </book>
    </user>
    


点击get books info,会不刷新显示返回的结果。

参考：
http://www.w3school.com.cn/xml/xml_http.asp 
