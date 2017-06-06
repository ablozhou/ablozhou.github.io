---
layout: post
title:  "Centos7上安装docker-ce社区版"
author: "周海汉"
date:   2017-06-06 20:18:26 +0800
categories: tech
tags:
    - docker
---

# 概述
本文是centos7上安装docker-ce社区版的最新稳定版的实录.

对其他操作系统和版本,可以参考官方文档.

# 安装相关依赖
yum-utils 提供 yum-config-manager 工具,  devicemapper存储驱动依赖 device-mapper-persistent-data 和 lvm2.

```
[zhouhh@mainServer ~]$ sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```
# 配置版本镜像库

季度更新的稳定stable版和月度更新的edge版
```
[zhouhh@mainServer ~]$ sudo yum-config-manager \
     --add-repo \
     https://download.docker.com/linux/centos/docker-ce.repo
[zhouhh@mainServer ~]$ sudo yum-config-manager --enable docker-ce-edge

```
这会在/etc/添加
/etc/yum.repos.d/docker-ce.repo
内容类似:
```
[docker-ce-stable]
name=Docker CE Stable - $basearch
baseurl=https://download.docker.com/linux/centos/7/$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg
[docker-ce-edge]
name=Docker CE Edge - $basearch
baseurl=https://download.docker.com/linux/centos/7/$basearch/edge
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg

```
由于docker.com服务器下载很慢,所以改为国内镜像.

新建 /etc/yum.repos.d/docker.repo，内容为
```
[dockerrepo]
name=Docker Repository
baseurl=https://mirrors.tuna.tsinghua.edu.cn/docker/yum/repo/centos7
enabled=1
gpgcheck=1
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/docker/yum/gpg
```
执行
```
[zhouhh@mainServer yum.repos.d]$ sudo yum makecache

```

如需禁止edge版本, 可以执行下面的命令

```
[zhouhh@mainServer ~]$ sudo yum-config-manager --disable docker-ce-edge
```

# 安装docker

```
[zhouhh@mainServer ~]$ sudo yum makecache fast

[zhouhh@mainServer ~]$ sudo yum install docker-ce
Error: docker-ce conflicts with 2:docker-1.12.6-28.git1398f24.el7.centos.x86_64
Error: docker-ce-selinux conflicts with 2:container-selinux-2.12-2.gite7096ce.el7.noarch

```

出现冲突, 原因是直接安装过docker.

```
[zhouhh@mainServer ~]$ yum list docker

Installed Packages
docker.x86_64                      2:1.12.6-28.git1398f24.el7.centos                      @extras
[zhouhh@mainServer ~]$ sudo yum erase docker.x86_64
Removed:
  docker.x86_64 2:1.12.6-28.git1398f24.el7.centos
[zhouhh@mainServer ~]$ sudo yum list container-selinux-2.12-2.gite7096ce.el7.noarch

[zhouhh@mainServer ~]$ sudo yum erase container-selinux.noarch

```

再安装:
```
[zhouhh@mainServer ~]$ sudo yum install docker-ce
Loaded plugins: fastestmirror, langpacks
Installing:
 docker-ce               x86_64       17.05.0.ce-1.el7.centos         docker-ce-edge        19 M
Installing for dependencies:
 docker-ce-selinux       noarch       17.05.0.ce-1.el7.centos         docker-ce-edge        28 k

[Errno 12] Timeout on https://download.docker.com/linux/centos/7/x86_64/edge/Packages/docker-ce-17.05.0.ce-1.el7.centos.x86_64.rpm

Transaction check error:
  file /usr/bin/docker from install of docker-ce-17.05.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-28.git1398f24.el7.centos.x86_64
  file /usr/bin/docker-containerd from install of docker-ce-17.05.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-28.git1398f24.el7.centos.x86_64
  file /usr/bin/docker-containerd-shim from install of docker-ce-17.05.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-28.git1398f24.el7.centos.x86_64
  file /usr/bin/dockerd from install of docker-ce-17.05.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-28.git1398f24.el7.centos.x86_64

Error Summary


```
如果生产系统需要稳定版本, 需要 `yum list` 进行查询. 但yum list只会显示二进制包, 加上.x86_64会显示包含源码包的全部的包. sort -r会按版本倒序排序.

```
[zhouhh@mainServer ~]$ yum list docker-ce.x86_64  --showduplicates |sort -r
 * updates: mirrors.tuna.tsinghua.edu.cn
Loading mirror speeds from cached hostfile
Loaded plugins: fastestmirror, langpacks
 * extras: mirror.bit.edu.cn
docker-ce.x86_64            17.05.0.ce-1.el7.centos             docker-ce-edge
docker-ce.x86_64            17.04.0.ce-1.el7.centos             docker-ce-edge
docker-ce.x86_64            17.03.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.03.0.ce-1.el7.centos             docker-ce-stable
 * base: mirror.bit.edu.cn
 ```
 第二列是版本号. el7表示centos7. 第三列是库名.
 
 安装指定版本:
 sudo yum install docker-ce-<VERSION>
 
 安装稳定版本:
 ```
 
 [zhouhh@mainServer ~]$ sudo yum install docker-ce-17.03.1.ce-1.el7.centos
Installed:
  docker-ce.x86_64 0:17.03.1.ce-1.el7.centos

Dependency Installed:
  docker-ce-selinux.noarch 0:17.05.0.ce-1.el7.centos

Complete!


 ```
 
 # 删除老版本docker

如果需要删除老的版本, 可以用如下的命令查询和删除.
老版本docker名字叫docker或docker-engine.
新版本社区版叫docker-ce, 企业版是docker-ee
```
[zhouhh@mainServer ~]$ yum list installed | grep docker
docker-client.x86_64                   2:1.12.6-28.git1398f24.el7.centos
docker-common.x86_64                   2:1.12.6-28.git1398f24.el7.centos
[zhouhh@mainServer ~]$ sudo yum erase -y docker-client.x86_64
[zhouhh@mainServer ~]$ sudo yum erase -y docker-common.x86_64

[zhouhh@mainServer ~]$ sudo yum remove docker \
                  docker-common \
                  container-selinux \
                  docker-selinux \
                  docker-engine
```
## 删除docker ce版和镜像
```
[zhouhh@mainServer ~]$ sudo yum remove docker-ce
[zhouhh@mainServer ~]$ sudo rm -rf /var/lib/docker
```
可能还需要移除devicemapper, 重新格式化相关块设备.

```
[zhouhh@mainServer ~]$ sudo mkdir /etc/docker
[zhouhh@mainServer ~]$ sudo vi /etc/docker/daemon.json
{
  "storage-driver": "devicemapper"
}
```

对生产系统, 需要使用direct-lvm模式,需准备块设备,参考:
[devicemapper storage driver guide](https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/#configure-direct-lvm-mode-for-production)

# 启动测试docker

Hello world的镜像启动后会打印"Hello from Docker!"然后退出.

```
[zhouhh@mainServer ~]$ sudo systemctl start docker
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
78445dd45222: Pull complete
Digest: sha256:c5515758d4c5e1e838e9cd307f6c6a0d620b5e07e6f927b07d05f6d12a1ac8d7
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

```

# 参考

[Get Docker for CentOS](https://docs.docker.com/engine/installation/linux/centos/)
