---
layout: post
title:  "anaconda mac 启动慢的问题"
author: "周海汉"
date:   2020-04-04 13:48:26 +0800
categories: tech
tags:
    - mac
    - anaconda
---

应该是连接网络更新版本信息需要到外网，所以很慢。
1. 一是修改配置
采用清华镜像

vi ~/.condarc

```
ssl_verify: false
show_channel_urls: true
channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  - defaults
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
```

2. 二是禁掉enable ssl verify
在打开anaconda-navigator后，preferences里禁掉enable ssl verify . 我在mac里修改遇到说https://api.anaconda.com不合法设置不成功的问题。可能还是墙的原因。

3. 三是在preferences同样的地方设为offline mode。

4. 四是都不行先断网再启动。

5. 五可以直接执行jupyter-lab，spyder等启动编辑环境，不需要启动anaconda-navigator
