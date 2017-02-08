---
author: abloz
comments: true
date: 2015-05-28 16:52:55+00:00
layout: post
link: http://abloz.com/index.php/2015/05/29/getting-started-with-scala-3/
slug: getting-started-with-scala-3
title: scala入门（3）
wordpress_id: 2630
categories:
- 技术
tags:
- scala
---

周海汉 2015.5.28

今天股市大跌6%，市值蒸发4万亿。携程数据被删除，流量导入艺龙，艺龙网站瘫痪。真是个祸不单行的日子。

**case语法**

scala实现数据结构Tree，并实现查找节点是否存在

zhh@test % cat tree.scala

    
    abstract class IntTree
    case object EmptyTree extends IntTree
    case class Node(elem: Int, left: IntTree, right: IntTree) extends IntTree
    
    object Tree {
    	def contains(t: IntTree, v: Int): Boolean = t match {
    	    case EmptyTree => false
    	    case Node(e, l, r) => e == v || contains(l, v) || contains(r, v)
    	}
    
    	def insert(t: IntTree, v: Int): IntTree = t match {
    	    case EmptyTree => Node(v, EmptyTree, EmptyTree)
    	    case Node(e, l, r) =>
    		if(e == v) t
    		else if(e > v) Node(e, insert(l, v), r)
    		else Node(e, l, insert(r, v))
    	}
    	def main(arr: Array[String]) {
    		val e=EmptyTree
    		var t=insert(e,10)
    		t=insert(t,11)
    		t=insert(t,8)
    		var c=contains(t,11)
    		println("tree:"+t)
    		println("contains 8?:"+c)
    	}
    }
    


第一句是定义一个IntTree虚基类。

然后case打头，定义了一个静态单例的EmptyTree节点，继承于IntTree。

还cased打头定义了一个Node类。

case打头定义的类和单例与普通的类和单例有何不同？



	
  * case定义的类，可以不用new，直接使用。如val a=new Node(xxx)，可以直接写成val a = Node(xxx)

	
  * getter函数对构造参数自动生成。如对某Node 实例n，直接用n.r获取右成员。

	
  * 提供缺省的equals和hashCode方法及toString方法。

	
  * 这些类实例可以用于模式匹配match...case


zhh@test % scalac tree.scala
zhh@test % scala -classpath . Tree
tree:Node(10,Node(8,EmptyTree,EmptyTree),Node(11,EmptyTree,EmptyTree))
contains 8?:true
