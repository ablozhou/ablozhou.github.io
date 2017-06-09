---
layout: post
title:  "docker使用"
author: "周海汉"
date:   2017-06-09 20:18:26 +0800
categories: tech
tags:
    - docker
---
![image](https://www.docker.com/sites/all/themes/docker/assets/images/brand-full.svg)
# 启动docker
```
[zhouhh@mainServer ~]$ sudo systemctl start docker
[zhouhh@mainServer ~]$ sudo systemctl enable docker

[zhouhh@mainServer ~]$ docker pull hub.c.163.com/public/centos:7.2-tools

```

# 网络配置

docker提供overlay和bridge两种网络模式驱动.

缺省的网络如下:
```
[zhouhh@mainServer ~]$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
9c12b9cdd56c        bridge              bridge              local
ece62f2ec867        host                host                local
0c0d6c064361        none                null                local
```

如果不指定网络驱动类型, 缺省都是bridge模式.

![桥接模式](https://docs.docker.com/engine/tutorials/bridge1.png)

# 加速器
使用 Docker 的时候，需要经常从官方获取镜像，但是由于显而易见的网络原因，拉取镜像的过程非常耗时，严重影响使用 Docker 的体验。因此 DaoCloud 推出了加速器工具解决这个难题，通过智能路由和缓存机制，极大提升了国内网络访问 Docker Hub 的速度，目前已经拥有了广泛的用户群体，并得到了 Docker 官方的大力推荐。

网易蜂巢也提供镜像下载
```
[zhouhh@mainServer ~]$ curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://9bd9d1e3.m.daocloud.io
docker version >= 1.12
{"registry-mirrors": ["http://9bd9d1e3.m.daocloud.io"],
  "storage-driver": "devicemapper"
}
Success.
You need to restart docker to take effect: sudo systemctl restart docker
```

```
[zhouhh@mainServer ~]$ docker search redis
NAME                      DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
redis                     Redis is an open source key-value store th...   3819      [OK]
bitnami/redis             Bitnami Redis Docker Image                      49                   [OK]
torusware/speedus-redis   Always updated official Redis docker image...   32                   [OK]

[zhouhh@mainServer ~]$ docker pull redis
Using default tag: latest
latest: Pulling from library/redis
10a267c67f42: Downloading [==========>                                        ] 10.58 MB/52.58 MB
```

```
[zhouhh@mainServer ~]$ docker image ls
REPOSITORY                    TAG                 IMAGE ID            CREATED             SIZE
redis                         latest              a858478874d1        2 weeks ago         184 MB
hub.c.163.com/public/centos   7.2-tools           4a4618db62b9        3 months ago        515 MB
hello-world                   latest              48b5124b2768        4 months ago        1.84 kB
[zhouhh@mainServer ~]$ docker run redis
1:M 07 Jun 02:55:44.047 # Server started, Redis version 3.2.9
1:M 07 Jun 02:55:44.047 * The server is now ready to accept connections on port 6379

```

```
[zhouhh@mainServer redis]$ docker container ls
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
18635a66fa6f        redis               "docker-entrypoint..."   31 minutes ago      Up 31 minutes       6379/tcp            epic_darwin
[zhouhh@mainServer redis]$ docker container inspect 186
...
"Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:02",
            "Networks": {
                "bridge": {
                "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
...

[zhouhh@mainServer redis]$ redis-cli -h 172.17.0.2
172.17.0.2:6379> set test 'zhouhh'
OK
172.17.0.2:6379> get test
"zhouhh"

```
