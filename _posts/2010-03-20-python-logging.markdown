---
author: abloz
comments: true
date: 2010-03-20 06:40:52+00:00
layout: post
link: http://abloz.com/index.php/2010/03/20/python-logging/
slug: python-logging
title: python 日志记录
wordpress_id: 1169
categories:
- 技术
tags:
- log
- python
---

周海汉 /文

http://blog.csdn.net/ablo_zhou

2010.3.20

一、我写的log4py介绍

在写<汉字大全 >时，自己实现了简单的log系统：


    
    
    #!/bin/env python
    #--*-- coding=utf8 --*--
    #
    #   Author: ablozhou
    #   E-mail: ablozhou@gmail.com
    #
    #   Copyright 2010 ablozhou
    #
    #   Distributed under the terms of the GPL (GNU Public License)
    #
    #   hzdq is free software; you can redistribute it and/or modify
    #   it under the terms of the GNU General Public License as published by
    #   the Free Software Foundation; either version 2 of the License, or
    #   (at your option) any later version.
    #
    #   This program is distributed in the hope that it will be useful,
    #   but WITHOUT ANY WARRANTY; without even the implied warranty of
    #   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    #   GNU General Public License for more details.
    #
    #   You should have received a copy of the GNU General Public License
    #   along with this program; if not, write to the Free Software
    #   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
    #
    # 2010.3.14 写文件，log级别常数定义
    import datetime
    import sys
    import traceback
    import codecs
    import types
    #log编码全部按utf8处理
    loglevels = {'stdout':['info','debug','warn','error','fatal'],
        'file':['info','debug','warn','error','fatal']
        }
    logfile = 'logs.txt'
    class log4py:
        def __init__(self,modulename='gloabal', loglevel=loglevels, filename='log4py.txt'):
            self.filename = filename
            #self.flag = set(loglevel['stdout']+loglevel['file'])
            self.loglevel = loglevel
            self.modulename = modulename
            self.fcname = None
        class function():
            def __init__(self,fcname,parent):
                parent.debug('enter ',fcname)
                self.fcname = fcname
                self.parent = parent
            def __del__(self):
                self.parent.debug('exit ',self.fcname)
        def dbgfc(self,fcname):
            '''set debug function name'''
            f = None
            if 'debug' in self.flag:
                f = self.function(fcname,self)
            return f
        def _gettime(self):
            return datetime.datetime.now().isoformat()
        def outstd(self,*fmt):
            s = self.fmtstr(*fmt)
            print s
        def outfile(self,*fmt):
            s = self.fmtstr(*fmt)
            #print 'before outfile '+s
            if s:
                #print 'outfile '+s
                encoding = 'utf8'
                out = open(logfile, 'a+')#, encoding
                out.write(s)
                out.write('n')
                out.close()
        def fmtstr(self, *fmt):
            str = ''
            encoding = 'utf8'#缺省utf8编码
            for i in fmt:
                if not type(i) in [types.UnicodeType, types.StringTypes, types.StringType]:
                    s= repr(i)
                else:
                    s = i
                if type(s) == type(u''):
                    str += s.encode(encoding)
                else:
                    str += s
                str += '.'
            #str += 'n'
            #print 'fmtstr:'+str
            return str
        def debug(self,*fmt):
            if 'debug' in self.loglevel['stdout']:
                self.outstd(self._gettime(),'[DEBUG]',self.modulename,*fmt)
            if 'debug' in self.loglevel['file']:
                #print 'debug file ...'
                self.outfile(self._gettime(),'[DEBUG]',self.modulename,*fmt)
        def warn(self,*fmt):
            if 'warn' in self.loglevel['stdout']:
                self.outstd(self._gettime(),'[WARN]',self.modulename,*fmt)
            if 'warn' in self.loglevel['file']:
                self.outfile(self._gettime(),'[WARN]',self.modulename,*fmt)
        def info(self,*fmt):
            if 'info' in self.loglevel['stdout']:
                self.outstd(self._gettime(),'[INFO]',self.modulename,*fmt)
            if 'info' in self.loglevel['file']:
                self.outfile(self._gettime(),'[INFO]',self.modulename,*fmt)
        def error(self,*fmt):
            if 'error' in self.loglevel['stdout']:
                self.outstd(self._gettime(),'[ERROR]',self.modulename,*fmt)
            if 'error' in self.loglevel['file']:
                self.outfile(self._gettime(),'[ERROR]',self.modulename,*fmt)
        def fatal(self,*fmt):
            if 'fatal' in self.loglevel['stdout']:
                self.outstd(self._gettime(),'[FATAL',self.modulename,*fmt)
            if 'fatal' in self.loglevel['file']:
                self.outfile(self._gettime(),'[FATAL',self.modulename,*fmt)
    #unit test
    if __name__ == '__main__':
        log=log4py()
        log.outstd('INFO','stdout','test')
        log.outfile('INFO','stdout','test')
        log.debug('debug information 调试')
        log.error('errorrrrrrrrrrrrrrr')
        log.debug('hello')
    




输出

INFO.stdout.test.
2010-03-20T09:19:47.091774.[DEBUG].gloabal.debug information 调试.
2010-03-20T09:19:47.092294.[ERROR].gloabal.errorrrrrrrrrrrrrrr.
2010-03-20T09:19:47.092568.[DEBUG].gloabal.hello.

使用时，只需

import log4py

log = log4py.log4py('module name')

就可以用log.debug('debug')等几个级别打印log了。还可以定义是标准输出还是输出到文件，输出什么级别的。适用于小型的log系统。

该log4py的好处是使用起来简单，具有基本的级别定义，完全支持中文，log调试的输入除了字符串还支持列表，字典，数字等，可以打印exception信息。打印的格式为"时间到毫秒，模块名，log级别，log内容“。

但与系统的log比起来，缺乏强大的定制能力。

二、系统的logging模块

著名的log4j,log4cpp，以及python自带的logging其配置都相当复杂，使用灵活，可以通过配置文件自定义输出哪些模块，输出级别，输出格式，输出到文件和标准输出。并且兼顾多线程，性能等。

系统自带的logging模块，缺省就可以简单使用：

>>> import logging
>>> logging.debug('debug')
>>> logging.warn('debug')
WARNING:root:debug
>>> logging.debug('你好，调试')
>>> logging.warn('你好，调试')
WARNING:root:你好，调试

可见，在控制台，debug缺省是不打印的。

可以在编程时直接控制log的方式，也可以通过配置文件来进行。当然，配置文件更灵活。

2.1 logging的几个组件

Logger，Manager, Handler,Filter,Formatter,Configuration,Level

Logger 是应用中log的实例，Handler是输出的方式，如：

    * StreamHandler - logging to a stream, defaulting to sys.stderr.
    * FileHandler - logging to disk files.
    * RotatingFileHandler - logging to disk files with support for rollover, rotating files.
    * SocketHandler - logging to a streaming socket.
    * DatagramHandler - logging to a UDP socket.
    * SMTPHandler - logging to an email address.
    * SysLogHandler - logging to Unix syslog. Contributed by Nicolas Untz, based on Sam Rushing's syslog module .
    * MemoryHandler - buffering records in memory until a specific trigger occurs (or until the buffer gets full).
    * NTEventLogHandler - writes events to the NT event log. For this to work, you need to have Mark Hammond's Win32 extensions installed. (Though of course you can still log to NT from other platforms - just use SocketHandler to redirect to an NT machine).
    * HTTPHandler - sends events to a Web server using either GET or POST semantics.

Filter是设置的模块，哪些需要记录，都可以配置。

Formatter是输出的格式，可以格式化时间，模块，级别。

Level是输出的级别，有如下级别：

DEBUG
INFO
WARNING
ERROR
CRITICAL

log4j等原来的版本最高级是FATAL，python的logging最高级别是CTITICAL,因为FATAL是系统崩溃的错误。

下面是一个使用配置文件写log的例子：


    
    
    #!/usr/bin/env python
    #coding:utf8
    #author <a href="http://blog.csdn.net/ablo_zhou" target="_blank" title="">周海汉</a>
    #date:2010.3.20
    #file testlog.py
    import logging
    import logging.config
    logconf = '/home/zhouhh/logconf.ini'
    logging.config.fileConfig(fname=logconf)
    log1 = logging.getLogger('modlog1')
    log1.debug('log1调试信息')
    log1.warn('log1警告信息')
    log1.error('log1 error错误信息')
    log2 =  logging.getLogger('modlog1.modlog2')
    log2.debug('log2调试信息')
    log2.warn('log2警告信息')
    log2.error('log2 错误信息')
    



配置文件放在/home/zhouhh/logconf.ini


    
    
    # --- logconf.ini ------------
    [loggers]
    keys=root,modlog1,modlog2
    
    [handlers]
    keys=hd1,hd2
    
    [formatters]
    keys=fmt1,fmt2
    #root logger
    #
    #level: DEBUG, INFO, WARN, ERROR, CRITICAL  , NOTSET.
    # 在root logger, NOTSET 表示记录所有信息.
    #propagate 表示该logger是否从父logger中传送handler
    # channel 表示logger内通道名最低的部分，如 logger 名 "a.b.c", 该值是 "c".
    #
    #parent 表示父 logger名，但root的父log是 "(root)" 而不是 "root".
    #
    #qualname 完全的通道名 ，如logger 名是 "a.b.c", 该值即 "a.b.c".
    #
    #handlers 是本logger附带的逗号隔开的操作者名
    #qualname=(root)用于root
    #propagate=1 用于非root的loggers
    [logger_root]
    level=NOTSET
    handlers=hd1
    qualname=(root)
    propagate=1
    channel=
    parent=
    #如果是NOTSET,表示查看父logger
    #propagate=0表示当root，1表示继承父logger
    [logger_modlog1]
    level=DEBUG
    propagate=1
    qualname=modlog1
    handlers=hd2
    channel=modlog1
    parent=(root)
    
    [logger_modlog2]
    level=WARN
    propagate=1
    qualname=modlog1.modlog2
    handlers=hd2
    channel=modlog2
    parent=modlog1
    #NOTSET从父logger继承
    #formatter留空表示logging._defaultFormatter
    [handler_hd1]
    class=StreamHandler
    level=DEBUG
    formatter=fmt1
    args=(sys.stdout,)
    stream=sys.stdout
    
    [handler_hd2]
    class=FileHandler
    level=DEBUG
    formatter=fmt2
    args=('python.log', 'w')
    filename=python.log
    mode=w
    [formatter_fmt1]
    format=F1 %(asctime)s %(levelname)s %(message)s
    datefmt=
    [formatter_fmt2]
    format=F2 %(asctime)s %(pathname)s(%(lineno)d): %(levelname)s %(message)s
    datefmt=
    
    



执行后，命令行看到输出：



   1. zhouhh@zhouhh-home:~$ python testlog.py
   2. F1 2010-03-20 16:36:28,411 DEBUG log1调试信息
   3. F1 2010-03-20 16:36:28,412 WARNING log1警告信息
   4. F1 2010-03-20 16:36:28,412 ERROR log1 error错误信息
   5. F1 2010-03-20 16:36:28,412 WARNING log2警告信息
   6. F1 2010-03-20 16:36:28,412 ERROR log2 错误信息

zhouhh@zhouhh-home:~$ python testlog.py F1 2010-03-20 16:36:28,411 DEBUG log1调试信息 F1 2010-03-20 16:36:28,412 WARNING log1警告信息 F1 2010-03-20 16:36:28,412 ERROR log1 error错误信息 F1 2010-03-20 16:36:28,412 WARNING log2警告信息 F1 2010-03-20 16:36:28,412 ERROR log2 错误信息

文件python.log看到信息：



   1. F2 2010-03-20 16:36:28,411 testlog.py(16): DEBUG log1调试信息
   2. F2 2010-03-20 16:36:28,412 testlog.py(17): WARNING log1警告信息
   3. F2 2010-03-20 16:36:28,412 testlog.py(18): ERROR log1 error错误信息
   4. F2 2010-03-20 16:36:28,412 testlog.py(22): WARNING log2警告信息
   5. F2 2010-03-20 16:36:28,412 testlog.py(22): WARNING log2警告信息
   6. F2 2010-03-20 16:36:28,412 testlog.py(23): ERROR log2 错误信息
   7. F2 2010-03-20 16:36:28,412 testlog.py(23): ERROR log2 错误信息

F2 2010-03-20 16:36:28,411 testlog.py(16): DEBUG log1调试信息 F2 2010-03-20 16:36:28,412 testlog.py(17): WARNING log1警告信息 F2 2010-03-20 16:36:28,412 testlog.py(18): ERROR log1 error错误信息 F2 2010-03-20 16:36:28,412 testlog.py(22): WARNING log2警告信息 F2 2010-03-20 16:36:28,412 testlog.py(22): WARNING log2警告信息 F2 2010-03-20 16:36:28,412 testlog.py(23): ERROR log2 错误信息 F2 2010-03-20 16:36:28,412 testlog.py(23): ERROR log2 错误信息

下面是一个比较完全的配置文件，从http://www.red-dove.com/python_logging.html拿过来的，供写logconf文件时参考：


    
    
    # --- logconf.ini -----------------------------------------------------------
    #The "loggers" section contains the key names for all the loggers in this
    #configuration. These are not the actual channel names, but values used to
    #identify where the parameters for each logger are found in this file.
    #The section for an individual logger is named "logger_xxx" where the "key"
    #for a logger is "xxx". So ... "logger_root", "logger_log02", etc. further
    #down the file, indicate how the root logger is set up, logger "log_02" is set
    #up, and so on.
    #Logger key names can be any identifier, except "root" which is reserved for
    #the root logger. (The names "lognn" are generated by the GUI configurator.)
    [loggers]
    keys=root,log02,log03,log04,log05,log06,log07
    #The "handlers" section contains the key names for all the handlers in this
    #configuration. Just as for loggers above, the key names are values used to
    #identify where the parameters for each handler are found in this file.
    #The section for an individual handler is named "handler_xxx" where the "key"
    #for a handler is "xxx". So sections "handler_hand01", "handler_hand02", etc.
    #further down the file, indicate how the handlers "hand01", "hand02" etc.
    #are set up.
    #Handler key names can be any identifier. (The names "handnn" are generated
    #by the GUI configurator.)
    [handlers]
    keys=hand01,hand02,hand03,hand04,hand05,hand06,hand07,hand08,hand09
    #The "formatters" section contains the key names for all the formatters in
    #this configuration. Just as for loggers and handlers above, the key names
    #are values used to identify where the parameters for each formatter are found
    #in this file.
    #The section for an individual formatter is named "formatter_xxx" where the
    #"key" for a formatter is "xxx". So sections "formatter_form01",
    #"formatter_form02", etc. further down the file indicate how the formatters
    #"form01", "form02" etc. are set up.
    #Formatter key names can be any identifier. (The names "formnn" are generated
    #by the GUI configurator.)
    [formatters]
    keys=form01,form02,form03,form04,form05,form06,form07,form08,form09
    #The section below indicates the information relating to the root logger.
    #
    #The level value needs to be one of DEBUG, INFO, WARN, ERROR, CRITICAL or NOTSET.
    #In the root logger, NOTSET indicates that all messages will be logged.
    #Level values are eval()'d in the context of the logging package's namespace.
    #
    #The propagate value indicates whether or not parents of this loggers will
    #be traversed when looking for handlers. It doesn't really make sense in the
    #root logger - it's just there because a root logger is almost like any other
    #logger.
    #
    #The channel value indicates the lowest portion of the channel name of the
    #logger. For a logger called "a.b.c", this value would be "c".
    #
    #The parent value indicates the key name of the parent logger, except that
    #root is shown as "(root)" rather than "root".
    #
    #The qualname value is the fully qualified channel name of the logger. For a
    #logger called "a.b.c", this value would be "a.b.c".
    #
    #The handlers value is a comma-separated list of the key names of the handlers
    #attached to this logger.
    #
    [logger_root]
    level=NOTSET
    handlers=hand01
    qualname=(root) # note - this is used in non-root loggers
    propagate=1 # note - this is used in non-root loggers
    channel=
    parent=
    #
    #The explanation for the values in this section is analogous to the above. The
    #logger is named "log02" and coincidentally has a key name of "log02". It has
    #a level of DEBUG and handler with key name "hand02". (See section
    #"handler_hand02" for handler details.) If the level value were NOTSET, this tells
    #the logging package to consult the parent (as long as propagate is 1) for the
    #effective level of this logger. If propagate is 0, this level is treated as for
    #the root logger - a value of NOTSET means "pass everything", and other values are
    #interpreted at face value.
    #
    [logger_log02]
    level=DEBUG
    propagate=1
    qualname=log02
    handlers=hand02
    channel=log02
    parent=(root)
    #
    #The explanation for the values in this section is analogous to the above. The
    #logger is named "log02.log03" and has a key name of "log03".
    #It has a level of INFO and handler with key name "hand03".
    #
    [logger_log03]
    level=INFO
    propagate=1
    qualname=log02.log03
    handlers=hand03
    channel=log03
    parent=log02
    #
    #The explanations for the values in this section and subsequent logger sections
    #are analogous to the above.
    #
    [logger_log04]
    level=WARN
    propagate=0
    qualname=log02.log03.log04
    handlers=hand04
    channel=log04
    parent=log03
    [logger_log05]
    level=ERROR
    propagate=1
    qualname=log02.log03.log04.log05
    handlers=hand05
    channel=log05
    parent=log04
    [logger_log06]
    level=CRITICAL
    propagate=1
    qualname=log02.log03.log04.log05.log06
    handlers=hand06
    channel=log06
    parent=log05
    [logger_log07]
    level=WARN
    propagate=1
    qualname=log02.log03.log04.log05.log06.log07
    handlers=hand07
    channel=log07
    parent=log06
    #The section below indicates the information relating to handler "hand01".
    #The first three keys (class, level and formatter) are common to all handlers.
    #Any other values are handler-specific, except that "args", when eval()'ed,
    #is the list of arguments to the constructor for the handler class.
    #
    #The class value indicates the handler's class (as determined by eval() in
    #the logging package's namespace).
    #
    #The level value needs to be one of DEBUG, INFO, WARN, ERROR, CRITICAL or NOTSET.
    #NOTSET means "use the parent's level".
    #
    #The formatter value indicates the key name of the formatter for this handler.
    #If blank, a default formatter (logging._defaultFormatter) is used.
    #
    #The stream value indicates the stream for this StreamHandler. It is computed
    #by doing eval() on the string value in the context of the logging package's
    #namespace.
    #
    #The args value is a tuple of arguments which is passed to the constructor for
    #this handler's class in addition to the "self" argument.
    #
    [handler_hand01]
    class=StreamHandler
    level=NOTSET
    formatter=form01
    args=(sys.stdout,)
    stream=sys.stdout
    #The section below indicates the information relating to handler "hand02".
    #The first three keys are common to all handlers.
    #Any other values are handler-specific, except that "args", when eval()'ed,
    #is the list of arguments to the constructor for the handler class.
    #
    #The filename value is the name of the file to write logging information to.
    #The mode value is the mode used to open() the file. The maxsize and backcount
    #values control rollover as described in the package's API documentation.
    #
    [handler_hand02]
    class=FileHandler
    level=DEBUG
    formatter=form02
    args=('python.log', 'w')
    filename=python.log
    mode=w
    #The section below indicates the information relating to handler "hand03".
    #The first three keys are common to all handlers.
    #Any other values are handler-specific, except that "args", when eval()'ed,
    #is the list of arguments to the constructor for the handler class.
    #
    #The host value is the name of the host to send logging information to.
    #The port value is the port number to use for the socket connection.
    #
    [handler_hand03]
    class=handlers.SocketHandler
    level=INFO
    formatter=form03
    args=('localhost', handlers.DEFAULT_TCP_LOGGING_PORT)
    host=localhost
    port=DEFAULT_TCP_LOGGING_PORT
    #The section below indicates the information relating to handler "hand04".
    #The first three keys are common to all handlers.
    #Any other values are handler-specific, except that "args", when eval()'ed,
    #is the list of arguments to the constructor for the handler class.
    #
    #The host value is the name of the host to send logging information to.
    #The port value is the port number to use for the socket connection.
    #
    [handler_hand04]
    class=handlers.DatagramHandler
    level=WARN
    formatter=form04
    args=('localhost', handlers.DEFAULT_UDP_LOGGING_PORT)
    host=localhost
    port=DEFAULT_UDP_LOGGING_PORT
    #The section below indicates the information relating to handler "hand05".
    #The first three keys are common to all handlers.
    #Any other values are handler-specific, except that "args", when eval()'ed,
    #is the list of arguments to the constructor for the handler class.
    #
    #The host value is the name of the host to send logging information to.
    #The port value is the port number to use for the socket connection.
    #The facility is the syslog facility to use for logging.
    #
    [handler_hand05]
    class=handlers.SysLogHandler
    level=ERROR
    formatter=form05
    args=(('localhost', handlers.SYSLOG_UDP_PORT), handlers.SysLogHandler.LOG_USER)
    host=localhost
    port=SYSLOG_UDP_PORT
    facility=LOG_USER
    #The section below indicates the information relating to handler "hand06".
    #The first three keys are common to all handlers.
    #Any other values are handler-specific, except that "args", when eval()'ed,
    #is the list of arguments to the constructor for the handler class.
    #
    #The appname value is the name of the application which appears in the
    #NT event log.
    #The dllname value is the pathname of a DLL to use for message definitions.
    #The logtype is the type of NT event log to write to - Application, Security
    #or System.
    #
    [handler_hand06]
    class=NTEventLogHandler
    level=CRITICAL
    formatter=form06
    args=('Python Application', '', 'Application')
    appname=Python Application
    dllname=
    logtype=Application
    #The section below indicates the information relating to handler "hand07".
    #The first three keys are common to all handlers.
    #Any other values are handler-specific, except that "args", when eval()'ed,
    #is the list of arguments to the constructor for the handler class.
    #
    #The host value is the name of the SMTP server to connect to.
    #The port value is the port number to use for the SMTP connection.
    #The from value is the "From" value in emails.
    #The to value is a comma-separated list of email addresses.
    #The subject value is the subject of the email.
    #
    [handler_hand07]
    class=SMTPHandler
    level=WARN
    formatter=form07
    args=('localhost', 'from@abc', ['user1@abc', 'user2@xyz'], 'Logger Subject')
    host=localhost
    port=25
    from=from@abc
    to=user1@abc,user2@xyz
    subject=Logger Subject
    #The section below indicates the information relating to handler "hand08".
    #The first three keys are common to all handlers.
    #Any other values are handler-specific, except that "args", when eval()'ed,
    #is the list of arguments to the constructor for the handler class.
    #
    #The capacity value is the size of this handler's buffer.
    #The flushlevel value is the logging level at which the buffer is flushed.
    #The from value is the "From" value in emails.
    #The target value is the key name of the handler which messages are flushed
    #to (i.e. sent to when flushing).
    #
    [handler_hand08]
    class=MemoryHandler
    level=NOTSET
    formatter=form08
    target=
    args=(10, ERROR)
    capacity=10
    flushlevel=ERROR
    #The section below indicates the information relating to handler "hand09".
    #The first three keys are common to all handlers.
    #Any other values are handler-specific, except that "args", when eval()'ed,
    #is the list of arguments to the constructor for the handler class.
    #
    #The host value is the name of the HTTP server to connect to.
    #The port value is the port number to use for the HTTP connection.
    #The url value is the url to request from the server.
    #The method value is the HTTP request type (GET or POST).
    #
    [handler_hand09]
    class=HTTPHandler
    level=NOTSET
    formatter=form09
    args=('localhost:9022', '/log', 'GET')
    host=localhost
    port=9022
    url=/log
    method=GET
    #The sections below indicate the information relating to the various
    #formatters. The format value is the overall format string, and the
    #datefmt value is the strftime-compatible date/time format string. If
    #empty, the logging package substitutes ISO8601 format date/times where
    #needed. See the package API documentation for more details
    #of the format string structure.
    #
    [formatter_form01]
    format=F1 %(asctime)s %(levelname)s %(message)s
    datefmt=
    [formatter_form02]
    format=F2 %(asctime)s %(pathname)s(%(lineno)d): %(levelname)s %(message)s
    datefmt=
    [formatter_form03]
    format=F3 %(asctime)s %(levelname)s %(message)s
    datefmt=
    [formatter_form04]
    format=%(asctime)s %(levelname)s %(message)s
    datefmt=
    [formatter_form05]
    format=F5 %(asctime)s %(levelname)s %(message)s
    datefmt=
    [formatter_form06]
    format=F6 %(asctime)s %(levelname)s %(message)s
    datefmt=
    [formatter_form07]
    format=F7 %(asctime)s %(levelname)s %(message)s
    datefmt=
    [formatter_form08]
    format=F8 %(asctime)s %(levelname)s %(message)s
    datefmt=
    [formatter_form09]
    format=F9 %(asctime)s %(levelname)s %(message)s
    datefmt=
    # --- end of logconf.ini ----------------------------------------------------
    
    




3.参考：

http://www.red-dove.com/python_logging.html
http://www.python.org/dev/peps/pep-0282/
http://docs.python.org/library/logging.html#configuration
http://blog.donews.com/limodou/archive/2005/02/16/278699.aspx
