---
layout: post
title:  "在mac osx上安装机器学习开发环境"
date:   2017-05-15 23:50:26 +0800
categories: 技术
tags:
    - 机器学习
    - theano
    - keras
    - tensorflow
    - anaconda
    - python3.6
    - numpy
    - machine learning
---

# 概述
上一篇["在linux上安装机器学习开发环境"](http://abloz.com/%E6%8A%80%E6%9C%AF/2017/05/15/centos-keras-install/)文章演示了在centos下设置机器学习环境. 本篇讨论如何在mac下配置相关环境.

# 下载Anaconda
Anaconda介绍在上篇中有, 在此不再重复.
Anaconda 安装包可以到 https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/ 下载。

我下载的是4.3.1

```
zhh@zmac ~ $ wget -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-4.3.1-MacOSX-x86_64.sh
```
wget -c 参数支持断点续传

# 安装Anaconda
```
zhh@zmac ~ $ bash Anaconda3-4.3.1-MacOSX-x86_64.sh

Welcome to Anaconda3 4.3.1 (by Continuum Analytics, Inc.)

In order to continue the installation process, please review the license
agreement.
Please, press ENTER to continue
>>>
...
[/Users/zhh/anaconda3] >>>
PREFIX=/Users/zhh/anaconda3
installing: python-3.6.0-0 ...
installing: _license-1.1-py36_1 ...
installing: alabaster-0.7.9-py36_0 ...
installing: anaconda-client-1.6.0-py36_0 ...
installing: anaconda-navigator-1.5.0-py36_0 ...
installing: anaconda-project-0.4.1-py36_0 ...
installing: appnope-0.1.0-py36_0 ...
installing: appscript-1.0.1-py36_0 ...
installing: astroid-1.4.9-py36_0 ...
installing: astropy-1.3-np111py36_0 ...
installing: babel-2.3.4-py36_0 ...
installing: backports-1.0-py36_0 ...
installing: beautifulsoup4-4.5.3-py36_0 ...
installing: bitarray-0.8.1-py36_0 ...
installing: blaze-0.10.1-py36_0 ...
installing: bokeh-0.12.4-py36_0 ...
installing: boto-2.45.0-py36_0 ...
installing: bottleneck-1.2.0-np111py36_0 ...
installing: cffi-1.9.1-py36_0 ...
installing: chardet-2.3.0-py36_0 ...
installing: chest-0.2.3-py36_0 ...
installing: click-6.7-py36_0 ...
installing: cloudpickle-0.2.2-py36_0 ...
installing: clyent-1.2.2-py36_0 ...
installing: colorama-0.3.7-py36_0 ...
installing: configobj-5.0.6-py36_0 ...
installing: contextlib2-0.5.4-py36_0 ...
installing: cryptography-1.7.1-py36_0 ...
installing: curl-7.52.1-0 ...
installing: cycler-0.10.0-py36_0 ...
installing: cython-0.25.2-py36_0 ...
installing: cytoolz-0.8.2-py36_0 ...
installing: dask-0.13.0-py36_0 ...
installing: datashape-0.5.4-py36_0 ...
installing: decorator-4.0.11-py36_0 ...
installing: dill-0.2.5-py36_0 ...
installing: docutils-0.13.1-py36_0 ...
installing: entrypoints-0.2.2-py36_0 ...
installing: et_xmlfile-1.0.1-py36_0 ...
installing: fastcache-1.0.2-py36_1 ...
installing: flask-0.12-py36_0 ...
installing: flask-cors-3.0.2-py36_0 ...
installing: freetype-2.5.5-2 ...
installing: get_terminal_size-1.0.0-py36_0 ...
installing: gevent-1.2.1-py36_0 ...
installing: greenlet-0.4.11-py36_0 ...
installing: h5py-2.6.0-np111py36_2 ...
installing: hdf5-1.8.17-1 ...
installing: heapdict-1.0.0-py36_1 ...
installing: icu-54.1-0 ...
installing: idna-2.2-py36_0 ...
installing: imagesize-0.7.1-py36_0 ...
installing: ipykernel-4.5.2-py36_0 ...
installing: ipython-5.1.0-py36_1 ...
installing: ipython_genutils-0.1.0-py36_0 ...
installing: ipywidgets-5.2.2-py36_1 ...
installing: isort-4.2.5-py36_0 ...
installing: itsdangerous-0.24-py36_0 ...
installing: jbig-2.1-0 ...
installing: jdcal-1.3-py36_0 ...
installing: jedi-0.9.0-py36_1 ...
installing: jinja2-2.9.4-py36_0 ...
installing: jpeg-9b-0 ...
installing: jsonschema-2.5.1-py36_0 ...
installing: jupyter-1.0.0-py36_3 ...
installing: jupyter_client-4.4.0-py36_0 ...
installing: jupyter_console-5.0.0-py36_0 ...
installing: jupyter_core-4.2.1-py36_0 ...
installing: lazy-object-proxy-1.2.2-py36_0 ...
installing: libiconv-1.14-0 ...
installing: libpng-1.6.27-0 ...
installing: libtiff-4.0.6-3 ...
installing: libxml2-2.9.4-0 ...
installing: libxslt-1.1.29-0 ...
installing: llvmlite-0.15.0-py36_0 ...
installing: locket-0.2.0-py36_1 ...
installing: lxml-3.7.2-py36_0 ...
installing: markupsafe-0.23-py36_2 ...
installing: matplotlib-2.0.0-np111py36_0 ...
installing: mistune-0.7.3-py36_1 ...
installing: mkl-2017.0.1-0 ...
installing: mkl-service-1.1.2-py36_3 ...
installing: mpmath-0.19-py36_1 ...
installing: multipledispatch-0.4.9-py36_0 ...
installing: nbconvert-4.2.0-py36_0 ...
installing: nbformat-4.2.0-py36_0 ...
installing: networkx-1.11-py36_0 ...
installing: nltk-3.2.2-py36_0 ...
installing: nose-1.3.7-py36_1 ...
installing: notebook-4.3.1-py36_0 ...
installing: numba-0.30.1-np111py36_0 ...
installing: numexpr-2.6.1-np111py36_2 ...
installing: numpy-1.11.3-py36_0 ...
installing: numpydoc-0.6.0-py36_0 ...
installing: odo-0.5.0-py36_1 ...
installing: openpyxl-2.4.1-py36_0 ...
installing: openssl-1.0.2k-1 ...
installing: pandas-0.19.2-np111py36_1 ...
installing: partd-0.3.7-py36_0 ...
installing: path.py-10.0-py36_0 ...
installing: pathlib2-2.2.0-py36_0 ...
installing: patsy-0.4.1-py36_0 ...
installing: pep8-1.7.0-py36_0 ...
installing: pexpect-4.2.1-py36_0 ...
installing: pickleshare-0.7.4-py36_0 ...
installing: pillow-4.0.0-py36_0 ...
installing: pip-9.0.1-py36_1 ...
installing: ply-3.9-py36_0 ...
installing: prompt_toolkit-1.0.9-py36_0 ...
installing: psutil-5.0.1-py36_0 ...
installing: ptyprocess-0.5.1-py36_0 ...
installing: py-1.4.32-py36_0 ...
installing: pyasn1-0.1.9-py36_0 ...
installing: pycosat-0.6.1-py36_1 ...
installing: pycparser-2.17-py36_0 ...
installing: pycrypto-2.6.1-py36_4 ...
installing: pycurl-7.43.0-py36_2 ...
installing: pyflakes-1.5.0-py36_0 ...
installing: pygments-2.1.3-py36_0 ...
installing: pylint-1.6.4-py36_1 ...
installing: pyopenssl-16.2.0-py36_0 ...
installing: pyparsing-2.1.4-py36_0 ...
installing: pyqt-5.6.0-py36_1 ...
installing: pytables-3.3.0-np111py36_0 ...
installing: pytest-3.0.5-py36_0 ...
installing: python-dateutil-2.6.0-py36_0 ...
installing: python.app-1.2-py36_4 ...
installing: pytz-2016.10-py36_0 ...
installing: pyyaml-3.12-py36_0 ...
installing: pyzmq-16.0.2-py36_0 ...
installing: qt-5.6.2-0 ...
installing: qtawesome-0.4.3-py36_0 ...
installing: qtconsole-4.2.1-py36_1 ...
installing: qtpy-1.2.1-py36_0 ...
installing: readline-6.2-2 ...
installing: redis-3.2.0-0 ...
installing: redis-py-2.10.5-py36_0 ...
installing: requests-2.12.4-py36_0 ...
installing: rope-0.9.4-py36_1 ...
installing: ruamel_yaml-0.11.14-py36_1 ...
installing: scikit-image-0.12.3-np111py36_1 ...
installing: scikit-learn-0.18.1-np111py36_1 ...
installing: scipy-0.18.1-np111py36_1 ...
installing: seaborn-0.7.1-py36_0 ...
installing: setuptools-27.2.0-py36_0 ...
installing: simplegeneric-0.8.1-py36_1 ...
installing: singledispatch-3.4.0.3-py36_0 ...
installing: sip-4.18-py36_0 ...
installing: six-1.10.0-py36_0 ...
installing: snowballstemmer-1.2.1-py36_0 ...
installing: sockjs-tornado-1.0.3-py36_0 ...
installing: sphinx-1.5.1-py36_0 ...
installing: spyder-3.1.2-py36_0 ...
installing: sqlalchemy-1.1.5-py36_0 ...
installing: sqlite-3.13.0-0 ...
installing: statsmodels-0.6.1-np111py36_1 ...
installing: sympy-1.0-py36_0 ...
installing: terminado-0.6-py36_0 ...
installing: tk-8.5.18-0 ...
installing: toolz-0.8.2-py36_0 ...
installing: tornado-4.4.2-py36_0 ...
installing: traitlets-4.3.1-py36_0 ...
installing: unicodecsv-0.14.1-py36_0 ...
installing: wcwidth-0.1.7-py36_0 ...
installing: werkzeug-0.11.15-py36_0 ...
installing: wheel-0.29.0-py36_0 ...
installing: widgetsnbextension-1.2.6-py36_0 ...
installing: wrapt-1.10.8-py36_0 ...
installing: xlrd-1.0.0-py36_0 ...
installing: xlsxwriter-0.9.6-py36_0 ...
installing: xlwings-0.10.2-py36_0 ...
installing: xlwt-1.2.0-py36_0 ...
installing: xz-5.2.2-1 ...
installing: yaml-0.1.6-0 ...
installing: zlib-1.2.8-3 ...
installing: anaconda-4.3.1-np111py36_0 ...
installing: conda-4.3.14-py36_0 ...
installing: conda-env-2.6.0-0 ...
Python 3.6.0 :: Continuum Analytics, Inc.
creating default environment...
installation finished.
Do you wish the installer to prepend the Anaconda3 install location
to PATH in your /Users/zhh/.bash_profile ? [yes|no]
[yes] >>>
Prepending PATH=/Users/zhh/anaconda3/bin to PATH in
newly created /Users/zhh/.bash_profile

For this change to become active, you have to open a new terminal.

Thank you for installing Anaconda3!
```

详细列出了会缺省安装的相关包.
缺省也会添加路径到.bash_profile中.如果用的是zsh,可以手工在.zshrc中添加路径

```
zhh@zmac ~ $ vi .zshrc
# added by Anaconda3 4.3.1 installer
export PATH="/Users/zhh/anaconda3/bin:$PATH"

zhh@zmac ~ $ source .zshrc
zhh@zmac ~ $ conda -V
conda 4.3.14
```

# 创建虚拟环境
```
zhh@zmac ~ $ conda create -n zhhml python=3.6 numpy pandas scikit-learn jupyter matplotlib
Fetching package metadata ...

CondaHTTPError: HTTP None None for url <https://repo.continuum.io/pkgs/free/osx-64/repodata.json.bz2>
Elapsed: None

An HTTP error occurred when trying to retrieve this URL.
HTTP errors are often intermittent, and a simple retry will get you on your way.
ConnectionError(MaxRetryError("HTTPSConnectionPool(host='repo.continuum.io', port=443): Max retries exceeded with url: /pkgs/free/osx-64/repodata.json.bz2 (Caused by NewConnectionError('<requests.packages.urllib3.connection.VerifiedHTTPSConnection object at 0x10e0752b0>: Failed to establish a new connection: [Errno 65] No route to host',))",),)

```
报错了, 这是GFW做的好事.
# 添加清华的mirror镜像
```
zhh@zmac ~ $ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
zhh@zmac ~ $ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
zhh@zmac ~ $ conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
zhh@zmac ~ $ conda config --set show_channel_urls yes
```

zhh@zmac ~ $ vi .condarc
删除
- defaults

# 创建新虚拟环境zhhml,表示zhh machine learning环境
```
zhh@zmac ~ $ conda create -n zhhml python=3.6 numpy pandas scikit-learn jupyter matplotlib
Fetching package metadata .........
Solving package specifications: .
Package plan for installation in environment /Users/zhh/anaconda3/envs/zhhml:
...
# To activate this environment, use:
# > source activate zhhml
#
# To deactivate this environment, use:
# > source deactivate zhhml

# 激活虚拟环境
zhh@zmac ~ $ source activate zhhml
(zhhml) zhh@zmac ~ $
(zhhml) zhh@zmac ~ $ conda install theano
Fetching package metadata .........
Solving package specifications: .

Package plan for installation in environment /Users/zhh/anaconda3/envs/zhhml:

The following NEW packages will be INSTALLED:

    libgpuarray: 0.6.2-np112py36_0 https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    mako:        1.0.4-py36_0      https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    nose:        1.3.7-py36_2      https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    theano:      0.9.0-py36_0      https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
(zhhml) zhh@zmac ~ $ conda install tensorflow
Fetching package metadata .........
Solving package specifications: .

Package plan for installation in environment /Users/zhh/anaconda3/envs/zhhml:

The following NEW packages will be INSTALLED:

    mock:       2.0.0-py36_0  https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    pbr:        1.10.0-py36_0 https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    protobuf:   3.2.0-py36_0  https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    tensorflow: 1.0.0-py36_0  https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
(zhhml) zhh@zmac ~ $ conda install keras
Fetching package metadata .........
Solving package specifications: .

Package plan for installation in environment /Users/zhh/anaconda3/envs/zhhml:

The following NEW packages will be INSTALLED:

    h5py:   2.6.0-np112py36_7 https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    hdf5:   1.8.17-9          https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    keras:  2.0.2-py36_0      https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    pyyaml: 3.12-py36_0       https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    yaml:   0.1.6-0           https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    
```

# 测试

## tensorflow 后端

```
(zhhml) zhh@zmac ~ $ python
Python 3.6.1 | packaged by conda-forge | (default, Mar 23 2017, 21:57:00)
[GCC 4.2.1 Compatible Apple LLVM 6.1.0 (clang-602.0.53)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> from keras.models import Sequential
Using TensorFlow backend.
>>> from keras.layers import Dense, Activation
>>>

```

## theano后端
```
(zhhml) zhh@zmac ~ $ vi .keras/keras.json
"backend": "tensorflow",
"image_data_format": "channels_last",
```
修改为
```
"backend": "theano",
    "image_data_format": "channels_first"
```

再测试
```
(zhhml) zhh@zmac ~ $ python
Python 3.6.1 | packaged by conda-forge | (default, Mar 23 2017, 21:57:00)
[GCC 4.2.1 Compatible Apple LLVM 6.1.0 (clang-602.0.53)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> from keras.models import Sequential
Using Theano backend.
>>> from keras.layers import Dense, Activation
>>>
```

至此,mac上安装keras，tensorflow，theano成功.

# 参考
https://www.dataweekends.com/blog/2017/03/09/set-up-your-mac-for-deep-learning-with-python-keras-and-tensorflow