---
layout: post
title:  "akka http复杂格式json处理"
author: "周海汉"
date:   2017-07-15 10:18:26 +0800
categories: tech
tags:
    - scala
    - akka-http
    - json
    - json4s
---

# 概述
json 分为好几种形态.
1. 字符串形态, 用于数据交换和描述存储的原始形式.
2. Json对象形态, 这是Json引擎内在逻辑,树形结构,抽象语法树AST
3. 模型对象形态, 这是用户业务对象

在实际编码中这三种形态经常相互转化.

由于官方文档的示例都非常简单, 所以遇到复杂的结构出了问题很难处理.

本文采用akka-http自带spray json和json4s的json分别处理.

# 用g8生成模板

```
zhouhh@/Users/zhouhh/git $ sbt new akka/akka-http-scala-seed.g8

name [My Akka HTTP Project]: TestJsonConvert
scala_version [2.12.2]:
akka_http_version [10.0.9]:
akka_version [2.5.3]:

Template applied in ./testjsonconvert

zhouhh@/Users/zhouhh/git/testjsonconvert $ find .
.
./build.sbt
./project
./project/build.properties
./project/plugins.sbt
./src
./src/main
./src/main/scala
./src/main/scala/com/example
./src/main/scala/com/example/routes
./src/main/scala/com/example/routes/BaseRoutes.scala
./src/main/scala/com/example/routes/SimpleRoutes.scala
./src/main/scala/com/example/WebServer.scala
./src/main/scala/com/example/WebServerHttpApp.scala
./src/test
./src/test/scala
./src/test/scala/com
./src/test/scala/com/example
./src/test/scala/com/example/routes
./src/test/scala/com/example/routes/BaseRoutesSpec.scala
./src/test/scala/com/example/routes/SimpleRoutesSpec.scala
./src/test/scala/com/example/WebServerHttpAppSpec.scala

```
## build.sbt
```
zhouhh@/Users/zhouhh/git/testjsonconvert $ cat build.sbt
lazy val akkaHttpVersion = "10.0.9"
lazy val akkaVersion    = "2.5.3"

lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization    := "com.example",
      scalaVersion    := "2.12.2"
    )),
    name := "TestJsonConvert",
    libraryDependencies ++= Seq(
      "com.typesafe.akka" %% "akka-http"         % akkaHttpVersion,
      "com.typesafe.akka" %% "akka-http-xml"     % akkaHttpVersion,
      "com.typesafe.akka" %% "akka-stream"       % akkaVersion,
      "com.typesafe.akka" %% "akka-http-spray-json" % "10.0.9",
      "org.json4s" % "json4s-jackson_2.12" % "3.5.2",

      "com.typesafe.akka" %% "akka-http-testkit" % akkaHttpVersion % Test,
      "org.scalatest"     %% "scalatest"         % "3.0.1"         % Test
    )
  )
```

# Spray Json 转换
## Json转换代码
```
zhouhh@/Users/zhouhh/git/testjsonconvert/src/main/scala/com/example $ vi TestSprayJsonConvert.scala

```

```scala
package com.example

import spray.json._

case class Color( name: String, red: Double, green: Int, blue: Int )
case class Colors( colors: List[Color] )
case class Paint( name: String, colors: Colors )

object MyJsonProtocol extends DefaultJsonProtocol {
    implicit val colorFormat = jsonFormat4( Color ) //4个属性
    implicit val colorsFormat = jsonFormat1( Colors ) //1个属性
    implicit val paintFormat = jsonFormat2( Paint ) //2个属性
}

/**
 * Author: zhouhh
 * Date: 2017.7.15
 *  抽象语法树结构(Abstract Syntax Tree (AST)), 是Json对象树, 区别于json字符串和模型对象
 *  该代码演示三者之间互转. 但引入复杂对象,浮点和集合
 *
 */
object TestSprayJsonConvert {
    import MyJsonProtocol._

    def main( args: Array[String] ): Unit = {
        //object  to jsonAst, 军校蓝, 此处故意调整值为浮点
        val json = Color( "CadetBlue", 95.2, 158, 160 ).toJson
        println( json ) //{"name":"CadetBlue","red":95,"green":158,"blue":160}
        //jsonAst to object
        val color = json.convertTo[Color]
        println( "name:" + color.name + ",red:" + color.red + ",green:" + color.green + ",blue:" + color.blue ) //name:CadetBlue,red:95,green:158,blue:160

        val jsonsListStr = "[{\"name\":\"CadetBlue\",\"red\":95.3,\"green\":158,\"blue\":160},{\"name\":\"CadetRed\",\"red\":160.5,\"green\":158,\"blue\":95}]"
        //另一种更直观的表示
        val jsons = """{"colors":[{"name":"CadetBlue","red":95.3,"green":158,"blue":160},{"name":"CadetRed","red":160.5,"green":158,"blue":95}]}"""
        //string -> jsonAst(JsValue) -> object
        val colorsObj: Colors = jsons.parseJson.convertTo[Colors]
        print( colorsObj )
        val colorsList: List[Color] = jsonsListStr.parseJson.convertTo( DefaultJsonProtocol.listFormat[Color] )
        //此处故意将colorsObj命名有区别,否则出现两个colors, 后者是前者的成员.
        colorsObj.colors.foreach { color =>
            println( "name:" + color.name + ",red:" + color.red + ",green:" + color.green + ",blue:" + color.blue )

        }
        //do the same thing but directly var List
        colorsList.foreach { color =>
            println( "name:" + color.name + ",red:" + color.red + ",green:" + color.green + ",blue:" + color.blue )

        }

        //object -> json
        // val listjson = colors.colors.toArray.toJson
        val listjson: JsValue = colorsObj.toJson
        println( listjson )

        //复杂结构, json字符串,对象互转.
        val paintJsonStr = """ {"name":"mypaint","colors":{"colors":[{"name":"CadetBlue","red":95.3,"green":158,"blue":160},{"name":"CadetRed","red":160.5,"green":158,"blue":95}]}}"""

        val paintAST = paintJsonStr.parseJson
        val paint: Paint = paintAST.convertTo[Paint]
        val paintJsonStrTo = paint.toJson
        println( paintAST )
        println( paint )
        println( paintJsonStrTo )

    }

}
```

## 运行测试
```
zhouhh@/Users/zhouhh/git/testjsonconvert $ sbt

> run
[info] Formatting 1 Scala source {file:/Users/zhouhh/git/testjsonconvert/}root(compile) ...
[info] Reformatted 1 Scala source {file:/Users/zhouhh/git/testjsonconvert/}root(compile).
[info] Compiling 1 Scala source to /Users/zhouhh/git/testjsonconvert/target/scala-2.12/classes...
[warn] Multiple main classes detected.  Run 'show discoveredMainClasses' to see the list

Multiple main classes detected, select one to run:

 [1] com.example.TestSprayJsonConvert
 [2] com.example.WebServer
 [3] com.example.WebServerHttpApp

Enter number: 1

[info] Running com.example.TestSprayJsonConvert
{"name":"CadetBlue","red":95.2,"green":158,"blue":160}
name:CadetBlue,red:95.2,green:158,blue:160
Colors(List(Color(CadetBlue,95.3,158,160), Color(CadetRed,160.5,158,95)))name:CadetBlue,red:95.3,green:158,blue:160
name:CadetRed,red:160.5,green:158,blue:95
name:CadetBlue,red:95.3,green:158,blue:160
name:CadetRed,red:160.5,green:158,blue:95
{"colors":[{"name":"CadetBlue","red":95.3,"green":158,"blue":160},{"name":"CadetRed","red":160.5,"green":158,"blue":95}]}
{"name":"mypaint","colors":{"colors":[{"name":"CadetBlue","red":95.3,"green":158,"blue":160},{"name":"CadetRed","red":160.5,"green":158,"blue":95}]}}
Paint(mypaint,Colors(List(Color(CadetBlue,95.3,158,160), Color(CadetRed,160.5,158,95))))
{"name":"mypaint","colors":{"colors":[{"name":"CadetBlue","red":95.3,"green":158,"blue":160},{"name":"CadetRed","red":160.5,"green":158,"blue":95}]}}
[success] Total time: 12 s, completed 2017-7-15 9:07:53
```

# json4s转json

```scala
zhouhh@/Users/zhouhh/git/testjsonconvert $ vi src/main/scala/com/example/TestJson4s.scala
cat: zhouhh@/Users/zhouhh/git/testjsonconvert: No such file or directory
cat: $: No such file or directory
cat: vi: No such file or directory
package com.example

import org.json4s._
import org.json4s.jackson.JsonMethods._
import org.json4s.JsonDSL._

/**
 * 测试json4s.jackson
 */
object TestJson4s {
    case class Winner( id: Long, numbers: List[Int] )
    case class Lotto( id: Long, winningNumbers: List[Int], winners: List[Winner], drawDate: Option[java.util.Date] )

    def mprint( json: String ): Unit = {
        print( json )

    }
    def genJson(): String = {

        val winners = List( Winner( 23, List( 2, 45, 34, 23, 3, 5 ) ), Winner( 54, List( 52, 3, 12, 11, 18, 22 ) ) )
        val lotto = Lotto( 5, List( 2, 45, 34, 23, 7, 5, 3 ), winners, None )

        val json =
            ( "lotto" ->
                ( "lotto-id" -> lotto.id ) ~
                ( "winning-numbers" -> lotto.winningNumbers ) ~
                ( "draw-date" -> lotto.drawDate.map( _.toString ) ) ~
                ( "winners" ->
                    lotto.winners.map { w =>
                        ( ( "winner-id" -> w.id ) ~
                            ( "numbers" -> w.numbers ) )
                    } ) )
        val jsonstr = compact( render( json ) )
        println( compact( jsonstr ) )

        jsonstr

    }
    def main( args: Array[String] ) {

        mprint( genJson() )
    }
}

```

```
          "org.json4s" % "json4s-jackson_2.11" % "3.5.2",

```

## 执行

```
> run
Multiple main classes detected, select one to run:

 [1] com.example.TestJson4s
 [2] com.example.TestSprayJsonConvert
 [3] com.example.WebServer
 [4] com.example.WebServerHttpApp

Enter number: 1

[info] Running com.example.TestJson4s
"{\"lotto\":{\"lotto-id\":5,\"winning-numbers\":[2,45,34,23,7,5,3],\"winners\":[{\"winner-id\":23,\"numbers\":[2,45,34,23,3,5]},{\"winner-id\":54,\"numbers\":[52,3,12,11,18,22]}]}}"
{"lotto":{"lotto-id":5,"winning-numbers":[2,45,34,23,7,5,3],"winners":[{"winner-id":23,"numbers":[2,45,34,23,3,5]},{"winner-id":54,"numbers":[52,3,12,11,18,22]}]}}[success] Total time: 28 s, completed 2017-7-15 10:26:50
>

```
# 参考
[http://akka.io/](http://akka.io/)
