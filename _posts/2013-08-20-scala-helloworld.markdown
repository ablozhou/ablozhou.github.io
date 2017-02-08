---
author: abloz
comments: true
date: 2013-08-20 06:34:11+00:00
layout: post
link: http://abloz.com/index.php/2013/08/20/scala-helloworld/
slug: scala-helloworld
title: scala HelloWorld
wordpress_id: 2199
categories:
- 技术
tags:
- scala
---

周海汉/文 2013.8.1

最近网络封锁太严，日志都发不出来了，只好重发。





scala，一种基于JVM虚拟机的函数式语言，以其编程效率和分布式处理能力著称。spark 就是用scala写的。







下载：










[hadoop@hs11 scala-2.11.0-M4]$ scala
Welcome to Scala version 2.11.0-M4 (Java HotSpot(TM) 64-Bit Server VM, Java 1.6.0_45).
Type in expressions to have them evaluated.
Type :help for more information.


scala> object Hello{
| def main(arg: Array[String]) {
| println("hello world")
| }
| }
defined object Hello


scala> Hello.main(null)
hello world




scala> :q










[hadoop@hs11 examples]$ cat HelloWorld.scala
package examples
object HelloWorld {
def main(args: Array[String]) {
println("Hello, world!")
}
}




[hadoop@hs11 examples]$ scalac HelloWorld.scala




[hadoop@hs11 examples]$ ls examples/Hello*
examples/HelloWorld.class  examples/HelloWorld$.class







[hadoop@hs11 examples]$ scala examples.HelloWorld
Hello, world!







如果继承自App，对象中所有语句自动执行。可以省去main函数




[hadoop@hs11 examples]$ cat Hello1.scala
package examples
object Hello1 extends App {
println("Hello world, App!")
}




[hadoop@hs11 examples]$ scala examples.Hello1
Hello world, App!



