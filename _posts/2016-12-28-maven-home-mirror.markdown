---
author: abloz
comments: true
date: 2016-12-28 11:12:49+00:00
layout: post
link: http://abloz.com/index.php/2016/12/28/maven-home-mirror/
slug: maven-home-mirror
title: maven国内镜像
wordpress_id: 2817
categories:
- 技术
tags:
- maven
- 镜像
- 阿里云
---

周海汉 /文
2016.12.28

maven仓库是java编程很重要的依赖。国内访问国外的maven仓库都是龟速，还经常失败。
以前oschina提供国内maven镜像，但因为无利可图，带宽耗费巨大，oschina关闭了该maven仓库。
这让java开发者痛苦了很长一段时间。

幸好阿里云又建立了新的镜像。以阿里的实力，应该不至于搞两年又关了吧。
用上阿里镜像后，maven编译变得飞快。感谢阿里。


# maven配置


可以在maven安装目录的conf目录，修改settings.xml

找到原来的mirrors，修改成如下的镜像配置：

    
    <mirrors>
        <mirror>
          <id>alimaven</id>
          <name>aliyun maven</name>
          <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
          <mirrorOf>central</mirrorOf>
        </mirror>
    </mirrors>




# gradle 配置


在build.gradle中添加

    
    allprojects {
        repositories {
            mavenLocal()
            maven{ url 'http://maven.aliyun.com/nexus/content/groups/public/'}
        }
    }


系统配置：

将init.gradle放到 USER_HOME/.gradle/目录下`

或者将.gradle结尾的文件名放到 USER_HOME/.gradle/init.d/目录下。`

可以用该脚本替换gradle缺省的mavenCentral()和jcenter()配置：

    
    allprojects {
        repositories {
            mavenLocal()
            def REPOSITORY_URL = 'http://maven.aliyun.com/nexus/content/groups/public/'
            all { ArtifactRepository repo ->
                def url = repo.url.toString()
                if ((repo instanceof MavenArtifactRepository) && (url.startsWith('https://repo1.maven.org/maven2') || url.startsWith('https://jcenter.bintray.com'))) {
                    project.logger.lifecycle 'Repository ${repo.url} replaced by $REPOSITORY_URL .'
                    remove repo
                }
            }
            maven {
                url REPOSITORY_URL
            }
        }
    }







# 参考


https://docs.gradle.org/current/userguide/init_scripts.html
