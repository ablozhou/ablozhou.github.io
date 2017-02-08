---
author: abloz
comments: true
date: 2010-10-28 03:52:10+00:00
layout: post
link: http://abloz.com/index.php/2010/10/28/run-under-ubuntu-with-wine-in-ie/
slug: run-under-ubuntu-with-wine-in-ie
title: 在ubuntu下用wine运行ie
wordpress_id: 960
categories:
- 技术
tags:
- ie
- ies4linux
- linux
- wine
---

周海汉2010.10.28

有时用户需在linux下测试ie的网页表现，或者用某些和ie绑定很紧密的网页和功能。最干脆的方法是用虚拟机装windows或切换到windows，然而wine也是一种解决方案。
在我试用时，发现wine下运行windows程序一直不太顺利。

我的系统：

    
    zhouhh@zhh64:~$ cat /etc/lsb-release
    DISTRIB_ID=Ubuntu
    DISTRIB_RELEASE=10.04
    DISTRIB_CODENAME=lucid
    DISTRIB_DESCRIPTION="Ubuntu 10.04.1 LTS"


缺省用apt安装的wine版本 1.2稳定版。
运行植物大战僵尸可以，但汉化版的按钮看不见中文。
运行ie则直接报错，看到一个空白框，然后弹出一个出错对话框。

[![](http://abloz.com/wp-content/uploads/2010/10/Screenshot-Program-Error-300x207.png)](http://abloz.com/wp-content/uploads/2010/10/Screenshot-Program-Error.png)

出错信息：

    
    zhouhh@zhh64:~$ env WINEPREFIX=/home/zhouhh/.wine/ wine "C:Program FilesInternet Exploreriexplore.exe"
    fixme:ole:CoResumeClassObjects stub
    fixme:urlmon:URLMoniker_BindToObject use running object table
    fixme:shdocvw:BindStatusCallback_OnProgress status code 1
    fixme:shdocvw:BindStatusCallback_OnProgress status code 2
    fixme:shdocvw:BindStatusCallback_OnProgress status code 11
    fixme:msvcrt:_setmbcp trail bytes data not available for DBCS codepage 0 - assuming all bytes
    fixme:system:SetProcessDPIAware stub!
    fixme:dwmapi:DwmIsCompositionEnabled 0x32e914
    fixme:winsock:WSAIoctl unsupported WS_IOCTL cmd (9800012c)
    fixme:winsock:WSAIoctl unsupported WS_IOCTL cmd (9800012c)
    fixme:iphlpapi:NotifyAddrChange (Handle 0x21fe8d8, overlapped 0x21fe8e0): stub
    0[13e5a0]: IMM32: InitKeyboardLayout, aKeyboardLayout=e0010804, sCodePage=936, sIMEProperty=00090000
    fixme:shdocvw:ClOleCommandTarget_QueryStatus (0x130eb4)->((null) 1 0x32f04c (nil))
    fixme:shdocvw:ClOleCommandTarget_QueryStatus command_0: 27, 0x0
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented cmdid 25
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented cmdid 26
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented group {000214d1-0000-0000-c000-000000000046}
    fixme:mshtml:nsHttpChannelInternal_SetDocumentURI (0x2409300)->()
    fixme:shdocvw:ClientSite_GetContainer (0x130eb4)->(0x32f01c)
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented group {000214d1-0000-0000-c000-000000000046}
    fixme:wininet:InternetLockRequestFile STUB
    fixme:mshtml:nsChannel_GetRequestHeader (0x2409300)->(0x32db70 0x240fd7c)
    fixme:mshtml:nsChannel_GetRequestMethod (0x2409300)->(0x32dd30)
    fixme:mshtml:nsURI_GetHostPort default action not implemented
    fixme:mshtml:nsChannel_GetReferrer (0x2409300)->(0x32e250)
    fixme:mshtml:nsChannel_IsNoStoreResponse (0x2409300)->(0x32e13c)
    fixme:mshtml:nsChannel_IsNoCacheResponse (0x2409300)->(0x32e138)
    fixme:mshtml:nsChannel_GetReferrer (0x2409300)->(0x32e290)
    fixme:mshtml:nsChannel_SetResponseHeader (0x2409300)->(0x32e390 0x32e210 1)
    fixme:mshtml:nsChannel_SetResponseHeader (0x2409300)->(0x32e390 0x32e210 1)
    fixme:mshtml:nsChannel_SetResponseHeader (0x2409300)->(0x32e390 0x32e210 1)
    fixme:mshtml:nsChannel_SetRequestHeader (0x2424508)->(0x32df40 0x32dfd0 0)
    fixme:mshtml:nsChannel_SetReferrer (0x2424508)->(0x2410248)
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented cmdid 29
    fixme:shdocvw:DocHostUIHandler_GetDropTarget (0x130eb4)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x2424628)->(0x32f0fc 0x32f0e8 0)
    fixme:shdocvw:ClientSite_GetContainer (0x130eb4)->(0x32f9cc)
    fixme:shdocvw:InPlaceFrame_SetStatusText (0x130eb4)->((null))
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented cmdid 25
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented cmdid 26
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented cmdid 21
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented cmdid 28
    fixme:wininet:InternetLockRequestFile STUB
    fixme:mshtml:nsChannel_SetRequestHeader (0x135998)->(0x32f0a0 0x32f0b0 0)
    fixme:mshtml:nsChannel_SetReferrer (0x135998)->(0x2410248)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x2407030)->(0x32f46c 0x32f458 0)
    fixme:mshtml:nsChannel_SetRequestHeader (0x137eb8)->(0x32f7c0 0x32f7d0 0)
    fixme:mshtml:nsChannel_SetReferrer (0x137eb8)->(0x2410248)
    fixme:mshtml:nsChannel_SetRequestHeader (0x2406470)->(0x32f6d0 0x2381fe4 0)
    fixme:mshtml:nsHttpChannelInternal_SetDocumentURI (0x2406470)->()
    fixme:mshtml:nsChannel_SetReferrer (0x2406470)->(0x2410248)
    fixme:mshtml:nsChannel_SetRequestHeader (0x136448)->(0x32f6d0 0x2381fe4 0)
    fixme:mshtml:nsHttpChannelInternal_SetDocumentURI (0x136448)->()
    fixme:mshtml:nsChannel_SetReferrer (0x136448)->(0x2410248)
    fixme:mshtml:nsChannel_Open (0x1ea038)->(0x32cbc0)
    fixme:mshtml:nsChannel_SetRequestHeader (0x1368c8)->(0x32f7c0 0x32f7d0 0)
    fixme:mshtml:nsChannel_SetReferrer (0x1368c8)->(0x2410248)
    fixme:mshtml:nsChannel_SetRequestHeader (0x1eaa08)->(0x32f6d0 0x2381fe4 0)
    fixme:mshtml:nsHttpChannelInternal_SetDocumentURI (0x1eaa08)->()
    fixme:mshtml:nsChannel_SetReferrer (0x1eaa08)->(0x2410248)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x2406308)->(0x32f0fc 0x32f0e8 0)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x136180)->(0x32f0fc 0x32f0e8 0)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x136780)->(0x32f0fc 0x32f0e8 0)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x1ea870)->(0x32f0fc 0x32f0e8 0)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x1d0648)->(0x32f0fc 0x32f0e8 0)
    fixme:wininet:InternetLockRequestFile STUB
    fixme:mshtml:nsChannel_GetContentLength (0x1368c8)->(0x32ebf8)
    fixme:wininet:InternetLockRequestFile STUB
    fixme:mshtml:nsChannel_GetContentLength (0x135998)->(0x32ebf8)
    fixme:wininet:InternetLockRequestFile STUB
    fixme:mshtml:nsChannel_IsNoStoreResponse (0x2406470)->(0x32ea68)
    fixme:mshtml:nsChannel_IsNoCacheResponse (0x2406470)->(0x32ea68)
    fixme:resource:GetGuiResources (0xffffffff,0): stub
    fixme:wininet:InternetLockRequestFile STUB
    fixme:mshtml:nsChannel_GetContentLength (0x137eb8)->(0x32ebf8)
    fixme:wininet:InternetLockRequestFile STUB
    fixme:mshtml:nsChannel_IsNoStoreResponse (0x136448)->(0x32ea68)
    fixme:mshtml:nsChannel_IsNoCacheResponse (0x136448)->(0x32ea68)
    fixme:wininet:InternetLockRequestFile STUB
    fixme:mshtml:nsChannel_IsNoStoreResponse (0x1eaa08)->(0x32ea68)
    fixme:mshtml:nsChannel_IsNoCacheResponse (0x1eaa08)->(0x32ea68)
    fixme:mshtml:nsURI_GetUserPass default action not implemented
    fixme:mshtml:nsChannel_SetRequestHeader (0x242f300)->(0x32eb20 0x2381fe4 0)
    fixme:mshtml:nsHttpChannelInternal_SetDocumentURI (0x242f300)->()
    fixme:mshtml:nsChannel_SetReferrer (0x242f300)->(0x2423ea8)
    fixme:mshtml:nsURI_GetUserPass default action not implemented
    fixme:mshtml:nsURI_GetUserPass default action not implemented
    fixme:mshtml:nsURL_GetQuery default action not implemented
    fixme:mshtml:nsURI_GetOriginCharset default action not implemented
    fixme:mshtml:nsChannel_SetRequestHeader (0x2552578)->(0x32e790 0x2381fe4 0)
    fixme:mshtml:nsHttpChannelInternal_SetDocumentURI (0x2552578)->()
    fixme:mshtml:nsChannel_SetReferrer (0x2552578)->(0x2423ea8)
    fixme:mshtml:nsChannel_SetRequestHeader (0x2552160)->(0x32e790 0x2381fe4 0)
    fixme:mshtml:nsHttpChannelInternal_SetDocumentURI (0x2552160)->()
    fixme:mshtml:nsChannel_SetReferrer (0x2552160)->(0x2423ea8)
    fixme:mshtml:nsChannel_SetRequestHeader (0x254d8d0)->(0x32d450 0x2381fe4 0)
    fixme:mshtml:nsHttpChannelInternal_SetDocumentURI (0x254d8d0)->()
    fixme:mshtml:nsChannel_SetReferrer (0x254d8d0)->(0x2423ea8)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x242f660)->(0x32f0fc 0x32f0e8 0)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x25527e8)->(0x32f0fc 0x32f0e8 0)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x2550398)->(0x32f0fc 0x32f0e8 0)
    fixme:mshtml:HttpNegotiate_GetRootSecurityId (0x254ba50)->(0x32f0fc 0x32f0e8 0)
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented group {000214d0-0000-0000-c000-000000000046}
    fixme:shdocvw:PropertyNotifySink_OnChanged unimplemented dispid 1005
    fixme:shdocvw:ClOleCommandTarget_Exec Unimplemented group {000214d0-0000-0000-c000-000000000046}
    fixme:mshtml:nsChannel_SetRequestHeader (0x2bcb548)->(0x32e994 0x2381fe4 0)
    fixme:mshtml:nsHttpChannelInternal_SetDocumentURI (0x2bcb548)->()
    fixme:mshtml:nsChannel_SetReferrer (0x2bcb548)->(0x2410248)
    wine: Unhandled page fault on write access to 0x49001100 at address 0x253a6e1 (thread 002b), starting debugger...
    Unhandled exception: page fault on write access to 0x49001100 in 32-bit code (0x0253a6e1).


说明wine1.2 很不好用。但缺省的ubuntu10.04 apt只能安装wine1.2. 如果安装最新的wine1.3会不会解决ie问题呢？
安装wine 1.3非稳定版本：
先添加wine的软件源：系统->系统管理->软件源。在“其他软件”页面点添加，输入：
ppa:ubuntu-wine/ppa
点确定。[
](../wp-content/uploads/2010/10/Screenshot-Program-Error.png)
ppa是Personal Package Archives 个人软件包档案，　Personal Package Archives（个人软件包档案）是Ubuntu Launchpad网站提供的一项服务，允许个人用户上传软件源代码，通过Launchpad进行编译并发布为2进制软件包，作为apt/新立得源供其他用户下载和更新。在Launchpad网站上的每一个用户和团队都可以拥有一个或多个PPA。
关闭时提示更新。然后可以用sudo apt-get install wine1.3安装，或者用[点击安装](apt://wine1.3)

[![](http://abloz.com/wp-content/uploads/2010/10/Screenshot-正在下载包文件-300x246.png)](http://abloz.com/wp-content/uploads/2010/10/Screenshot-正在下载包文件.png)

安装完毕，wine ie已经可以执行。但浏览某些中文网站还是会崩溃。

[![](http://abloz.com/wp-content/uploads/2010/10/Screenshot-Wine-Internet-Explorer-300x164.png)](http://abloz.com/wp-content/uploads/2010/10/Screenshot-Wine-Internet-Explorer.png)也可以安装ies4linux，但我没有装成功。

    
    wget http://www.tatanka.com.br/ies4linux/downloads/ies4linux-latest.tar.gz
    tar zxvf ies4linux-latest.tar.gz
    cd ies4linux-*
    ./ies4linux


[![](http://abloz.com/wp-content/uploads/2010/10/Screenshot-Internet-Explorers-for-Linux-188x300.png)](http://abloz.com/wp-content/uploads/2010/10/Screenshot-Internet-Explorers-for-Linux.png)
点高级：
[![](http://abloz.com/wp-content/uploads/2010/10/Screenshot-Internet-Explorers-for-Linux-1-231x300.png)](http://abloz.com/wp-content/uploads/2010/10/Screenshot-Internet-Explorers-for-Linux-1.png)
但安装过程中报错：

    
    zhouhh@zhh64:~/ies4linux-2.99.0.1$ ./ies4linux
    IEs4Linux 2 is developed to be used with recent Wine versions (0.9.x). It seems that you are using an old version. It's recommended that you update your wine to the latest version (Go to: winehq.com).
    
    grep: : 没有那个文件或目录
    python: ../../src/xcb_io.c：249：process_responses: 断言“(((long) (dpy->last_request_read) - (long) (dpy->request)) <= 0)”失败。
    ui/pygtk/python-gtk.sh: line 6:  4655 已放弃               python "$IES4LINUX"/ui/pygtk/ies4linux-gtk.py


参考
http://www.tatanka.com.br/ies4linux/page/Installation　　

http://www.winehq.org/download/deb
https://launchpad.net/~ubuntu-wine/+archive/ppa
