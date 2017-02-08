---
author: abloz
comments: true
date: 2012-05-24 02:48:03+00:00
layout: post
link: http://abloz.com/index.php/2012/05/24/pinterest-used-technology/
slug: pinterest-used-technology
title: Pinterest 所采用的相关技术
wordpress_id: 1616
categories:
- 技术
tags:
- Architecture
- Pinterest
- Redis
---

Pinterest 合伙人 Paul Sciarra 在Quara上发布[shared a bit about their stack](http://www.quora.com/Pinterest/What-technologies-were-used-to-make-Pinterest) :



	
  * Python + heavily-modified Django at the application layer

	
  * Tornado and (very selectively) node.js as web-servers.

	
  * Memcached and membase / redis for object- and logical-caching, respectively.

	
  * RabbitMQ as a message queue.

	
  * Nginx, HAproxy and Varnish for static-delivery and load-balancing.

	
  * Persistent data storage using MySQL.

	
  * MrJob on EMR for map-reduce.

	
  * Git.




支持300万以上用户，4亿以上PageView




这是[Alex Popescu](http://nosql.mypopescu.com/post/17658415847/polyglot-persistence-at-pinterest-redis-membase)分析的Pinterest架构图：







[![](http://abloz.com/wp-content/uploads/2012/05/Pinterest-architecture.png)](http://abloz.com/wp-content/uploads/2012/05/Pinterest-architecture.png)




参考：




[http://highscalability.com/blog/2012/2/16/a-short-on-the-pinterest-stack-for-handling-3-million-users.html](http://highscalability.com/blog/2012/2/16/a-short-on-the-pinterest-stack-for-handling-3-million-users.html)




[http://nosql.mypopescu.com/post/17658415847/polyglot-persistence-at-pinterest-redis-membase](http://nosql.mypopescu.com/post/17658415847/polyglot-persistence-at-pinterest-redis-membase)
