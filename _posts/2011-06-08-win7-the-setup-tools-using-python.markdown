---
author: abloz
comments: true
date: 2011-06-08 06:36:05+00:00
layout: post
link: http://abloz.com/index.php/2011/06/08/win7-the-setup-tools-using-python/
slug: win7-the-setup-tools-using-python
title: win7 下使用python的setup tools
wordpress_id: 1287
categories:
- 技术
tags:
- easy_install
- egg
- python
---

周海汉 2011.6.8
2011.6.8
ablozhou#gmail.com

环境：win7 32位旗舰版，安装了python31和python26，但我想使用python26的版本。

问题：python egg 文件如何使用呢？python 组件如何安装？下面的文章解决这些问题。


## 1.为何要使用安装工具？


可以在使用python的包时更容易，方便下载，创建，依赖，安装，升级，卸载等的管理。

因为很多python的包采用蟒蛋（python egg）的方式发布。蟒蛋可以是压缩的或没有压缩的方式打的包。比如xml库lxml，python26的最新版win32的包为：lxml-2.3-py2.6-win32.egg，下载地址在[http://pypi.python.org/pypi/lxml/2.3#downloads](http://pypi.python.org/pypi/lxml/2.3#downloads) .egg文件并不能直接执行，必须依赖安装工具进行安装。


## **2.下载安装python安装工具**


下载地址：[http://pypi.python.org/pypi/setuptools](http://pypi.python.org/pypi/setuptools#downloads) 可以找到正确的版本进行下载。win7 32位可以下载setuptools-0.6c11.win32-py2.6.exe 。

**注意：**win7 64位必须使用[ez_setup.py](http://peak.telecommunity.com/dist/ez_setup.py)进行安装。方法是下载ez_setup.py后，在cmd下执行 python ez_setup.py，即可自动安装setuptools。目前没有直接的exe安装版本。

下载完成后双击执行安装文件，即可在c:python26scripts下安装easy_install。包含一个easy_install.exe，如果环境变量PATH设置正确，可以直接在命令行下执行easy_install package命令。下面有相应的示例。


## 3.安装lxml


没有安装lxml之前，执行import报错：

```



>>> import lxml




Traceback (most recent call last):




File "<pyshell#1>", line 1, in <module>




import lxml




ImportError: No module named lxml


```

在cmd中安装lxml

```
C:Userszhouhh.TKOFFICE>easy_install

install_dir C:Python31Libsite-packages

error: No urls, filenames, or requirements specified (see --help)

C:Userszhouhh.TKOFFICE>easy_install lxml

install_dir C:Python31Libsite-packages

Searching for lxml

Reading http://pypi.python.org/simple/lxml/

Reading http://codespeak.net/lxml

Best match: lxml 2.3

Downloading http://pypi.python.org/packages/3.1/l/lxml/lxml-2.3-py3.1-win32.egg#

md5=84f5d7d34176c2433abb2c7e833cf309

Processing lxml-2.3-py3.1-win32.egg

creating c:python31libsite-packageslxml-2.3-py3.1-win32.egg

Extracting lxml-2.3-py3.1-win32.egg to c:python31libsite-packages

Adding lxml 2.3 to easy-install.pth file

Installed c:python31libsite-packageslxml-2.3-py3.1-win32.egg

Processing dependencies for lxml

Finished processing dependencies for lxml
```

结果下载到python31下去了。
一看，原来path下缺省的是python31.
C:Python31;C:Python31Scripts;
将其修改为python26 再执行同样的命令，即会正确安装相应的py26版本成功到python26下。


## 4.如果已下载有egg文件，应如何安装？


easy_install的命令格式，就是easy_install package

package可以是网络上的url，也可以是本地的。

```
C:Userszhouhh.TKOFFICE>easy_install E:downloadslxml-2.3-py2.6-win32.egg

Processing lxml-2.3-py2.6-win32.egg

creating c:python26libsite-packageslxml-2.3-py2.6-win32.egg

Extracting lxml-2.3-py2.6-win32.egg to c:python26libsite-packages

Adding lxml 2.3 to easy-install.pth file

Installed c:python26libsite-packageslxml-2.3-py2.6-win32.egg

Processing dependencies for lxml==2.3

Finished processing dependencies for lxml==2.3
```

这时，再执行import 正确。

    
    
    >>> import lxml
    
    >>>
    




## 5. 参考资料


python的pypi，即python package index，可以下载大部分的包。easy_install可以自动到相应网站寻找正确的版本，并解决依赖问题。

[http://peak.telecommunity.com/DevCenter/EasyInstall](http://peak.telecommunity.com/DevCenter/EasyInstall)

[http://pypi.python.org/pypi/setuptools](http://pypi.python.org/pypi/setuptools)

[http://pypi.python.org/pypi/lxml/2.3](http://pypi.python.org/pypi/lxml/2.3)

可爱的 Python: 使用 setuptools 孵化 Python egg:



[http://www.ibm.com/developerworks/cn/linux/l-cppeak3.html](http://www.ibm.com/developerworks/cn/linux/l-cppeak3.html)
