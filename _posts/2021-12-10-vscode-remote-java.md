---
layout: post
title:  "vscode 远程调试java"
author: "周海汉"
date:   2021-12-10 21:28:36 +0800
categories: tech
tags:
    - ubuntu
    - vscode
    - java
---
# vscode 远程调试java

vscode是一款很好用的工具，可以基本替代大多数开发工具。但对不同的语言不同环境，并不是开箱即用。需要一定的配置。

本文主要是记录java远程开发配置。

# vscode 配置
vscode 的用户配置分3个级别，分别是默认配置、全局配置和工作区配置，优先级也依次递增。对于团队项目，一些规范可以通过项目目录下建一个`.vscode/setting.json`文件。

# vscode安装相关插件
- 安装 microsoft的Extension Pack for Java
    - Language Support for Java(TM) by Red Hat
    - Debugger for Java
    - Test Runner for Java
    - Maven for Java
    - Project Manager for Java
    - Visual Studio IntelliCode


- 安装 microsoft remote相关插件
    - Remote Development
    - Remote - SSH: Editing Configuration Files
    - Remote - SSH
    - Remote - Containers
    - Remote - WSL


# 编辑相关.ssh/config
```
Host mysvr
    HostName 111.194.84.170
    Port 2020
    User zhh
    IdentityFile ~/.ssh/id_rsa
```
点vscode状态栏左下角远程连接，可以选择相应的远程设备，如WSL，container和SSH方式。

然后就可以打开远程文件夹

# 新建文件夹如下

`mkdir -p src/main/java/com/abloz`

```
roottree.
├── README.en.md
├── README.md
└── src
    └── main
        └── java
            └── com
                └── abloz
                    └── main.java
```

用vscode打开
写一个简单的hello world，main.java
```
package com.abloz;

class Main {

    public static void main(String[] args){
        System.out.println("hello");
        
    }
}
```

# 配置.vscode/launch.json
点左侧debug按钮，生成launch.json,选择java，launch java.
```
{
    "type": "java",
    "name": "Launch Main",
    "request": "launch",
    "mainClass": "com.abloz.Main",
    "projectName": "xxx"
}
```
xxx为自动生成的project名称

# 运行和调试
可以通过vscode F5进行调试，添加断点。

# 问题
## vscode 启动vscode server失败
`The Language Support for Java (Syntax Server) server crashed and will restart`

因为lombok的原因，在settings.json
找到 java.jdt.ls.vmargs，删除lombok的设置：
原始版本：
```
"java.jdt.ls.vmargs": "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m -javaagent:\"/home/zhh/.vscode-server/extensions/gabrielbb.vscode-lombok-1.0.1/server/lombok.jar\"",
```
删除后
```
"java.jdt.ls.vmargs": "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
```
或重置为下面的设置
```
"java.jdt.ls.vmargs": "-noverify -Xmx1G -XX:+UseG1GC -XX:+UseStringDeduplication"
```

有可能需要删除插件，类似命令：
```
 rm /home/zhh/.vscode-server/extensions/gabrielbb.vscode-lombok-1.0.1 -rf
 ```
