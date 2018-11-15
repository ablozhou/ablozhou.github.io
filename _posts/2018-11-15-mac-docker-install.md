---
layout: post
title:  "Mac下docker安装"
author: "周海汉"
date:   2018-11-15 19:28:26 +0800
categories: tech
tags:
    - mac
    - docker
---
# docker简介
什么是Docker？

Docker是一个开源项目，诞生于2013年初，最初是dotCloud公司内部的一个业余项目。它基于Google公司推出的Go语言实现。

Docker 是世界领先的软件容器平台。开发人员利用 Docker 可以消除协作编码时“在我的机器上可正常工作”的问题。运维人员利用 Docker 可以在隔离容器中并行运行和管理应用，获得更好的计算密度。企业利用 Docker 可以构建敏捷的软件交付管道，以更快的速度、更高的安全性和可靠的信誉为 Linux 和 Windows Server 应用发布新功能。

Docker以Linux容器LXC为基础，实现轻量级的操作系统虚拟化解决方案。在LXC的基础上Docker进行了进一步的封装，让用户不需要去关心容器的管理，使得操作更为简便。用户操作Docker的容器就像操作一个快速轻量级的虚拟机一样简单。
 
 
## 为什么要使用Docker？
具体说来，Docker在如下几个方面具有较大的优势。

对研发人员：
- 不受应用、语言或技术栈限制
构建、测试、调试和部署以任何编程语言编写的 Linux 和 Windows Server 容器应用，无需担心任何不兼容或版本冲突。
- 快速搭建标准环境
工作就绪时间缩短 65%：快速构建、测试和运行复杂的多容器应用，无需再浪费时间在服务器和开发人员机器上安装和维护软件。所有依赖资源都在容器中运行，消除“在我的机器上可正常工作”的问题。
- 内置容器编排
Docker 内置易于配置的 Swarm 集群功能。在使用最小设置的模拟生产环境中测试和调试应用。

对系统管理员来说：
-   更快速的交付和部署
Docker 用户交付软件的速度平均提高了 13 倍。应用维护和支持工时节省高达 10 倍。
-   更轻松的迁移和扩展
Docker容器几乎可以在任意的平台上运行，包括物理机、虚拟机、公有云、个人电脑、服务器等。
内置编排能够扩展到数千个节点和容器。Docker 容器能够在短短数秒之内启动和停止，便于扩展应用服务，以满足客户的高峰需求，并在峰值下降时缩减规模。
-   更简单的管理
使用Docker，只需要小小的修改，就可以替代以往大量的更新工作。所有的修改都以增量的方式被分发和更新，从而实现自动化并且高效的管理。


# docker 版本
Docker 提供了两个版本：社区版 (CE) 和企业版 (EE)。

Docker 社区版 (CE) 是开发人员和小型团队开始使用 Docker 并尝试使用基于容器的应用的理想之选。Docker CE 有两个更新渠道，即 stable 和 edge：

- Stable 每个季度为您提供可靠更新
- Edge 每个月为您提供新功能

MAC下需要 Apple Mac OS Yosemite 10.10.3 最好是OS X El Capitan 10.11或更高版本。

# 采用homebrew cask 安装
```
zhouhh@/Users/zhouhh $ brew cask install docker
==> Creating Caskroom at /usr/local/Caskroom
==> We'll set permissions properly so we won't need sudo in the future
Password:
==> Downloading https://download.docker.com/mac/stable/26764/Docker.dmg
```

# 手动下载安装

也可以手动下载，点击以下链接下载 [Stable](https://download.docker.com/mac/stable/Docker.dmg) 或 [Edge](https://download.docker.com/mac/edge/Docker.dmg) 版本

但官方的下载文件在国内非常慢，也可以到国内的镜像站如[daocloud下载](https://download.daocloud.io)。

# 国内镜像加速
[docker中国](https://registry.docker-cn.com)
[网易镜像](http://hub-mirror.c.163.com)
[中科大镜像](https://docker.mirrors.ustc.edu.cn)

可以在屏幕顶上菜单栏点击docker for mac图标，找到preferences，deamon，添加上述镜像。

或者linux系统可以直接编辑配置文件：
```
$ sudo echo "DOCKER_OPTS=\"--registry-mirror=http://hub-mirror.c.163.com\"" >> /etc/default/docker
$ service docker restart
```

# docker 基本命令
- 用`docker info`来查看docker环境信息
- `docker ps`查看容器进程
- `docker version` 查看docker版本
- `docker images` 查看已经安装的image
```
zhouhh@/Users/zhouhh $ docker

Usage:	docker COMMAND
Management Commands:
  checkpoint  Manage checkpoints
  container   Manage containers
  image       Manage images
  network     Manage networks
  node        Manage Swarm nodes
  plugin      Manage plugins
  secret      Manage Docker secrets
  service     Manage services
  stack       Manage Docker stacks
  swarm       Manage Swarm
  system      Manage Docker
  volume      Manage volumes

Commands:
  attach      Attach to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  deploy      Deploy a new stack or update an existing stack
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes

Run 'docker COMMAND --help' for more information on a command.

```
