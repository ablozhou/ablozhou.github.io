---
author: abloz
comments: true
date: 2012-11-13 00:40:26+00:00
layout: post
link: http://abloz.com/index.php/2012/11/13/analysis-of-the-beijing-real-estate-transaction-data-pyquery-crawl/
slug: analysis-of-the-beijing-real-estate-transaction-data-pyquery-crawl
title: 用pyquery抓取分析北京房地产成交数据
wordpress_id: 1969
categories:
- 技术
tags:
- pyquery
- python
---


    #!/usr/bin/env python
    #coding:gbk
    #author:周海汉
    #note:分析北京住房和城乡建设委员会每天房产成交数据
    import urllib2
    import sys
    import os
    import datetime
    import time
    import shutil
    
    from pyquery import PyQuery as pq
    
    fn = "1.txt"
    fnwork = "roominfo.csv"
    lockfile = "lock.txt"
    html = ""
    
    def hasfetch():
        old=datetime.datetime.now()-datetime.timedelta(days =1)
        #print old
        tnow=datetime.datetime.now()
        print "NOW :",tnow
    
    
    
        try:
    
            t = open(lockfile,'r').read()
            print "LAST FETCH TIME:",t
            date = time.strptime(t[:19],"%Y-%m-%d %H:%M:%S")
            #print date
            old = datetime.datetime(date[0], date[1],date[2])
            print old
            #print (tnow-old).days > 0 and False or True
            #old = datetime.datetime(t)
        except Exception,e:
            print e
            return False
    
        if (tnow-old).days > 0 :
            return False
        return True
    
    if hasfetch():
        print 'has crawled the room info, DO NOTHING!!!!'
        exit(0)
    headers = {'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'}
    url = "http://www.bjjs.gov.cn/tabid/2167/Default.aspx"
    url = "http://www.bjjs.gov.cn/tabid/2207/Default.aspx"
    #for chinese url
    
    #p=pq(u'<td width="145" align="left">第A01版：<strong>今日一版</strong></td>')('td')
    #print p.children().text().encode('gbk')
    
    #if os.path.isfile(fn):
    #    html = open(fn,'rb').read()
    #else:
    try:
    
        url=url.encode('utf8')
        url=urllib2.unquote(url)
    
        #req = urllib2.Request(url)
        f = urllib2.urlopen(url)
        html = f.read()
        type = sys.getfilesystemencoding()
        html1 =  html.decode("UTF-8").encode(type)
        #print html1
    
    
        p = pq(html.decode("UTF-8"))
        #print p.children().text().encode(type)
        #print p("#ess_ctr5233_ModuleContent").text().encode(type)
        data = p("#ess_ctr5233_ModuleContent")
        table1=data.find("table")
        #print t1.text().encode(type)
        #print table1.eq(0).text().encode(type)
        txt = ''
        for i in range(1,4):
            txt += table1.eq(i).text().replace(' ',',').encode(type)
            txt += "n"
            #print txt
        w = open(fn,"a+")
        w.write(txt)
        w.close()
        shutil.copyfile(fn,fnwork)
    
        print 'sucessfull!'
        l = open(lockfile,"w+")
        l.write(str(datetime.datetime.now()))
        l.close()
    
    
    
        #d=pq(filename=fn)
    
        #print d.html().encode('utf8')
        #print d.text().encode('utf8')
    except Exception,e:
        print 'except'
        print e
    
    



