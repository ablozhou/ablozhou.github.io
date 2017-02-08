---
author: abloz
comments: true
date: 2015-05-28 16:23:59+00:00
layout: post
link: http://abloz.com/index.php/2015/05/29/getting-started-with-scala-2/
slug: getting-started-with-scala-2
title: scala入门(2)
wordpress_id: 2628
categories:
- 技术
tags:
- scala
---

周海汉 2015.5.28

**1. 类**

    
    class Complex(real: Double, imaginary: Double) {
    	def re() = real
    	def im() = imaginary
    }
    class Complex2(real: Double, imaginary: Double) {
    	def re = real
    	def im = imaginary
    }
    object Imaginary{
    	def main(args: Array[String]) {
    		val comp = new Complex(1.2,3.4)
    		println("imaginary part:"+comp.im())
    		println("imaginary part:"+comp.im)
    		val comp2 = new Complex2(5.6,7.8)
    		//println("comp2 imaginary part:"+comp2.im())
    		println("comp2 imaginary part:"+comp2.im)
    	}
    }
    


scala类可以直接带参数。复数类Complex带了两个参数，real和imaginary, 以及两个方法：re()和im().

这两个方法没有显示指定返回值类型，编译器根据右边赋值来自动指定返回Double类型。如果编译器不能判定返回类型，则会给出错误提示。

Complex2 的两个方法re和im定义成和属性类似，不带空括号，其定义和使用都不带括号。这和Complex类中方法带无参括号的方法并不相同。

comp2.im()语句会报如下错误：

zhh@test % scalac class.scala
class.scala:15: error: Double does not take parameters
println("comp2 imaginary part:"+comp2.im())
^
one error found

注释后执行：

zhh@test % scalac class.scala
zhh@test % scala -classpath . Imaginary
imaginary part:3.4
imaginary part:3.4
comp2 imaginary part:7.8

**2.for循环**

    
    object For {
    	//for comprehension
    	def forcompre{
    
    		val names= List("黄小灿", "黄小鸭",
    				"周小羊","喜羊羊", "灰太狼",
    				"懒羊羊")
    		println(names)
    		println("包含羊的名字：")
    		for (name <- names if name.contains("羊")) println(name)
    
    		println("包含小的名字,并且姓不黄的：")
    		for (name <- names if name.contains("小"); if !name.startsWith("黄"))
    			println(name)
    
    	}
    
    	def casematch() {
    		val willWork = List(1, 3, 23, 90)
    		val willNotWork = List(4, 18, 52)
    		val empty = List()
    		for (l <- List(willWork, willNotWork, empty)) {
    			l match {
    				case List(_, 3, _, _) => println("Four elements, with the 2nd being '3':"+l)
    				case List(_*) => println("Any other list with 0 or more elements:"+l)
    			}
    		}
    	}
    
    	def main(arr:Array[String]) {
    		forcompre
    		casematch
    
    	}
    }
    


这里采用了for的列表推导式。item <- list 表示每次从list里取出一个item，作用于后面的if条件。多个if条件用分号隔开。

casematch函数中，对List中的元素做case匹配，这在java等传统语言中是没有的。

下划线等同于正则表达式中的“*”，因为*在scala中是保留符号，所以用下划线“_”代替。

match ... case相当于java语言的switch...case.

zhh@test % scalac for.scala
zhh@test % scala -classpath . For
List(黄小灿, 黄小鸭, 周小羊, 喜羊羊, 灰太狼, 懒羊羊)
包含羊的名字：
周小羊
喜羊羊
class Fruit() {}
懒羊羊
包含小的名字,并且姓不黄的：
周小羊
Four elements, with the 2nd being '3':List(1, 3, 23, 90)
Any other list with 0 or more elements:List(4, 18, 52)
Any other list with 0 or more elements:List()


