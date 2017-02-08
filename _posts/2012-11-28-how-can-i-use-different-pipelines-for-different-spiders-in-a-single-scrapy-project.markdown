---
author: abloz
comments: true
date: 2012-11-28 15:44:36+00:00
layout: post
link: http://abloz.com/index.php/2012/11/28/how-can-i-use-different-pipelines-for-different-spiders-in-a-single-scrapy-project/
slug: how-can-i-use-different-pipelines-for-different-spiders-in-a-single-scrapy-project
title: How can I use different pipelines for different spiders in a single Scrapy
  project
wordpress_id: 1999
categories:
- 技术
- 转载
tags:
- scrapy
---

Hi vitsin,
You can't override settings like this in your spiders like your code does:

    class FirstSpider(CrawlSpider):
        settings.overrides['ITEM_PIPELINES'] = ...

And you can't customize the item pipelines per spider.

What you could do is check the spider in the process_item() of your pipeline,
and ignore certain ones. For example:

    def process_item(self, item, spider):
        if spider.name not in ['myspider1', 'myspider2', 'myspider3']:
            return item

Hope this helps,
Pablo.
Not for the moment.
But there are some nice alternatives for achieving that functionality. For
example, you can choose a spider attribute to define which pipelines will be
enabled for each spider, and then check that attribute in your pipelines.

Here's how your spiders would look:

    class SomeSpider(CrawlSpider):
        pipelines = ['first']

    class AnotherSpider(CrawlSpider):
        pipelines = ['first', 'second']

And your pipelines:

    class FirstPipeline(object):
        def process_item(self, item, spider):
            if 'first' not in getattr(spider, 'pipelines', []):
                return item

            # ... pipeline code here ...


    class SecondPipeline(object):
       def process_item(self, item, spider):
            if 'second' not in getattr(spider, 'pipelines', []):
                return item

            # ... pipeline code here ...


Btw, this code can be easily made more performant by using sets instead of
lines for the pipelines attribute, and by caching the pipelines per spider.

Pablo.

On Thu, Nov 25, 2010 at 07:14:12AM -0800, vitsin wrote:
> hi,
> are you planning may be to add support for custom pipeline per spider?
> 10x,
> --vs
--------------
I can think of at least four approaches:

Use a different scrapy project per set of spiders+pipelines (might be appropriate if your spiders are different enough warrant being in different projects)
On the scrapy tool command line, change the pipeline setting with scrapy settings in between each invocation of your spider
Isolate your spiders into their own scrapy tool commands, and define the default_settings['ITEM_PIPELINES'] on your command class to the pipeline list you want for that command. See line 6 of this example.
In the pipeline classes themselves, have process_item() check what spider it's running against, and do nothing if it should be ignored for that spider. See the example using resources per spider to get you started. (This seems like an ugly solution because it tightly couples spiders and item pipelines. You probably shouldn't use this one.)

from:
http://stackoverflow.com/questions/8372703/how-can-i-use-different-pipelines-for-different-spiders-in-a-single-scrapy-proje
