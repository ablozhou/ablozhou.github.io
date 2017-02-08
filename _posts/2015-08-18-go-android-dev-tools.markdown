---
author: abloz
comments: true
date: 2015-08-18 00:39:44+00:00
layout: post
link: http://abloz.com/index.php/2015/08/18/go-android-dev-tools/
slug: go-android-dev-tools
title: 【转】android dev tools
wordpress_id: 2702
categories:
- 技术
- 转载
tags:
- android
- 翻墙
---

按：大陆连纯搞技术的都被政治害惨了。下载正常的开发工具和sdk，要么慢得像乌龟，要么直接被GFW封锁。所以一些面试官听说候选人不会翻墙，立马就开始鄙视。

测试了www.google.com, dl.google.com,developer.android.com,dl-ssl.google.com，全部不通。包括网上找的hosts都不能用。

http://www.androiddevtools.cn/ 的维护者花了大量精力整理了如下的安卓开发用国内资源，希望可以免翻墙直接开发。非常感谢。

------


# AndroidDevTools简介



```
**Android Dev Tools官网地址：[www.androiddevtools.cn](http://www.androiddevtools.cn/)**

收集整理Android开发所需的Android SDK、开发中用到的工具、Android开发教程、Android设计规范，免费的设计素材等。

欢迎大家推荐自己在Android开发过程中用的好用的工具、学习开发教程、用到设计素材，欢迎Star、Fork 。

如果你对翻译英文的Android开发技术文章感兴趣，欢迎Start和Fork[AndroidWeekly中国文章翻译项目](https://github.com/AWCNTT/ArticleTranslateProject)
```


```
如果你觉得本站对你有用，你可以点击底部的分享按钮，把本站分享到社交网络让你的小伙伴和更多的人知道，
或者可以考虑对本站 [**捐赠**](http://www.androiddevtools.cn/donate.html)支持下，支持我把本站做的更好，帮助更多的人。目前支持支付宝和微信，金额随意。
```



# [](http://www.androiddevtools.cn/#android-tools)Android Tools




#### [](http://www.androiddevtools.cn/#android-sdk%E5%9C%A8%E7%BA%BF%E6%9B%B4%E6%96%B0%E9%95%9C%E5%83%8F%E6%9C%8D%E5%8A%A1%E5%99%A8)Android SDK在线更新镜像服务器





	
  1. 中国科学院开源协会镜像站地址:

	
    * IPV4/IPV6: `http://mirrors.opencas.cn` 端口：80

	
    * IPV4/IPV6: `http://mirrors.opencas.org` 端口：80

	
    * IPV4/IPV6: `http://mirrors.opencas.ac.cn` 端口：80




	
  2. 上海GDG镜像服务器地址:

`http://sdk.gdgshanghai.com` 端口：8000

	
  3. 北京化工大学镜像服务器地址:

	
    * IPv4: `http://ubuntu.buct.edu.cn/` 端口：80

	
    * IPv4: `http://ubuntu.buct.cn/` 端口：80

	
    * IPv6: `http://ubuntu.buct6.edu.cn/` 端口：80




	
  4. 大连东软信息学院镜像服务器地址:

`http://mirrors.neusoft.edu.cn` 端口：80


**使用方法**：



	
  1. 启动 Android SDK Manager ，打开主界面，依次选择『**Tools**』、『**Options...**』，弹出『**Android SDK Manager - Settings**』窗口；

	
  2. 在『**Android SDK Manager - Settings**』窗口中，在『**HTTP Proxy Server」和「HTTP Proxy Port**』输入框内填入上面镜像服务器地址(**不包含http://**，如下图)和端口，并且选中『**Force https://... sources to be fetched using http://...**』复选框。设置完成后单击『**Close**』按钮关闭『**Android SDK Manager - Settings**』窗口返回到主界面；

	
  3. 依次选择『**Packages**』、『**Reload**』。


![SDK Manager Proxy Settings](http://www.androiddevtools.cn/static/image/sdk-manager-proxy-settings.png)


#### [](http://www.androiddevtools.cn/#android-studio)Android Studio


<table >

<tr >
版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="center" >1.4 Preview2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQm6690)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDBBfYp)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dD99jpf)
</td>
</tr>
<tr >

<td align="center" >1.4 Preview1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3fEP8p)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6kovdK)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJ5ldl5)
</td>
</tr>
<tr >

<td align="center" >1.3.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntCamKx)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3KVNLF)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6wzdBO)
</td>
</tr>
<tr >

<td align="center" >1.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQm5zto)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mg3Uie8)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWl5eRa)
</td>
</tr>
<tr >

<td align="center" >1.3 RC4
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJCBx9p)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hq91OX2)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGH5p2I)
</td>
</tr>
<tr >

<td align="center" >1.3 RC3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJJwwll)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6KewUu)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqB3geK)
</td>
</tr>
<tr >

<td align="center" >1.3 RC2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bnyMfJx)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdhdc9l)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qW2zrGS)
</td>
</tr>
<tr >

<td align="center" >1.3 RC1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3KTPid)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgmrPJ6)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o61gMSi)
</td>
</tr>
<tr >

<td align="center" >1.3 Beta
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGy6f5s)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqvm0fi)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntqY2At)
</td>
</tr>
<tr >

<td align="center" >1.3 Preview3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntvHs2d)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJJZMzT)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hkFLW)
</td>
</tr>
<tr >

<td align="center" >1.3 Preview2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hq5uz20)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3nb1Vv)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1nt5kqQd)
</td>
</tr>
<tr >

<td align="center" >1.3 Preview1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6OKUIQ)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgIGdio)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bn548rH)
</td>
</tr>
<tr >

<td align="center" >1.2.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i32AQUD)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sj7enLj)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3xRdJ3)
</td>
</tr>
<tr >

<td align="center" >1.2.1.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjDiYIT)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTDvwBd)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDlhpGt)
</td>
</tr>
<tr >

<td align="center" >1.2 正式版
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgKehW8)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sj0rdF3)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dD0F5b7)
</td>
</tr>
<tr >

<td align="center" >1.2 RC3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgrDRvU)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgMfXuK)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntuZ61V)
</td>
</tr>
<tr >

<td align="center" >1.2 RC2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1wHTMm)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDiyDe5)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3CcG7N)
</td>
</tr>
<tr >

<td align="center" >1.2 RC
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQdCBC2)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDztuMH)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1nt20Pvj)
</td>
</tr>
<tr >

<td align="center" >1.2 Beta3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3gT9Rn)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQnLwhO)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/154yIE)
</td>
</tr>
<tr >

<td align="center" >1.2 Beta2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntyww5r)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjHRbi9)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGzOx0M)
</td>
</tr>
<tr >

<td align="center" >1.2 Beta
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0cZHXu)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bnrUSBd)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTpCFTt)
</td>
</tr>
<tr >

<td align="center" >1.2 Preview 4
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJ0ZHij)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3kqZ9j)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3w2nNv)
</td>
</tr>
<tr >

<td align="center" >1.2 Preview 3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWx97pa)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3BuYFz)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0B5qdM)
</td>
</tr>
<tr >

<td align="center" >1.2 Preview 2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWn0bqk)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGEaFII)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6Fo0iu)
</td>
</tr>
<tr >

<td align="center" >1.2 Preview 1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sj6uAfz)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgIGdio)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgsrAXU)
</td>
</tr>
<tr >

<td align="center" >1.1 正式版
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjr1dpj)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mg0yHi4)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGDubg6)
</td>
</tr>
<tr >

<td align="center" >1.1 RC1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jG3QuV0)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQhDPPw)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6smUng)
</td>
</tr>
<tr >

<td align="center" >1.1 Beta4
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntMaSA1)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bn2IyMN)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWPs9dy)
</td>
</tr>
<tr >

<td align="center" >1.1 Beta3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJoMNSf)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWyoku4)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jG24kv0)
</td>
</tr>
<tr >

<td align="center" >1.1 Beta2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdCJ4H1)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqpaWa4)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3w0vT7)
</td>
</tr>
<tr >

<td align="center" >1.1 Beta
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDo1b9Z)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kT21VQv)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdrKGsb)
</td>
</tr>
<tr >

<td align="center" >1.1 Preview 2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJMCx79)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQd901k)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjuiarb)
</td>
</tr>
<tr >

<td align="center" >1.1 Preview 1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTFsJ9H)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6p4j8I)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJJouDl)
</td>
</tr>
<tr >

<td align="center" >1.0.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJA0b0n)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGuvmuU)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWCzSjM)
</td>
</tr>
<tr >

<td align="center" >1.0.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1cu76m)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqoZCDe)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0nLN6g)
</td>
</tr>
<tr >

<td align="center" >1.0正式版
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQzmQDO)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDitUFJ)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTn7wLx)
</td>
</tr>
<tr >

<td align="center" >1.0 RC4
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJkbwin)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hq1QBVQ)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQBygj4)
</td>
</tr>
<tr >

<td align="center" >1.0 RC2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjx4rNJ)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQpJmqI)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntuUBvN)
</td>
</tr>
<tr >

<td align="center" >1.0 RC1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjsKtIl)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdrcRfX)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjO82st)
</td>
</tr>
<tr >

<td align="center" >0.9.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6JoLzc)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o69LsOq)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0B1Gju)
</td>
</tr>
<tr >

<td align="center" >0.9.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdzkjgn)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sj17AJN)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0hFuDi)
</td>
</tr>
<tr >

<td align="center" >0.9.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdgTnqF)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qW3B0Ck)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDitjW1)
</td>
</tr>
<tr >

<td align="center" >0.9.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQ3VNMi)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bnCPy5x)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1tUA5o)
</td>
</tr>
<tr >

<td align="center" >0.8.14
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kT1d5JL)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGj4Eu6)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdgmYiR)
</td>
</tr>
<tr >

<td align="center" >0.8.13
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgE85Pu)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGBoOiq)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqJ0xhi)
</td>
</tr>
<tr >

<td align="center" >0.8.12
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQ3ps2I)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6uR15g)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3uvHid)
</td>
</tr>
<tr >

<td align="center" >0.8.11
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0lbPEK)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjpveBN)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdCGfgn)
</td>
</tr>
<tr >

<td align="center" >0.8.10
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6NWZuq)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6E36um)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3iPGtn)
</td>
</tr>
<tr >

<td align="center" >0.8.9
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mggH8P6)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bnrjr0F)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0ozyz2)
</td>
</tr>
<tr >

<td align="center" >0.8.8
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6hZneE)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdh77nt)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDgVDxn)
</td>
</tr>
<tr >

<td align="center" >0.8.7
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntt61xn)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQCHAV4)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQcPIcq)
</td>
</tr>
<tr >

<td align="center" >0.8.6
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mg6zsGK)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1nt5b0F3)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hq674bU)
</td>
</tr>
<tr >

<td align="center" >0.8.5
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDxQfh3)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bn6HEwR)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDkYOMH)
</td>
</tr>
<tr >

<td align="center" >0.8.4
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWqbWyo)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3Ia7Nv)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntwTDqx)
</td>
</tr>
<tr >

<td align="center" >0.8.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQioNrs)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6v5E6Q)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bnb9uiz)
</td>
</tr>
<tr >

<td align="center" >0.8.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQ1ln14)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJkDQHl)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0ncknA)
</td>
</tr>
<tr >

<td align="center" >0.8.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6LTxVG)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dD5qHjF)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTqlzxH)
</td>
</tr>
<tr >

<td align="center" >0.8 0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQ5oGaI)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTHpLyR)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0qzDao)
</td>
</tr>
<tr >

<td align="center" >0.6.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqqX2ba)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWjpB9y)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWBFTiG)
</td>
</tr>
<tr >

<td align="center" >0.6.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjJf0Pf)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jcixK)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqpB7As)
</td>
</tr>
<tr >

<td align="center" >0.5.9
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDw3oYl)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c08a8y0)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqeMmVU)
</td>
</tr>
<tr >

<td align="center" >0.5.8
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWLPqd2)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3ECc9f)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i37QxBf)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#sdk-tools)SDK Tools


<table >

<tr >
版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="center" >sdk-tools-r24.3.3
</td>

<td align="center" >[installer_r24.3.3-windows.exe](http://pan.baidu.com/s/1eQwEMGE) [android-sdk_r24.3.3-windows.zip](http://pan.baidu.com/s/1hq5ylWo)
</td>

<td align="center" >[android-sdk_r24.3.3-macosx.zip](http://pan.baidu.com/s/1mgjBxA4)
</td>

<td align="center" >[android-sdk_r24.3.3-linux.tgz](http://pan.baidu.com/s/1hqu8P2s)
</td>
</tr>
<tr >

<td align="center" >sdk-tools-r24.3.2
</td>

<td align="center" >[installer_r24.3.2-windows.exe](http://pan.baidu.com/s/1kToZVL1) [android-sdk_r24.3.2-windows.zip](http://pan.baidu.com/s/1i3eUFDb)
</td>

<td align="center" >[android-sdk_r24.3.2-macosx.zip](http://pan.baidu.com/s/1gdeYIVx)
</td>

<td align="center" >[android-sdk_r24.3.2-linux.tgz](http://pan.baidu.com/s/1eQpQgXO)
</td>
</tr>
<tr >

<td align="center" >sdk-tools-r24.2
</td>

<td align="center" >[installer_r24.2-windows.exe](http://pan.baidu.com/s/1ntkRd6D) [android-sdk_r24.2-windows.zip](http://pan.baidu.com/s/1mgAB66s)
</td>

<td align="center" >[android-sdk_r24.2-macosx.zip](http://pan.baidu.com/s/1eQnhj9o)
</td>

<td align="center" >[android-sdk_r24.2-linux.tgz](http://pan.baidu.com/s/1dDhd76h)
</td>
</tr>
<tr >

<td align="center" >sdk-tools-r24.1.2
</td>

<td align="center" >[installer_r24.1.2-windows.exe](http://pan.baidu.com/s/1pJwVClt) [android-sdk_r24.1.2-windows.zip](http://pan.baidu.com/s/1ntOefLf)
</td>

<td align="center" >[android-sdk_r24.1.2-macosx.zip](http://pan.baidu.com/s/1qWv7Jpq)
</td>

<td align="center" >[android-sdk_r24.1.2-linux.tgz](http://pan.baidu.com/s/1ntzbACp)
</td>
</tr>
<tr >

<td align="center" >sdk-tools-r24.0.2
</td>

<td align="center" >[installer_r24.0.2-windows.exe](http://pan.baidu.com/s/1eQH3ZOI) [android-sdk_r24.0.2-windows.zip](http://pan.baidu.com/s/1c0vnzMC)
</td>

<td align="center" >[android-sdk_r24.0.2-macosx.zip](http://pan.baidu.com/s/1mgDnXMw)
</td>

<td align="center" >[android-sdk_r24.0.2-linux.tgz](http://pan.baidu.com/s/1eQEglTS)
</td>
</tr>
<tr >

<td align="center" >sdk-tools-r24.0.1
</td>

<td align="center" >[installer_r24.0.1-windows.exe](http://pan.baidu.com/s/1gdgojhp) [android-sdk_r24.0.1-windows.zip](http://pan.baidu.com/s/1gdEKclP)
</td>

<td align="center" >[android-sdk_r24.0.1-macosx.zip](http://pan.baidu.com/s/1i3467DN)
</td>

<td align="center" >[android-sdk_r24.0.1-linux.tgz](http://pan.baidu.com/s/1gdvNj83)
</td>
</tr>
<tr >

<td align="center" >sdk-tools-r24
</td>

<td align="center" >[installer_r24-windows.exe](http://pan.baidu.com/s/1jG5ks7c) [android-sdk_r24-windows.zip](http://pan.baidu.com/s/1pJ4uk4r)
</td>

<td align="center" >[android-sdk_r24-macosx.zip](http://pan.baidu.com/s/1pJ8xUgN)
</td>

<td align="center" >[android-sdk_r24-linux.tgz](http://pan.baidu.com/s/1pJ4uk47)
</td>
</tr>
<tr >

<td align="center" >sdk-tools-r23.0.5
</td>

<td align="center" >[android-sdk_r23.0.5-windows(非官方版).zip](http://pan.baidu.com/s/1bntmoqV)
</td>

<td align="center" >[android-sdk_r23.0.5-macosx(非官方版).zip](http://pan.baidu.com/s/1o6LWg10)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >sdk-tools-r23.0.2
</td>

<td align="center" >[installer_r23.0.2-windows.exe](http://pan.baidu.com/s/1jGj2xIA) [android-sdk_r23.0.2-windows.zip](http://pan.baidu.com/s/1CiWSu)
</td>

<td align="center" >[android-sdk_r23.0.2-macosx.zip](http://pan.baidu.com/s/1bny9Mk3)
</td>

<td align="center" >[android-sdk_r23.0.2-linux.tgz](http://pan.baidu.com/s/1qWAu4o8)
</td>
</tr>
<tr >

<td align="center" >sdk-tools-r23
</td>

<td align="center" >[installer_r23-windows.exe](http://pan.baidu.com/s/1nt5Gwhb) [android-sdk_r23-windows.zip](http://pan.baidu.com/s/1kTC6akZ)
</td>

<td align="center" >[android-sdk_r23-macosx.zip](http://pan.baidu.com/s/1gdj7X3l)
</td>

<td align="center" >[android-sdk_r23-linux.tgz](http://pan.baidu.com/s/1yBnSa)
</td>
</tr>
</tbody>
</table>

```
**备注：** `非官方版` 是在 `23.0.2` 的基础上进行了在线更新包含了 `Android 5.0 SDK` ，`SDK Tools 23.0.5` 、`Build Tools 21.0.1`、`Support Library 21`等。
```



#### [](http://www.androiddevtools.cn/#sdk-platform-tools)SDK Platform-Tools


这是 adb, fastboot 等工具包。把解压出来的 `platform-tools` 文件夹放在 android sdk 根目录下，并把 `adb`所在的目录添加到系统 `PATH` 路径里，即可在命令行里直接访问了 adb, fastboot 等工具。
<table >

<tr >
版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="left" >platform-tools-r22
</td>

<td align="center" >[platform-tools_r22-windows.zip](http://pan.baidu.com/s/1sj4ZfTb)
</td>

<td align="left" >[platform-tools_r22-mac.zip](http://pan.baidu.com/s/1jG3l6Ea)
</td>

<td align="center" >[platform-tools_r22-linux.zip](http://pan.baidu.com/s/1c0GUTxA)
</td>
</tr>
<tr >

<td align="left" >platform-tools-r21
</td>

<td align="center" >[platform-tools_r21-windows.zip](http://pan.baidu.com/s/1gdF1fkZ)
</td>

<td align="left" >[platform-tools_r21-mac.zip](http://pan.baidu.com/s/1dDu6xC9)
</td>

<td align="center" >[platform-tools_r21-linux.zip](http://pan.baidu.com/s/1dDAL25j)
</td>
</tr>
<tr >

<td align="left" >platform-tools-r20
</td>

<td align="center" >[platform-tools_r20-windows.zip](http://pan.baidu.com/s/1ntHqLZj)
</td>

<td align="left" >[platform-tools_r20-mac.zip](http://pan.baidu.com/s/1gdy6fzP)
</td>

<td align="center" >[platform-tools_r20-linux.zip](http://pan.baidu.com/s/173KQi)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#build-tools)Build-Tools


这是Android开发所需的Build-Tools，下载并解压后，将解压出的整个文件夹复制或者移动到 `your sdk 路径/build-tools` 文件夹即可。
<table >

<tr >
版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="center" >21.1.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3kqFHV)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGquuqU)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDdDne5)
</td>
</tr>
<tr >

<td align="center" >21.1.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqH1pZY)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hq1mml2)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >21.1.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgzFXW0)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i367FTz)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >21.1.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJ3DCGN)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqIfeCW)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >21.0.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTDpnt9)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDCf9TZ)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >21.0.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQreI6A)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQCd5YE)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >21.0.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3y0mKd)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3oWM01)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >20.0.0
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0AfIOK)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >19.1.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1nttAyhV)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1nt2vM21)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >19.0.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWCzdwC)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hq7VIgG)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >19.0.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntl0Qnf)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1xY7PO)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >19.0.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJ1BJrt)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o65bAwa)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="center" >19.0.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6I8NBs)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0dBDvE)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#sdk-list)SDK


这是Android开发所需的sdk，下载并解压后，将解压出的整个文件夹复制或者移动到 `your sdk 路径/platforms`文件夹，然后打开SDK Manager，打开 `Tools(工具)`菜单选择 `Options(选项)`菜单项打开Android SDK Manager Setting对话框，点击 `Clear Cache(清除缓存)`按钮，然后重启Eclipse(或Android Studio)和SDK Manager。
<table >

<tr >
系统版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="left" >android 5.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i33Puo1)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6v7E2I)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6v7E2I)
</td>
</tr>
<tr >

<td align="left" >android L Rev3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1u8dhc)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jG1duN8)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jG1duN8)
</td>
</tr>
<tr >

<td align="left" >android L
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3tDDvZ)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntHmhYx)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntHmhYx)
</td>
</tr>
<tr >

<td align="left" >android 4.4W
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eYPGE)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1nt5GKWh)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1nt5GKWh)
</td>
</tr>
<tr >

<td align="left" >android 4.4.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQf8ZgI)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jeRGM)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jeRGM)
</td>
</tr>
<tr >

<td align="left" >android 4.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o65bfV8)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bn1tNm3)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bn1tNm3)
</td>
</tr>
<tr >

<td align="left" >android 4.2.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgICw9E)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJJSlfl)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJJSlfl)
</td>
</tr>
<tr >

<td align="left" >android 4.1.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1nt3bpI5)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTA6V8z)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTA6V8z)
</td>
</tr>
<tr >

<td align="left" >android 4.0.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJoegpd)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGzdDxc)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGzdDxc)
</td>
</tr>
<tr >

<td align="left" >android 4.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0H6Ld2)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqwzPTa)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqwzPTa)
</td>
</tr>
<tr >

<td align="left" >android 3.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGLvX6A)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWqH9Q8)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWqH9Q8)
</td>
</tr>
<tr >

<td align="left" >android 3.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJ0naTP)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jG62PSy)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jG62PSy)
</td>
</tr>
<tr >

<td align="left" >android 3.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0hi7Ck)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bn2Duub)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bn2Duub)
</td>
</tr>
<tr >

<td align="left" >android 2.3.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ngubc)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGge2bk)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGge2bk)
</td>
</tr>
<tr >

<td align="left" >android 2.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qW8YzY8)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntmJVmD)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntmJVmD)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#sdk-system-images)SDK System images


这是在创建模拟器时需要的system image，也就是在创建模拟器时 `CPU/ABI`项需要选择的，下载并解压后，将解压出的整个文件夹复制或者移动到 `your sdk 路径/system-images`文件夹下即可， 如果没有 `system-images`目录就先创建此文件夹，然后打开SDK Manager，打开 `Tools(工具)`菜单选择 `Options(选项)`菜单项打开Android SDK Manager Setting对话框，点击 `Clear Cache(清除缓存)`按钮，然后重启Eclipse(或Android Studio)和SDK Manager。
<table >

<tr >
系统版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="left" >android 5.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntwpDQL)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1D7glC)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1D7glC)
</td>
</tr>
<tr >

<td align="left" >android L
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqIcqhA)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntFQlRV)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntFQlRV)
</td>
</tr>
<tr >

<td align="left" >android 4.4W
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgJVZfE)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1GmAE6)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1GmAE6)
</td>
</tr>
<tr >

<td align="left" >android 4.4.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3Jwhed)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qW0QWdm)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qW0QWdm)
</td>
</tr>
<tr >

<td align="left" >android 4.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1guLaQ)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJPp6dX)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJPp6dX)
</td>
</tr>
<tr >

<td align="left" >android 4.2.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJO99hD)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTyZo27)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kTyZo27)
</td>
</tr>
<tr >

<td align="left" >android 4.1.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1nMr4E)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kT2xdxd)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1kT2xdxd)
</td>
</tr>
<tr >

<td align="left" >android 4.0.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1i3Fsx6H)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdnCh2b)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdnCh2b)
</td>
</tr>
<tr >

<td align="left" >android 4.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1pJzIXZl)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqoWcNM)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqoWcNM)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#googlemap-apis-sdk)GoogleMap APIs SDK


这是GoogleMap APIs SDK，下载并解压后，将解压出的整个文件夹复制或者移动到 `your sdk 路径/add-ons`文件夹下，然后打开SDK Manager，打开 `Tools(工具)`菜单选择 `Options(选项)`菜单项打开Android SDK Manager Setting对话框，点击 `Clear Cache(清除缓存)`按钮，然后重启Eclipse(或Android Studio)和SDK Manager。
<table >

<tr >
系统版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="left" >android 4.4.2
</td>

<td align="center" >[下载ARM版](http://pan.baidu.com/s/1bno0mFt) [下载x86版](http://pan.baidu.com/s/1jGgKyZc)
</td>

<td align="center" >[下载ARM版](http://pan.baidu.com/s/1bngsIkB) [下载x86版](http://pan.baidu.com/s/1eQDwCpG)
</td>

<td align="center" >[下载ARM版](http://pan.baidu.com/s/1bngsIkB) [下载x86版](http://pan.baidu.com/s/1eQDwCpG)
</td>
</tr>
<tr >

<td align="left" >android 4.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bnb9at5)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdJ0mqR)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdJ0mqR)
</td>
</tr>
<tr >

<td align="left" >android 4.2.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGl4hZw)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDmurr7)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDmurr7)
</td>
</tr>
<tr >

<td align="left" >android 4.1.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntK9Urf)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgIAcpa)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgIAcpa)
</td>
</tr>
<tr >

<td align="left" >android 4.0.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bnEiHiB)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqBWAIo)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqBWAIo)
</td>
</tr>
<tr >

<td align="left" >android 4.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gd68WtP)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqBWAIo)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqBWAIo)
</td>
</tr>
<tr >

<td align="left" >android 3.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6Dgtse)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdf49Jt)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1gdf49Jt)
</td>
</tr>
<tr >

<td align="left" >android 3.1
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1o6Dgtse)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGBS4rO)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1jGBS4rO)
</td>
</tr>
<tr >

<td align="left" >android 3.0
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0CKIFA)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0iY68w)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1c0iY68w)
</td>
</tr>
<tr >

<td align="left" >android 2.3.3
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqHwsHA)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDvhHOt)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1dDvhHOt)
</td>
</tr>
<tr >

<td align="left" >android 2.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWJNPyk)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQEc8SU)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQEc8SU)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#google-glass-sdk)Google Glass SDK


这是GDK，下载并解压后，将解压出的整个文件夹复制或者移动到 `your sdk 路径/add-ons`文件夹下，然后打开SDK Manager，打开 `Tools(工具)`菜单选择 `Options(选项)`菜单项打开Android SDK Manager Setting对话框，点击 `Clear Cache(清除缓存)`按钮，然后重启Eclipse(或Android Studio)和SDK Manager。
<table >

<tr >
系统版本
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="left" >android 4.4.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1fENeu)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQpGaA2)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQpGaA2)
</td>
</tr>
<tr >

<td align="left" >android 4.0.3
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1hqikzUs)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#google-tv-addon)Google TV Addon


这是Google TV Addon，下载并解压后，将解压出的整个文件夹复制或者移动到 `your sdk 路径/add-ons`文件夹，然后打开SDK Manager，打开`Tools(工具)`菜单选择 `Options(选项)`菜单项打开Android SDK Manager Setting对话框，点击 `Clear Cache(清除缓存)`按钮，然后重启Eclipse(或Android Studio)和SDK Manager。
<table >

<tr >
系统版本
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="left" >android 3.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1qWLPFfm)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQFy1KA)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1eQFy1KA)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-framework-source-code)Android Framework Source Code


这是Android Framework Source Code，下载并解压后，将解压出的整个文件夹复制或者移动到 `your sdk 路径/sources`文件夹下，然后重启Eclipse(或Android Studio)，这样当你在Eclipse里面按住 `Ctrl`键点击某个系统类时就可以打开该类的源码文件查看源码了。
<table >

<tr >
系统版本
</tr>

<tbody >
<tr >

<td align="left" >[android 5.0](http://pan.baidu.com/s/1dD5Z1Hf)
</td>
</tr>
<tr >

<td align="left" >[android 4.4W](http://pan.baidu.com/s/1eQf6F0Q)
</td>
</tr>
<tr >

<td align="left" >[android 4.4.2](http://pan.baidu.com/s/1hqGGrVA)
</td>
</tr>
<tr >

<td align="left" >[android 4.3](http://pan.baidu.com/s/1pJI3YrD)
</td>
</tr>
<tr >

<td align="left" >[android 4.2.2](http://pan.baidu.com/s/1qWlXS9u)
</td>
</tr>
<tr >

<td align="left" >[android 4.1.2](http://pan.baidu.com/s/1qWv1spm)
</td>
</tr>
<tr >

<td align="left" >[android 4.0.3](http://pan.baidu.com/s/1jGGCpuu)
</td>
</tr>
<tr >

<td align="left" >[android 4.0](http://pan.baidu.com/s/1o61AZwQ)
</td>
</tr>
<tr >

<td align="left" >[android 3.0](http://pan.baidu.com/s/1pJt14En)
</td>
</tr>
<tr >

<td align="left" >[android 2.3.3](http://pan.baidu.com/s/1eQekIPW)
</td>
</tr>
<tr >

<td align="left" >[android 2.2](http://pan.baidu.com/s/1bny9E2b)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-sdk-extras)Android SDK Extras


包含 `Android Support Library`、 `Google Cloud Messaging for Android Library`、 `Google Play services`、`Google Play services for fit preview`、 `Google Play services for Froyo`、 `Google Play APK Expansion Library`、`Google Play Billing Library`、 `Google Play Licensing Library`等，下载解压后将解压出的整个文件夹复制或者移动到 `your sdk`根目录下下，如果已经存在 `extras`文件夹就替换掉。
<table >

<tr >
版本号
</tr>

<tbody >
<tr >

<td align="center" >[21.0.3](http://pan.baidu.com/s/1kTmlB9d)
</td>
</tr>
<tr >

<td align="center" >[21.0.2](http://pan.baidu.com/s/1mgso8Y0)
</td>
</tr>
<tr >

<td align="center" >[21](http://pan.baidu.com/s/1o6v78Lk)
</td>
</tr>
<tr >

<td align="center" >[20](http://pan.baidu.com/s/1eQIMXMy)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#support-library)Support Library


包含supportive、v7和v13，下载解压后将解压出的整个文件夹复制或者移动到 `your sdk 路径/extras`下，然后打开SDK Manager，打开`Tools(工具)`菜单选择 `Options(选项)`菜单项打开Android SDK Manager Setting对话框，点击 `Clear Cache(清除缓存)`按钮，然后重启Eclipse(或Android Studio)和SDK Manager。
<table >

<tr >
版本号
</tr>

<tbody >
<tr >

<td align="center" >[21.0.3](http://pan.baidu.com/s/1ntsoeE1)
</td>
</tr>
<tr >

<td align="center" >[21.0.2](http://pan.baidu.com/s/1kTzIkYV)
</td>
</tr>
<tr >

<td align="center" >[21](http://pan.baidu.com/s/1o6MBWIu)
</td>
</tr>
<tr >

<td align="center" >[20](http://pan.baidu.com/s/1o6OBlR8)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#sdk-samples)SDK Samples


这是Android SDK自带的示例代码，下载并解压后，将解压出的整个文件夹复制或者移动到 `your sdk 路径/samples`文件夹下，然后重启Eclipse(或Android Studio)。 。
<table >

<tr >
系统版本
</tr>

<tbody >
<tr >

<td align="left" >[android 21](http://pan.baidu.com/s/1dDD19XB)
</td>
</tr>
<tr >

<td align="left" >[android L](http://pan.baidu.com/s/1gdpEan5)
</td>
</tr>
<tr >

<td align="left" >[android 4.4W](http://pan.baidu.com/s/1ntLVN9B)
</td>
</tr>
<tr >

<td align="left" >[android 4.4.2](http://pan.baidu.com/s/1dDeSKt7)
</td>
</tr>
<tr >

<td align="left" >[android 4.3](http://pan.baidu.com/s/1pJHicjx)
</td>
</tr>
<tr >

<td align="left" >[android 4.2.2](http://pan.baidu.com/s/1hqGavMc)
</td>
</tr>
<tr >

<td align="left" >[android 4.1.2](http://pan.baidu.com/s/1eYPL8)
</td>
</tr>
<tr >

<td align="left" >[android 4.0.3](http://pan.baidu.com/s/1i3mScXv)
</td>
</tr>
<tr >

<td align="left" >[android 4.0](http://pan.baidu.com/s/1kTiKqZP)
</td>
</tr>
<tr >

<td align="left" >[android 3.2](http://pan.baidu.com/s/1eQpafgI)
</td>
</tr>
<tr >

<td align="left" >[android 3.1](http://pan.baidu.com/s/1haIPw)
</td>
</tr>
<tr >

<td align="left" >[android 3.0](http://pan.baidu.com/s/1ntx9qFR)
</td>
</tr>
<tr >

<td align="left" >[android 2.3.3](http://pan.baidu.com/s/1hqiQw1Q)
</td>
</tr>
<tr >

<td align="left" >[android 2.2](http://pan.baidu.com/s/1ntv7wut)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#ndk)NDK


C/C++开发Android应用工具包,`Linux/Mac OS X 下NDK r10c`的安装方法请戳[这里](https://github.com/inferjay/AndroidDevTools/wiki/Installing-the-NDK-On-Linux-and-Mac-OS-X-(Darwin))
<table >

<tr >
版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="left" >ndk-r10e
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1jG7Yacm) [64位](http://pan.baidu.com/s/1jG5WjL8)
</td>

<td align="center" >[64位](http://pan.baidu.com/s/1hqKTsws)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1kTILsoR) [64位](http://pan.baidu.com/s/1mg5Sadq)
</td>
</tr>
<tr >

<td align="left" >ndk-r10d
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1yc9BK) [64位](http://pan.baidu.com/s/1dDGTrk1)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1hqtg8Qg) [64位](http://pan.baidu.com/s/1c0En1Uo)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1ntkOWEP) [64位](http://pan.baidu.com/s/1cxPFK)
</td>
</tr>
<tr >

<td align="left" >ndk-r10c
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1bnGnKkB) [64位](http://pan.baidu.com/s/1ntmhjUL)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1i37Ud8L) [64位](http://pan.baidu.com/s/1eQ08GOa)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1c0o11wk) [64位](http://pan.baidu.com/s/1c0tljk0)
</td>
</tr>
<tr >

<td align="left" >ndk64-r10
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1qW0RtzI) [64位](http://pan.baidu.com/s/1ntypDpf)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1o6G44Eu) [64位](http://pan.baidu.com/s/1gd7pvJ9)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1hql8AIo) [64位](http://pan.baidu.com/s/1dDreuPz)
</td>
</tr>
<tr >

<td align="left" >ndk32-r10
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1bnB1o1T) [64位](http://pan.baidu.com/s/1gdmW6cj)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1jGtBYyq) [64位](http://pan.baidu.com/s/1gdADfaF)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1V2Tg) [64位](http://pan.baidu.com/s/1pJJQokV)
</td>
</tr>
<tr >

<td align="left" >ndk-r9d
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1dDxjl8t) [64位](http://pan.baidu.com/s/1jGgecXw)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1eQnDNEE) [64位](http://pan.baidu.com/s/1i3l5L8T)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1jGr9w4A) [64位](http://pan.baidu.com/s/1sjAXS41)
</td>
</tr>
</tbody>
</table>
<table >

<tr >
Additional Download (32-, 64-bit)
Package
</tr>

<tbody >
<tr >

<td align="left" >r10 STL debug info
</td>

<td align="left" >[android-ndk-r10-cxx-stl-libs-with-debug-info.zip](http://pan.baidu.com/s/1xWgUE)
</td>
</tr>
<tr >

<td align="left" >r9 STL debug info
</td>

<td align="left" >[android-ndk-r9-cxx-stl-libs-with-debug-info.zip](http://pan.baidu.com/s/1c0EMn8O)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-l-preview-system-image)Android L Preview System Image


这个是Android L Preview系统的刷机镜像。
<table >

<tr >
设备
下载
</tr>

<tbody >
<tr >

<td align="center" >Nexus 5 (GSM/LTE) "hammerhead"
</td>

<td align="center" >[hammerhead-lpv79-preview-ac1d8a8e.tgz](http://pan.baidu.com/s/1kTsnxsF)
</td>
</tr>
<tr >

<td align="center" >Nexus 7 (Wifi) "razor"
</td>

<td align="center" >[razor-lpv79-preview-d0ddf8ce.tgz](http://pan.baidu.com/s/1mgn1CyG)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#jdk)JDK


<table >

<tr >
版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="center" >1.8 u5
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1bn2CVIB) [64位](http://pan.baidu.com/s/1eQtJyGq)
</td>

<td align="center" >[64位](http://pan.baidu.com/s/1pJkD78R)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1o64s0pc) [64位](http://pan.baidu.com/s/1jG3KBjg)
</td>
</tr>
<tr >

<td align="center" >1.7 u60
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1nt5a3jj) [64位](http://pan.baidu.com/s/1o61AAHc)
</td>

<td align="center" >[64位](http://pan.baidu.com/s/1nt0qGfn)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1eQd4wVK) [64位](http://pan.baidu.com/s/1jGzGQLw)
</td>
</tr>
<tr >

<td align="center" >1.6 u45
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1o67aooM) [64位](http://pan.baidu.com/s/1dDmtSZJ)
</td>

<td align="center" >[64位](http://pan.baidu.com/s/1hqpB7Nm)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1pJJj5Ib) [64位](http://pan.baidu.com/s/1dDck3O9)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#adt-bundle)ADT Bundle


ADT Bundle包含了Eclipse、ADT插件和SDK Tools，是已经集成好的IDE，只需安装好Jdk即可开始开发，推荐初学者下载ADT Bundle，不用再折腾开发环境。
<table >

<tr >
版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="center" >23.0.2
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1dDGM8oD) [64位](http://pan.baidu.com/s/1mgn2dOs)
</td>

<td align="center" >[64位](http://pan.baidu.com/s/1o6OBIHG)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1GmIsQ) [64位](http://pan.baidu.com/s/1EQMT4)
</td>
</tr>
<tr >

<td align="center" >23.0.0
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1i39mvY1) [64位](http://pan.baidu.com/s/1o65ExPS)
</td>

<td align="center" >[64位](http://pan.baidu.com/s/1hqvHkry)
</td>

<td align="center" >[32位](http://pan.baidu.com/s/1mgoh41q) [64位](http://pan.baidu.com/s/1qWJh4wk)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#adt-plugin)ADT Plugin


离线安装ADT插件请戳 [**项目wiki**](https://github.com/inferjay/AndroidDevTools/wiki/%E9%A6%96%E9%A1%B5)
<table >

<tr >
版本号
</tr>

<tbody >
<tr >

<td align="center" >[ADT-23.0.6](http://pan.baidu.com/s/1jGraNEQ)
</td>
</tr>
<tr >

<td align="center" >[ADT-23.0.4](http://pan.baidu.com/s/1i39UM7j)
</td>
</tr>
<tr >

<td align="center" >[ADT-23.0.3](http://pan.baidu.com/s/1hqJyLTi)
</td>
</tr>
<tr >

<td align="center" >[ADT-23.0.2](http://pan.baidu.com/s/1bnGkEvX)
</td>
</tr>
<tr >

<td align="center" >[ADT-23.0.0](http://pan.baidu.com/s/1sjArX7J)
</td>
</tr>
<tr >

<td align="center" >[ADT-22.6.3](http://pan.baidu.com/s/1jGMb5yQ)
</td>
</tr>
<tr >

<td align="center" >[AdT-22.6.1](http://pan.baidu.com/s/1pJ185Rl)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#gradle)Gradle


<table >

<tr >
版本号
</tr>

<tbody >
<tr >

<td align="left" >[gradle-2.4-all.zip](http://pan.baidu.com/s/1c0dcgfe)
</td>
</tr>
<tr >

<td align="left" >[gradle-2.3-all.zip](http://pan.baidu.com/s/1dDEnQr3)
</td>
</tr>
<tr >

<td align="left" >[gradle-2.2.1-all.zip](http://pan.baidu.com/s/1nt9jd25)
</td>
</tr>
<tr >

<td align="left" >[gradle-2.2-all.zip](http://pan.baidu.com/s/1CTrBK)
</td>
</tr>
<tr >

<td align="left" >[gradle-2.1-all.zip](http://pan.baidu.com/s/1bnF6jV5)
</td>
</tr>
<tr >

<td align="left" >[gradle-2.0-all.zip](http://pan.baidu.com/s/1mgFTN7a)
</td>
</tr>
<tr >

<td align="left" >[gradle-1.12-all.zip](http://pan.baidu.com/s/1Gmlx8)
</td>
</tr>
<tr >

<td align="left" >[gradle-1.11-all.zip](http://pan.baidu.com/s/1c0hCmdE)
</td>
</tr>
<tr >

<td align="left" >[gradle-1.10-all.zip](http://pan.baidu.com/s/1qWtzaGW)
</td>
</tr>
<tr >

<td align="left" >[gradle-1.9-all.zip](http://pan.baidu.com/s/1dDeSuXV)
</td>
</tr>
<tr >

<td align="left" >[gradle-1.8-all.zip](http://pan.baidu.com/s/1o6Npqqe)
</td>
</tr>
<tr >

<td align="left" >[gradle-1.7-all.zip](http://pan.baidu.com/s/1pJnvyWz)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#gradle-dependencies-configuration-generator)Gradle Dependencies Configuration Generator


[Gradle, please](http://gradleplease.appspot.com/)


#### [](http://www.androiddevtools.cn/#version-control-tools)版本控制工具




##### [](http://www.androiddevtools.cn/#git)Git


<table >

<tr >
版本号
Windows
Mac OSX
Linux
</tr>

<tbody >
<tr >

<td align="left" >Git-2.0.1
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1mgkM9BE)
</td>

<td align="center" >[下载](https://github.com/inferjay/AndroidDevTools/wiki/Download-for-Linux-and-Unix)
</td>
</tr>
<tr >

<td align="left" >Git-1.9.4
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntjy9N7)
</td>

<td align="center" >
</td>

<td align="center" >[下载](https://github.com/inferjay/AndroidDevTools/wiki/Download-for-Linux-and-Unix)
</td>
</tr>
<tr >

<td align="left" >Git-1.8.5.2
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1ntJWxeD)
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1bncr1pX)
</td>

<td align="center" >[下载](https://github.com/inferjay/AndroidDevTools/wiki/Download-for-Linux-and-Unix)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#svn-plugin-for-eclipse)SVN Plugin For Eclipse


<table >

<tr >
版本号
</tr>

<tbody >
<tr >

<td align="left" >[1.10.5](http://pan.baidu.com/s/1mg2x4Xq)
</td>
</tr>
<tr >

<td align="left" >[1.8.22](http://pan.baidu.com/s/1hqswoGs)
</td>
</tr>
<tr >

<td align="left" >[1.6.18](http://pan.baidu.com/s/1o60r6UA)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#apk-decompile-tools)Apk反编译工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Enjarify
</td>

<td align="center" >Enjarify 是一个用 Python 写的， Google 官方开源的可以将 Dalvik 字节码转换为 Java 字节码的工具。
</td>

<td align="center" >[下载](https://github.com/google/enjarify)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >JEB Android Decompiler
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://www.android-decompiler.com/index.php)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Virtuous Ten Studio
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://virtuous-ten-studio.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Apk文件修改工具Root Tools
</td>

<td align="center" >
</td>

<td align="center" >[下载](https://github.com/Stericson/RootTools)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Dex文件反编译工具Dedexer
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://dedexer.sourceforge.net/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >APK+Dex文件反编译及回编译工具
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://idoog.me/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >android-apktool
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://ibotpeaches.github.io/Apktool/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Onekey Decompile Apk]
</td>

<td align="center" >
</td>

<td align="center" >[下载](https://code.google.com/p/onekey-decompile-apk/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Baksmali
</td>

<td align="center" >
</td>

<td align="center" >[下载](https://code.google.com/p/smali/downloads/detail?name=baksmali)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Smali
</td>

<td align="center" >
</td>

<td align="center" >[下载](https://code.google.com/p/smali/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >AXMLPrinter2
</td>

<td align="center" >
</td>

<td align="center" >[下载](https://android4me.googlecode.com/files/AXMLPrinter2.jar)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >JAD Java Decompiler
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://varaneckas.com/jad/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >JD-GUI Decompiler
</td>

<td align="center" >
</td>

<td align="center" >[下载](http:)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >XJad V2.2
</td>

<td align="center" >
</td>

<td align="center" >[下载](http://files.cnblogs.com/arix04/XJad_V2.2.rar)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android APK Decompiler
</td>

<td align="center" >在线反编译工具
</td>

<td align="center" >[下载](http://www.decompileandroid.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >SmaliViewer
</td>

<td align="center" >是一款免费的APK分析软件，无论从分析的深

度还是广度来看，都是一款能够满足用户需求

的产品，使您在APK分析的过程中，更加得心应手。
</td>

<td align="center" >[下载](http://blog.avlyun.com/wp-content/uploads/2014/04/SmaliViewer.zip)
</td>

<td align="center" >[使用指南](http://blog.avlyun.com/show/%E3%80%8Asv%E7%94%A8%E6%88%B7%E6%8C%87%E5%8D%97%E3%80%8B/)
</td>
</tr>
<tr >

<td align="left" >Android逆向助手
</td>

<td align="center" >Android逆向助手是一功能强大的逆向辅助软件。

该软件可以帮助用户来进行apk反编译打包签名；

dex/jar互转替换提取修复；so反编译；

xml、txt加密；字符串编码等等，操作简单，

只需要直接将文件拖放到源和目标文件。
</td>

<td align="center" >[下载](http://enjoycode.info/uploads/Androidnxzs.zip)
</td>

<td align="center" >[使用指南](http://www.sanwho.com/620.html)
</td>
</tr>
<tr >

<td align="left" >Android Killer
</td>

<td align="center" >集Apk反编译、Apk打包、Apk签名，编码互转，
ADB通信（应用安装-卸载-运行-设备文件管理）等特色
功能于一 身，支持logcat日志输出，语法高亮，
基于关键字（支持单行代码或多行代码段）项目内搜索，
可自定义外部工具；吸收融汇多种工具功能与特点，
打造一站 式逆向工具操作体验，大大简化了用户在
安卓应用/游戏修改过程中的各类繁琐工作。
</td>

<td align="center" >[下载1](http://www.pd521.com/thread-136-1-1.html)
[下载2](http://pan.baidu.com/share/home?uk=4099707276#category/type=6)
</td>

<td align="center" >[使用指南](http://www.pd521.com/thread-509-1-1.html)
</td>
</tr>
<tr >

<td align="left" >DexExtractor
</td>

<td align="center" >android dex extractor ，anti-shell，android 脱壳。
</td>

<td align="center" >[下载](https://github.com/bunnyblue/DexExtractor)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#security-tools)安全工具


<table >

<tr >
名称
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >APKfuscator
</td>

<td align="center" >[下载](https://github.com/strazzere/APKfuscator)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >ApkAnalyser
</td>

<td align="center" >[下载](https://github.com/sonyxperiadev/ApkAnalyser/downloads)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >AppXplore
</td>

<td align="center" >[下载](https://play.google.com/store/apps/details?id=com.sonyericsson.androidapp.AppExplore&feature=search_result#?t=W251bGwsMSwxLDEsImNvbS5zb255ZXJpY3Nzb24uYW5kcm9pZGFwcC5BcHBFeHBsb3JlIl0.)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android analysis framework
</td>

<td align="center" >[下载](http://www.dexlabs.org/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Androguard
</td>

<td align="center" >[下载](https://code.google.com/p/androguard/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Droidbox
</td>

<td align="center" >[下载](https://code.google.com/p/droidbox/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >dsploit
</td>

<td align="center" >[下载](https://github.com/evilsocket/dsploit)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Androwarn
</td>

<td align="center" >[下载](https://github.com/maaaaz/androwarn)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Anubis
</td>

<td align="center" >[下载](http://anubis.iseclab.org/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Drozer
</td>

<td align="center" >[下载](https://www.mwrinfosecurity.com/products/drozer/community-edition/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >VirusTotal
</td>

<td align="center" >[下载](https://www.virustotal.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >GDB for Android
</td>

<td align="center" >[下载](http://gnutoolchains.com/android/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >VisualGDB
</td>

<td align="center" >[下载](http://visualgdb.com/?features=android)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#)静态代码分析工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >infer
</td>

<td align="left" >Facebook 开源的静态代码分析工具，用于在发布移动
应用之前对代码进行分析，找出潜在的问题。
</td>

<td align="center" >[下载](https://github.com/facebook/infer)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#%E6%90%9C%E7%B4%A2%E5%B7%A5%E5%85%B7)搜索工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Structural Java Exception Search
</td>

<td align="left" >Java异常搜索工具
</td>

<td align="center" >[下载](http://www.brainleg.com/search)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Library Finde
</td>

<td align="left" >最快的方式获取依赖库
</td>

<td align="center" >[下载](https://github.com/cesarferreira/alfi)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Codota
</td>

<td align="left" >示例代码搜索网站
</td>

<td align="center" >[下载](http://www.codota.com/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#debug%E8%B0%83%E8%AF%95%E5%B7%A5%E5%85%B7)Debug调试工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Stetho
</td>

<td align="left" >Stetho 是Facebook推出的Android 调试平台，基于
Chrome Developer Tools ，调试网络请求方面特别方便。
</td>

<td align="center" >[下载](https://github.com/facebook/stetho)
</td>

<td align="center" >[教程](http://facebook.github.io/stetho/)
</td>
</tr>
<tr >

<td align="left" >Augmented Traffic Control
</td>

<td align="left" >Facebook宣布开源移动网络测试工具ATC，该工具支持利用
Wi-Fi网络模拟2G、2.5G、3G以及LTE 4G移动网络
环境，让测试工程师们能够快速对智能手机和App在
不同国家地区和应用环境下的性能表现进行测试。
</td>

<td align="center" >[下载](https://github.com/facebook/augmented-traffic-control)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### Api测试工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >bat
</td>

<td align="left" >一个用Go写的命令行API测试利器，支持文件下载，
文件上传，支持Linux的pipe方式，总之就是炫酷。
</td>

<td align="center" >[下载](https://github.com/astaxie/bat)
</td>

<td align="center" >[教程](https://github.com/astaxie/bat#installation)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#eclipse-android-studio-idea-plugin)Eclipse/Android Studio/IDEA插件




##### [](http://www.androiddevtools.cn/#eclipse-plugin)Eclipse插件


<table >

<tr >
名称
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >SVN
</td>

<td align="center" >[下载](http://pan.baidu.com/s/1sjqamOP)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Genymobile模拟器
</td>

<td align="center" >[下载](http://genymotion.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Memory-Analyzer-Tools
</td>

<td align="center" >[下载](http://download.eclipse.org/mat/1.4/update-site/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Droidinspector
</td>

<td align="center" >[下载](http://www.sriramramani.com/droidinspector/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >SQLiteManager
</td>

<td align="center" >[下载](https://dl.dropboxusercontent.com/u/91846918/sqlite%20manager/com.questoid.sqlitemanager_1.0.0.jar)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Color Theme
</td>

<td align="center" >[下载](http://eclipsecolorthemes.org/?view=plugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >RoboVM
</td>

<td align="center" >[下载](http://www.robovm.org/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Newrelic
</td>

<td align="center" >[下载](https://download.newrelic.com/android_agent/eclipse)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


##### [](http://www.androiddevtools.cn/#android-studio-idea-plugin)Android Studio/IDEA插件


<table >

<tr >
名称
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android Resource Resizer Plugin
</td>

<td align="center" >[下载](https://github.com/walmyrcarvalho/android-resource-resizer)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Gradle Dependencies Helper Plugin
</td>

<td align="center" >[下载](https://github.com/ligi/GradleDependenciesHelperPlugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Parcelable code generation Plugin
</td>

<td align="center" >[下载](https://github.com/mcharmas/android-parcelable-intellij-plugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Holo Colors IDEA Plugin
</td>

<td align="center" >[下载](https://github.com/jeromevdl/android-holo-colors-idea-plugin/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Toolbox Plugin
</td>

<td align="center" >[下载](https://github.com/idamobile/android-toolbox-plugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Gradle Sign Plugin
</td>

<td align="center" >[下载](https://github.com/alexvasilkov/AndroidGradleSignPlugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Permissions Usage Plugin
</td>

<td align="center" >[下载](https://github.com/RomainPiel/AndroidPermissionsUsage)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Helper Plugin
</td>

<td align="center" >[下载](https://github.com/eunjae-lee/AndroidHelper)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Studio Prettify Plugin
</td>

<td align="center" >[下载](https://github.com/Haehnchen/idea-android-studio-plugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >IDEA ADB Plugin
</td>

<td align="center" >[下载](https://github.com/pbreault/adb-idea)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Otto Intellij Plugin
</td>

<td align="center" >[下载](https://github.com/square/otto-intellij-plugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Dagger intellij Plugin
</td>

<td align="center" >[下载](https://github.com/square/dagger-intellij-plugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Gradle Gui Plugin
</td>

<td align="center" >[下载](https://github.com/gradle-archive/gradle-intellij-gui)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Studio Unit Test Plugin
</td>

<td align="center" >[下载](https://github.com/evant/android-studio-unit-test-plugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Layout ID Converter Plugin
</td>

<td align="center" >[下载](https://github.com/funnything/OffingHarbor)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >IDEA protobuf Plugin
</td>

<td align="center" >[下载](https://github.com/nnmatveev/idea-plugin-protobuf)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Simple Team Code Reviewer Plugin
</td>

<td align="center" >[下载](https://github.com/syllant/idea-plugin-revu)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android XML Plugin
</td>

<td align="center" >[下载](https://github.com/mironov-nsk/AndroidXML)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >ADF Plugin
</td>

<td align="center" >[下载](https://github.com/tizionario/adf-intellijPlugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Java2smali Plugin
</td>

<td align="center" >[下载](https://github.com/ollide/intellij-java2smali)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >IDEA gitignore Plugin
</td>

<td align="center" >[下载](https://github.com/hsz/idea-gitignore)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >IDEA Background Image Plugin
</td>

<td align="center" >[下载](https://github.com/kimptoc/Intellij-IDEA-Plugin-Background-Image)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >IDEA Maven Plugin
</td>

<td align="center" >[下载](https://github.com/born2snipe/idea-plugin-maven-plugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Gradle GooglePlay Publisher Plugin
</td>

<td align="center" >[下载](https://github.com/Triple-T/gradle-play-publisher)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Drawable Selectors Generates Plugin
</td>

<td align="center" >[下载](https://github.com/inmite/android-selector-chapek)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Drawable Importer
</td>

<td align="center" >[下载](https://github.com/winterDroid/android-drawable-importer-intellij-plugin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >GsonFormat
</td>

<td align="center" >[下载](https://github.com/zzz40500/GsonFormat)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >ormlite-android-gradle-plugin
</td>

<td align="center" >[下载](https://github.com/stephanenicolas/ormlite-android-gradle-plugin)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-res-themes-style-generator-tools)Android资源/Themes/Style生成工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android Asset Studio
</td>

<td align="left" >
</td>

<td align="center" >[下载](http://romannurik.github.io/AndroidAssetStudio/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Drawable Factory
</td>

<td align="left" >
</td>

<td align="center" >[下载](https://github.com/tizionario/AndroidDrawableFactory)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Action Bar Style Generator
</td>

<td align="left" >
</td>

<td align="center" >[下载](http://jgilfelt.github.io/android-actionbarstylegenerator)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Holo Colors Generator
</td>

<td align="left" >
</td>

<td align="center" >[下载](http://android-holo-colors.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Simple Nine-patch Generator
</td>

<td align="left" >
</td>

<td align="center" >[下载](http://romannurik.github.io/AndroidAssetStudio/nine-patches.html)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Device Frame Generator
</td>

<td align="left" >
</td>

<td align="center" >[下载](http://f2prateek.com/android-device-frame-generator/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-res-analysis-tools)Android资源分析工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android Assets Viewer
</td>

<td align="left" >
</td>

<td align="center" >[下载](http://www.cellebellum.net/AndroidAssetsViewer/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-layout-parser-tools)Android Layout Parser工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android Layout Binder
</td>

<td align="left" >
</td>

<td align="center" >[下载](http://android.lineten.net/layout.php)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-content-provider-generator-tools)Android Content Provider代码生成工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Content Provider Code Generator
</td>

<td align="left" >
</td>

<td align="center" >[下载](https://github.com/BoD/android-contentprovider-generator)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-fragment-code-generator-tools)Android Fragment Code Generator代码生成工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android Fragment Code Generator
</td>

<td align="left" >
</td>

<td align="center" >[下载](http://techisfun.github.io/pages/android-fragment-generator/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-code-generator-tools)代码生成工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android KickstartR
</td>

<td align="left" >AndroidKickstartR帮助您快速创建
Android应用程序并使用最流行的库进行配置。
它创建和配置你的项目给你。只专注于代码!
</td>

<td align="center" >[下载](http://androidkickstartr.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Button Maker
</td>

<td align="left" >Android Button Maker是一个在线生成Android应用按钮代码的工具。
Android的API提供可绘制资源，其中的XML文件定义的几何形状，包括颜色，边框和梯度。
这些按钮是在shape drawable XML代码基础上产生的相比通常的PNG按钮加载速度更快。
您可以在设置面板中自定义按钮的属性和获得源代码。
</td>

<td align="center" >[下载](http://angrytools.com/android/button/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >DroidDraw
</td>

<td align="left" >
</td>

<td align="center" >[下载](https://code.google.com/p/droiddraw/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android SVG to VectorDrawable
</td>

<td align="left" >一个可以将SVG图片转换为Vector Drawable xml文件的在线工具。
</td>

<td align="center" >[下载](http://inloop.github.io/svg2android/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-native-dev-tools)Android Native开发工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android++
</td>

<td >
</td>

<td align="center" >[下载](http://android-plus-plus.com/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-test-tools)Android测试工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Appurify
</td>

<td >
</td>

<td align="center" >[下载](http://appurify.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Monkey
</td>

<td >
</td>

<td align="center" >[下载](http://developer.android.com/intl/zh-cn/tools/help/monkey.html)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Testin
</td>

<td >
</td>

<td align="center" >[下载](http://testin.cn/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Spoon
</td>

<td >
</td>

<td align="center" >[下载](http://square.github.io/spoon/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Little Eye
</td>

<td >
</td>

<td align="center" >[下载](http://www.littleeye.co/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >易测云
</td>

<td >
</td>

<td align="center" >[下载](http://www.yiceyun.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Emmagee
</td>

<td >
</td>

<td align="center" >[下载](https://code.google.com/p/emmagee/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Apk View Tracer
</td>

<td >
</td>

<td align="center" >[下载](https://code.google.com/p/apk-view-tracer/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >APT
</td>

<td >APT是一个Android平台高效性能测试组件，
提供丰富实用的功能，适用于开发自测、
定位性能瓶颈；
测试人员完成性能基准测试、竞品对比测试。
</td>

<td align="center" >[下载](https://code.csdn.net/Tencent/apt)
</td>

<td align="center" >[教程](http://www.eoeandroid.com/thread-497380-1-1.html)
</td>
</tr>
<tr >

<td align="left" >GT
</td>

<td >GT（随身调）是APP的随身调测平台，它是直接运行在手机上的“集成调测环境”(IDTE, Integrated Debug&Test Environment)。
</td>

<td align="center" >[下载](http://gt.tencent.com/index.html)
</td>

<td align="center" >[教程](http://gt.tencent.com/docs.html)
</td>
</tr>
<tr >

<td align="left" >Mobile-Checker
</td>

<td >移动端页面检查工具,可以选择三种屏幕规格，通过工具发现网站在移动端存在的问题。
</td>

<td align="center" >[下载](https://github.com/w3c/Mobile-Checker)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#multi-channel-apk-genterator-tools)Android多渠道打包工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Umeng多渠道打包工具
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/umeng/umeng-muti-channel-build-tool)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >AppTools具
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/wubo/apptools)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >package_tool
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/ahui2823/package_tool)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >RyApkTool
</td>

<td >
</td>

<td align="center" >[下载](http://blog.csdn.net/rydiy/article/details/7901564)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >兰贝壳儿
</td>

<td >
</td>

<td align="center" >[下载](http://www.orchidshell.com/)
</td>

<td align="center" >[教程](http://www.orchidshell.com/Instructions/OchidShellInstructions.htm)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-log-collection-tools)Android Bug日志收集工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Crashlytics
</td>

<td >
</td>

<td align="center" >[下载](http://try.crashlytics.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >ACRA
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/ACRA/acra)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >ChkBugReport
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/sonyxperiadev/ChkBugReport)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Log Collector
</td>

<td >
</td>

<td align="center" >[下载](https://code.google.com/p/android-log-collector/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Crash Catcher
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/netcook/crash-catcher)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-other-language-dev-tools)其他语言开发Android应用工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Xamarin
</td>

<td >
</td>

<td align="center" >[下载](http://xamarin.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Basic4android
</td>

<td >
</td>

<td align="center" >[下载](http://www.basic4ppc.com/index.html)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Scripting Layer
</td>

<td >
</td>

<td align="center" >[下载](https://code.google.com/p/android-scripting/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Ruby Rhodes
</td>

<td >移动设备上的Ruby
</td>

<td align="center" >[下载](http://rhomobile.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >PHP for Android
</td>

<td >
</td>

<td align="center" >[下载](http://www.phpforandroid.net/doku.php)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Codename One
</td>

<td >
</td>

<td align="center" >[下载](http://www.codenameone.com/index.html)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Touchqode
</td>

<td >
</td>

<td align="center" >[下载](http://www.codenameone.com/index.html)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >App Inventor
</td>

<td >
</td>

<td align="center" >[下载](http://www.codenameone.com/index.html)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#adroid-sensors-simulate-tools)传感器模拟工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Sensor Simulator
</td>

<td >独立的Java应用程序，它模拟传感器
的数据并将它们传送到Android模拟器。
</td>

<td align="center" >[下载](http://www.openintents.org/en/node/23))
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-serial-dev-tools)Android串口开发工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android Serialport Api
</td>

<td >
</td>

<td align="center" >[下载](https://code.google.com/p/android-serialport-api/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#img-size-handle-tools)图片尺寸处理工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >9-Patch Resizer
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/redwarp/9-Patch-Resizer)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#img-compress-tools)图片压缩工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >OptiPNG
</td>

<td >
</td>

<td align="center" >[下载](http://optipng.sourceforge.net/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Pngcrush
</td>

<td >
</td>

<td align="center" >[下载](http://pmt.sourceforge.net/pngcrush/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >ImageOptim
</td>

<td >
</td>

<td align="center" >[下载](https://imageoptim.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Tinypng
</td>

<td >
</td>

<td align="center" >[下载](https://tinypng.com/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#android-res-clean-tools)资源清理工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android Lint
</td>

<td >
</td>

<td align="center" >[下载](http://tools.android.com/tips/lint)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Resource Cleaner
</td>

<td >
</td>

<td align="center" >[下载](https://code.google.com/p/android-resource-cleaner/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Unused Resources
</td>

<td >
</td>

<td align="center" >[下载](https://code.google.com/p/android-unused-resources/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Resource Remover
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/KeepSafe/android-resource-remover)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#px-to-dp-convert-tools)px和dp转换/计算工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android dp px Calculator
</td>

<td >
</td>

<td align="center" >[下载](http://labs.rampinteractive.co.uk/android_dp_px_calculator/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >dp px converter
</td>

<td >
</td>

<td align="center" >[下载](http://pixplicity.com/dp-px-converter/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >pixelcalc
</td>

<td >
</td>

<td align="center" >[下载](http://angrytools.com/android/pixelcalc/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >androidpixels
</td>

<td >
</td>

<td align="center" >[下载](http://androidpixels.net/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >android dpi calculator
</td>

<td >
</td>

<td align="center" >[下载](http://coh.io/adpi/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >DPI Calculator
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/dpi-calculator/dldofgjemhkpilajnlenfijjpkabilcg?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android DPI Calculator插件
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/JerzyPuchalski/Android-DPI-Calculator)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#java-to-ios)Java To iOS


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >j2Objc
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/google/j2objc)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >RoboVM
</td>

<td >
</td>

<td align="center" >[下载](http://www.robovm.org/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#json-xml-to-pojo-class-tools)JSON/XML转换为POJO Class工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >jsonschema2pojo
</td>

<td >
</td>

<td align="center" >[下载](http://www.jsonschema2pojo.org/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Convert XML or JSON to Java Pojo
</td>

<td >
</td>

<td align="center" >[下载](http://pojo.sodhanalibrary.com/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#java-dao-generate-tools)Java DAO Generate工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Generate Java DAO for relational data table
</td>

<td >
</td>

<td align="center" >[下载](http://pojo.sodhanalibrary.com/GenerateDAO.html)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#chrome-plugin)Chrome插件




##### [](http://www.androiddevtools.cn/#chrome-android-plugin)Android插件


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android SDK Search
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/android-sdk-search/hgcbffeicehlpmgmnhnkjbjoldkfhoin)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Resource Navigator
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/android-resource-navigato/agoomkionjjbejegcejiefodgbckeebo?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >ADB Plugin for remote
debugging Chrome on Android
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/adb/dpngiggdglpdnjdoaefidgiigpemgage?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Mobile/RWD Tester
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/mobilerwd-tester/elmekokodcohlommfikpmojheggnbelo?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >ExtensionAndroid SDK Samples Search
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/android-sdk-samples-searc/mbiobcenjhldinmnbpjihaemkfofnmgf?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Developer Improvements
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/android-developer-improve/omakkdelnjjgfmohpfkejgfcckpkbhbj?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android downloader
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/android-downloader/pkffcfhlacdchhpahlgcajjiiljobbbb?hl=en)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


##### [](http://www.androiddevtools.cn/#json-xml-format-plugin)JSON/XML格式化插件


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >JSONView
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >JSON Formatter
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >JSON Viewer
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/json-viewer/gbmdgpbipfallnflgajpaliibnhdgobh?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >JSON Finder
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/json-finder/flhdcaebggmmpnnaljiajhihdfconkbj?hl=en)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


##### [](http://www.androiddevtools.cn/#encode-decode-plugin)Encode/Decode插件


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Base64 Encode and Decode
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/base64-encode-and-decode/kcafoaahiffdjffagoegkdiabclnkbha?hl=en)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


##### [](http://www.androiddevtools.cn/#chrome-git-plugin)Git Plugin


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Git Cheat Sheet
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/git-cheat-sheet/mjdmgoiobnbkfcfjcceaodlcodhpokgn?hl=en)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


## [](http://www.androiddevtools.cn/#android-dev-guides)Android Dev Guides




#### [](http://www.androiddevtools.cn/#google-java-program-guide-cn)Google Java编程风格指南中文版


英文地址：[http://google-styleguide.googlecode.com/svn/trunk/javaguide.html](http://google-styleguide.googlecode.com/svn/trunk/javaguide.html)

地址0：[http://hawstein.com/posts/google-java-style.html](http://hawstein.com/posts/google-java-style.html)

地址1：[https://github.com/codeset/google-java-styleguide](https://github.com/codeset/google-java-styleguide)


#### [](http://www.androiddevtools.cn/#android-api-doc-cn)Android Api中文版


地址：[http://wikidroid.sinaapp.com/Android中文API](http://wikidroid.sinaapp.com/Android%E4%B8%AD%E6%96%87API))


#### [](http://www.androiddevtools.cn/#android-api-guide-cn)Android API指南中文版


地址：[http://wiki.eoeandroid.com/Android_API_Guides](http://wiki.eoeandroid.com/Android_API_Guides)


#### [](http://www.androiddevtools.cn/#proguard-config-guide)Android Proguard混淆配置指南


地址：[https://github.com/inferjay/AndroidProguardGuide/](https://github.com/inferjay/AndroidProguardGuide/)


#### [](http://www.androiddevtools.cn/#gradle-plugin-guide-cn)Gradle插件使用指南中文版


地址：[http://avatarqing.github.io/Gradle-Plugin-User-Guide-Chinese-Verision](http://avatarqing.github.io/Gradle-Plugin-User-Guide-Chinese-Verision)


#### [](http://www.androiddevtools.cn/#gradle-user-guide)Gradle User Guide


Gradle 1.12用户指南：[http://pan.baidu.com/s/1dD7sC2d](http://pan.baidu.com/s/1dD7sC2d)


## [](http://www.androiddevtools.cn/#android-dev-tutorials)Android Dev Tutorials




#### [](http://www.androiddevtools.cn/#android-learning-way)Android学习之路


地址：[http://stormzhang.github.io/android/2014/07/07/learn-android-from-rookie/](http://stormzhang.github.io/android/2014/07/07/learn-android-from-rookie/)


#### [](http://www.androiddevtools.cn/#google-androidtraining-tutorials)Google Android官方培训课程中文版


地址：[http://hukai.me/android-training-course-in-chinese/index.html](http://hukai.me/android-training-course-in-chinese/index.html)


#### [](http://www.androiddevtools.cn/#developing-android-apps)Developing Android Apps


地址：[https://www.udacity.com/course/ud853](https://www.udacity.com/course/ud853)


#### [](http://www.androiddevtools.cn/#java-design-patterns-samples-in-java)Java Design Patterns Samples in Java.


[Java Design Patterns](https://github.com/iluwatar/java-design-patterns)


# [](http://www.androiddevtools.cn/#design-tools)Design Tools




#### [](http://www.androiddevtools.cn/#photoshop-plugin)Photoshop插件


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Cut&Slice
</td>

<td >切图神器
</td>

<td align="center" >[下载](http://www.cutandslice.me/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >DevRocket
</td>

<td >切图神器
</td>

<td align="center" >[下载](http://www.robovm.org/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Cutterman
</td>

<td >最好用的切图工具
</td>

<td align="center" >[下载](http://www.cutterman.cn/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Ink
</td>

<td >
</td>

<td align="center" >[下载](http://ink.chrometaphore.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Corner Editor
</td>

<td >路径圆角编辑工具
</td>

<td align="center" >[下载1](http://photoshopscripts.wordpress.com/)
[下载1](http://sourceforge.net/projects/cornereditor/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >GuideGuide
</td>

<td >辅助线工具
</td>

<td align="center" >[下载](http://guideguide.me/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Assistor PS
</td>

<td >
</td>

<td align="center" >[下载](http://assistor.net/en/assistor)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Skeuomorphism.it
</td>

<td >
</td>

<td align="center" >[下载](http://skeuomorphism.it/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >QuickGuide
</td>

<td >
</td>

<td align="center" >[下载](http://guchitaka.com/project-view/quickguidepro/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Long Shadow Generator
</td>

<td >长投影效果生成插件
</td>

<td align="center" >[下载](http://lab.rayps.com/lsg2/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >android_resizer_toolkit
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/marcosecchi/android_resizer_toolkit)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >android-ps-tools
</td>

<td >一些方便Android UI设计的PhototShop插件。
</td>

<td align="center" >[下载](https://github.com/timroes/android-ps-tools)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >LayerCraft
</td>

<td >A Photoshop plugin to export UI assets from layers
</td>

<td align="center" >[下载](http://lab.rayps.com/lc/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#vector-img-design-tools)矢量图设计工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Sketch 3
</td>

<td >
</td>

<td align="center" >[下载](http://bohemiancoding.com/sketch/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Affinity Designer
</td>

<td >
</td>

<td align="center" >[下载](https://affinity.serif.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Gravit
</td>

<td >
</td>

<td align="center" >[下载](http://gravit.io/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Adobe Illustrator
</td>

<td >
</td>

<td align="center" >[下载](https://www.adobe.com/cn/products/illustrator.html)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#ui-icon-cut-ools)切图工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Slicy
</td>

<td >
</td>

<td align="center" >[下载](http://macrabbit.com/slicy/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#desgin-size-mark-tools)设计稿尺寸标注工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >马克鳗
</td>

<td >
</td>

<td align="center" >[下载](http://www.getmarkman.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >PxCook像素大厨
</td>

<td >UI设计师效率提升利器，让你专注于设计本质，
不再为标注切图而烦恼，从设计到实现一气呵成
</td>

<td align="center" >[下载](http://www.fancynode.com.cn/)
</td>

<td align="center" >[使用教程](http://www.fancynode.com.cn/tutorial)
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#prototype-design-tools)原型设计工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Axure
</td>

<td >
</td>

<td align="center" >[下载](http://www.axure.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Fluid UI
</td>

<td >
</td>

<td align="center" >[下载](https://chrome.google.com/webstore/detail/fluid-ui/obgmmkbgpilmggfkhganmcmpemnhimgg?hl=en)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Briefs
</td>

<td >
</td>

<td align="center" >[下载](http://giveabrief.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Flinto
</td>

<td >
</td>

<td align="center" >[下载](https://www.flinto.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Balsamiq Mockups
</td>

<td >
</td>

<td align="center" >[下载](http://balsamiq.com/products/mockups/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >AppCooker
</td>

<td >
</td>

<td align="center" >[下载](http://www.appcooker.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Proto.io
</td>

<td >
</td>

<td align="center" >[下载](https://proto.io/en/signup/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >UXPin
</td>

<td >
</td>

<td align="center" >[下载](http://uxpin.com/#)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >InVision
</td>

<td >
</td>

<td align="center" >[下载](http://www.invisionapp.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >POP
</td>

<td >
</td>

<td align="center" >[下载](https://popapp.in/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >快现
</td>

<td >
</td>

<td align="center" >[下载](http://www.ikuaixian.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Composite
</td>

<td >
</td>

<td align="center" >[下载](http://www.getcomposite.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >OmniGraffle
</td>

<td >
</td>

<td align="center" >[下载](https://www.omnigroup.com/omnigraffle)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Marvelapp
</td>

<td >
</td>

<td align="center" >[下载](https://marvelapp.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Justinmind
</td>

<td >
</td>

<td align="center" >[下载](http://www.justinmind.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Form
</td>

<td >
</td>

<td align="center" >[下载](http://www.relativewave.com/form.html)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Prott
</td>

<td >
</td>

<td align="center" >[下载](https://prottapp.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Composite
</td>

<td >
</td>

<td align="center" >[下载](http://www.getcomposite.com/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#interaction-desgin-tools)交互设计工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Framer Studio
</td>

<td >
</td>

<td align="center" >[下载](http://framerjs.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Quartz Composer
</td>

<td >
</td>

<td align="center" >[下载](http://adcdownload.apple.com/Developer_Tools/graphics_tools_for_xcode__march_2014/graphics_tools_for_xcode_5.1__march_2014.dmg)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Origami
</td>

<td >
</td>

<td align="center" >[下载](http://facebook.github.io/origami/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >jQC
</td>

<td >
</td>

<td align="center" >[下载](http://qcdesigners.com/index.php/forums)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Avocado
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/ideo/avocado)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Pixate
</td>

<td >
</td>

<td align="center" >[下载](http://www.pixate.com/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#ui-effect-preview-tools)UI效果预览工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android Design Preview
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/romannurik/AndroidDesignPreview/releases)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >PS Play
</td>

<td >
</td>

<td align="center" >[下载](http://isux.tencent.com/app/psplay)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Pixl Preview
</td>

<td >
</td>

<td align="center" >[下载](https://play.google.com/store/apps/details?id=at.markushi.pixl)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Skala Preview
</td>

<td >
</td>

<td align="center" >[下载](http://bjango.com/mac/skalapreview/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >LiveView
</td>

<td >
</td>

<td align="center" >[下载](http://www.zambetti.com/projects/liveview/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#harmonize-colors-tools)配色工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Android Material Design可视化调色板
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/HozakaN/MaterialDesignColorPalette)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Material Design Colours.xml
</td>

<td >
</td>

<td align="center" >[下载](https://gist.github.com/daniellevass/b0b8cfa773488e138037)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Colorube配色神器
</td>

<td >
</td>

<td align="center" >[下载](http://www.fancynode.com/colorcube/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Adobe Kuler
</td>

<td >
</td>

<td align="center" >[下载](https://kuler.adobe.com/zh/create/color-wheel/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >ColorSchemer Studio
</td>

<td >
</td>

<td align="center" >[下载](http://www.colorschemer.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Piknik
</td>

<td >
</td>

<td align="center" >[下载](https://gist.github.com/daniellevass/b0b8cfa773488e138037)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#design-cvs-tools)设计稿版本控制工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >LayerVault
</td>

<td >
</td>

<td align="center" >[下载](https://layervault.com/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#icon-handle-tools)图标处理工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Icon Slate
</td>

<td >
</td>

<td align="center" >[下载](http://www.kodlian.com/apps)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#online-icon-library)在线Icon库


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >IconFont
</td>

<td >
</td>

<td align="center" >[下载](http://iconfont.cn/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >NounProject
</td>

<td >
</td>

<td align="center" >[下载](http://thenounproject.com/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#take-color-tools)取色工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >ColorSnapper
</td>

<td >
</td>

<td align="center" >[下载](http://colorsnapper.com/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#hex-opacity-list)不透明度16进制值


<table >

<tr >
不透明度
16进制值
</tr>

<tbody >
<tr >

<td align="center" >100%
</td>

<td align="center" >FF
</td>
</tr>
<tr >

<td align="center" >95%
</td>

<td align="center" >F2
</td>
</tr>
<tr >

<td align="center" >90%
</td>

<td align="center" >E6
</td>
</tr>
<tr >

<td align="center" >85%
</td>

<td align="center" >D9
</td>
</tr>
<tr >

<td align="center" >80%
</td>

<td align="center" >CC
</td>
</tr>
<tr >

<td align="center" >75%
</td>

<td align="center" >BF
</td>
</tr>
<tr >

<td align="center" >70%
</td>

<td align="center" >B3
</td>
</tr>
<tr >

<td align="center" >65%
</td>

<td align="center" >A6
</td>
</tr>
<tr >

<td align="center" >60%
</td>

<td align="center" >99
</td>
</tr>
<tr >

<td align="center" >55%
</td>

<td align="center" >8C
</td>
</tr>
<tr >

<td align="center" >50%
</td>

<td align="center" >80
</td>
</tr>
<tr >

<td align="center" >45%
</td>

<td align="center" >73
</td>
</tr>
<tr >

<td align="center" >40%
</td>

<td align="center" >66
</td>
</tr>
<tr >

<td align="center" >35%
</td>

<td align="center" >59
</td>
</tr>
<tr >

<td align="center" >30%
</td>

<td align="center" >4D
</td>
</tr>
<tr >

<td align="center" >25%
</td>

<td align="center" >40
</td>
</tr>
<tr >

<td align="center" >20%
</td>

<td align="center" >33
</td>
</tr>
<tr >

<td align="center" >15%
</td>

<td align="center" >26
</td>
</tr>
<tr >

<td align="center" >10%
</td>

<td align="center" >1A
</td>
</tr>
<tr >

<td align="center" >5%
</td>

<td align="center" >0D
</td>
</tr>
<tr >

<td align="center" >0%
</td>

<td align="center" >00
</td>
</tr>
</tbody>
</table>
出自：[http://stackoverflow.com/questions/5445085/understanding-colors-in-android-6-chars](http://stackoverflow.com/questions/5445085/understanding-colors-in-android-6-chars)


#### [](http://www.androiddevtools.cn/#phone-to-computer-preview-tools)手机To电脑同步预览工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >Reflector
</td>

<td >
</td>

<td align="center" >[下载](http://www.airsquirrels.com/reflector/download/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >x-Mirage
</td>

<td >
</td>

<td align="center" >[下载](http://x-mirage.com/x-mirage/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >AirServer
</td>

<td >
</td>

<td align="center" >[下载](http://www.airserver.com/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >BBQScreen
</td>

<td >
</td>

<td align="center" >[下载](http://screen.bbqdroid.org/)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


#### [](http://www.androiddevtools.cn/#gif-record-tools)Gif图片录制工具


<table >

<tr >
名称
简介
下载地址
使用教程
</tr>

<tbody >
<tr >

<td align="left" >LICEcap
</td>

<td >
</td>

<td align="center" >[下载](http://www.cockos.com/licecap/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >GifCam
</td>

<td >
</td>

<td align="center" >[下载](http://blog.bahraniapps.com/gifcam/)
</td>

<td align="center" >
</td>
</tr>
<tr >

<td align="left" >Android Tool
</td>

<td >
</td>

<td align="center" >[下载](https://github.com/mortenjust/androidtool-mac)
</td>

<td align="center" >
</td>
</tr>
</tbody>
</table>


## [](http://www.androiddevtools.cn/#ui-programming-language)UI Programming Language


[UILang](http://uilang.com/)


## [](http://www.androiddevtools.cn/#design-tutorials)Design Tutorials


[HackDesign](https://hackdesign.org/lessons)


## [](http://www.androiddevtools.cn/#design-games)Design Games


[The Bezier Game](http://bezier.method.ac/)

一个帮助你练习PS里钢笔工具的小游戏。


## [](http://www.androiddevtools.cn/#design-guides)Design Guides




#### [](http://www.androiddevtools.cn/#android-design-guides-cn)Android设计指南非官方简体中文版


Topfun镜像地址：[http://www.topfun.us/adchs/index.html](http://www.topfun.us/adchs/index.html)

Github镜像地址：[http://adchs.github.io](http://adchs.github.io/)

ApkBus镜像地址：[http://www.apkbus.com/design/](http://www.apkbus.com/design/)

Segmentfault镜像地址：[http://mirrors.segmentfault.com/adchs/](http://mirrors.segmentfault.com/adchs/)

多看阅读镜像地址：[http://www.duokan.com/book/47790](http://www.duokan.com/book/47790)


#### [](http://www.androiddevtools.cn/#android-cheatsheet-for-graphic-designers)Android Cheatsheet for Graphic Designers


地址:[http://petrnohejl.github.io/Android-Cheatsheet-For-Graphic-Designers/](http://petrnohejl.github.io/Android-Cheatsheet-For-Graphic-Designers/)


#### [](http://www.androiddevtools.cn/#google-material-design-cn)Google Material Design 中文版


地址：[http://wiki.jikexueyuan.com/project/material-design/](http://wiki.jikexueyuan.com/project/material-design/)

地址： [http://www.ui.cn/Material/](http://www.ui.cn/Material/)


#### [](http://www.androiddevtools.cn/#designers-guide-to-dpi)Designer's Guide To dpi


地址：[http://sebastien-gabriel.com/designers-guide-to-dpi/home](http://sebastien-gabriel.com/designers-guide-to-dpi/home#)


#### [](http://www.androiddevtools.cn/#email-design-guide)Email Design Guide


地址：[http://mailchimp.com/resources/email-design-guide/](http://mailchimp.com/resources/email-design-guide/)


## [](http://www.androiddevtools.cn/#free-design-resources)Free Design Resources


[Google Material Design 素材](http://pan.baidu.com/s/1i35iBNv)(感谢 [@SanityD](http://weibo.com/sanityd))

[Material Design Icon Templates](https://dribbble.com/shots/1617724)

[Material Design的图标集](https://github.com/google/material-design-icons)

[Material Design UI Kit for Sketch](https://www.behance.net/gallery/20514895/Material-Design-UI-Kit)

[Nexus 5 template for Sketch](http://tristanremy.com/nexus-5/)

[Free Design Resources](http://androiduiux.com/free-design-resources/?blogsub=confirming#blog_subscription-2)

[434 SVG icons](https://dl.dropboxusercontent.com/u/8067075/System%20Icons.zip)

[UI Cloun](http://ui-cloud.com/)

[161个国内外社交网站矢量图标](https://github.com/nullice/NViconsLib_Silhouette)

[250 free icons in 5 sizes and 14 colors](http://www.androidicons.com/)

[MINIMALISTIC EVERYDAY ICONS](http://matt-cooper.com/minimalistic-icons/)

[Icons4android一套极具人气的在线资源集合](http://www.icons4android.com/)


# [](http://www.androiddevtools.cn/#books-list)Books


[Free Programming Books](https://github.com/vhf/free-programming-books/blob/master/free-programming-books.md#android)

一堆免费的Android开发相关的电子书。

[50 Android Hacks](http://www.it-ebooks.info/book/2445/)

50 Android Hacks这本书分12个部分介绍了50个Android开发的小技巧。

[免费的编程中文书籍索引](http://siberiawolf.com/free_programming/index.html)


# [](http://www.androiddevtools.cn/#license)Disclaimer



    
    <code>版权归原作者所有，这里仅做收集整理，欢迎自由转载-非商用-非衍生-保持署名和网站链接。</code>
