---
author: abloz
comments: true
date: 2016-05-25 06:21:15+00:00
layout: post
link: http://abloz.com/index.php/2016/05/25/mac-os-x-install-python-lxml-yosemite-and-libxml2/
slug: mac-os-x-install-python-lxml-yosemite-and-libxml2
title: mac OS X Yosemite 安装 python lxml 和libxml2
wordpress_id: 2743
categories:
- 技术
tags:
- libxml
- lxml
- mac
- python
---

周海汉 2016.5.25

用python做数据分析或爬虫抓包，离不开高效的lxml。但lxml安装在mac下却会失败。

    
    % pip install lxml
    Collecting lxml
      Using cached lxml-3.6.0.tar.gz
    Building wheels for collected packages: lxml
      Running setup.py bdist_wheel for lxml ... error
      Complete output from command /usr/bin/python -u -c "import setuptools, tokenize;__file__='/private/var/folders/zf/jf20tj1j49nflxqkfrvf4d1r0000gn/T/pip-build-UOgePA/lxml/setup.py';exec(compile(getattr(tokenize, 'open', open)(__file__).read().replace('\r\n', '\n'), __file__, 'exec'))" bdist_wheel -d /var/folders/zf/jf20tj1j49nflxqkfrvf4d1r0000gn/T/tmpc6WLwjpip-wheel- --python-tag cp27:
      Building lxml version 3.6.0.
    ...
    cc -fno-strict-aliasing -fno-common -dynamic -arch x86_64 -arch i386 -g -Os -pipe -fno-common -fno-strict-aliasing -fwrapv -DENABLE_DTRACE -DMACOSX -DNDEBUG -Wall -Wstrict-prototypes -Wshorten-64-to-32 -DNDEBUG -g -fwrapv -Os -Wall -Wstrict-prototypes -DENABLE_DTRACE -arch x86_64 -arch i386 -pipe -I/usr/include/libxml2 -Isrc/lxml/includes -I/System/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7 -c src/lxml/lxml.etree.c -o build/temp.macosx-10.10-intel-2.7/src/lxml/lxml.etree.o -w -flat_namespace
      In file included from src/lxml/lxml.etree.c:320:
      src/lxml/includes/etree_defs.h:14:10: fatal error: 'libxml/xmlversion.h' file not found
      #include "libxml/xmlversion.h"
               ^
      1 error generated.
      Compile failed: command 'cc' failed with exit status 1
      creating var
      creating var/folders
      creating var/folders/zf
      creating var/folders/zf/jf20tj1j49nflxqkfrvf4d1r0000gn
      creating var/folders/zf/jf20tj1j49nflxqkfrvf4d1r0000gn/T
      cc -I/usr/include/libxml2 -I/usr/include/libxml2 -c /var/folders/zf/jf20tj1j49nflxqkfrvf4d1r0000gn/T/xmlXPathInitzbnoga.c -o var/folders/zf/jf20tj1j49nflxqkfrvf4d1r0000gn/T/xmlXPathInitzbnoga.o
      /var/folders/zf/jf20tj1j49nflxqkfrvf4d1r0000gn/T/xmlXPathInitzbnoga.c:1:10: fatal error: 'libxml/xpath.h' file not found
      #include "libxml/xpath.h"
               ^
      1 error generated.
      *********************************************************************************
      Could not find function xmlCheckVersion in library libxml2. Is libxml2 installed?
      Perhaps try: xcode-select --install
      *********************************************************************************
      error: command 'cc' failed with exit status 1
    
      ----------------------------------------
      Failed building wheel for lxml
    error: command 'cc' failed with exit status 1


lxml依赖libxml2. 需要下载编译libxml2

一种方式，直接下载libxml2.9.3源码

libxml2-2.9.3 % ./configure --with-python=/System/Library/Frameworks/Python.framework/Versions/2.7/

make&make install

但执行pip install lxml还是报同样的错误。

用brew 安装 libxml2

    
    libxml2-2.9.3 % sudo brew install libxml2 --with-python
    Password:
    ==> Downloading http://xmlsoft.org/sources/libxml2-2.9.3.tar.gz
    ######################################################################## 100.0%
    ==> ./configure --prefix=/usr/local/Cellar/libxml2/2.9.3 --without-python --without-lzma
    ==> make
    ==> make install
    ==> python setup.py install --prefix=/usr/local/Cellar/libxml2/2.9.3
    ==> Caveats
    This formula is keg-only, which means it was not symlinked into /usr/local.
    
    OS X already provides this software and installing another version in
    parallel can cause all kinds of trouble.
    
    Generally there are no consequences of this for you. If you build your
    own software and it requires this formula, you'll need to add to your
    build variables:
    
        LDFLAGS:  -L/usr/local/opt/libxml2/lib
        CPPFLAGS: -I/usr/local/opt/libxml2/include
    
    
    If you need Python to find bindings for this keg-only formula, run:
      echo /usr/local/opt/libxml2/lib/python2.7/site-packages >> /usr/local/lib/python2.7/site-packages/libxml2.pth
      mkdir -p /Users/zhh/Library/Python/2.7/lib/python/site-packages
      echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> /Users/zhh/Library/Python/2.7/lib/python/site-packages/homebrew.pth
    ==> Summary
    🍺  /usr/local/Cellar/libxml2/2.9.3: 281 files, 10.9M, built in 2 minutes 47 seconds


执行 pip install lxml还是报同样的错。

    
    % find / -name xmlversion.h
    
    /Applications/Postgres.app/Contents/Versions/9.4/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/SDKs/AppleTVSimulator.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Platforms/WatchSimulator.platform/Developer/SDKs/WatchSimulator.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift-migrator/sdk/iPhoneOS.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift-migrator/sdk/iPhoneSimulator.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift-migrator/sdk/MacOSX.sdk/usr/include/libxml2/libxml/xmlversion.h
    /Users/zhh/anaconda/include/libxml2/libxml/xmlversion.h
    /Users/zhh/anaconda/pkgs/libxml2-2.9.2-0/include/libxml2/libxml/xmlversion.h
    /Users/zhh/Downloads/libxml2-2.9.3/include/libxml/xmlversion.h
    /usr/local/Cellar/libxml2/2.9.3/include/libxml2/libxml/xmlversion.h
    /usr/local/include/libxml2/libxml/xmlversion.h
    


设置 C_INCLUDE_PATH

    
    % export C_INCLUDE_PATH=/usr/local/include:/usr/local/include/libxml2:$C_INCLUDE_PATH
    
    % sudo pip install lxml
    Password:
    The directory '/Users/zhh/Library/Caches/pip/http' or its parent directory is not owned by the current user and the cache has been disabled. Please check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
    The directory '/Users/zhh/Library/Caches/pip' or its parent directory is not owned by the current user and caching wheels has been disabled. check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
    Collecting lxml
    Installing collected packages: lxml
    Successfully installed lxml-3.6.0





### 参考


http://blog.marchtea.com/archives/91




