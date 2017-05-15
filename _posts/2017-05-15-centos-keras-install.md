---
layout: post
title:  "在linux上安装机器学习开发环境"
date:   2017-05-15 22:50:26 +0800
categories: 技术
tags:
    - 机器学习
---

# 下载Anoconda

Anaconda 是一个用于科学计算的 Python 发行版，支持 Linux, Mac, Windows, 包含了众多流行的科学计算、数据分析的 Python 包。

Anaconda 具有比pip包管理更强大的能力,不仅管理python 包的依赖,也同时管理其他非python的依赖,所以有逐渐取代pip的趋势. 同时, Anaconda还有virtual envi等功能, 可以创建虚拟环境.

Anaconda 安装包可以到 https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/ 下载。

TUNA 还提供了 Anaconda 仓库的镜像，运行以下命令:

conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
即可添加 Anaconda Python 免费仓库。

Conda 三方源
当前tuna还维护了一些anaconda三方源。

# 配置

```
Conda Forge
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
msys2
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/

https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-4.3.1-Linux-x86_64.sh
[zhouhh@mainServer ~]$ bash Anaconda3-4.3.1-Linux-x86_64.sh

Welcome to Anaconda3 4.3.1 (by Continuum Analytics, Inc.)


[zhouhh@mainServer ~]$ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
[zhouhh@mainServer ~]$ conda config --set show_channel_urls yes
[zhouhh@mainServer ~]$ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
[zhouhh@mainServer ~]$ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/

[zhouhh@mainServer ~]$ vi .condarc
channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  - defaults
show_channel_urls: true

```

# 安装机器学习相关包
## 安装numpy scipy mkl
```
[zhouhh@mainServer ~]$ conda install numpy scipy mkl 
Fetching package metadata ...

CondaHTTPError: HTTP None None for url <https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/linux-64/repodata.json>
Elapsed: None

An HTTP error occurred when trying to retrieve this URL.
HTTP errors are often intermittent, and a simple retry will get you on your way.
SSLError(SSLError(SSLError("bad handshake: Error([('SSL routines', 'ssl3_get_server_certificate', 'certificate verify failed')],)",),),)
```

删除 .condarc的- defaults

```
[zhouhh@mainServer ~]$ conda config --show
add_anaconda_token: True
add_pip_as_python_dependency: True
allow_softlinks: True
always_copy: False
always_softlink: False
always_yes: False
auto_update_conda: True
binstar_upload: None
changeps1: True
channel_alias: https://conda.anaconda.org
channel_priority: True
channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
client_ssl_cert:
client_ssl_cert_key:
create_default_packages: []
debug: False
default_channels:
  - https://repo.continuum.io/pkgs/free
  - https://repo.continuum.io/pkgs/r
  - https://repo.continuum.io/pkgs/pro
disallow: []
envs_dirs:
  - /home/zhouhh/anaconda3/envs
  - /home/zhouhh/.conda/envs
json: False
offline: False
proxy_servers: {}
quiet: False
shortcuts: True
show_channel_urls: True
ssl_verify: True
track_features: []
update_dependencies: True
use_pip: True
verbosity: 0

```
## 安装theano

```
[zhouhh@mainServer ~]$ conda intall theano
The following NEW packages will be INSTALLED:

    libgpuarray: 0.6.4-0      https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    mako:        1.0.6-py36_0 https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    pygpu:       0.6.4-py36_0 https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    theano:      0.9.0-py36_0 https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free

```
## 安装keras
缺省会安装tensorflow 1.1

```
[zhouhh@mainServer ~]$ conda install keras
Fetching package metadata .....
Solving package specifications: .

Package plan for installation in environment /home/zhouhh/anaconda3:

The following NEW packages will be INSTALLED:

    keras:       2.0.2-py36_0      https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    libprotobuf: 3.2.0-0           https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    protobuf:    3.2.0-py36_0      https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    tensorflow:  1.1.0-np112py36_0 https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free


```

# 测试机器学习环境
```python
[zhouhh@mainServer ~]$ python3
Python 3.6.0 |Anaconda custom (64-bit)| (default, Dec 23 2016, 12:22:00)
[GCC 4.4.7 20120313 (Red Hat 4.4.7-1)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from keras.models import Sequential
Using TensorFlow backend.
>>> from keras.layers import Dense, Activation
>>> model = Sequential([
...     Dense(32, input_shape=(784,)),
...     Activation('relu'),
...     Dense(10),
...     Activation('softmax'),
... ])

```

修改.keras/keras.json
将"backend": "tensorflow"改为
"backend": "theano"

```
[zhouhh@mainServer ~]$ cat .keras/keras.json
{
    "epsilon": 1e-07,
    "floatx": "float32",
    "image_data_format": "channels_last",
    "backend": "theano"

}

[zhouhh@mainServer ~]$ python3
Python 3.6.0 |Anaconda custom (64-bit)| (default, Dec 23 2016, 12:22:00)
[GCC 4.4.7 20120313 (Red Hat 4.4.7-1)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from keras.models import Sequential
Using Theano backend.
>>> from keras.layers import Dense, Activation
>>> model = Sequential([
...     Dense(32, input_shape=(784,)),
...     Activation('relu'),
...     Dense(10),
...     Activation('softmax'),
... ])
>>>

```

至此,keras,tensorflow和theano安装成功

