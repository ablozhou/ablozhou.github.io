---
author: abloz
comments: true
date: 2015-05-28 15:46:06+00:00
layout: post
link: http://abloz.com/index.php/2015/05/28/getting-started-with-scala-1/
slug: getting-started-with-scala-1
title: scala入门（1）
wordpress_id: 2624
categories:
- 技术
tags:
- scala
---

周海汉 2015.5.28







**1.概述**




scala是基于JVM的，纯面向对象的函数式编程语言。其亮点有采用Actor模式的高并发编程，Java库的无缝采用，函数式编程，静态类型语言。




著名的Play框架即采用scala语言，并且提供scala和java两种编程接口。




学习scala语言，如果有其他语言基础，其独特的地方有如下几点：




第一是 Actor；第二是函数风格；第三case class ；第四是Mixin trait；第五是 XML；第六是单例和伴生对象。




官网：




[http://www.scala-lang.org/](http://www.scala-lang.org/)




下载：




[http://www.scala-lang.org/download/all.html](http://www.scala-lang.org/download/all.html)




[http://www.scala-lang.org/download/2.12.0-M1.html](http://www.scala-lang.org/download/2.12.0-M1.html)




scala ide,基于eclipse




[http://scala-ide.org/](http://scala-ide.org/?_ga=1.54076328.1825518876.1432260106)




相关网站：




[http://akka.io/](http://akka.io/)




[http://www.typesafe.com/get-started](http://www.typesafe.com/get-started)







环境准备：




Java 1.6以上




类Unix系统环境和Windows







[下载scala-2.12.0-M1.tar.gz](http://www.scala-lang.org/download/2.12.0-M1.html)，解压




将其bin目录添加到PATH中。







scala包含




- scala Scala interactive interpreter 交互解释器




- scalac Scala compiler  编译器




- fsc Scala resident compiler




- scaladoc Scala API documentation generator




- scalap Scala classfile decoder




执行以上命令分别完成相应功能。







**2. 交互命令行**






    
    zhh@scala-2.12.0-M1 % scala
    Welcome to Scala version 2.12.0-M1 (Java HotSpot(TM) 64-Bit Server VM, Java 1.8.0_45).
    Type in expressions to have them evaluated.
    Type :help for more information.
    
    scala> help
    <console>:8: error: not found: value help
    help
    ^
    
    scala> :help
    All commands can be abbreviated, e.g., :he instead of :help.
    :edit <id>|<line> edit history
    :help [command] print this summary or command-specific help
    :history [num] show the history (optional num is commands to show)
    :h? <string> search the history
    :imports [name name ...] show import history, identifying sources of names
    :implicits [-v] show the implicits in scope
    :javap <path|class> disassemble a file or class name
    :line <id>|<line> place line(s) at the end of history
    :load <path> interpret lines in a file
    :paste [-raw] [path] enter paste mode or paste a file
    :power enable power user mode
    :quit exit the interpreter
    :replay [options] reset the repl and replay all previous commands
    :require <path> add a jar to the classpath
    :reset [options] reset the repl to its initial state, forgetting all session entries
    :save <path> save replayable session to a file
    :sh <command line> run a shell command (result is implicitly => List[String])
    :settings <options> update compiler options, if possible; see reset
    :silent disable/enable automatic printing of results
    :type [-v] <expr> display the type of an expression without evaluating it
    :kind [-v] <expr> display the kind of expression's type
    :warnings show the suppressed warnings from the most recent line which had any
    
    scala> 3+2
    res1: Int = 5
    
    scala> print("hello world")
    hello world









**3. hello world**




zhh@test % vi hello.scala




zhh@test % scalac hello.scala




zhh@test % ls




HelloWorld$.class HelloWorld.class hello.scala




zhh@test % scala HelloWorld




No such file or class on classpath: HelloWorld




zhh@test % scala -classpath . HelloWorld




Hello, world!




zhh@test % cat hello.scala









    
    object HelloWorld {
    	def main(args: Array[String]) {
    		println("Hello, world!")
    	}
    }
    


object关键字相当于java语言的static，是scala语言的单例模式。scala语言的类型放在变量的后面，用冒号：隔开。这和go语言，swift语言类似。

用scalac进行编译，用scala执行。参数-classpath . 表示指定当前目录为classpath。






**4. 引入Java类**




zhh@test %




zhh@test % scalac javaChinaDate.scala




zhh@test % scala -classpath . ChinaDate




2015年5月28日




zhh@test % cat javaChinaDate.scala









    
    import java.util.{Date, Locale}; import java.text.DateFormat; import java.text.DateFormat._
    object ChinaDate {
    	def main(args: Array[String]) {
    		val now = new Date
    		val df = getDateInstance(LONG, Locale.CHINA); println(df format now)
    	}
    }
    


引入java类。其中

    
    java.util.{Date, Locale}







是scala语法糖。scala语法可以有分号，也可以省。但两个语句写在一行时分号则不能省。





**5. 回调函数实现timer**


zhh@test % vi timer.scala









    
    object Timer {
    	def oncePerSecond(callback: () => Unit) {
    		while (true) { callback(); Thread sleep 1000 } }
    	def timeFlies() {
    		println("time flies like an arrow...")
    	}
    	def main(args: Array[String]) {
    		oncePerSecond(timeFlies)
    	}
    }
    


一秒打印一句话。其中()=>Unit 表示一个无参函数，返回类型为Unit。Unit在scala语言中相当于c语言的void。






zhh@test % scalac timer.scala




zhh@test % scala -classpath . Timer




time flies like an arrow...




time flies like an arrow...





**6.匿名回调函数实现Timer**


zhh@test % vi timeranony.scala




zhh@test % scalac timeranony.scala




zhh@test % scala -classpath . TimerAnonymous




time flies like an arrow...




abloz.com




time flies like an arrow...




abloz.com




time flies like an arrow...




abloz.com




^C




zhh@test % cat timeranony.scala






    
    object TimerAnonymous {
    	def oncePerSecond(callback: () => Unit) {
    		while (true) { callback(); Thread sleep 1000 }
    	}
    	def main(args: Array[String]) {
    		oncePerSecond(() =>{
    			println("time flies like an arrow...");
    			println("abloz.com")
    			}
    			) }
    }
    


=>后面直接跟函数体，没有指定回调函数名字，直接用()=>{...}代替定义的回调函数timeFlies。


