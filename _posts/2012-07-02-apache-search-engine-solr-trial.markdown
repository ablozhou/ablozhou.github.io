---
author: abloz
comments: true
date: 2012-07-02 08:59:36+00:00
layout: post
link: http://abloz.com/index.php/2012/07/02/apache-search-engine-solr-trial/
slug: apache-search-engine-solr-trial
title: apache 搜索引擎solr试用
wordpress_id: 1731
categories:
- 技术
tags:
- apache
- lucene
- solr
---

来源：http://abloz.com  
author:ablozhou  
date: 2012-07-02




solr是apache旗下的开源搜索服务器，基于lucene搜索引擎。目前是apache的lucene项目下的子项目。solr的安装配置已经相当简单。所以，看起来像google那样复杂的搜索引擎技术，也可以不费很大力气的情况下，实现一个小型版。目前solr是企业级搜索服务器，最新版4.0alpha。





## 下载




[zhouhh@Hadoop48 ~]$ wget http://labs.renren.com/apache-mirror/lucene/solr/4.0.0-ALPHA/apache-solr-4.0.0-ALPHA.tgz




Length: 105132366 (100M) [application/x-gzip]




[zhouhh@Hadoop48 ~]$ tar zxvf apache-solr-4.0.0-ALPHA.tgz





## 启动solr




[zhouhh@Hadoop48 ~]$ cd apache-solr-4.0.0-ALPHA/example/




[zhouhh@Hadoop48 example]$ java -jar startjar




用浏览器访问8983端口，可以看到solr已经运行。但是因为没有索引信息，所以查询不到东西。




[http://hadoop48:8983/solr/](http://hadoop48:8983/solr/)





## 添加内容




另起一个命令行窗口，进入exampledocs目录，添加solr.xml和monitor.xml两个文件到搜索引擎。




[zhouhh@Hadoop48 exampledocs]$ java -jar post.jar solr.xml monitor.xml




看一下这两个文件什么内容：




[zhouhh@Hadoop48 exampledocs]$ cat solr.xml




<add>




<doc>




<field name="id">SOLR1000</field>




<field name="name">Solr, the Enterprise Search Server</field>




<field name="manu">Apache Software Foundation</field>




<field name="cat">software</field>




<field name="cat">search</field>




<field name="features">Advanced Full-Text Search Capabilities using Lucene</field>




<field name="features">Optimized for High Volume Web Traffic</field>




<field name="features">Standards Based Open Interfaces - XML and HTTP</field>




<field name="features">Comprehensive HTML Administration Interfaces</field>




<field name="features">Scalability - Efficient Replication to other Solr Search Servers</field>




<field name="features">Flexible and Adaptable with XML configuration and Schema</field>




<field name="features">Good unicode support: h&#xE9;llo (hello with an accent over the e)</field>




<field name="price">0</field>




<field name="popularity">10</field>




<field name="inStock">true</field>




<field name="incubationdate_dt">2006-01-17T00:00:00.000Z</field>




</doc>




</add>




[zhouhh@Hadoop48 exampledocs]$ cat monitor.xml




<add><doc>




<field name="id">3007WFP</field>




<field name="name">Dell Widescreen UltraSharp 3007WFP</field>




<field name="manu">Dell, Inc.</field>




<!-- Join -->




<field name="manu_id_s">dell</field>




<field name="cat">electronics</field>




<field name="cat">monitor</field>




<field name="features">30" TFT active matrix LCD, 2560 x 1600, .25mm dot pitch, 700:1 contrast</field>




<field name="includes">USB cable</field>




<field name="weight">401.6</field>




<field name="price">2199</field>




<field name="popularity">6</field>




<field name="inStock">true</field>




<!-- Buffalo store -->




<field name="store">43.17614,-90.57341</field>




</doc></add>





## 查询




浏览器进入[http://hadoop48:8983/solr/#/collection1/query](http://hadoop48:8983/solr/#/collection1/query)




在q里面输入dell，wt选json得到：[http://hadoop48:8983/solr/collection1/select?q=dell&wt=json&indent=true](http://hadoop48:8983/solr/collection1/select?q=dell&amp;wt=json&amp;indent=true)




![](http://abloz.com/wp-content/plugins/wp-ueditor/ueditor/php/upload/52511341220718.JPG)




{




"responseHeader":{




  "status":0,




  "QTime":1,




  "params":{




    "indent":"true",




    "wt":"json",




    "q":"dell"}},




"response":{"numFound":1,"start":0,"docs":[




    {




      "id":"3007WFP",




      "name":"Dell Widescreen UltraSharp 3007WFP",




      "manu":"Dell, Inc.",




      "manu_id_s":"dell",




      "cat":["electronics",




        "monitor"],




      "features":["30" TFT active matrix LCD, 2560 x 1600, .25mm dot pitch, 700:1 contrast"],




      "includes":"USB cable",




      "weight":401.6,




      "price":2199.0,




      "price_c":"2199,USD",




      "popularity":6,




      "inStock":true,




      "store":"43.17614,-90.57341",




      "_version_":1406367184436854784}]




}}




如果输入solr，得到




http://hadoop48:8983/solr/collection1/select?q=solr&wt=json&indent=true




{




"responseHeader":{




  "status":0,




  "QTime":1,




  "params":{




    "indent":"true",




    "wt":"json",




    "q":"solr"}},




"response":{"numFound":1,"start":0,"docs":[




    {




      "id":"SOLR1000",




      "name":"Solr, the Enterprise Search Server",




      "manu":"Apache Software Foundation",




      "cat":["software",




        "search"],




      "features":["Advanced Full-Text Search Capabilities using Lucene",




        "Optimized for High Volume Web Traffic",




        "Standards Based Open Interfaces - XML and HTTP",




        "Comprehensive HTML Administration Interfaces",




        "Scalability - Efficient Replication to other Solr Search Servers",




        "Flexible and Adaptable with XML configuration and Schema",




        "Good unicode support: héllo (hello with an accent over the e)"],




      "price":0.0,




      "price_c":"0,USD",




      "popularity":10,




      "inStock":true,




      "incubationdate_dt":"2006-01-17T00:00:00Z",




      "_version_":1406367184423223296}]




}}




输入google得到为空：




[http://hadoop48:8983/solr/collection1/select?q=google&wt=json&indent=true](http://hadoop48:8983/solr/collection1/select?q=google&amp;wt=json&amp;indent=true)




{




"responseHeader":{




  "status":0,




  "QTime":1,




  "params":{




    "indent":"true",




    "wt":"json",




    "q":"google"}},




"response":{"numFound":0,"start":0,"docs":[]




}}





## 中文支持




utf8完美支持。编辑一个my.xml




[zhouhh@Hadoop48 exampledocs]$ vi my.xml




    
    <add>
    <doc>
      <field name="id">mytest1</field>
      <field name="name">我的solr测试</field>
      <field name="manu">http://abloz.com</field>
      <field name="cat">software</field>
      <field name="cat">search</field>
      <field name="features">solr是全文搜索引擎</field>
      <field name="features">基于xml和http协议</field>
      <field name="features">是一种开放源码的、基于 Lucene Java 的搜索服务器，易于加入到 Web 应用程序中。Solr 提供了层面搜索、命中醒目显示并且支持多种输出格式（包括 XML/XSLT 和 JSON 格式）。它易于安装和配置，而且附带了一个基于 HTTP 的管理界面。您可以坚持使用 Solr 的表现优异的基本搜索功能，也可以对它进行扩展从而满足企业的需要。</field>
      <field name="price">0</field>
      <field name="popularity">10</field>
      <field name="inStock">true</field>
      <field name="incubationdate_dt">2012-07-2T00:00:00.000Z</field>
    </doc>
    </add>




提交到搜索引擎：




[zhouhh@Hadoop48 exampledocs]$ java -jar post.jar my.xml




全文搜索比如，“醒目”，[http://hadoop48:8983/solr/collection1/select?q=%E9%86%92%E7%9B%AE&wt=xml&indent=true](http://hadoop48:8983/solr/collection1/select?q=%E9%86%92%E7%9B%AE&amp;wt=xml&amp;indent=true)




得到：




    
    <response>
    <lst name="responseHeader">
    <int name="status">
    0
    </int>
    <int name="QTime">
    0
    </int>
    <lst name="params">
    <str name="indent">
    true
    </str>
    <str name="wt">
    xml
    </str>
    <str name="q">
    醒目
    </str>
    </lst>
    </lst>
    <result name="response" numFound="1" start="0">
    <doc>
    <str name="id">
    mytest1
    </str>
    <str name="name">
    我的solr测试
    </str>
    <str name="manu">
    http://abloz.com
    </str>
    <arr name="cat">
    <str>
    software
    </str>
    <str>
    search
    </str>
    </arr>
    <arr name="features">
    <str>
    solr是全文搜索引擎
    </str>
    <str>
    基于xml和http协议
    </str>
    <str>
    是一种开放源码的、基于 Lucene Java 的搜索服务器，易于加入到 Web 应用程序中。Solr 提供了层面搜索、命中醒目显示并且支持多种输出格式（包括 XML/XSLT 和 JSON 格式）。它易于安装和配置，而且附带了一个基于 HTTP 的管理界面。您可以坚持使用 Solr 的表现优异的基本搜索功能，也可以对它进行扩展从而满足企业的需要。
    </str>
    </arr>
    <float name="price">
    0.0
    </float>
    <str name="price_c">
    0,USD
    </str>
    <int name="popularity">
    10
    </int>
    <bool name="inStock">
    true
    </bool>
    <date name="incubationdate_dt">
    2012-07-02T00:00:00Z
    </date>
    <long name="_version_">
    1406371395836837888
    </long>
    </doc>
    </result>
    </response>




参考：




[https://builds.apache.org/job/Solr-trunk/javadoc/doc-files/tutorial.html](https://builds.apache.org/job/Solr-trunk/javadoc/doc-files/tutorial.html) 官方教程




[http://www.ibm.com/developerworks/cn/java/j-solr1/](http://www.ibm.com/developerworks/cn/java/j-solr1/) 使用 Apache Solr 实现更加灵巧的搜索




[http://lucene.apache.org/solr/](http://lucene.apache.org/solr/)




[http://www.originsoft.net/archives/32](http://www.originsoft.net/archives/32) [Apache Solr 初级教程（介绍、安装部署、Java接口、中文分词）](http://www.originsoft.net/archives/32)




[Solr的配置及从数据库建立索引](http://blog.csdn.net/christophe2008/article/details/6299225)



