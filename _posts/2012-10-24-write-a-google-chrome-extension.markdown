---
author: abloz
comments: true
date: 2012-10-24 10:19:10+00:00
layout: post
link: http://abloz.com/index.php/2012/10/24/write-a-google-chrome-extension/
slug: write-a-google-chrome-extension
title: 写一个google chrome 扩展插件
wordpress_id: 1924
categories:
- 技术
tags:
- chrome
- extention
---

周海汉
2012.10.24

chrome插件开发比ie简单多了。IE必须开发activex控件，不懂com，不懂VC，非常困难。而chrome只需懂点JS，CSS，HTML5就差不多了。
方法如下：
1.新建一个目录，里面用于存放插件文件
2.新建 manifest.json
内容如下，一定要存成UTF8格式。manifest_version版本为2.第一版很快就将不支持了。第一版和第二版有些差别。如下：
https://developer.chrome.com/extensions/manifestVersion.html

    
    {
      "manifest_version": 2,
      "name": "第一个Chrome插件",
      "version": "1.0",
      "description": "我的第一个Chrome插件，还不错吧",
      "browser_action": {
        "default_icon": "icon.gif",
        "default_popup": "popup.html"
      }
    }


3.新建popup.html如下

<p>Hello,Chrome!</p>
<p>欢迎你，我的第一个Chrome扩展插件</p>
<p><a href="http://www.abloz.com" target="_blank">欢迎访问我的blog</a>
<p><img src="backimg.jpg" /></p>

4. icon.gif和backimg.jpg可以自己找合适的。



5.进入工具->扩展程序，路径显示[chrome://chrome/extensions/](chrome://chrome/extensions/)

选中“开发者模式”，点“载入正在开发的扩展程序”

工具栏出现了我们的图标，点击可以弹出我们定制的页面。

如图

[![](http://abloz.com/wp-content/uploads/2012/10/ex1.jpg)](http://abloz.com/wp-content/uploads/2012/10/ex1.jpg)

点击后打开

[![](http://abloz.com/wp-content/uploads/2012/10/ex2.jpg)](http://abloz.com/wp-content/uploads/2012/10/ex2.jpg)



插件安装路径：

C:Users{user}AppDataLocalGoogleChromeUser DataDefaultExtensions

{user}替换成登陆用户。

下面的目录都是插件id，可以通过[chrome://chrome/extensions/](chrome://chrome/extensions/)开发者模式下看到

6.打包发布：

在开发者模式下，点打包扩展程序，生成的crx文件即为插件。pem文件是自动生成的密钥文件。将crx发给朋友，

在[chrome://chrome/extensions/](chrome://chrome/extensions/) 页面，将crx拖过去即可安装。
