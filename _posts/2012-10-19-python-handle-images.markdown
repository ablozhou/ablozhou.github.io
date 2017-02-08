---
author: abloz
comments: true
date: 2012-10-19 09:03:15+00:00
layout: post
link: http://abloz.com/index.php/2012/10/19/python-handle-images/
slug: python-handle-images
title: 用python处理图像
wordpress_id: 1917
categories:
- 技术
---

周海汉
2012.10.19
[http://abloz.com/2012/10/19/python-handle-images.html](http://abloz.com/2012/10/19/python-handle-images.html)

**centos 5.5 上pil安装测试**
先安装PIL，即Python Image Library。可用于对验证码进行处理识别。
最简单方法，可以用pip安装PIL
[zhouhh@Hadoop47 img]$ sudo pip install PIL
但问题是pip经常被GFW超时和断网。所以也可以下载源码编译安装：

    
    
    [zhouhh@Hadoop48 ~]$ wget http://effbot.org/downloads/Imaging-1.1.7.tar.gz
    Length: 498749 (487K) [application/x-tar]
    [zhouhh@Hadoop48 Imaging-1.1.7]$ python setup.py build_ext -i
    [zhouhh@Hadoop48 Imaging-1.1.7]$ sudo python setup.py install
    


timg.py执行图片去噪，中值化处理等。

    
    [zhouhh@Hadoop48 python]$ cat timg.py
    #!/usr/bin/env python
    import Image,ImageEnhance,ImageFilter
    
    image_name="22.jpg"
    im = Image.open(image_name)
    im = im.filter(ImageFilter.MedianFilter())
    enhancer = ImageEnhance.Contrast(im)
    im = enhancer.enhance(2)
    im = im.convert('1')
    im.show()
    im.save('23.jpg')


[zhouhh@Hadoop48 python]$ ./timg.py
IOError: decoder jpeg not available
原来编译时没注意所缺的组件
[zhouhh@Hadoop48 ~]$ sudo yum install libjpeg freetype-devel libjpeg-devel

需将原来安装的PIL删掉
[root@Hadoop48 site-packages]# rm PIL -rf
[root@Hadoop48 site-packages]# rm PIL.pth
[zhouhh@Hadoop48 Imaging-1.1.7]$ rm build/ -rf
[zhouhh@Hadoop48 Imaging-1.1.7]$ python setup.py build_ext -i
[zhouhh@Hadoop48 Imaging-1.1.7]$ sudo python selftest.py
--- PIL CORE support ok
*** TKINTER support not installed
--- JPEG support ok
--- ZLIB (PNG/ZIP) support ok
--- FREETYPE2 support ok
*** LITTLECMS support not installed

[zhouhh@Hadoop48 Imaging-1.1.7]$ sudo python setup.py install

[zhouhh@Hadoop48 python]$ ./timg.py
处理前
[![](http://abloz.com/wp-content/uploads/2012/10/22.jpg)](http://abloz.com/wp-content/uploads/2012/10/22.jpg)
处理后
[![](http://abloz.com/wp-content/uploads/2012/10/23.jpg)](http://abloz.com/wp-content/uploads/2012/10/23.jpg)

**ubuntu12.04 安装**
pip install PIL后遇到的问题：
exceptions.IOError: decoder zip not available
因为pypi.python.org被封，所以只能编译，或通过apt-get安装

    
    
    zhouhh@zhh:~/Imaging-1.1.7$ python setup.py build_ext -i
    *** TKINTER support not available
    *** JPEG support not available
    --- ZLIB (PNG/ZIP) support available
    *** FREETYPE2 support not available
    *** LITTLECMS support not available
    


缺一些组件，需要安装：

    
    
    zhouhh@zhh:~$ sudo apt-get build-dep python-imaging
    


遇到 http://security.ubuntu.com/ubuntu/pool/main/t/tiff/libtiffxx0c2_3.9.5-2ubuntu1.2_i386.deb 404 not found的问题，通过
apt-get update 解决。期间设置了/etc/apt/sourecs.list 中将cd部分的注释去掉，并将ubuntu 12.04 iso文件放入虚拟光驱。
这个命令成功后执行：

    
    
    sudo ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/
    sudo ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/
    sudo ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/
    


此时执行pip安装或编译

    
    
    zhouhh@zhh:~/Imaging-1.1.7$ sudo pip install PIL
    


或执行编译，就可以看到类似提示：

    
    
    zhouhh@zhh:~/Imaging-1.1.7$ python setup.py build_ext -i
    running build_ext
    --------------------------------------------------------------------
    PIL 1.1.7 SETUP SUMMARY
    --------------------------------------------------------------------
    version       1.1.7
    platform      linux2 2.7.3 (default, Aug  1 2012, 05:16:07)
                  [GCC 4.6.3]
    --------------------------------------------------------------------
    --- TKINTER support available
    --- JPEG support available
    --- ZLIB (PNG/ZIP) support available
    --- FREETYPE2 support available
    *** LITTLECMS support not available
    


这样安装就没有问题了。
将原来PIL删除

    
    
    zhouhh@zhh:~/Imaging-1.1.7$ sudo python setup.py install
    



**参考**
PIL 官方网站：[http://www.pythonware.com/products/pil/](http://www.pythonware.com/products/pil/)
Python 图像处理模块 PIL(Python Image Library) 安装 [http://www.pythonclub.org/modules/pil/start](http://www.pythonclub.org/modules/pil/start)
Python图像处理库(PIL) -- 学习资源 [http://www.cnblogs.com/wei-li/archive/2012/04/19/2445126.html](http://www.cnblogs.com/wei-li/archive/2012/04/19/2445126.html)
python 图片识别 [http://cocobear.info/blog/2008/08/04/python-pic-recognize/](http://cocobear.info/blog/2008/08/04/python-pic-recognize/)
ubuntu 安装：http://www.sandersnewmedia.com/why/2012/04/16/installing-pil-virtualenv-ubuntu-1204-precise-pangolin/
pypi 中文镜像 http://e.pypi.python.org/  pip install -i http://e.pypi.python.org/simple xxx 来使用，或编辑.pip/pip.conf
添加
[global]
indexl-url=http://e.pypi.python.org/simple

赖永浩：打造百折不挠的 setuptools  http://blog.csdn.net/lanphaday/article/details/7243905
