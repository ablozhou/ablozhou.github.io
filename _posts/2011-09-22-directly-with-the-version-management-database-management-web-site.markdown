---
author: abloz
comments: true
date: 2011-09-22 07:17:39+00:00
layout: post
link: http://abloz.com/index.php/2011/09/22/directly-with-the-version-management-database-management-web-site/
slug: directly-with-the-version-management-database-management-web-site
title: 直接用版本管理库管理网站？
wordpress_id: 1442
categories:
- 技术
tags:
- blog
- github
- web
---

github.com 提供[pages](http://pages.github.com/)服务，可以将页面提交到库中，自动进行网页发表。

如用户名是alice，创建了库alice.github.com，如果将index.html放到master下，则可以通过http://alice.github.com 进行访问。每次提交会自动更新。

演示：[github.com/defunkt/defunkt.github.com](http://github.com/defunkt/defunkt.github.com/) → [http://defunkt.github.com/](http://defunkt.github.com/)





如果要更复杂的布局，可以使用 [Jekyll](http://github.com/mojombo/jekyll/), 它是一个blog静态页面生成程序，支持模版等，可以方便的生成页面。

演示： [github.com/pages/pages.github.com](http://github.com/pages/pages.github.com/) → [http://pages.github.com/](http://pages.github.com/)



如果有自己的域名，如abloz.com,怎么办呢？

jekyll也可以将静态页面生成到自己的域名。

1.在库的root下编辑CNAME文件，输入abloz.com

2.访问DNS 域名注册页面，如果使用http://www.abloz.com,可增加CNAME，指向你的github.com页，如http://abloz.github.com。如使用http://abloz.com, 则需增加A记录，指向207.97.227.245，此时不要使用CNAME。生效时间可能要一天。

演示： [github.com/mojombo/mojombo.github.com](http://github.com/mojombo/mojombo.github.com/) → [http://tom.preston-werner.com/](http://tom.preston-werner.com/)



参考：

http://pages.github.com/
