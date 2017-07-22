---
layout: post
title:  "akka http的Actor示例"
author: "周海汉"
date:   2017-07-22 10:18:26 +0800
categories: tech
tags:
    - akka
    - actor
    - akka-http

---

# 概述
这是akka http 文档自带的例子, 略作改编.

本代码演示了akka-http中和actor交互. 
代码功能为拍卖(Aution),投标(Bid)和查询投标(GetBids),实现了http的PUT,GET等方法.

## 关注点
- List初始化方法
- akka-http和Actor发送消息
- json和对象,字符串之间的转换
- Route实现方式
- 异步通信
- 异步通信后值的返回方式
- PUT方法参数传送方式

```scala
package com.example

/**
 * Created by zhouhh on 2017/7/18.
 */

import akka.actor.{ Actor, ActorSystem, Props, ActorLogging }
import akka.http.scaladsl.Http
import akka.http.scaladsl.model.StatusCodes
import akka.http.scaladsl.server.Directives._
import akka.http.scaladsl.marshallers.sprayjson.SprayJsonSupport._
import akka.pattern.ask
import akka.stream.ActorMaterializer
import akka.util.Timeout
import spray.json._
import spray.json.DefaultJsonProtocol._
import scala.concurrent.duration._
import scala.concurrent._
import scala.io.StdIn

object WebServer1 {

  case class Bid(userId: String, offer: Int)
  case object GetBids
  case class Bids(bids: List[Bid])

  class Auction extends Actor with ActorLogging {
    var bids = List.empty[Bid]
    def receive = {
      case bid @ Bid(userId, offer) =>
        bids = bids :+ bid
        log.info(s"Bid complete: $userId, $offer")
      case GetBids => sender() ! Bids(bids)
      case _ => log.info("Invalid message")
    }
  }

  // 来自 spray-json
  implicit val bidFormat = jsonFormat2(Bid)
  implicit val bidsFormat = jsonFormat1(Bids)

  def main(args: Array[String]) {
    implicit val system = ActorSystem()
    implicit val materializer = ActorMaterializer()
    // 这个在最后的 future flatMap/onComplete 里面会用到
    implicit val executionContext = system.dispatcher

    val auction = system.actorOf(Props[Auction], "auction")

    val route =
      path("auction") {
        put {
          parameter("bid".as[Int], "user") { (bid, user) =>
            // 下单, fire-and-forget
            auction ! Bid(user, bid)
            complete((StatusCodes.Accepted, "bid placed"))
          }
        } ~
          get {
            implicit val timeout: Timeout = 5.seconds

            // 查询actor现在的状态
            val bids: Future[Bids] = (auction ? GetBids).mapTo[Bids]
            complete(bids)
          }
      }

    val bindingFuture = Http().bindAndHandle(route, "localhost", 8080)
    println(s"Server online at http://localhost:8080/\nPress RETURN to stop...")
    StdIn.readLine() // 等用户输入 RETURN 键停跑
    bindingFuture
      .flatMap(_.unbind()) // 放开对端口 8080 的绑定
      .onComplete(_ ⇒ system.terminate()) // 结束后关掉程序
  }
}
```

# 调用方式
mac中的zsh,?和&需转义. linux中去掉转义符.

## PUT 投标
```
curl -X PUT http://localhost:8080/auction\?bid=3\&user=zhh
```
## GET
```
curl  http://localhost:8080/auction

```
# 参考
- https://zhuanlan.zhihu.com/p/24798365

- http://doc.akka.io/docs/akka-http/current/scala/http/introduction.html
