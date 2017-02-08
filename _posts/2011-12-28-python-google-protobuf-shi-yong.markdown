---
author: abloz
comments: true
date: 2011-12-28 12:47:26+00:00
layout: post
link: http://abloz.com/index.php/2011/12/28/python-google-protobuf-shi-yong/
slug: python-google-protobuf-shi-yong
title: python google protobuf 使用
wordpress_id: 1473
categories:
- 技术
tags:
- protobuf
- python
---

google protobuf由于采用二进制打包，数据量很小，又支持主流的java,c,python语言，所以尤其适合于mobile客户端与服务器的通信。相对于xml，html，json等格式，有其独特优势。

下载：[http://code.google.com/p/protobuf/downloads/list](http://code.google.com/p/protobuf/downloads/list)

解压后里面有个python目录。linux可以直接编译源码，对windows，可以将protoc.exe拷贝到python目录下，然后在cmd下，切换到该目录，执行python setup.py install



然后就可以用命令将proto文件编译成py：

protoc.exe --python_out=d:/test/ *.proto



示例：

完成测试test.proto

    
    message TestMsg
    {
        required int32 id=1;
        required int32 time=2;
        optional string note=3;
    }


protoc.exe --python_out=d:/test/ test.proto

    
    #-*- coding:utf-8 -*-
    import google.protobuf
    import TestMsg_pb2
    import time
    
    #压缩
    test = TestMsg_pb2()
    test.id=1
    test.time=int(time.time())
    test.string="asdftest"
    print test
    test_str = test.SerializeToString()
    print test_str
    #解压
    test1 = TestMsg_pb2()
    test1.ParseFromString(test_str)
    print test1
