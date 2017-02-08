---
author: abloz
comments: true
date: 2012-05-24 11:19:02+00:00
layout: post
link: http://abloz.com/index.php/2012/05/24/pydoop-write-hadoop-mapreduce-using-python/
slug: pydoop-write-hadoop-mapreduce-using-python
title: pydoop：用python 写Hadoop的MapReduce
wordpress_id: 1620
categories:
- 技术
tags:
- hadoop
- pydoop
- python
---



Pydoop 是用python 对Hadoop 的C++API的MapReduce和HDFS的封装。程序很小，只有500多KB。



[zhouhh@Hadoop48 ~]$ tar -zxvf pydoop-0.5.2-rc2.tar.gz



[zhouhh@Hadoop48 pydoop-0.5.2-rc2]$ python setup.py build

build通过后，执行安装

可以安装在系统中或安装在本地

sudo安装时如果不跟参数，会导致环境变量不可用：



[zhouhh@Hadoop48 pydoop-0.5.2-rc2]$ sudo python setup.py install

错误：

RuntimeError: Could not determine JAVA_HOME path

但是该环境变量是存在的：

    
    [zhouhh@Hadoop48 pydoop-0.5.2-rc2]$ echo $JAVA_HOME
    /usr/java/jdk1.7.0


打开setup.py

    
    self.java_home = os.getenv("JAVA_HOME", find_first_existing("/opt/sun-jdk", "/usr/lib/jvm/java-6-sun"))


改为：

    
    self.java_home = os.getenv("JAVA_HOME", find_first_existing("/opt/sun-jdk", "/usr/lib/jvm/java-6-sun","/usr/java/jdk1.7.0"))




再执行setup.py install

    
    ValueError: HADOOP_HOME not set
    [zhouhh@Hadoop48 pydoop-0.5.2-rc2]$ echo $HADOOP_HOME
    /home/zhouhh/hadoop-1.0.3



    
    [zhouhh@Hadoop48 pydoop-0.5.2-rc2]$ echo $HADOOP_HOME
    /home/zhouhh/hadoop-1.0.3


找到：

paths = reduce(list.__add__, map(glob.glob, ("/opt/hadoop*", "/usr/lib/hadoop*", "/usr/local/lib/hadoop*")))



改为：

paths = reduce(list.__add__, map(glob.glob, ("/opt/hadoop*", "/usr/lib/hadoop*", "/usr/local/lib/hadoop*","/home/zhouhh/hadoop-*")))

...

为了避免环境变量问题，

如果安装到系统，应略过创建：

[zhouhh@Hadoop48 pydoop-0.5.2-rc2]$ sudo python setup.py install --skip-build

或者直接装在当前用户下：

[zhouhh@Hadoop48 pydoop-0.5.2-rc2]$ python setup.py install --user

或安装到指定目录：

[zhouhh@Hadoop48 pydoop-0.5.2-rc2]$ python setup.py install --home /home/zhouhh/pydoop

检验是否成功：

    
    [zhouhh@Hadoop48 pydoop-0.5.2-rc2]$ cd test
    [zhouhh@Hadoop48 test]$ python all_test.py


ImportError: /usr/lib64/libboost_python.so.2: undefined symbol: PyUnicodeUCS4_FromEncodedObject



单词计数示例

    
    from pydoop.pipes import Mapper, Reducer, Factory, runTask
    
    class WordCountMapper(Mapper):
    
      def map(self, context):
        words = context.getInputValue().split()
        for w in words:
          context.emit(w, "1")
    
    class WordCountReducer(Reducer):
    
      def reduce(self, context):
        s = 0
        while context.nextValue():
          s += int(context.getInputValue())
        context.emit(context.getInputKey(), str(s))
    
    runTask(Factory(WordCountMapper, WordCountReducer))




对简单任务，可以使用pydoop_script工具：

    
    def mapper(k, text, writer):
      for word in text.split():
        writer.emit(word, 1)
    
    def reducer(word, count, writer):
      writer.emit(word, sum(map(int, count)))


**参考：**

下载：https://sourceforge.net/projects/pydoop/files

示例地址：[http://pydoop.sourceforge.net/docs/examples/index.html](http://pydoop.sourceforge.net/docs/examples/index.html)

最新版下载：[http://sourceforge.net/projects/pydoop/files/Pydoop-0.5/pydoop-0.5.2-rc2.tar.gz/download](http://sourceforge.net/projects/pydoop/files/Pydoop-0.5/pydoop-0.5.2-rc2.tar.gz/download)

主页：[http://sourceforge.net/apps/mediawiki/pydoop/index.php?title=Main_Page](http://sourceforge.net/apps/mediawiki/pydoop/index.php?title=Main_Page)
