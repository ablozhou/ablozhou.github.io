---
author: abloz
comments: true
date: 2013-09-17 13:06:34+00:00
layout: post
link: http://abloz.com/index.php/2013/09/17/go-coroutine-language-and-communication-channels/
slug: go-coroutine-language-and-communication-channels
title: go语言的协程和通道通信
wordpress_id: 2228
categories:
- 技术
tags:
- go
---

周海汉 2013.9.17
许式伟的《go语言编程》，有一个简单的例子，描述go协程和通信通道chan。挺优美的。如下：


    
    [andy@s1 test]$ cat sum.go
    package main
    
    import "fmt"
    
    func sum(values []int, myChan chan int) {
    
        sum := 0
        for _, value := range values {
            sum += value
        }
    
         myChan <- sum //值传到通道
    }
    
    func main() {
    
        myChan := make( chan int,2)
    
        values := []int {1,2,3,5,5,4}
        go sum(values,myChan)  //协程1
        go sum(values[:3],myChan) //协程2
    
        sum1,sum2 := <-myChan, <-myChan
        fmt.Println("Result:",sum1,sum2,sum1+sum2)
    }



结果：
[andy@s1 test]$ go run sum.go
Result: 20 6 26

