---
author: abloz
comments: true
date: 2015-06-03 12:02:26+00:00
layout: post
link: http://abloz.com/index.php/2015/06/03/play-framework-getting-started-1/
slug: play-framework-getting-started-1
title: play框架入门（1）
wordpress_id: 2650
categories:
- 技术
tags:
- java
- play
- scala
---

周海汉 2015.6.3


概述：




play框架是用scala写的scala和java的框架，支持高并发，web和JPA。play框架得到一些互联网新兴企业的喜爱，相较spring，struts和hibernate/mybatis而言，更简单高效。修改完代码无需重新打包部署，浏览器直接看到修改。







官网




[https://playframework.com/](https://playframework.com/)




下载，最新版2.4，是基于sbt的activator 进行编译管理的：




老的版本2.2以前不需要activator




[https://playframework.com/download#older-versions](https://playframework.com/download#older-versions)




[http://downloads.typesafe.com/play/2.2.4/play-2.2.4.zip](http://downloads.typesafe.com/play/2.2.4/play-2.2.4.zip)




我们下载2.2.4.










1. 生成新app，名字为 zhh




play new zhh




会让你选择项目名称，所用语言。我们选java。







生成的文件：




./.classpath




./.gitignore




./.project




./.settings




./.settings/org.eclipse.core.resources.prefs




./.settings/org.scala-ide.play2.prefs




./.settings/org.scala-ide.sdt.core.prefs




./app




./app/controllers




./app/controllers/Application.java




./app/views




./app/views/index.scala.html




./app/views/main.scala.html




./build.sbt




./conf




./conf/application.conf




./conf/routes




./logs




./project




./project/build.properties




./project/plugins.sbt




./project/project







2.运行，指定9001端口




zhh@zhh % play "run 9001"







3. 在浏览器访问




[http://localhost:9001/](http://localhost:9001/)




可以看到 Your new application is ready.




后面是play的介绍和原理解释。







4.关键文件




conf/routers配置路由：




# Home page
GET     /                           controllers.Application.index()





# Map static resources from the /public folder to the /assets URL path







GET     /assets/*file               controllers.Assets.at(path="/public", file)










app/controllers/Application.java




package controllers;







import play.*;




import play.mvc.*;







import views.html.*;







public class Application extends Controller {







public static Result index() {




return ok(index.render("Your new application is ready.世界，你好！"));




}







}







模板放在views里面。 模板的语言是scala，scala相当于简化和方便化的java语言，用于模板很强大，可以实现模板继承等关系。







app/views/index.scala.html




@(message: String)

@main("Welcome to Play") {

@play20.welcome(message, style = "Java")







app/views/main.scala.html




_@(title: String)(content: Html)_

<!DOCTYPE html>

<html>
<head>
<title>@title</title>
<link rel="stylesheet" media="screen" href="@routes.Assets.at("_stylesheets__/__main.css__")"_>
<link rel="shortcut icon" type="image/png" href="@routes.Assets.at("_images__/__favicon.png__")"_>
<script src="@routes.Assets.at("_javascripts__/__jquery-1.9.0.min.js__")"_ type="text/javascript"></script>
</head>
<body>
@content
</body>
</html>







}







5.原理




用户通过浏览器访问根/时，play框架会根据routers里面的配置，找到controllers.Application.index()，这会调用Application类的index()函数，




index.render("Your new application is ready.世界，你好！")




会将“Your new application is ready.世界，你好！”传到index.scala.html. index.scala.html再调用main.scala.html, 将消息和@play20的内容传递到main模板。







我们修改一下程序和模板，进行测试。




首先，将index.scala.html修改为index1.scala.html




刷新浏览器，报错：




compile error 错误: 找不到符号




将Application index函数内容改为：




return ok(_index1_.render("Your new application is ready.世界，你好！”);




则没有报错。




我们再给模板传递多一个参数，修改Application.java：




return ok(_index1_.render("Your new application is ready.世界，你好！","zhh 测试内容"));







index1.scala.html修改为：




@(message1: String,message2:String)

@main("Welcome to Play",message2) {

@play20.welcome(message1, style = "Java")







main.scala.html修改为：




_@(title: String, msg:String)(content: Html)_

<!DOCTYPE html>

<html>
<head>
<title>@title</title>
<link rel="stylesheet" media="screen" href="@routes.Assets.at("_stylesheets__/__main.css__")"_>
<link rel="shortcut icon" type="image/png" href="@routes.Assets.at("_images__/__favicon.png__")"_>
<script src="@routes.Assets.at("_javascripts__/__jquery-1.9.0.min.js__")"_ type="text/javascript"></script>
</head>
<body>
<h1>_@msg_</h1>
@content
</body>
</html>




刷新后，看到我从程序传递到web模板的内容。




}









