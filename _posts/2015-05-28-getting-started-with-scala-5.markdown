---
author: abloz
comments: true
date: 2015-05-28 17:08:23+00:00
layout: post
link: http://abloz.com/index.php/2015/05/29/getting-started-with-scala-5/
slug: getting-started-with-scala-5
title: scala 入门（5）
wordpress_id: 2636
categories:
- 技术
tags:
- scala
---

周海汉 2015.5.29 0点

**scala mixin模式续**

上一篇文章用水果为例，满足了老板用礼仪专家给的建议，给每种水果贴上是否送礼的标签。

但水果怎么吃，一些不产水果的地方的人可能不知道。因此又请教了农业专家。不同水果给出不同说明。

zhh@test % cat mixin2.scala

    
    class Fruit(name:String) {
    	def nm=name
    }
    
    trait Gift {
    	def gift ={ true }
    }
    
    trait NoGift {
    	def gift ={ false }
    }
    
    trait Peel {
    	def eat = { "peel"}
    }
    
    
    trait Husk{
    	def eat = { "husk"}
    }
    
    
    class Apple(name:String) extends Fruit(name) with Gift with Peel
    
    class Pear(name:String) extends Fruit(name) with NoGift with Peel
    
    class Orange(name:String) extends Fruit(name) with Gift with Husk
    
    
    object BuyFruit{
    def main(arr : Array[String]) {
    	println("mixin混入编程示例。苹果削皮吃，适合送礼；梨削皮，不适合送礼；橘子剥皮，适合送礼")
    	val a = new Apple("apple")
    	println(a.nm )
    	println(a.gift)
    	println(a.eat)
    
    	val p = new Pear("pear")
    	println(p.nm )
    	println(p.gift)
    	println(p.eat)
    
    	val o = new Orange("orange")
    	println(o.nm )
    	println(o.gift)
    	println(o.eat)
    }
    }
    


用mixin的方式，很方便的加上了水果的吃法。注意mixin多基类注入时，采用多个with实现。

另外就是父类的参数的初始化方式。

zhh@test % scalac mixin2.scala
zhh@test % scala -classpath . BuyFruit
mixin混入编程示例。苹果削皮吃，适合送礼；梨削皮，不适合送礼；橘子剥皮，适合送礼
apple
true
peel
pear
false
peel
orange
true
husk
