---
author: abloz
comments: true
date: 2015-05-22 06:54:33+00:00
layout: post
link: http://abloz.com/index.php/2015/05/22/gradle-build-scripts-need-to-re-download-gradle-problem/
slug: gradle-build-scripts-need-to-re-download-gradle-problem
title: gradle编译脚本需要重新下载gradle问题
wordpress_id: 2294
categories:
- 技术
tags:
- gradle
---

执行gradle脚本时，总是需要下载gradle，但我已经安装好了，并配置了环境。

zhh@complete % ./gradlew run
Downloading https://services.gradle.org/distributions/gradle-2.4-bin.zip

需要将二进制放到如下目录中。

zhh@qtpfibs0bk58et4qkc9rtloo1 % pwd
/Users/zhh/.gradle/wrapper/dists/gradle-2.4-bin/qtpfibs0bk58et4qkc9rtloo1

在用户名下.gradle下面如上的目录中，将自己下载的gradle-2.4-bin.zip放进去即可。

其中qtpfibs0bk58et4qkc9rtloo1这个字符串可能不是固定的。因为我解决了一个下载后，又遇到另一个同样的下载，发现新建了一个目录，所以我又放了进去。

zhh@1lebsnfoptv8qpa10w6kyy5mp % pwd
/Users/zhh/.gradle/wrapper/dists/gradle-2.4-bin/1lebsnfoptv8qpa10w6kyy5mp
zhh@1lebsnfoptv8qpa10w6kyy5mp % ls
gradle-2.4 gradle-2.4-bin.zip gradle-2.4-bin.zip.lck gradle-2.4-bin.zip.ok



一旦遇到要下载gradle-xx.zip, 就到.gradle/wrapper的相应目录下去看，如果没有，可以将事先下载好的gradle-xx.zip放进去。

zhh@test % ./run.sh
Unzipping /Users/zhh/.gradle/wrapper/dists/gradle-2.4-bin/qtpfibs0bk58et4qkc9rtloo1/gradle-2.4-bin.zip to /Users/zhh/.gradle/wrapper/dists/gradle-2.4-bin/qtpfibs0bk58et4qkc9rtloo1
Set executable permissions for: /Users/zhh/.gradle/wrapper/dists/gradle-2.4-bin/qtpfibs0bk58et4qkc9rtloo1/gradle-2.4/bin/gradle
:compileJava



遇到提示

This build could be faster, please consider using the Gradle Daemon: http://gradle.org/docs/2.4/userguide/gradle_daemon.html

执行下面命令，将gradle用daemon模式启动。

% touch ~/.gradle/gradle.properties && echo "org.gradle.daemon=true" >> ~/.gradle/gradle.properties






