---
author: abloz
comments: true
date: 2007-11-08 07:25:07+00:00
layout: post
link: http://abloz.com/index.php/2007/11/08/ie-click-to-activate-control-web-site-code-to-resolve-method/
slug: ie-click-to-activate-control-web-site-code-to-resolve-method
title: IE"单击以激活控件"网站代码解决法
wordpress_id: 245
categories:
- 技术
tags:
- flash
- ie
---

# 




周海汉/文 2007.11.8

由于微软输了专利官 司，所以从2006年开始，IE6补丁和IE7里面的flash，quick time,Java及其他控件都需要点击才能激活。经常看到flash外面包含了个虚框，鼠标移上去后提示：“click to activate and use this control”或“单击以激活控件”。如果这是个flash的菜单什么的，给使用者很不好的体验。google到外国使用者的解决办法。

**1.在HTML页最后的<object>标签下，增加下面的代码：**

<script type="text/javascript" src="fixit.js"></script>

**2.fixit.js 文件如下：**

theObjects = document.getElementsByTagName("object");

for (var i = 0; i < theObjects.length; i++) ...{

theObjects[i].outerHTML = theObjects[i].outerHTML;

}

** 3.更新网站。**flash的有[自己的解决办法](http://www.amarasoftware.com/macromedia-ie-solution.htm)。 但比这个复杂，解决的也更好。

对于IE浏览器用户，微软倒是提供了[回 退的补丁KB917425](http://www.microsoft.com/downloads/details.aspx?familyid=B7D9801B-4FB5-492E-903E-3400ABF1D731&displaylang=zh-cn)，用于回退KB912812的更新。但我下载后并不能装上。至于网络上大量提到的卸载KB912945或 KB912812，我的系统并不存在。而且对于IE7恐怕也没有用。因此只能用傲游或firefox替代了。

**参考：**

[http://msdn.microsoft.com/ieupdate](http://support.microsoft.com/kb/912945)
[http://www.macromedia.com/devnet/activecontent/articles/devletter.html](http://www.macromedia.com/devnet/activecontent/articles/devletter.html)
h[ttp://blog.deconcept.com/2005/12/15/internet-explorer-eolas-changes-and-the-flash-plugin/](http://blog.deconcept.com/2005/12/15/internet-explorer-eolas-changes-and-the-flash-plugin/)
[http://www.ediy.co.nz/internet-explorer-flash-applet-activation-fix-xidc19237.html](http://www.ediy.co.nz/internet-explorer-flash-applet-activation-fix-xidc19237.html)

[http://www.mix-fx.com/flash-prompt.htm](http://www.mix-fx.com/flash-prompt.htm)
