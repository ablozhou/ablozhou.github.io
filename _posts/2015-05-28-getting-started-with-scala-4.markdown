---
author: abloz
comments: true
date: 2015-05-28 17:00:51+00:00
layout: post
link: http://abloz.com/index.php/2015/05/29/getting-started-with-scala-4/
slug: getting-started-with-scala-4
title: scala 入门（4）
wordpress_id: 2632
categories:
- 技术
tags:
- scala
---

周海汉 2015.5.28

赖永浩在介绍python的mixin模式时，曾举例水果有适合送礼和不适合送礼的。如苹果和橘子吉利，适合送礼。而梨则表示离别，香蕉表示焦躁，所以不适合送礼。要实现这样的类当然可以用定义子类继承的方式，也可以用组合的方式。但这些方式侵入性较强，必须修改实现内部的源代码。

而mixin模式，翻译成中文叫混入模式，是侵入性较弱的。只需在定义的地方加上相应的混入基类，该类就有了相应的能力。混入类必须用trait标记。

    
    class Fruit() {}
    
    trait Gift {
    	def gift ={ true }
    }
    
    trait NoGift {
    	def gift ={ false }
    }
    
    class Apple(name:String) extends Fruit with Gift {
    	def nm = name
    }
    
    class Pear(name:String) extends Fruit with NoGift{
    
    	def nm = name
    }
    
    
    object BuyFruit{
    def main(arr : Array[String]) {
    	val a = new Apple("apple")
    	println(a.nm + a.gift)
    
    	val p = new Pear("pear")
    	println(p.nm + p.gift)
    }
    }
    


采用混插方式，让苹果和梨具有了可以判断是否适合送礼的能力。mixin相当于外来的专家给的标签，直接贴在水果上。

zhh@test % scalac mixin.scala

zhh@test % scala -classpath . BuyFruit
appletrue
pearfalse
