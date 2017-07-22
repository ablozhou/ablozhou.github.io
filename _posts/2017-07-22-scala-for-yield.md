---
layout: post
title:  "scala的for循环yield值"
author: "周海汉"
date:   2017-07-22 10:18:26 +0800
categories: tech
tags:
    - scala
    - yield

---

# 概述
scala语言的for语法很灵活. 除了普通的直接对集合的循环, 以及循环中的判断和值返回. 非常灵活.

for 可以通过yield(生产)返回值, 最终组成for循环的对象类型.for 循环中的 yield 会把当前的元素记下来，保存在集合中，循环结束后将返回该集合。如果被循环的是 Map，返回的就是Map，被循环的是 List，返回的就是List，以此类推。

守卫( guards) (for loop 'if' conditions)

可以在 for 循环结构中加上 'if' 表达式, 和yield联合起来用.


# 普通对集合或迭代循环
```scala
scala> for(i<- 1 to 5) println(i)
1
2
3
4
5
scala> for(i<- 1 until 5) println(i)
1
2
3
4
```
# yield返回值
```scala
scala> for (i <- 1 to 5) yield i
res0: scala.collection.immutable.IndexedSeq[Int] = Vector(1, 2, 3, 4, 5)

scala> val a= for (i <- 1 to 5) yield i
a: scala.collection.immutable.IndexedSeq[Int] = Vector(1, 2, 3, 4, 5)

scala> a
res1: scala.collection.immutable.IndexedSeq[Int] = Vector(1, 2, 3, 4, 5)

scala> val a= for (i <- 1 until 5) yield i
a: scala.collection.immutable.IndexedSeq[Int] = Vector(1, 2, 3, 4)

scala> a
res2: scala.collection.immutable.IndexedSeq[Int] = Vector(1, 2, 3, 4)

scala> val a= for (i <- 1 until 5) yield i*2
a: scala.collection.immutable.IndexedSeq[Int] = Vector(2, 4, 6, 8)

scala> val a = Array(1, 2, 3, 4, 5)
a: Array[Int] = Array(1, 2, 3, 4, 5)

scala> for ( e <- a) yield e
res3: Array[Int] = Array(1, 2, 3, 4, 5)
```

# 循环过滤 if 判断, 并返回值
```scala
scala> for ( e <- a if e%2 == 0) yield e
res4: Array[Int] = Array(2, 4)
scala> a
res10: Array[Int] = Array(1, 2, 3, 4, 5)

scala> val b = 6 to 7
b: scala.collection.immutable.Range.Inclusive = Range 6 to 7

scala> for {
     | x <-a
     | y <-b
     | } yield (x,y)
res11: Array[(Int, Int)] = Array((1,6), (1,7), (2,6), (2,7), (3,6), (3,7), (4,6), (4,7), (5,6), (5,7))

scala> for {
     | y <- b
     | x <- a
     | } yield (x,y)
res12: scala.collection.immutable.IndexedSeq[(Int, Int)] = Vector((1,6), (2,6), (3,6), (4,6), (5,6), (1,7), (2,7), (3,7), (4,7), (5,7))

```
# for 复杂实例
找出.txt后缀文件
```scala
scala> def getTextFile(path:String) : Array[java.io.File] =
     | for {
     | file <- new File(path).listFiles
     | if file.isFile
     | if file.getName.endsWith(".txt")
     | } yield file
getTextFile: (path: String)Array[java.io.File]

scala> getTextFile(".")
res9: Array[java.io.File] = Array(./a.txt, ./test.txt)

```

# 参考
https://unmi.cc/scala-yield-samples-for-loop/
