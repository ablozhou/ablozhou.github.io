---
author: abloz
comments: true
date: 2012-12-27 10:13:47+00:00
layout: post
link: http://abloz.com/index.php/2012/12/27/docbook-written-document/
slug: docbook-written-document
title: 用docbook写文档
wordpress_id: 2033
categories:
- 技术
tags:
- apache
- docbook
---

周海汉
2012.12.27

在翻译[HBase官方文档中文版](http://abloz.com/hbase/book.html)时遇到一个困难，就是原文进行大量章节变动后，对章节号和注解号跟踪非常困难。在usenet上询问，HBase官方文档作者之一Stack告诉我是采用DocBook来写xml，然后再通过maven来编译生成html的。自己又土了一把，直接下载html翻译的。为什么很多开源软件的文档不是直接编写html呢？
html和word文档都有一个问题，就是内容和排版是搅合在一起的。word文档最大的毛病是不适合版本管理和多人合作。html还通过css进行了一部分分离，但相对而言，还是有很多排版标签。而docbook则仅需很少的xml标签，用户可以直接面向内容，至于如何展示，再用独立的xsl等来规定。

docbook网站：http://docbook.org
对于如何使用docbook规范来写文档，windows下有一篇很好的文档《[一个简单的Docbook 5.0例子](http://easwy.com/blog/archives/a-simple-docbook-5-example/)》，本文也基本按照该文来操作的。linux下面由于我操作系统比较旧，相关依赖库比较麻烦，所以没有完成。

以下操作都是在win7下完成的。


## 
下载：


**docbook xml dtd下载**
http://sourceforge.net/projects/docbook/files/
**下载xsl**
http://superb-dca2.dl.sourceforge.net/project/docbook/docbook-xsl-ns/1.78.0/docbook-xsl-ns-1.78.0.tar.bz2

**下载libxml和文档生成相关工具**
ftp://ftp.zlatkovic.com/libxml/ 里有libxml相关库的windows编译版本，感谢!
将下面这些库从上面的网址下载下来，解压
[iconv-1.9.2.win32.zip](ftp://ftp.zlatkovic.com/libxml/iconv-1.9.2.win32.zip)1.3 MB

[libxml2-2.7.8.win32.zip](ftp://ftp.zlatkovic.com/libxml/libxml2-2.7.8.win32.zip)2.6 MB

[libxmlsec-1.2.18.win32.zip](ftp://ftp.zlatkovic.com/libxml/libxmlsec-1.2.18.win32.zip)967 kB

[libxmlsec-nounicode-1.2.18.win32.zip](ftp://ftp.zlatkovic.com/libxml/libxmlsec-nounicode-1.2.18.win32.zip)951 kB

[libxslt-1.1.26.win32.zip](ftp://ftp.zlatkovic.com/libxml/libxslt-1.1.26.win32.zip)398 kB

[openssl-0.9.8a.win32.zip](ftp://ftp.zlatkovic.com/libxml/openssl-0.9.8a.win32.zip)2.4 MB

[xsldbg-3.1.7.win32.zip](ftp://ftp.zlatkovic.com/libxml/xsldbg-3.1.7.win32.zip)688 kB

[zlib-1.2.5.win32.zip](ftp://ftp.zlatkovic.com/libxml/zlib-1.2.5.win32.zip)169 kB

**如要生成pdf，下载apache fop**

http://xmlgraphics.apache.org/fop/

http://labs.mop.com/apache-mirror/xmlgraphics/fop/binaries/
http://labs.mop.com/apache-mirror/xmlgraphics/fop/binaries/fop-1.1-bin.zip

解压后将所有bin目录内容复制到一个目录下，我将其复制到D:docbookbin，并将该目录加入到系统的Path中。

在cmd中执行xsltproc如果没有报错，则环境准备正确。




## **写文档**


**建一个book.xml，这是文档内容。**

<?xml version='1.0' encoding="utf-8"?>
<article xmlns="http://docbook.org/ns/docbook" version="5.0" xml:lang="zh-CN"
xmlns:xlink='http://www.w3.org/1999/xlink'>
<articleinfo>
<title>用Docbook 5.0自动生成文档</title>
<author>
<firstname>Andy</firstname>
<surname>Zhou</surname>
</author>
<author>
<firstname>http://abloz.com</firstname>
</author>
</articleinfo>

<section>
<title>欢迎</title>
<para>
欢迎您来到<link xlink:href='http://abloz.com/'>瀚海星空</link>。
</para>
</section>

<section>
<title>HBase 0.95官方文档中文版</title>
<para>
<link xlink:href='http://abloz.com/hbase/book.html'>HBase 0.95官方文档中文版</link>有望放到HBase官方网站的链接中，期望更多的朋友加入翻译。
该文档也是Docbook写的，然后再编译成html或pdf版本的。
</para>
</section>

</article>

**编辑docbook_zhh.xsl，这是html生成的样式规范**

<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version='1.0'>
<xsl:include href="D:/docbook/docbook-xsl-ns-1.78.0/html/docbook.xsl"/>
<xsl:output method="html"
encoding="UTF-8"
indent="yes"/>
</xsl:stylesheet>

**生成命令**

D:docbookexample>xsltproc -o book.html docbook_zhh.xsl book.xml



book.html源码：
<table >
<tbody >
<tr >

<td ><html>
</td>
</tr>
<tr >

<td >
</td>

<td ><head>
</td>
</tr>
<tr >

<td >
</td>

<td ><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</td>
</tr>
<tr >

<td >
</td>

<td ><title>用Docbook 5.0自动生成文档</title>
</td>
</tr>
<tr >

<td >
</td>

<td ><meta name="generator" content="DocBook XSL Stylesheets V1.78.0">
</td>
</tr>
<tr >

<td >
</td>

<td ></head>
</td>
</tr>
<tr >

<td >
</td>

<td ><body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF"><div lang="zh-CN" class="article">
</td>
</tr>
<tr >

<td >
</td>

<td ><div class="titlepage">
</td>
</tr>
<tr >

<td >
</td>

<td ><div>
</td>
</tr>
<tr >

<td >
</td>

<td ><div><h2 class="title">
</td>
</tr>
<tr >

<td >
</td>

<td ><a name="id472859"></a>用Docbook 5.0自动生成文档</h2></div>
</td>
</tr>
<tr >

<td >
</td>

<td ><div><div class="author"><h3 class="author">
</td>
</tr>
<tr >

<td >
</td>

<td ><span class="firstname">Andy</span> <span class="surname">Zhou</span>
</td>
</tr>
<tr >

<td >
</td>

<td ></h3></div></div>
</td>
</tr>
<tr >

<td >
</td>

<td ><div><div class="author"><h3 class="author"><span class="firstname">http://abloz.com</span></h3></div></div>
</td>
</tr>
<tr >

<td >
</td>

<td ></div>
</td>
</tr>
<tr >

<td >
</td>

<td ><hr>
</td>
</tr>
<tr >

<td >
</td>

<td ></div>
</td>
</tr>
<tr >

<td >
</td>

<td ><div class="toc">
</td>
</tr>
<tr >

<td >
</td>

<td ><p><b>目录</b></p>
</td>
</tr>
<tr >

<td >
</td>

<td ><dl class="toc">
</td>
</tr>
<tr >

<td >
</td>

<td ><dt><span class="section"><a href="[#id532049](file:///D:/docbook/example/book.html#id532049)">欢迎</a></span></dt>
</td>
</tr>
<tr >

<td >
</td>

<td ><dt><span class="section"><a href="[#id531993](file:///D:/docbook/example/book.html#id531993)">HBase 0.95官方文档中文版</a></span></dt>
</td>
</tr>
<tr >

<td >
</td>

<td ></dl>
</td>
</tr>
<tr >

<td >
</td>

<td ></div>
</td>
</tr>
<tr >

<td >
</td>

<td ><div class="section">
</td>
</tr>
<tr >

<td >
</td>

<td ><div class="titlepage"><div><div><h2 class="title" style="clear: both">
</td>
</tr>
<tr >

<td >
</td>

<td ><a name="id532049"></a>欢迎</h2></div></div></div>
</td>
</tr>
<tr >

<td >
</td>

<td ><p>
</td>
</tr>
<tr >

<td >
</td>

<td >欢迎您来到<a class="link" href="[http://abloz.com/](http://abloz.com/)" target="_top">瀚海星空</a>。
</td>
</tr>
<tr >

<td >
</td>

<td ></p>
</td>
</tr>
<tr >

<td >
</td>

<td ></div>
</td>
</tr>
<tr >

<td >
</td>

<td ><div class="section">
</td>
</tr>
<tr >

<td >
</td>

<td ><div class="titlepage"><div><div><h2 class="title" style="clear: both">
</td>
</tr>
<tr >

<td >
</td>

<td ><a name="id531993"></a>HBase 0.95官方文档中文版</h2></div></div></div>
</td>
</tr>
<tr >

<td >
</td>

<td ><p>
</td>
</tr>
<tr >

<td >
</td>

<td ><a class="link" href="[http://abloz.com/hbase/book.html](http://abloz.com/hbase/book.html)" target="_top">HBase 0.95官方文档中文版</a>有望放到HBase官方网站的链接中，期望更多的朋友加入翻译。
</td>
</tr>
<tr >

<td >
</td>

<td >该文档也是Docbook写的，然后再编译成html或pdf版本的。
</td>
</tr>
<tr >

<td >
</td>

<td ></p>
</td>
</tr>
<tr >

<td >
</td>

<td ></div>
</td>
</tr>
<tr >

<td >
</td>

<td ></div></body>
</td>
</tr>
<tr >

<td >
</td>

<td ></html>
</td>
</tr>
</tbody>
</table>
**html内容：**











## 用Docbook 5.0自动生成文档













### Andy Zhou
















### http://abloz.com














* * *










**目录**



[欢迎](file:///D:/docbook/example/book.html#id532049)
[HBase 0.95官方文档中文版](file:///D:/docbook/example/book.html#id531993)










## 欢迎





欢迎您来到[瀚海星空](http://abloz.com/)。












## HBase 0.95官方文档中文版





[HBase 0.95官方文档中文版](http://abloz.com/hbase/book.html)有望放到HBase官方网站的链接中，期望更多的朋友加入翻译。 该文档也是Docbook写的，然后再编译成html或pdf版本的。





