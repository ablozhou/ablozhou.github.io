---
author: abloz
comments: true
date: 2015-05-20 03:20:40+00:00
layout: post
link: http://abloz.com/index.php/2015/05/20/mac-go-under-linguistic-environment-preparation/
slug: mac-go-under-linguistic-environment-preparation
title: Mac下Go语言环境准备
wordpress_id: 2281
categories:
- 技术
tags:
- beego
- go
---

周海汉 2015.5.20




下载最新版本：




wget [https://storage.googleapis.com/golang/go1.4.2.darwin-amd64-osx10.8.tar.gz](https://storage.googleapis.com/golang/go1.4.2.darwin-amd64-osx10.8.tar.gz)







解压，缺省放在/usr/local下




tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz




设环境变量：







export GOPATH=$HOME/go




export GOROOT=/usr/local/go




export PATH=$PATH:$GOPATH/bin:$GOROOT/bin




也可以放在指定目录，如~/go，设环境变量：




export GOROOT=$HOME/go




export GOPATH=$HOME/go




export PATH=$PATH:$GOROOT/bin







测试：




➜ ~ go




Go is a tool for managing Go source code.







Usage:







go command [arguments]







➜ go cat test.go



```



package main







import "fmt"







func main() {




fmt.Printf("hello world\n");




}


```



➜ go go run test.go




hello world







beego 谢孟军




➜ ~ go get github.com/astaxie/beego




`go get [github.com/beego/bee](http://github.com/beego/bee)`




export PATH=$PATH:<your_main_gopath>/bin/bee




进入$GOPATH/src，执行




$ bee new myapp






    
    $ cd myapp
    $ bee run
    
    zhh@myapp % bee run
    2015/05/20 10:23:44 [INFO] Uses 'myapp' as 'appname'
    2015/05/20 10:23:44 [INFO] Initializing watcher...
    2015/05/20 10:23:44 [TRAC] Directory(/Users/zhh/go/src/myapp/controllers)
    2015/05/20 10:23:44 [TRAC] Directory(/Users/zhh/go/src/myapp)
    2015/05/20 10:23:44 [TRAC] Directory(/Users/zhh/go/src/myapp/routers)
    2015/05/20 10:23:44 [TRAC] Directory(/Users/zhh/go/src/myapp/tests)
    2015/05/20 10:23:44 [INFO] Start building...
    2015/05/20 10:23:46 [SUCC] Build was successful
    2015/05/20 10:23:46 [INFO] Restarting myapp ...
    2015/05/20 10:23:46 [INFO] ./myapp is running...
    2015/05/20 10:23:46 [app.go:103] [I] http server Running on :8000
    访问http://localhost:8000/
    <a href="http://abloz.com/wp-content/uploads/2015/05/屏幕快照-2015-05-20-上午10.24.28.png"><img src="http://abloz.com/wp-content/uploads/2015/05/屏幕快照-2015-05-20-上午10.24.28-300x247.png" alt="beego" height="247" class="alignnone size-medium wp-image-2282" width="300"></img></a>
    
    



