---
layout: post
title:  "scala安装试用"
author: "周海汉"
date:   2017-07-01 17:38:26 +0800
categories: tech
tags:
    - scala
---

# java环境
需要java sdk 1.7 以上

```
[zhouhh@mainServer hadoop-3.0.0-alpha3]$ !cat
cat /etc/redhat-release
CentOS Linux release 7.1.1503 (Core)
[zhouhh@mainServer hadoop-3.0.0-alpha3]$ echo $JAVA_HOME
/etc/alternatives/java_sdk_openjdk
[zhouhh@mainServer
[zhouhh@mainServer hadoop-3.0.0-alpha3]$ java -version
openjdk version "1.8.0_131"
OpenJDK Runtime Environment (build 1.8.0_131-b12)
OpenJDK 64-Bit Server VM (build 25.131-b12, mixed mode)
hadoop-3.0.0-alpha3]$ javac -version
javac 1.8.0_131



```
# 下载安装scala
下载安装scala只需找到对应版本,解压即可.
下载地址:http://www.scala-lang.org/download/
```
[zhouhh@msvr ~]$ wget https://downloads.lightbend.com/scala/2.12.2/scala-2.12.2.tgz
解压
[zhouhh@msvr scala-2.12.2]$ ./bin/scala
Welcome to Scala 2.12.2 (OpenJDK 64-Bit Server VM, Java 1.8.0_131).
Type in expressions for evaluation. Or try :help.
[zhouhh@msvr ~]$ vi .bashrc
# scala
export SCALA_HOME="${HOME}/java/scala"
export PATH="$SCALA_HOME/bin:$PATH"
[zhouhh@msvr ~]$ source .bashrc
[zhouhh@msvr ~]$ scala
Welcome to Scala 2.12.2 (OpenJDK 64-Bit Server VM, Java 1.8.0_131).
Type in expressions for evaluation. Or try :help.

scala> 1+1
res1: Int = 2
```

编写测试程序
```
[zhouhh@msvr scala]$ cat hello.scala
object HelloWorld {
  def main(args: Array[String]): Unit = {
    println("Hello, 中国!")
  }
}
[zhouhh@msvr scala]$ scala hello.scala
Hello, 中国!
```
在命令行执行
```
scala> object HelloWorld {
     | def main(args: Array[String]):Unit = {
     |
     |  print("Hello, 中国")
     | }
     | }
defined object HelloWorld

scala> HelloWorld.main(Array())
Hello, 中国
```
编译
```
[zhouhh@msvr scala]$ scalac hello.scala

[zhouhh@msvr scala]$ scala HelloWorld
Hello, 中国!

```
# 继承app
可以不用写入口的main
```
scala> object HelloWorld extends App {
     | print("hello,中国2")
     | }
defined object HelloWorld

scala> HelloWorld.main(Array())
hello,中国2

```

# 脚本化

```
[zhouhh@msvr scala]$ cat hello.sh
#!/usr/bin/env scala
object HelloWorld extends App {
  println("Hello, 中国!")
}
HelloWorld.main(args)
[zhouhh@msvr scala]$ ./hello.sh
/home/zhouhh/test/scala/./hello.sh:5: warning: Script has a main object but statement is disallowed
HelloWorld.main(args)
               ^
one warning found
Hello, 中国!

```
